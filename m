From: Andreas Gal <gal@uci.edu>
Subject: [PATCH] Add -u option to diff-cache to show UNCHANGED files
Date: Sat, 23 Apr 2005 20:28:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504232022180.4690@sam.ics.uci.edu>
References: <Pine.LNX.4.21.0504232003490.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0504231906110.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 05:23:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPXic-0002yX-Sl
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 05:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVDXD2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 23:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVDXD2Z
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 23:28:25 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:47765 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S262238AbVDXD2T (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 23:28:19 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3O3SHF6004856;
	Sat, 23 Apr 2005 20:28:17 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3O3SH8U004852;
	Sat, 23 Apr 2005 20:28:17 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231906110.2344@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


With -u diff-cache shows unchanged files, instead of files that changed. 
This is useful to implement a "git clean" command that throws away all 
checked out files that have not changed (yes, I really would like to 
have that). One could also do show-files and then substract the 
diff-cache output from it, but thats slow and clumsy. 

Signed-off-by: Andreas Gal <gal@uci.edu>

--- b407d753e520fa0b1523d770d98b3015af197275/diff-cache.c
+++ diff-cache.c
@@ -2,6 +2,7 @@
 
 static int cached_only = 0;
 static int line_termination = '\n';
+static int show_unchanged = 0;
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce)
@@ -32,7 +33,7 @@
 	}
 
 	oldmode = ntohl(old->ce_mode);
-	if (mode == oldmode && !memcmp(sha1, old->sha1, 20))
+	if ((mode == oldmode && !memcmp(sha1, old->sha1, 20)) != show_unchanged)
 		return 0;
 
 	strcpy(old_sha1_hex, sha1_to_hex(old->sha1));
@@ -85,7 +86,7 @@
 	}
 }
 
-static char *diff_cache_usage = "diff-cache [-r] [-z] [--cached] <tree sha1>";
+static char *diff_cache_usage = "diff-cache [-r] [-u] [-z] [--cached] <tree sha1>";
 
 int main(int argc, char **argv)
 {
@@ -102,6 +103,10 @@
 			/* We accept the -r flag just to look like diff-tree */
 			continue;
 		}
+		if (!strcmp(arg, "-u")) {
+			show_unchanged = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-z")) {
 			line_termination = '\0';
 			continue;
