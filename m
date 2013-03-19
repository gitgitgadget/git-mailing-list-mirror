From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/6] git add: -u/-A now affects the entire working tree
Date: Tue, 19 Mar 2013 15:53:17 -0700
Message-ID: <20130319225317.GG19014@google.com>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <20130319224400.GA19014@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 23:53:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI5Pj-0004zY-Mo
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 23:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464Ab3CSWxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 18:53:23 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:49171 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab3CSWxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 18:53:22 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so584677dae.37
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 15:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ehhfTKfatRJG++6fLMR9S+a3pYqRkQTOkkRumb/6nAg=;
        b=PrRoKXIcVpb1WTbmBzJOVm6yriG76sLha6vxkSKzuTp9UNuXmz9uTddeOkim0RGN10
         92WRekBqdYiKKrDBK38brdDSKh6BQ5nvJuX15mB3xjfe+MKyxYG0y3kNhV7iHP1BvXFM
         c6jwQtAZSrthbjyzcY8QmC0foMoz59X9SIiOOYdhSnjJcver9qoo0rH99uwNW6G8zM3/
         ygqftnXLBQsf5+8h7B9s+g0otZkSU/agR1ZtAAjTZRfNhtH3eZbvZyWVt+JuArrlxJlk
         vMdsr5khAO2a7Cf6HD4haHy+ixXPRuxxzmguNI63ty+KNmsszPLYJ/jMxb+5uDjk6fxM
         +HNw==
X-Received: by 10.68.47.39 with SMTP id a7mr5716064pbn.155.1363733601812;
        Tue, 19 Mar 2013 15:53:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id pv7sm16944885pbb.33.2013.03.19.15.53.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 15:53:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130319224400.GA19014@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218566>

From: Junio C Hamano <gitster@pobox.com>

As promised in 0fa2eb530fb7 (add: warn when -u or -A is used without
pathspec, 2013-01-28), in Git 2.0, "git add -u/-A" that is run
without pathspec in a subdirectory updates all updated paths in the
entire working tree, not just the current directory and its
subdirectories.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 Documentation/git-add.txt |  16 +++----
 builtin/add.c             | 110 ++++------------------------------------------
 t/t2200-add-update.sh     |   9 +---
 3 files changed, 19 insertions(+), 116 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index b0944e5..02b99cb 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -104,10 +104,10 @@ apply to the index. See EDITING PATCHES below.
 	<pathspec>.  This removes as well as modifies index entries to
 	match the working tree, but adds no new files.
 +
-If no <pathspec> is given, the current version of Git defaults to
-"."; in other words, update all tracked files in the current directory
-and its subdirectories. This default will change in a future version
-of Git, hence the form without <pathspec> should not be used.
+If no <pathspec> is given when `-u` option is used, all
+tracked files in the entire working tree are updated (old versions
+of Git used to limit the update to the current directory and its
+subdirectories).
 
 -A::
 --all::
@@ -116,10 +116,10 @@ of Git, hence the form without <pathspec> should not be used.
 	entry.	This adds, modifies, and removes index entries to
 	match the working tree.
 +
-If no <pathspec> is given, the current version of Git defaults to
-"."; in other words, update all files in the current directory
-and its subdirectories. This default will change in a future version
-of Git, hence the form without <pathspec> should not be used.
+If no <pathspec> is given when `-A` option is used, all
+files in the entire working tree are updated (old versions
+of Git used to limit the update to the current directory and its
+subdirectories).
 
 -N::
 --intent-to-add::
diff --git a/builtin/add.c b/builtin/add.c
index 2493493..5c0a869 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -26,50 +26,8 @@ static int take_worktree_changes;
 struct update_callback_data {
 	int flags;
 	int add_errors;
-	const char *implicit_dot;
-	size_t implicit_dot_len;
 };
 
-static const char *option_with_implicit_dot;
-static const char *short_option_with_implicit_dot;
-
-static void warn_pathless_add(void)
-{
-	static int shown;
-	assert(option_with_implicit_dot && short_option_with_implicit_dot);
-
-	if (shown)
-		return;
-	shown = 1;
-
-	/*
-	 * To be consistent with "git add -p" and most Git
-	 * commands, we should default to being tree-wide, but
-	 * this is not the original behavior and can't be
-	 * changed until users trained themselves not to type
-	 * "git add -u" or "git add -A". For now, we warn and
-	 * keep the old behavior. Later, the behavior can be changed
-	 * to tree-wide, keeping the warning for a while, and
-	 * eventually we can drop the warning.
-	 */
-	warning(_("The behavior of 'git add %s (or %s)' with no path argument from a\n"
-		  "subdirectory of the tree will change in Git 2.0 and should not be used anymore.\n"
-		  "To add content for the whole tree, run:\n"
-		  "\n"
-		  "  git add %s :/\n"
-		  "  (or git add %s :/)\n"
-		  "\n"
-		  "To restrict the command to the current directory, run:\n"
-		  "\n"
-		  "  git add %s .\n"
-		  "  (or git add %s .)\n"
-		  "\n"
-		  "With the current Git version, the command is restricted to the current directory."),
-		option_with_implicit_dot, short_option_with_implicit_dot,
-		option_with_implicit_dot, short_option_with_implicit_dot,
-		option_with_implicit_dot, short_option_with_implicit_dot);
-}
-
 static int fix_unmerged_status(struct diff_filepair *p,
 			       struct update_callback_data *data)
 {
@@ -96,27 +54,11 @@ static void update_callback(struct diff_queue_struct *q,
 {
 	int i;
 	struct update_callback_data *data = cbdata;
-	const char *implicit_dot = data->implicit_dot;
-	size_t implicit_dot_len = data->implicit_dot_len;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
 
-		/*
-		 * Check if "git add -A" or "git add -u" was run from a
-		 * subdirectory with a modified file outside that directory,
-		 * and warn if so.
-		 *
-		 * "git add -u" will behave like "git add -u :/" instead of
-		 * "git add -u ." in the future.  This warning prepares for
-		 * that change.
-		 */
-		if (implicit_dot &&
-		    strncmp_icase(path, implicit_dot, implicit_dot_len)) {
-			warn_pathless_add();
-			continue;
-		}
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
@@ -140,24 +82,13 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
-#define ADD_CACHE_IMPLICIT_DOT 32
 int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
 
 	memset(&data, 0, sizeof(data));
-	data.flags = flags & ~ADD_CACHE_IMPLICIT_DOT;
-	if ((flags & ADD_CACHE_IMPLICIT_DOT) && prefix) {
-		/*
-		 * Check for modified files throughout the worktree so
-		 * update_callback has a chance to warn about changes
-		 * outside the cwd.
-		 */
-		data.implicit_dot = prefix;
-		data.implicit_dot_len = strlen(prefix);
-		pathspec = NULL;
-	}
+	data.flags = flags;
 
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
@@ -170,9 +101,7 @@ int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 	return !!data.add_errors;
 }
 
-#define WARN_IMPLICIT_DOT (1u << 0)
-static char *prune_directory(struct dir_struct *dir, const char **pathspec,
-			     int prefix, unsigned flag)
+static char *prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
 	char *seen;
 	int i, specs;
@@ -189,16 +118,6 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec,
 		if (match_pathspec(pathspec, entry->name, entry->len,
 				   prefix, seen))
 			*dst++ = entry;
-		else if (flag & WARN_IMPLICIT_DOT)
-			/*
-			 * "git add -A" was run from a subdirectory with a
-			 * new file outside that directory.
-			 *
-			 * "git add -A" will behave like "git add -A :/"
-			 * instead of "git add -A ." in the future.
-			 * Warn about the coming behavior change.
-			 */
-			warn_pathless_add();
 	}
 	dir->nr = dst - dir->entries;
 	add_pathspec_matches_against_index(pathspec, seen, specs);
@@ -415,7 +334,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
-	int implicit_dot = 0;
 
 	git_config(add_config, NULL);
 
@@ -435,19 +353,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die(_("-A and -u are mutually incompatible"));
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
-	if (addremove) {
-		option_with_implicit_dot = "--all";
-		short_option_with_implicit_dot = "-A";
-	}
-	if (take_worktree_changes) {
-		option_with_implicit_dot = "--update";
-		short_option_with_implicit_dot = "-u";
-	}
-	if (option_with_implicit_dot && !argc) {
-		static const char *here[2] = { ".", NULL };
+
+	if ((addremove || take_worktree_changes) && !argc) {
+		static const char *whole[2] = { ":/", NULL };
 		argc = 1;
-		argv = here;
-		implicit_dot = 1;
+		argv = whole;
 	}
 
 	add_new_files = !take_worktree_changes && !refresh_only;
@@ -460,8 +370,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
 		 (!(addremove || take_worktree_changes)
-		  ? ADD_CACHE_IGNORE_REMOVAL : 0)) |
-		 (implicit_dot ? ADD_CACHE_IMPLICIT_DOT : 0);
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
 	if (require_pathspec && argc == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
@@ -485,10 +394,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		}
 
 		/* This picks up the paths that are not tracked */
-		baselen = fill_directory(&dir, implicit_dot ? NULL : pathspec);
+		baselen = fill_directory(&dir, pathspec);
 		if (pathspec)
-			seen = prune_directory(&dir, pathspec, baselen,
-					implicit_dot ? WARN_IMPLICIT_DOT : 0);
+			seen = prune_directory(&dir, pathspec, baselen);
 	}
 
 	if (refresh_only) {
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index c317254..4281e18 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -80,18 +80,13 @@ test_expect_success 'change gets noticed' '
 
 '
 
-# Note that this is scheduled to change in Git 2.0, when
-# "git add -u" will become full-tree by default.
-test_expect_success 'non-limited update in subdir leaves root alone' '
+test_expect_success 'non-qualified update in subdir updates from the root' '
 	(
 		cd dir1 &&
 		echo even more >>sub2 &&
 		git add -u
 	) &&
-	cat >expect <<-\EOF &&
-	check
-	top
-	EOF
+	: >expect &&
 	git diff-files --name-only >actual &&
 	test_cmp expect actual
 '
-- 
1.8.2.rc3
