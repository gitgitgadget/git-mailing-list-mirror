From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-fsck: add --lost-found option
Date: Tue, 3 Jul 2007 01:33:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707030133060.4071@racer.site>
References: <Pine.LNX.4.64.0707021751380.4071@racer.site>
 <7vabuewgdb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707030018120.4071@racer.site>
 <7vps3auz5y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 02:34:05 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5WLE-00038S-IZ
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 02:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207AbXGCAd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 20:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756014AbXGCAd7
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 20:33:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:59508 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755859AbXGCAd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 20:33:58 -0400
Received: (qmail invoked by alias); 03 Jul 2007 00:33:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 03 Jul 2007 02:33:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iDPAQ49aigNWd4S4aY2jBREswM2raAzAGHuiOdx
	PmYrxDZ86kJrk+
X-X-Sender: gene099@racer.site
In-Reply-To: <7vps3auz5y.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51435>


With this option, dangling objects are not only reported, but also
written to .git/lost-found/commit/ or .git/lost-found/other/. This
option implies '--full' and '--no-reflogs'.

'git fsck --lost-found' is meant as a replacement for git-lost-found.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Step 1.

 Documentation/git-fsck.txt |    6 +++++-
 builtin-fsck.c             |   22 ++++++++++++++++++++++
 t/t1420-lost-found.sh      |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletions(-)
 create mode 100755 t/t1420-lost-found.sh

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 234c22f..08512e0 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
-		 [--full] [--strict] [--verbose] [<object>*]
+	 [--full] [--strict] [--verbose] [--lost-found] [<object>*]
 
 DESCRIPTION
 -----------
@@ -64,6 +64,10 @@ index file and all SHA1 references in .git/refs/* as heads.
 --verbose::
 	Be chatty.
 
+--lost-found::
+	Write dangling refs into .git/commit/ or .git/other/, depending
+	on type.
+
 It tests SHA1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 944a496..a6ef65e 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -20,6 +20,7 @@ static int check_strict;
 static int keep_cache_objects;
 static unsigned char head_sha1[20];
 static int errors_found;
+static int write_lost_and_found;
 static int verbose;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
@@ -138,6 +139,21 @@ static void check_unreachable_object(struct object *obj)
 	if (!obj->used) {
 		printf("dangling %s %s\n", typename(obj->type),
 		       sha1_to_hex(obj->sha1));
+		if (write_lost_and_found) {
+			char *filename = git_path("lost-found/%s/%s",
+				obj->type == OBJ_COMMIT ? "commit" : "other",
+				sha1_to_hex(obj->sha1));
+			FILE *f;
+
+			if (safe_create_leading_directories(filename)) {
+				error("Could not create lost-found");
+				return;
+			}
+			if (!(f = fopen(filename, "w")))
+				die("Could not open %s", filename);
+			fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
+			fclose(f);
+		}
 		return;
 	}
 
@@ -685,6 +701,12 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 			verbose = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--lost-found")) {
+			check_full = 1;
+			include_reflogs = 0;
+			write_lost_and_found = 1;
+			continue;
+		}
 		if (*arg == '-')
 			usage(fsck_usage);
 	}
diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
new file mode 100755
index 0000000..dc9e402
--- /dev/null
+++ b/t/t1420-lost-found.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='Test fsck --lost-found'
+. ./test-lib.sh
+
+test_expect_success setup '
+	git config core.logAllRefUpdates 0 &&
+	: > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m initial &&
+	echo 1 > file1 &&
+	echo 2 > file2 &&
+	git add file1 file2 &&
+	test_tick &&
+	git commit -m second &&
+	echo 3 > file3 &&
+	git add file3
+'
+
+test_expect_success 'lost and found something' '
+	git rev-parse HEAD > lost-commit &&
+	git rev-parse :file3 > lost-other &&
+	test_tick &&
+	git reset --hard HEAD^ &&
+	git fsck --lost-found &&
+	test 2 = $(ls .git/lost-found/*/* | wc -l) &&
+	test -f .git/lost-found/commit/$(cat lost-commit) &&
+	test -f .git/lost-found/other/$(cat lost-other)
+'
+
+test_done
-- 
1.5.2.2.3296.g5753c-dirty
