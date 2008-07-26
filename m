From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/3] builtin-branch: fix -v for --[no-]merged
Date: Sat, 26 Jul 2008 12:27:25 +0200
Message-ID: <1217068045-3575-4-git-send-email-hjemli@gmail.com>
References: <1217068045-3575-1-git-send-email-hjemli@gmail.com>
 <1217068045-3575-2-git-send-email-hjemli@gmail.com>
 <1217068045-3575-3-git-send-email-hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMhrY-0002Nb-H3
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 13:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYGZLWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 07:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbYGZLWA
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 07:22:00 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:50691 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbYGZLV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 07:21:59 -0400
Received: from localhost.localdomain (ti0025a380-0241.bb.online.no [88.89.68.241])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id m6QARRQk019909
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 12:27:28 +0200 (MEST)
X-Mailer: git-send-email 1.6.0.rc0.79.gb0320
In-Reply-To: <1217068045-3575-3-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90208>

After the optimization to --[no-]merged logic, the calculation of the
width of the longest refname to be shown might become inaccurate (since
the matching against merge_filter is performed after adding refs to
ref_list). This patch forces a recalculation of maxwidth when it might
be needed.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-branch.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index bff74cf..fed6f5e 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -363,6 +363,19 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	}
 }
 
+static int calc_maxwidth(struct ref_list *refs)
+{
+	int i, l, w = 0;
+	for (i = 0; i < refs->index; i++) {
+		if (!matches_merge_filter(refs->list[i].commit))
+			continue;
+		l = strlen(refs->list[i].name);
+		if (l > w)
+			w = l;
+	}
+	return w;
+}
+
 static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
 {
 	int i;
@@ -383,6 +396,8 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 				   (struct object *) filter, "");
 		ref_list.revs.limited = 1;
 		prepare_revision_walk(&ref_list.revs);
+		if (verbose)
+			ref_list.maxwidth = calc_maxwidth(&ref_list);
 	}
 
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
-- 
1.6.0.rc0.79.gb0320
