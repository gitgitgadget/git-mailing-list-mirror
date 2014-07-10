From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] merge: simplify merge_trivial() by using commit_list_append()
Date: Thu, 10 Jul 2014 11:41:40 +0200
Message-ID: <53BE5FD4.1050707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 11:42:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Arf-0004zx-Dp
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 11:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbaGJJmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 05:42:01 -0400
Received: from mout.web.de ([212.227.17.11]:56535 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbaGJJmA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 05:42:00 -0400
Received: from [192.168.178.27] ([79.253.174.99]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MfHfy-1XFWhb0lhq-00OlCv; Thu, 10 Jul 2014 11:41:49
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:gBcEa70TpKzO/aXkU5F4eFzJC6335a98ICm+hJeA0iwGIFWvVEq
 WaD0ij1QT+OzGdQLOmCQ4/wqyRXfr29OmOgF9Unm9xogP0Abw/t3ncjGhbHJykyGdNrdGrg
 cr84Cli1sQi54eVL7aOj9LCFVSrZ1BCXq+90YC+7o+5MBmPqEyvQHNzvCjOS5xzjanR0YNj
 fezIiFYhmXNziyzfmBzig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253182>

Build the commit_list of parents by calling commit_list_append() twice
instead of allocating and linking the items by hand.  This makes the
code shorter and simpler.  Rename the commit_list from parent to parents
(plural) while at it because there are two of them.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/merge.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b49c310..f50270e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -843,16 +843,14 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 {
 	unsigned char result_tree[20], result_commit[20];
-	struct commit_list *parent = xmalloc(sizeof(*parent));
+	struct commit_list *parents, **pptr = &parents;
 
 	write_tree_trivial(result_tree);
 	printf(_("Wonderful.\n"));
-	parent->item = head;
-	parent->next = xmalloc(sizeof(*parent->next));
-	parent->next->item = remoteheads->item;
-	parent->next->next = NULL;
+	pptr = commit_list_append(head, pptr);
+	pptr = commit_list_append(remoteheads->item, pptr);
 	prepare_to_commit(remoteheads);
-	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parent,
+	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
 			result_commit, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	finish(head, remoteheads, result_commit, "In-index merge");
-- 
2.0.0
