From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add '-z' to merge-tree.c
Date: Fri, 15 Apr 2005 18:17:57 -0700
Message-ID: <7vekdbfrju.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 03:14:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMbtO-0007y6-Jw
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 03:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVDPBSK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 21:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVDPBSK
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 21:18:10 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39605 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262517AbVDPBR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 21:17:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416011758.QGDM1497.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 21:17:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

    this adds '-z' to merge-tree and changes its default line
termination to LF to make it consistent with your other recent
changes.

The patch is against
    commit 028c5948257e763b3deb391e567b624eb7975ec2
    tree   6b866e10b16183e630db8449c64899f6810d4270

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 merge-tree.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

--- ,,linus/merge-tree.c	2005-04-15 18:09:29.000000000 -0700
+++ ./merge-tree.c	2005-04-15 17:55:42.000000000 -0700
@@ -1,5 +1,7 @@
 #include "cache.h"
 
+static int line_termination = '\n';
+
 struct tree_entry {
 	unsigned mode;
 	unsigned char *sha1;
@@ -35,7 +37,8 @@ static struct tree_entry *read_tree(unsi
 
 static void show(const struct tree_entry *a, const char *path)
 {
-	printf("select %o %s %s%c", a->mode, sha1_to_hex(a->sha1), path, 0);
+	printf("select %o %s %s%c", a->mode, sha1_to_hex(a->sha1), path,
+	       line_termination);
 }
 
 static void merge(const struct tree_entry *a, const struct tree_entry *b, const struct tree_entry *c, const char *path)
@@ -46,7 +49,7 @@ static void merge(const struct tree_entr
 	strcpy(hex_c, sha1_to_hex(c->sha1));
 	printf("merge %o->%o,%o %s->%s,%s %s%c",
 		a->mode, b->mode, c->mode,
-		hex_a, hex_b, hex_c, path, 0);
+		hex_a, hex_b, hex_c, path, line_termination);
 }
 
 static int same(const struct tree_entry *a, const struct tree_entry *b)
@@ -114,15 +117,29 @@ static void merge_tree(struct tree_entry
 	}
 }
 
+static const char *merge_tree_usage =
+    "merge-tree [-z] <src> <dst1> <dst2>";
+
 int main(int argc, char **argv)
 {
 	unsigned char src[20], dst1[20], dst2[20];
 
+	while ((1 < argc) && argv[1][0] == '-') {
+		switch (argv[1][1]) {
+		case 'z':
+			line_termination = 0;
+			break;
+		default:
+			usage(merge_tree_usage);
+		}
+		argc--; argv++;
+	}
+
 	if (argc != 4 ||
 	    get_sha1_hex(argv[1], src) ||
 	    get_sha1_hex(argv[2], dst1) ||
 	    get_sha1_hex(argv[3], dst2))
-		usage("merge-tree <src> <dst1> <dst2>");
+		usage(merge_tree_usage);
 	merge_tree(read_tree(src), read_tree(dst1), read_tree(dst2));
 	return 0;
 }


