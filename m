From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] show-diff -z option for machine readable output.
Date: Sat, 16 Apr 2005 16:30:39 -0700
Message-ID: <7vr7ha47vk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 01:27:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwh6-0004RM-Qp
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVDPXbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVDPXbA
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:31:00 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8911 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261197AbVDPXap (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 19:30:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416233040.LUCD13104.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 19:30:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds the -z option to the show-diff command,
primarily for use by scripts.  The information emitted is
similar to that of -q option, but in a more machine readable
form.  Records are terminated with NUL instead of LF, so that
the scripts can deal with pathnames with embedded newlines.

To be applied on top of my previous patch:

    [PATCH] Optionally tell show-diff to show only named files.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

show-diff.c: 0c5fb1a381a6c6689dca3f52d0c66bb591cadb39
--- show-diff.c
+++ show-diff.c	2005-04-16 16:23:40.000000000 -0700
@@ -55,7 +55,7 @@
 	}
 }
 
-static const char *show_diff_usage = "show-diff [-s] [-q] [paths...]";
+static const char *show_diff_usage = "show-diff [-s] [-q] [-z] [paths...]";
 
 static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
 {
@@ -76,6 +76,7 @@
 {
 	int silent = 0;
 	int silent_on_nonexisting_files = 0;
+	int machine_readable = 0;
 	int entries = read_cache();
 	int i;
 
@@ -84,6 +85,9 @@
 			silent_on_nonexisting_files = silent = 1;
 		else if (!strcmp(argv[1], "-q"))
 			silent_on_nonexisting_files = 1;
+		else if (!strcmp(argv[1], "-z")) {
+			machine_readable = 1;
+		}
 		else
 			usage(show_diff_usage);
 		argv++; argc--;
@@ -99,7 +103,7 @@
 	for (i = 0; i < entries; i++) {
 		struct stat st;
 		struct cache_entry *ce = active_cache[i];
-		int n, changed;
+		int changed;
 		unsigned long size;
 		char type[20];
 		void *new;
@@ -111,18 +115,24 @@
 		if (stat(ce->name, &st) < 0) {
 			if (errno == ENOENT && silent_on_nonexisting_files)
 				continue;
-			printf("%s: %s\n", ce->name, strerror(errno));
-			if (errno == ENOENT)
-				show_diff_empty(ce);
+			if (machine_readable)
+				printf("X %s%c", ce->name, 0);
+			else {
+				printf("%s: %s\n", ce->name, strerror(errno));
+				if (errno == ENOENT)
+					show_diff_empty(ce);
+			}
 			continue;
 		}
 		changed = cache_match_stat(ce, &st);
 		if (!changed)
 			continue;
-		printf("%s:  ", ce->name);
-		for (n = 0; n < 20; n++)
-			printf("%02x", ce->sha1[n]);
-		printf("\n");
+		if (!machine_readable)
+			printf("%s: %s\n", ce->name, sha1_to_hex(ce->sha1));
+		else {
+			printf("%s %s%c", sha1_to_hex(ce->sha1), ce->name, 0);
+			continue;
+		}
 		fflush(stdout);
 		if (silent)
 			continue;

