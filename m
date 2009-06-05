From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/3] bisect: when skipping,
	choose a commit away from a skipped commit
Date: Fri, 05 Jun 2009 06:10:42 +0200
Message-ID: <20090605041044.8885.92104.chriscool@tuxfamily.org>
References: <20090605040238.8885.92790.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 06:12:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCQnL-0001a8-R6
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 06:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbZFEEMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 00:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbZFEEMa
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 00:12:30 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:36124 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbZFEEM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 00:12:26 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id ED073940075;
	Fri,  5 Jun 2009 06:12:20 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id DBC5E940051;
	Fri,  5 Jun 2009 06:12:17 +0200 (CEST)
X-git-sha1: ff6af190b17f26b05e445c3ecf032ab1d63a4df5 
X-Mailer: git-mail-commits v0.4.5
In-Reply-To: <20090605040238.8885.92790.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120737>

To do that a new function "apply_skip_ratio" is added and another
function "managed_skipped" is created to wrap both "filter_skipped"
and the previous one.

In "managed_skipped" we detect when we should choose a commit away
from a skipped one and then we automatically choose a skip ratio
to pass to "apply_skip_ratio".

The ratio is choosen so that it alternates between 1/5, 2/5 and
3/5.

In "apply_skip_ratio", we ignore a given ratio of all the commits
that could be tested.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/bisect.c b/bisect.c
index 02497f7..3ad9887 100644
--- a/bisect.c
+++ b/bisect.c
@@ -571,6 +571,57 @@ struct commit_list *filter_skipped(struct commit_list *list,
 	return filtered;
 }
 
+static struct commit_list *apply_skip_ratio(struct commit_list *list,
+					    int count,
+					    int skip_num, int skip_denom)
+{
+	int index, i;
+	struct commit_list *cur, *previous;
+
+	cur = list;
+	previous = NULL;
+	index = count * skip_num / skip_denom;
+
+	for (i = 0; cur; cur = cur->next, i++) {
+		if (i == index) {
+			if (hashcmp(cur->item->object.sha1, current_bad_sha1))
+				return cur;
+			if (previous)
+				return previous;
+			return list;
+		}
+		previous = cur;
+	}
+
+	return list;
+}
+
+static struct commit_list *managed_skipped(struct commit_list *list,
+					   struct commit_list **tried)
+{
+	int count, skipped_first;
+	int skip_num, skip_denom;
+
+	*tried = NULL;
+
+	if (!skipped_revs.sha1_nr)
+		return list;
+
+	if (!skip_num)
+		return filter_skipped(list, tried, 0, NULL, NULL);
+
+	list = filter_skipped(list, tried, 0, &count, &skipped_first);
+
+	if (!skipped_first)
+		return list;
+
+	/* Use alternatively 1/5, 2/5 and 3/5 as skip ratio. */
+	skip_num = count % 3 + 1;
+	skip_denom = 5;
+
+	return apply_skip_ratio(list, count, skip_num, skip_denom);
+}
+
 static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 			     const char *bad_format, const char *good_format,
 			     int read_paths)
@@ -883,7 +934,7 @@ int bisect_next_all(const char *prefix)
 
 	revs.commits = find_bisection(revs.commits, &reaches, &all,
 				       !!skipped_revs.sha1_nr);
-	revs.commits = filter_skipped(revs.commits, &tried, 0, NULL, NULL);
+	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
 		/*
-- 
1.6.3.GIT
