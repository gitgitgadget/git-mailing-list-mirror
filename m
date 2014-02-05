From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 1/4] tree-diff: allow diff_tree_sha1 to accept NULL sha1
Date: Wed,  5 Feb 2014 20:57:09 +0400
Message-ID: <5a71a2ddf1610b1a52d054b3f986c47f15d0412a.1391619218.git.kirr@mns.spb.ru>
References: <cover.1391619218.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 17:55:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB5lK-0000Qd-JD
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 17:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbaBEQzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 11:55:41 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:60071 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbaBEQzk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 11:55:40 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WB5lB-0004Ch-VL; Wed, 05 Feb 2014 20:55:38 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WB5my-0004zH-MM; Wed, 05 Feb 2014 20:57:28 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391619218.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391619218.git.kirr@mns.spb.ru>
References: <cover.1391619218.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241607>

which would mean that corresponding tree - old or new - is empty.

As followup patches will show, that functionality was already needed in
several places of Git codebase, but there, we were preparing empty
tree_desc objects by hand, with some code duplication.

For handling sha1 = NULL case, let's reuse fill_tree_descriptor() which
returns just empty tree_desc in that case.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 tree-diff.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index f7b3ade..f438478 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -287,14 +287,10 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 	unsigned long size1, size2;
 	int retval;
 
-	tree1 = read_object_with_reference(old, tree_type, &size1, NULL);
-	if (!tree1)
-		die("unable to read source tree (%s)", sha1_to_hex(old));
-	tree2 = read_object_with_reference(new, tree_type, &size2, NULL);
-	if (!tree2)
-		die("unable to read destination tree (%s)", sha1_to_hex(new));
-	init_tree_desc(&t1, tree1, size1);
-	init_tree_desc(&t2, tree2, size2);
+	tree1 = fill_tree_descriptor(&t1, old);
+	tree2 = fill_tree_descriptor(&t2, new);
+	size1 = t1.size;
+	size2 = t2.size;
 	retval = diff_tree(&t1, &t2, base, opt);
 	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename()) {
 		init_tree_desc(&t1, tree1, size1);
-- 
1.9.rc1.181.g641f458
