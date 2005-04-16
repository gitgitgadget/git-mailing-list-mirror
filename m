From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Add --stage to show-files for new stage dircache.
Date: Sat, 16 Apr 2005 03:42:11 -0700
Message-ID: <7vbr8fatq4.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
	<7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
	<7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org>
	<7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
	<Pine.LNX.4.58.0504152256520.7211@ppc970.osdl.org>
	<7vis2ncf8j.fsf@assigned-by-dhc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 12:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMkhT-0001uc-US
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 12:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVDPKmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 06:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVDPKmZ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 06:42:25 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:40140 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261966AbVDPKmN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 06:42:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416104212.VDNW2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 06:42:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vfyxrau23.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 16 Apr 2005 03:35:00 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds --stage option to show-files command.  It shows
file-mode, SHA1, stage and pathname.  Record separator follows
the usual convention of -z option as before.

The patch is on top of the byte order fix for create_ce_flags in my
previous message.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h      |   12 +++++++-----
 show-files.c |   22 ++++++++++++++++++----
 2 files changed, 25 insertions(+), 9 deletions(-)

--- cache.h	2005-04-16 03:02:36.000000000 -0700
+++ cache.h=show-files-stage-flags	2005-04-16 02:48:47.000000000 -0700
@@ -65,8 +65,14 @@
 
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
+#define CE_STAGESHIFT 12
 
-#define create_ce_flags(len, stage) htons((len) | ((stage) << 12))
+#define create_ce_flags(len, stage) htons((len) | ((stage) << CE_STAGESHIFT))
+#define ce_namelen(ce) (CE_NAMEMASK & ntohs((ce)->ce_flags))
+#define ce_size(ce) cache_entry_size(ce_namelen(ce))
+#define ce_stage(ce) ((CE_STAGEMASK & ntohs((ce)->ce_flags)) >> CE_STAGESHIFT)
+
+#define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
 
 const char *sha1_file_directory;
 struct cache_entry **active_cache;
@@ -75,10 +81,6 @@
 #define DB_ENVIRONMENT "SHA1_FILE_DIRECTORY"
 #define DEFAULT_DB_ENVIRONMENT ".git/objects"
 
-#define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
-#define ce_namelen(ce) (CE_NAMEMASK & ntohs((ce)->ce_flags))
-#define ce_size(ce) cache_entry_size(ce_namelen(ce))
-
 #define alloc_nr(x) (((x)+16)*3/2)
 
 /* Initialize and use the cache information */



--- show-files.c
+++ show-files.c	2005-04-16 02:58:32.000000000 -0700
@@ -14,6 +14,7 @@
 static int show_cached = 0;
 static int show_others = 0;
 static int show_ignored = 0;
+static int show_stage = 0;
 static int line_terminator = '\n';
 
 static const char **dir;
@@ -108,10 +109,19 @@
 		for (i = 0; i < nr_dir; i++)
 			printf("%s%c", dir[i], line_terminator);
 	}
-	if (show_cached) {
+	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
-			printf("%s%c", ce->name, line_terminator);
+			if (!show_stage)
+				printf("%s%c", ce->name, line_terminator);
+			else
+				printf(/* "%06o %s %d %10d %s%c", */
+				       "%06o %s %d %s%c",
+				       ntohl(ce->ce_mode),
+				       sha1_to_hex(ce->sha1),
+				       ce_stage(ce),
+				       /* ntohl(ce->ce_size), */
+				       ce->name, line_terminator); 
 		}
 	}
 	if (show_deleted) {
@@ -156,12 +166,16 @@
 			show_ignored = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--stage")) {
+			show_stage = 1;
+			continue;
+		}
 
-		usage("show-files (--[cached|deleted|others|ignored])*");
+		usage("show-files [-z] (--[cached|deleted|others|ignored|stage])*");
 	}
 
 	/* With no flags, we default to showing the cached files */
-	if (!(show_cached | show_deleted | show_others | show_ignored))
+	if (!(show_stage | show_deleted | show_others | show_ignored))
 		show_cached = 1;
 
 	read_cache();

