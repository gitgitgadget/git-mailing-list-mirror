From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] builtin-add.c: restructure the code for
 maintainability
Date: Sat, 19 Jul 2008 23:09:01 -0700
Message-ID: <1216534144-23826-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 08:10:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKS7X-0004TW-TG
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 08:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbYGTGJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 02:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbYGTGJL
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 02:09:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYGTGJK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 02:09:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A10073CC3B
	for <git@vger.kernel.org>; Sun, 20 Jul 2008 02:09:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A34A33CC3A for <git@vger.kernel.org>; Sun, 20 Jul 2008 02:09:06
 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.4.570.g052e6
X-Pobox-Relay-ID: 5CC7FDEA-5622-11DD-B61A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89159>

The implementation of "git add" has four major codepaths that are mutually
exclusive:

 - if "--interactive" or "--patch" is given, spawn "git add--interactive"
   and exit without doing anything else.  Otherwise things are handled
   internally in this C code;

 - if "--update" is given, update the modified files and exit without
   doing anything else;

 - if "--refresh" is given, do refresh and exit without doing anything
   else;

 - otherwise, find the paths that match pathspecs and stage their
   contents.

It led to an unholy mess in the code structure; each of the latter three
codepaths has a separate call to read_cache(), even though they are all
about "read the current index, update it and write it back", and logically
they should read the index once _anyway_.

This cleans up the latter three cases by introducing a pair of helper
variables:

 - "add_new_files" is set if we need to scan the working tree for paths
   that match the pathspec.  This variable is false for "--update" and
   "--refresh", because they only work on already tracked files.

 - "require_pathspec" is set if the user must give at least one pathspec.
   "--update" does not need it but all the other cases do.

This is in preparation for introducing a new option "--all", that does the
equivalent of "git add -u && git add ." (aka "addremove").

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c |   75 ++++++++++++++++++++++++++++++++------------------------
 1 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index bf13aa3..9b2ee8c 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -140,8 +140,6 @@ static void refresh(int verbose, const char **pathspec)
 	for (specs = 0; pathspec[specs];  specs++)
 		/* nothing */;
 	seen = xcalloc(specs, 1);
-	if (read_cache() < 0)
-		die("index file corrupt");
 	refresh_index(&the_index, verbose ? 0 : REFRESH_QUIET, pathspec, seen);
 	for (i = 0; i < specs; i++) {
 		if (!seen[i])
@@ -216,13 +214,36 @@ static int add_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static int add_files(struct dir_struct *dir, int flags)
+{
+	int i, exit_status = 0;
+
+	if (dir->ignored_nr) {
+		fprintf(stderr, ignore_error);
+		for (i = 0; i < dir->ignored_nr; i++)
+			fprintf(stderr, "%s\n", dir->ignored[i]->name);
+		fprintf(stderr, "Use -f if you really want to add them.\n");
+		die("no files added");
+	}
+
+	for (i = 0; i < dir->nr; i++)
+		if (add_file_to_cache(dir->entries[i]->name, flags)) {
+			if (!ignore_add_errors)
+				die("adding files failed");
+			exit_status = 1;
+		}
+	return exit_status;
+}
+
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
-	int i, newfd;
+	int newfd;
 	const char **pathspec;
 	struct dir_struct dir;
 	int flags;
+	int add_new_files;
+	int require_pathspec;
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
@@ -233,53 +254,43 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	git_config(add_config, NULL);
 
+	add_new_files = !take_worktree_changes && !refresh_only;
+	require_pathspec = !take_worktree_changes;
+
 	newfd = hold_locked_index(&lock_file, 1);
 
 	flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
 		 (show_only ? ADD_CACHE_PRETEND : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0));
 
-	if (take_worktree_changes) {
-		const char **pathspec;
-		if (read_cache() < 0)
-			die("index file corrupt");
-		pathspec = get_pathspec(prefix, argv);
-		exit_status = add_files_to_cache(prefix, pathspec, flags);
-		goto finish;
-	}
-
-	if (argc == 0) {
+	if (require_pathspec && argc == 0) {
 		fprintf(stderr, "Nothing specified, nothing added.\n");
 		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
 		return 0;
 	}
 	pathspec = get_pathspec(prefix, argv);
 
-	if (refresh_only) {
-		refresh(verbose, pathspec);
-		goto finish;
-	}
-
-	fill_directory(&dir, pathspec, ignored_too);
+	/*
+	 * If we are adding new files, we need to scan the working
+	 * tree to find the ones that match pathspecs; this needs
+	 * to be done before we read the index.
+	 */
+	if (add_new_files)
+		fill_directory(&dir, pathspec, ignored_too);
 
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	if (dir.ignored_nr) {
-		fprintf(stderr, ignore_error);
-		for (i = 0; i < dir.ignored_nr; i++) {
-			fprintf(stderr, "%s\n", dir.ignored[i]->name);
-		}
-		fprintf(stderr, "Use -f if you really want to add them.\n");
-		die("no files added");
+	if (refresh_only) {
+		refresh(verbose, pathspec);
+		goto finish;
 	}
 
-	for (i = 0; i < dir.nr; i++)
-		if (add_file_to_cache(dir.entries[i]->name, flags)) {
-			if (!ignore_add_errors)
-				die("adding files failed");
-			exit_status = 1;
-		}
+	if (take_worktree_changes)
+		exit_status |= add_files_to_cache(prefix, pathspec, flags);
+
+	if (add_new_files)
+		exit_status |= add_files(&dir, flags);
 
  finish:
 	if (active_cache_changed) {
-- 
1.5.6.4.570.g052e6
