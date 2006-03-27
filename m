From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix error handling for nonexistent names
Date: Sun, 26 Mar 2006 16:28:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603261620130.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Mar 27 02:28:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNfbE-0006SB-4D
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 02:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWC0A2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 19:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWC0A23
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 19:28:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932274AbWC0A22 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 19:28:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2R0SODZ012101
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Mar 2006 16:28:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2R0SKWx023820;
	Sun, 26 Mar 2006 16:28:23 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18069>


[ This is an expanded version of a patch I sent out earlier: the 
  "rev-parse.c" part of it is identical to the earlier version, the 
  revision.c thing is new ]

When passing in a pathname pattern without the "--" separator on the 
command line, we verify that the pathnames in question exist. However, 
there were two bugs in that verification: 

 - git-rev-parse would only check the first pathname, and silently allow 
   any invalid subsequent pathname, whether it existed or not (which 
   defeats the purpose of the check, and is also inconsistent with what 
   git-rev-list actually does)

 - git-rev-list (and "git log" etc) would check each filename, but if the 
   check failed, it would print the error using the first one, ie:

	[torvalds@g5 git]$ git log Makefile bad-file
	fatal: 'Makefile': No such file or directory

   instead of saying that it's 'bad-file' that doesn't exist.

This fixes both bugs.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/rev-parse.c b/rev-parse.c
index 19a5ef7..8ca1c69 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -174,7 +174,9 @@ int main(int argc, char **argv)
 		char *dotdot;
 	
 		if (as_is) {
-			show_file(arg);
+			if (show_file(arg) && as_is < 2)
+				if (lstat(arg, &st) < 0)
+					die("'%s': %s", arg, strerror(errno));
 			continue;
 		}
 		if (!strcmp(arg,"-n")) {
@@ -194,7 +196,7 @@ int main(int argc, char **argv)
 
 		if (*arg == '-') {
 			if (!strcmp(arg, "--")) {
-				as_is = 1;
+				as_is = 2;
 				/* Pass on the "--" if we show anything but files.. */
 				if (filter & (DO_FLAGS | DO_REVS))
 					show_file(arg);
diff --git a/revision.c b/revision.c
index 12cd052..d67718c 100644
--- a/revision.c
+++ b/revision.c
@@ -649,7 +649,7 @@ int setup_revisions(int argc, const char
 			/* If we didn't have a "--", all filenames must exist */
 			for (j = i; j < argc; j++) {
 				if (lstat(argv[j], &st) < 0)
-					die("'%s': %s", arg, strerror(errno));
+					die("'%s': %s", argv[j], strerror(errno));
 			}
 			revs->prune_data = get_pathspec(revs->prefix, argv + i);
 			break;
