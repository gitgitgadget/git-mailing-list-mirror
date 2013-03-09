From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] git add: -u/-A now affects the entire working tree
Date: Sat,  9 Mar 2013 00:23:11 -0800
Message-ID: <1362817391-24452-3-git-send-email-gitster@pobox.com>
References: <1362817391-24452-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 09:23:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEF4E-0004Gk-OH
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 09:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303Ab3CIIXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 03:23:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071Ab3CIIXR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 03:23:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10B369FEC
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:23:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=OcvS
	P2aXLLTwXyefrhhyzRYRWWk=; b=PEJRYmpdt4Q78VIbhVIIvsBatM4tLPZ9Ea/C
	tDAUT8eK6kz+C51RB7/5ohmFpY0QicJ7KpBefxaCMVeAFb2BYHwOw4/8BOItthQi
	4Q+obl7BPVY0k7MaoZee9vrjrPB8hoKFLFS/zFEVoE3mPwQN4L/ySgvMvVmXYUV9
	45PnsC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=v7yMJs
	goWmyn0lGUs1E5Z9yuzlbutwwZYC47+V/dVredua0mwMWAUBnP3nxm5bIIFRBE8/
	btgM2C+EibqvqIDMOmUAUQxrfJcwsP3O4v5W3rYEI0gGrCe5/+j1i4ZNyZBBgYmz
	vgHzuSwXX/l6m3S57dQEAHk5o3wCgLy523yI0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 047D59FEB
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:23:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31B619FEA for
 <git@vger.kernel.org>; Sat,  9 Mar 2013 03:23:16 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-203-gc9aaab5
In-Reply-To: <1362817391-24452-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 97743D94-8892-11E2-A3D0-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217710>

As promised in 0fa2eb530fb7 (add: warn when -u or -A is used without
pathspec, 2013-01-28), in Git 2.0, "git add -u/-A" that is run
without pathspec in a subdirectory updates all updated paths in the
entire working tree, not just the current directory and its
subdirectories.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.txt | 24 ++++++++----------------
 builtin/add.c             | 47 ++++-------------------------------------------
 2 files changed, 12 insertions(+), 59 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index b849b78..02b99cb 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -104,14 +104,10 @@ apply to the index. See EDITING PATCHES below.
 	<pathspec>.  This removes as well as modifies index entries to
 	match the working tree, but adds no new files.
 +
-If no <pathspec> is given when `-u` option is used, Git used
-to update all tracked files in the current directory and its
-subdirectories. We would eventually want to change this to operate
-on the entire working tree, not limiting it to the current
-directory, to make it consistent with `git commit -a` and other
-commands.  In order to avoid harming users who are used to the old
-default, Git *errors out* when no <pathspec> is given to train their
-fingers to explicitly type `git add -u .` when they mean it.
+If no <pathspec> is given when `-u` option is used, all
+tracked files in the entire working tree are updated (old versions
+of Git used to limit the update to the current directory and its
+subdirectories).
 
 -A::
 --all::
@@ -120,14 +116,10 @@ fingers to explicitly type `git add -u .` when they mean it.
 	entry.	This adds, modifies, and removes index entries to
 	match the working tree.
 +
-If no <pathspec> is given when `-A` option is used, Git used
-to update all files in the current directory and its
-subdirectories. We would eventually want to change this to operate
-on the entire working tree, not limiting it to the current
-directory, to make it consistent with `git commit -a` and other
-commands.  In order to avoid harming users who are used to the old
-default, Git *errors out* when no <pathspec> is given to train their
-fingers to explicitly type `git add -A .` when they mean it.
+If no <pathspec> is given when `-A` option is used, all
+files in the entire working tree are updated (old versions
+of Git used to limit the update to the current directory and its
+subdirectories).
 
 -N::
 --intent-to-add::
diff --git a/builtin/add.c b/builtin/add.c
index 4b9d57c..6cd063f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -321,33 +321,6 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
-static void die_on_pathless_add(const char *option_name, const char *short_name)
-{
-	/*
-	 * To be consistent with "git add -p" and most Git
-	 * commands, we should default to being tree-wide, but
-	 * this is not the original behavior and can't be
-	 * changed until users trained themselves not to type
-	 * "git add -u" or "git add -A". In the previous release,
-	 * we kept the old behavior but gave a big warning.
-	 */
-	die(_("The behavior of 'git add %s (or %s)' with no path argument from a\n"
-	      "subdirectory of the tree will change in Git 2.0 and should not be "
-	      "used anymore.\n"
-	      "To add content for the whole tree, run:\n"
-	      "\n"
-	      "  git add %s :/\n"
-	      "  (or git add %s :/)\n"
-	      "\n"
-	      "To restrict the command to the current directory, run:\n"
-	      "\n"
-	      "  git add %s .\n"
-	      "  (or git add %s .)"),
-		option_name, short_name,
-		option_name, short_name,
-		option_name, short_name);
-}
-
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -358,8 +331,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
-	const char *option_with_implicit_dot = NULL;
-	const char *short_option_with_implicit_dot = NULL;
 
 	git_config(add_config, NULL);
 
@@ -379,21 +350,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
-		if (prefix)
-			die_on_pathless_add(option_with_implicit_dot,
-					    short_option_with_implicit_dot);
+
+	if ((addremove || take_worktree_changes) && !argc) {
+		static const char *whole[2] = { ":/", NULL };
 		argc = 1;
-		argv = here;
+		argv = whole;
 	}
 
 	add_new_files = !take_worktree_changes && !refresh_only;
-- 
1.8.2-rc3-203-gc9aaab5
