From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add --ignore-errors to git-add to allow it to skip files
	with read errors
Date: Mon, 12 May 2008 19:58:29 +0200
Message-ID: <20080512175829.GE3128@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org> <20080512175654.GB3128@steel.home> <20080512175745.GC3128@steel.home> <20080512175810.GD3128@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 12 19:59:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvcJ0-000773-IF
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 19:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070AbYELR6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 13:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbYELR6b
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 13:58:31 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:30722 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969AbYELR6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 13:58:31 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+BInc
Received: from tigra.home (Fab5c.f.strato-dslnet.de [195.4.171.92])
	by post.webmailer.de (mrclete mo15) (RZmta 16.34)
	with ESMTP id U00206k4CDgR9W ; Mon, 12 May 2008 19:58:29 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6F350277BD;
	Mon, 12 May 2008 19:58:29 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 854AC56D28; Mon, 12 May 2008 19:58:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080512175810.GD3128@steel.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81890>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Documentation/git-add.txt |    7 ++++++-
 builtin-add.c             |   11 +++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e0e730b..bb4abe2 100644
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
@@ -83,6 +83,11 @@ OPTIONS
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
index 7862808..522519e 100644
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
@@ -274,8 +278,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 
 	for (i = 0; i < dir.nr; i++)
-		if (add_file_to_cache(dir.entries[i]->name, verbose))
-			die("adding files failed");
+		if (add_file_to_cache(dir.entries[i]->name, verbose)) {
+			if (!ignore_add_errors)
+				die("adding files failed");
+			exit_status = 1;
+		}
 
  finish:
 	if (active_cache_changed) {
-- 
1.5.5.1.184.g5bee
