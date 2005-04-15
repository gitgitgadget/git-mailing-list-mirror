From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] merge-trees script for Linus git
Date: Fri, 15 Apr 2005 14:54:12 -0700
Message-ID: <7vbr8fhfjv.fsf@assigned-by-dhcp.cox.net>
References: <7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 23:51:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMYiB-00051c-3s
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 23:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVDOVyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 17:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVDOVyV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 17:54:21 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:21647 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261977AbVDOVyO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 17:54:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415215413.THLU22013.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 17:54:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

This is the '-q' option for show-diff.c to squelch complaints for
missing files.  It is handy if you want to run it in the merge
temporary directory after running merge-trees with its minimum
checkout mode, which is the default, because you would not find any
files other than the ones that needs human validation after the merge
there.

It also fixes the argument parsing bug Paul Mackerras noticed in
<16991.42305.118284.139777@cargo.ozlabs.ibm.com> but slightly
differently.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 
 show-diff.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

show-diff.c:  3f7acd2a692a03026784a18f28521b9af322b71e
--- show-diff.c
+++ show-diff.c	2005-04-15 14:14:53.000000000 -0700
@@ -58,15 +58,20 @@
 int main(int argc, char **argv)
 {
 	int silent = 0;
+	int silent_on_nonexisting_files = 0;
 	int entries = read_cache();
 	int i;
 
-	while (argc-- > 1) {
-		if (!strcmp(argv[1], "-s")) {
-			silent = 1;
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "-s")) {
+			silent_on_nonexisting_files = silent = 1;
 			continue;
 		}
-		usage("show-diff [-s]");
+		if (!strcmp(argv[i], "-q")) {
+			silent_on_nonexisting_files = 1;
+			continue;
+		}
+		usage("show-diff [-s] [-q]");
 	}
 
 	if (entries < 0) {
@@ -82,8 +87,10 @@
 		void *new;
 
 		if (stat(ce->name, &st) < 0) {
+			if (errno == ENOENT && silent_on_nonexisting_files)
+				continue;
 			printf("%s: %s\n", ce->name, strerror(errno));
-			if (errno == ENOENT && !silent)
+			if (errno == ENOENT)
 				show_diff_empty(ce);
 			continue;
 		}


