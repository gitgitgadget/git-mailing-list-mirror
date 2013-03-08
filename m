From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] git add: -u/-A now affects the entire working tree
Date: Fri,  8 Mar 2013 15:54:49 -0800
Message-ID: <1362786889-28688-3-git-send-email-gitster@pobox.com>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 00:55:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE78L-0002c3-Hi
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 00:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760018Ab3CHXy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 18:54:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759889Ab3CHXy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 18:54:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D6ACBF70;
	Fri,  8 Mar 2013 18:54:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0llc
	57oDa4qIDrXnqKcpMn4TsZ8=; b=RZbh9fHdAl39mpa171u+9HY9MkkdDSr7zw0H
	dY8z14aY6UWXQo2wnVxYXg6wFB0WT3XHsqHj5tb9q4Vbtg90RuO34tLjTum5ErBz
	gnpCybZPQ951OeSCZU4m3O2hvthYLNLl5yxl4G8mlMPAMFnec6emQOxKE3mW8sLa
	/JnpG4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	pZsqy7OafRmf9eSGMNREZ1zpV/ea2KDLZqswhPcEJQFZkKjlSq2wOUNLIDXPGig8
	T638u7sruIspplk2BACr8uf+V8mtkSTVPEUUpG22r/to7/QWS7ShZEW3XKe57JYn
	2BzlBckTiLG3So+ASLY4emZsusUEAs1dm2tIeZaLBQo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E0EFBF6F;
	Fri,  8 Mar 2013 18:54:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA5B8BF6E; Fri,  8 Mar 2013
 18:54:54 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-196-gfcda97c
In-Reply-To: <1362786889-28688-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 932DA8C0-884B-11E2-8ED7-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217693>

As promised in 0fa2eb530fb7 (add: warn when -u or -A is used without
pathspec, 2013-01-28), in Git 2.0, "git add -u/-A" that is run
without pathspec in a subdirectory updates all updated paths in the
entire working tree, not just the current directory and its
subdirectories.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.txt | 12 ++++--------
 builtin/add.c             | 47 ++++-------------------------------------------
 2 files changed, 8 insertions(+), 51 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 1ea1d39..15a8859 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -107,14 +107,10 @@ apply to the index. See EDITING PATCHES below.
 	from the index if the corresponding files in the working tree
 	have been removed.
 +
-If no <pathspec> is given when `-u` or `-A` option is used, Git used
-to update all tracked files in the current directory and its
-subdirectories. We would eventually want to change this to operate
-on the entire working tree, not limiting it to the current
-directory, to make it consistent with `git commit -a` and other
-commands.  In order to avoid harming users who are used to the old
-default, Git *errors out* when no <pathspec> is given to train their
-fingers to explicitly type `git add -u .` when they mean it.
+If no <pathspec> is given when `-u` or `-A` option is used, all
+tracked files in the entire working tree are updated (old versions
+of Git used to limit the update to the current directory and its
+subdirectories).
 
 -A::
 --all::
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
1.8.2-rc3-196-gfcda97c
