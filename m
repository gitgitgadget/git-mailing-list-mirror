From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] "git diff <tree>{3,}": do not reverse order of arguments
Date: Fri, 10 Oct 2008 21:56:15 -0400
Message-ID: <1223690175.2828.26.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 11 03:59:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoTlA-0000jh-RH
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 03:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbYJKB6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 21:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754599AbYJKB6A
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 21:58:00 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:53715 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbYJKB57 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 21:57:59 -0400
Received: from jankymail-a5.g.dreamhost.com (sd-green-bigip-66.dreamhost.com [208.97.132.66])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 61B8D1786B3
	for <git@vger.kernel.org>; Fri, 10 Oct 2008 18:57:58 -0700 (PDT)
Received: from [192.168.1.43] (pool-71-178-84-222.washdc.east.verizon.net [71.178.84.222])
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id 1F40013EE0;
	Fri, 10 Oct 2008 18:56:57 -0700 (PDT)
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97961>

According to the message of commit 0fe7c1de16f71312e6adac4b85bddf0d62a47168,
"git diff" with three or more trees expects the merged tree first followed by
the parents, in order.  However, this command reversed the order of its
arguments, resulting in confusing diffs.  A comment /* Again, the revs are all
reverse */ suggested there was a reason for this, but I can't figure out the
reason, so I removed the reversal of the arguments.  Test case included.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 builtin-diff.c                        |    4 +---
 t/t4013-diff-various.sh               |    1 +
 t/t4013/diff.diff_master_master^_side |   29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)
 create mode 100644 t/t4013/diff.diff_master_master^_side

diff --git a/builtin-diff.c b/builtin-diff.c
index 35da366..9c8c295 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -177,10 +177,8 @@ static int builtin_diff_combined(struct rev_info *revs,
 	if (!revs->dense_combined_merges && !revs->combine_merges)
 		revs->dense_combined_merges = revs->combine_merges = 1;
 	parent = xmalloc(ents * sizeof(*parent));
-	/* Again, the revs are all reverse */
 	for (i = 0; i < ents; i++)
-		hashcpy((unsigned char *)(parent + i),
-			ent[ents - 1 - i].item->sha1);
+		hashcpy((unsigned char *)(parent + i), ent[i].item->sha1);
 	diff_tree_combined(parent[0], parent + 1, ents - 1,
 			   revs->dense_combined_merges, revs);
 	return 0;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 1a6b522..fe6080d 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -258,6 +258,7 @@ diff --patch-with-stat -r initial..side
 diff --patch-with-raw -r initial..side
 diff --name-status dir2 dir
 diff --no-index --name-status dir2 dir
+diff master master^ side
 EOF
 
 test_done
diff --git a/t/t4013/diff.diff_master_master^_side b/t/t4013/diff.diff_master_master^_side
new file mode 100644
index 0000000..50ec9ca
--- /dev/null
+++ b/t/t4013/diff.diff_master_master^_side
@@ -0,0 +1,29 @@
+$ git diff master master^ side
+diff --cc dir/sub
+index cead32e,7289e35..992913c
+--- a/dir/sub
++++ b/dir/sub
+@@@ -1,6 -1,4 +1,8 @@@
+  A
+  B
+ +C
+ +D
+ +E
+ +F
++ 1
++ 2
+diff --cc file0
+index b414108,f4615da..10a8a9f
+--- a/file0
++++ b/file0
+@@@ -1,6 -1,6 +1,9 @@@
+  1
+  2
+  3
+ +4
+ +5
+ +6
++ A
++ B
++ C
+$
-- 
1.6.0.2.519.gf6ee
