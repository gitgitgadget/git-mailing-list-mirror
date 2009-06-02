From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] bisect: use the skip ratio to choose a commit away from a
	skipped commit
Date: Tue, 02 Jun 2009 22:16:31 +0200
Message-ID: <20090602201634.3630.89985.chriscool@tuxfamily.org>
References: <20090602200731.3630.33652.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBaRe-0008Np-Pg
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 22:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbZFBURn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbZFBURm
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 16:17:42 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:55048 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754803AbZFBURj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 16:17:39 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 56171D48091;
	Tue,  2 Jun 2009 22:17:33 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 496CBD4802D;
	Tue,  2 Jun 2009 22:17:26 +0200 (CEST)
X-git-sha1: 7c63f3b97d57c3c46297f8959e69756bdcbdc60f 
X-Mailer: git-mail-commits v0.4.5
In-Reply-To: <20090602200731.3630.33652.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120539>

To do that a new function "apply_skip_ratio" is added and another
function "managed_skipped" is created to wrap both "filter_skipped"
and the previous one.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/bisect.c b/bisect.c
index 5e5a248..0a50cba 100644
--- a/bisect.c
+++ b/bisect.c
@@ -571,6 +571,53 @@ struct commit_list *filter_skipped(struct commit_list *list,
 	return filtered;
 }
 
+static struct commit_list *apply_skip_ratio(struct commit_list *list,
+					    int count,
+					    int skip_num, int skip_denum)
+{
+	int index, i;
+	struct commit_list *cur, *previous;
+
+	cur = list;
+	previous = NULL;
+	index = count * skip_num / skip_denum;
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
+					   struct commit_list **tried,
+					   int skip_num, int skip_denum)
+{
+	int count, skipped_first;
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
+	return apply_skip_ratio(list, count, skip_num, skip_denum);
+}
+
 static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 			     const char *bad_format, const char *good_format,
 			     int read_paths)
@@ -927,7 +974,8 @@ int bisect_next_all(const char *prefix, const char *skip_ratio)
 
 	revs.commits = find_bisection(revs.commits, &reaches, &all,
 				       !!skipped_revs.sha1_nr);
-	revs.commits = filter_skipped(revs.commits, &tried, 0, NULL, NULL);
+	revs.commits = managed_skipped(revs.commits, &tried,
+				       skip_num, skip_denum);
 
 	if (!revs.commits) {
 		/*
-- 
1.6.3.GIT
