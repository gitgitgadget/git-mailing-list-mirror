From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix up some fallout from "setup_git_directory()" cleanups
Date: Mon, 31 Jul 2006 13:13:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607311311060.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jul 31 22:14:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7e9P-000794-E5
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 22:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWGaUOD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 16:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWGaUOD
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 16:14:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932484AbWGaUOB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 16:14:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6VKDunW004193
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Jul 2006 13:13:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6VKDtKX018873;
	Mon, 31 Jul 2006 13:13:55 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.498 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24542>


git-ls-files was broken by the setup_git_directory() calling changes, 
because I had missed the fact that the "prefix" variable in that file was 
static to the whole file, and unlike git-ls-tree (where I had fixed it 
up), it ended up using two different variables with the same name 
depending on what the scoping happened to be.

This fixes it up properly (by just removing the static variable, and 
passing the automatic one around properly), and git-ls-files should work 
again.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Sorry about that.

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 79ffe8f..11386c4 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -24,7 +24,6 @@ static int show_valid_bit = 0;
 static int line_terminator = '\n';
 
 static int prefix_len = 0, prefix_offset = 0;
-static const char *prefix = NULL;
 static const char **pathspec = NULL;
 static int error_unmatch = 0;
 static char *ps_matched = NULL;
@@ -207,7 +206,7 @@ static void show_ce_entry(const char *ta
 	}
 }
 
-static void show_files(struct dir_struct *dir)
+static void show_files(struct dir_struct *dir, const char *prefix)
 {
 	int i;
 
@@ -253,7 +252,7 @@ static void show_files(struct dir_struct
 /*
  * Prune the index to only contain stuff starting with "prefix"
  */
-static void prune_cache(void)
+static void prune_cache(const char *prefix)
 {
 	int pos = cache_name_pos(prefix, prefix_len);
 	unsigned int first, last;
@@ -276,7 +275,7 @@ static void prune_cache(void)
 	active_nr = last;
 }
 
-static void verify_pathspec(void)
+static const char *verify_pathspec(const char *prefix)
 {
 	const char **p, *n, *prev;
 	char *real_prefix;
@@ -313,7 +312,7 @@ static void verify_pathspec(void)
 		memcpy(real_prefix, prev, max);
 		real_prefix[max] = 0;
 	}
-	prefix = real_prefix;
+	return real_prefix;
 }
 
 static const char ls_files_usage[] =
@@ -453,7 +452,7 @@ int cmd_ls_files(int argc, const char **
 
 	/* Verify that the pathspec matches the prefix */
 	if (pathspec)
-		verify_pathspec();
+		prefix = verify_pathspec(prefix);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec && error_unmatch) {
@@ -476,8 +475,8 @@ int cmd_ls_files(int argc, const char **
 
 	read_cache();
 	if (prefix)
-		prune_cache();
-	show_files(&dir);
+		prune_cache(prefix);
+	show_files(&dir, prefix);
 
 	if (ps_matched) {
 		/* We need to make sure all pathspec matched otherwise
