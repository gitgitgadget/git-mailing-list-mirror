From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-branch: only traverse the requested refs
Date: Wed, 10 Oct 2007 23:54:43 +0200
Message-ID: <1192053283-2351-1-git-send-email-hjemli@gmail.com>
References: <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:56:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfjXb-0005s6-CM
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758606AbXJJVyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759216AbXJJVyf
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:54:35 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:49917 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756951AbXJJVye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:54:34 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id l9ALs9cR021381;
	Wed, 10 Oct 2007 23:54:09 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.4.207.g01d0
In-Reply-To: <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60557>

This avoids looking at every single file below .git/refs when git-branch
is fetching the list of refs to display.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

This patch should make git-branch much more efficient when there exists
many files below .git/refs, but it does require two passes through
.git/packed-refs when -a is specified.

No benchmarking performed...

 builtin-branch.c |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3da8b55..466e1e0 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -185,25 +185,8 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
 	struct ref_item *newitem;
-	int kind = REF_UNKNOWN_TYPE;
 	int len;
 
-	/* Detect kind */
-	if (!prefixcmp(refname, "refs/heads/")) {
-		kind = REF_LOCAL_BRANCH;
-		refname += 11;
-	} else if (!prefixcmp(refname, "refs/remotes/")) {
-		kind = REF_REMOTE_BRANCH;
-		refname += 13;
-	} else if (!prefixcmp(refname, "refs/tags/")) {
-		kind = REF_TAG;
-		refname += 10;
-	}
-
-	/* Don't add types the caller doesn't want */
-	if ((kind & ref_list->kinds) == 0)
-		return 0;
-
 	/* Resize buffer */
 	if (ref_list->index >= ref_list->alloc) {
 		ref_list->alloc = alloc_nr(ref_list->alloc);
@@ -214,7 +197,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	/* Record the new item */
 	newitem = &(ref_list->list[ref_list->index++]);
 	newitem->name = xstrdup(refname);
-	newitem->kind = kind;
+	newitem->kind = ref_list->kinds;
 	hashcpy(newitem->sha1, sha1);
 	len = strlen(newitem->name);
 	if (len > ref_list->maxwidth)
@@ -296,8 +279,15 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 	struct ref_list ref_list;
 
 	memset(&ref_list, 0, sizeof(ref_list));
+	if (kinds & REF_LOCAL_BRANCH) {
+		ref_list.kinds = REF_LOCAL_BRANCH;
+		for_each_branch_ref(append_ref, &ref_list);
+	}
+	if (kinds & REF_REMOTE_BRANCH) {
+		ref_list.kinds = REF_REMOTE_BRANCH;
+		for_each_remote_ref(append_ref, &ref_list);
+	}
 	ref_list.kinds = kinds;
-	for_each_ref(append_ref, &ref_list);
 
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
-- 
1.5.3.4.206.g58ba4
