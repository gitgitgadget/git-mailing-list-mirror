From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/3] bisect: when skipping,
	choose a commit away from a skipped commit
Date: Sat, 06 Jun 2009 06:41:34 +0200
Message-ID: <20090606044136.4031.48873.chriscool@tuxfamily.org>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 06:44:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCnlJ-0006bC-Lf
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 06:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbZFFEnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 00:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbZFFEnx
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 00:43:53 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:45980 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbZFFEns (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 00:43:48 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6D56C81807C;
	Sat,  6 Jun 2009 06:43:42 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 56787818068;
	Sat,  6 Jun 2009 06:43:40 +0200 (CEST)
X-git-sha1: fb714c571afe76aa6e2435113d22fe5fab29d1ff 
X-Mailer: git-mail-commits v0.4.5
In-Reply-To: <20090606043853.4031.78284.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120872>

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
 bisect.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/bisect.c b/bisect.c
index 115cf5f..6fdff05 100644
--- a/bisect.c
+++ b/bisect.c
@@ -585,6 +585,54 @@ struct commit_list *filter_skipped(struct commit_list *list,
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
@@ -897,7 +945,7 @@ int bisect_next_all(const char *prefix)
 
 	revs.commits = find_bisection(revs.commits, &reaches, &all,
 				       !!skipped_revs.sha1_nr);
-	revs.commits = filter_skipped(revs.commits, &tried, 0, NULL, NULL);
+	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
 		/*
-- 
1.6.3.GIT
