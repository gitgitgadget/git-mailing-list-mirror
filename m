From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add --ignore-errors to git-add to allow it to skip files
	with read errors
Date: Sun, 2 Mar 2008 16:44:00 +0100
Message-ID: <20080302154400.GF2973@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <20080302154321.GE2973@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:45:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqNJ-0002yF-Px
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbYCBPoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbYCBPoE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:44:04 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:38899 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbYCBPoB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:44:01 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKcp6o=
Received: from tigra.home (Fab7c.f.strato-dslnet.de [195.4.171.124])
	by post.webmailer.de (fruni mo58) (RZmta 16.8)
	with ESMTP id p07320k22FX576 ; Sun, 2 Mar 2008 16:44:00 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 249E7277BD;
	Sun,  2 Mar 2008 16:44:00 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 1B6FF56D24; Sun,  2 Mar 2008 16:44:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080302154321.GE2973@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75792>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Documentation/git-add.txt |    7 ++++++-
 builtin-add.c             |   11 +++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 4779909..9360a4f 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-add' [-n] [-v] [-f] [--interactive | -i] [--patch | -p] [-u] [--refresh]
-          [--] <filepattern>...
+	  [--ignore-errors] [--] <filepattern>...
 
 DESCRIPTION
 -----------
@@ -81,6 +81,11 @@ OPTIONS
 	Don't add the file(s), but only refresh their stat()
 	information in the index.
 
+\--ignore-errors::
+	If some files could not be added because of errors indexing
+	them, do not abort the operation, but continue adding the
+	others. The command shall still exit with non-zero status.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
diff --git a/builtin-add.c b/builtin-add.c
index bc55a0e..b67ad3f 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -191,6 +191,7 @@ static const char ignore_error[] =
 "The following paths are ignored by one of your .gitignore files:\n";
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
+static int ignore_add_errors;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only),
@@ -201,6 +202,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOLEAN('f', NULL, &ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update tracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
+	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip files which cannot be added because of errors"),
 	OPT_END(),
 };
 
@@ -231,6 +233,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 		if (verbose)
 			flags |= ADD_FILES_VERBOSE;
+		if (ignore_add_errors)
+			flags |= ADD_FILES_IGNORE_ERRORS;
 
 		exit_status = add_files_to_cache(prefix, pathspec, flags);
 		goto finish;
@@ -286,8 +290,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 
 	for (i = 0; i < dir.nr; i++)
-		if (add_file_to_cache(dir.entries[i]->name, verbose))
-			exit(1);
+		if (add_file_to_cache(dir.entries[i]->name, verbose)) {
+			if (!ignore_add_errors)
+				exit(1);
+			exit_status = 1;
+		}
 
  finish:
 	if (active_cache_changed) {
-- 
1.5.4.3.391.gf5a0c

