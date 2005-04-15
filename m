From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] trivial argument parsing patches
Date: Fri, 15 Apr 2005 21:28:01 +1000
Message-ID: <16991.42305.118284.139777@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 15 13:25:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMOwK-0000uU-6f
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 13:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVDOL2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 07:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVDOL2P
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 07:28:15 -0400
Received: from ozlabs.org ([203.10.76.45]:33440 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261743AbVDOL2I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 07:28:08 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8895767B88; Fri, 15 Apr 2005 21:28:06 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In perusing the git code, I noticed some errors in argument parsing,
which the patch below fixes.  The show-diff error (checking argv[1]
each time around the loop) probably doesn't actually cause any real
problem, but it could be confusing for a novice if "show-diff x"
produces an error but "show-diff -s x" doesn't (and ignores the extra
argument).

Signed-off-by: Paul Mackerras <paulus@samba.org>

rev-tree.c:  7bf9e9a92f528485360f374239809714ce7a19f5
--- rev-tree.c
+++ rev-tree.c	2005-04-15 21:17:16.000000000 +1000
@@ -189,8 +189,8 @@
 		char *arg = argv[i];
 
 		if (!strcmp(arg, "--cache")) {
-			read_cache_file(argv[2]);
 			i++;
+			read_cache_file(argv[i]);
 			continue;
 		}
 
show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
--- show-diff.c
+++ show-diff.c	2005-04-15 21:22:28.000000000 +1000
@@ -61,12 +61,10 @@
 	int entries = read_cache();
 	int i;
 
-	while (argc-- > 1) {
-		if (!strcmp(argv[1], "-s")) {
-			silent = 1;
-			continue;
-		}
-		usage("show-diff [-s]");
+	if (argc > 1) {
+		if (argc > 2 || strcmp(argv[1], "-s"))
+			usage("show-diff [-s]");
+		silent = 1;
 	}
 
 	if (entries < 0) {
