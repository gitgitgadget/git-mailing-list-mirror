From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH] Add support for -p/--patch to git-commit
Date: Sun, 26 Dec 2010 15:36:34 +0000
Message-ID: <E1PWsuV-0000FH-90@scarlatti.dunvegan.biz>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Dec 26 16:56:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWsx2-0002Ne-Bf
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 16:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab0LZPzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 10:55:39 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58952 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab0LZPzi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 10:55:38 -0500
Received: by wyb28 with SMTP id 28so7944738wyb.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 07:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id:from:date
         :subject;
        bh=6BmDRgdYY6CdxjLW/6/U7XyHXvtvVwpJr7PAhlNXBWw=;
        b=qqNpqltRQR0zjG8UJUYidAzVCx2M45vm77PtGceEq5irKEBxkNRC336JQOidQR5ddi
         ppyz9jDmCOqiboXVouoACRHCvCeX5Igb2hbQpCHU2yaLbopYSON3SAcEQZX0Qn7HFfui
         YuwwMshGD+ISC2uq721crNfXhK/4Q9yptYiLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:date:subject;
        b=hSW4RZWmKf/QhhI6E3fLE/RmISCk/3vPvzuNHwPQugU6RO+p1IKJCEdFPOjjcwkxei
         4XSmY3FoSHxbPsvC3kh+X2f0Ot4Dh6wALIE+BpyEJ7U7bLwB4bbFglL+q2zOkOyzpfmx
         i1EIBvMVuvxHdMFuh6b8o1T4zEs3+ijDaJZHw=
Received: by 10.227.135.13 with SMTP id l13mr6752089wbt.84.1293378936660;
        Sun, 26 Dec 2010 07:55:36 -0800 (PST)
Received: from scarlatti.dunvegan.biz (host86-159-223-152.range86-159.btcentralplus.com [86.159.223.152])
        by mx.google.com with ESMTPS id m10sm7735591wbc.16.2010.12.26.07.55.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 07:55:36 -0800 (PST)
Received: from root by scarlatti.dunvegan.biz with local (Exim 4.72)
	(envelope-from <3f03ad057b1c7753ff4124efdba67e5f192346fb@scarlatti.dunvegan.biz>)
	id 1PWsuV-0000FH-90
	for git@vger.kernel.org; Sun, 26 Dec 2010 15:53:27 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164193>

This works in the same was as git commit --interactive, and is
equivalent to running git add -p before git commit.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---

Hello Git,

Please let me know of any mistakes I've made, this is a first for me.

While this patch works as advertised, I wonder if it would be nicer to
change the behaviour of git commit --interactive and git commit -p to
act on a temporary copy of the index rather than mutating the existing
index. I've no idea how to go about that yet, but is it something that
should be changed?

Conrad

 Documentation/git-commit.txt |   24 ++++++++++++++++--------
 builtin/add.c                |    6 +++---
 builtin/commit.c             |   11 ++++++-----
 commit.h                     |    2 +-
 4 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b586c0f..fe3a14f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,11 +8,12 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
-	   [(-c | -C | --fixup | --squash) <commit>] [-F <file> | -m <msg>]
-	   [--reset-author] [--allow-empty] [--allow-empty-message] [--no-verify]
-	   [-e] [--author=<author>] [--date=<date>] [--cleanup=<mode>]
-	   [--status | --no-status] [-i | -o] [--] [<file>...]
+'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
+	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
+	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
+	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
+	   [--date=<date>] [--cleanup=<mode>] [--status | --no-status]
+	   [-i | -o] [--] [<file>...]
 
 DESCRIPTION
 -----------
@@ -39,9 +40,10 @@ The content to be added can be specified in several ways:
    that have been removed from the working tree, and then perform the
    actual commit;
 
-5. by using the --interactive switch with the 'commit' command to decide one
-   by one which files should be part of the commit, before finalizing the
-   operation.  Currently, this is done by invoking 'git add --interactive'.
+5. by using the --interactive or --patch switches with the 'commit' command
+   to decide one by one which files or hunks should be part of the commit,
+   before finalizing the operation.  Currently, this is done by invoking
+   'git add --interactive'.
 
 The `--dry-run` option can be used to obtain a
 summary of what is included by any of the above for the next
@@ -59,6 +61,12 @@ OPTIONS
 	been modified and deleted, but new files you have not
 	told git about are not affected.
 
+-p::
+--patch::
+	Use the interactive patch selection interface to chose
+	which changes to commit. See linkgit:git-add[1] for
+	details.
+
 -C <commit>::
 --reuse-message=<commit>::
 	Take an existing commit object, and reuse the log message
diff --git a/builtin/add.c b/builtin/add.c
index 12b964e..3d074b3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -242,7 +242,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 	return status;
 }
 
-int interactive_add(int argc, const char **argv, const char *prefix)
+int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 {
 	const char **pathspec = NULL;
 
@@ -253,7 +253,7 @@ int interactive_add(int argc, const char **argv, const char *prefix)
 	}
 
 	return run_add_interactive(NULL,
-				   patch_interactive ? "--patch" : NULL,
+				   patch ? "--patch" : NULL,
 				   pathspec);
 }
 
@@ -378,7 +378,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
-		exit(interactive_add(argc - 1, argv + 1, prefix));
+		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive));
 
 	if (edit_interactive)
 		return(edit_patch(argc, argv, prefix));
diff --git a/builtin/commit.c b/builtin/commit.c
index 22ba54f..0ae3262 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -70,7 +70,7 @@ static const char *logfile, *force_author;
 static const char *template_file;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
-static int all, edit_flag, also, interactive, only, amend, signoff;
+static int all, edit_flag, also, interactive, patch_interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
@@ -138,6 +138,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
 	OPT_BOOLEAN('i', "include", &also, "add specified files to index for commit"),
 	OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"),
+	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactively add changes"),
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run, "show what would be committed"),
@@ -296,8 +297,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 
 	if (is_status)
 		refresh_flags |= REFRESH_UNMERGED;
-	if (interactive) {
-		if (interactive_add(argc, argv, prefix) != 0)
+	if (interactive || patch_interactive) {
+		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
 			die("interactive add failed");
 		if (read_cache_preload(NULL) < 0)
 			die("index file corrupt");
@@ -969,8 +970,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			use_message_buffer = xstrdup(commit->buffer);
 	}
 
-	if (!!also + !!only + !!all + !!interactive > 1)
-		die("Only one of --include/--only/--all/--interactive can be used.");
+	if (!!also + !!only + !!all + !!interactive + !!patch_interactive > 1)
+		die("Only one of --include/--only/--all/--interactive/--patch can be used.");
 	if (argc == 0 && (also || (only && !amend)))
 		die("No paths with --include/--only does not make sense.");
 	if (argc == 0 && only && amend)
diff --git a/commit.h b/commit.h
index eb6c5af..951c22e 100644
--- a/commit.h
+++ b/commit.h
@@ -160,7 +160,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit **, int);
 
-extern int interactive_add(int argc, const char **argv, const char *prefix);
+extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
 extern int run_add_interactive(const char *revision, const char *patch_mode,
 			       const char **pathspec);
 
-- 
1.7.2.3
