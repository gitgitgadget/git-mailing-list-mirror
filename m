From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] git-add --all: add all files
Date: Sat, 19 Jul 2008 23:09:02 -0700
Message-ID: <1216534144-23826-2-git-send-email-gitster@pobox.com>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 08:10:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKS7Y-0004TW-IE
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 08:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbYGTGJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 02:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYGTGJP
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 02:09:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbYGTGJN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 02:09:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 69C0B33D8F
	for <git@vger.kernel.org>; Sun, 20 Jul 2008 02:09:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 70B5A33D8E for <git@vger.kernel.org>; Sun, 20 Jul 2008 02:09:10
 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.4.570.g052e6
In-Reply-To: <1216534144-23826-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5EF9A4F6-5622-11DD-95E6-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89160>

People sometimes find that "git add -u && git add ." are 13 keystrokes too
many.  This reduces it by nine.

The support of this has been very low priority for me personally, because
I almost never do "git add ." in a directory with already tracked files,
and in a new directory, there is no point saying "git add -u".

However, for two types of people (that are very different from me), this
mode of operation may make sense and there is no reason to leave it
unsupported.  That is:

 (1) If you are extremely well disciplined and keep perfect .gitignore, it
     always is safe to say "git add ."; or

 (2) If you are extremely undisciplined and do not even know what files
     you created, and you do not very much care what goes in your history,
     it does not matter if "git add ." included everything.

So there it is, although I suspect I will not use it myself, ever.

It will be too much of a change that is against the expectation of the
existing users to allow "git commit -a" to include untracked files, and
it would be inconsistent if we named this new option "-a", so the short
option is "-A".  We _might_ want to later add "git commit -A" but that is
a separate topic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This option is different from what "commit -a" does, so it must be
   named differently.  v2 patch uses -A as the short option.

 builtin-add.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 9b2ee8c..6f5672a 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -190,7 +190,7 @@ static const char ignore_error[] =
 "The following paths are ignored by one of your .gitignore files:\n";
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
-static int ignore_add_errors;
+static int ignore_add_errors, addremove;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only),
@@ -200,6 +200,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
 	OPT_BOOLEAN('f', "force", &ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked files"),
+	OPT_BOOLEAN('A', "all", &addremove, "add all, noticing removal of tracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip files which cannot be added because of errors"),
 	OPT_END(),
@@ -254,6 +255,14 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	git_config(add_config, NULL);
 
+	if (addremove && take_worktree_changes)
+		die("-A and -u are mutually incompatible");
+	if (addremove && !argc) {
+		static const char *here[2] = { ".", NULL };
+		argc = 1;
+		argv = here;
+	}
+
 	add_new_files = !take_worktree_changes && !refresh_only;
 	require_pathspec = !take_worktree_changes;
 
@@ -286,7 +295,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		goto finish;
 	}
 
-	if (take_worktree_changes)
+	if (take_worktree_changes || addremove)
 		exit_status |= add_files_to_cache(prefix, pathspec, flags);
 
 	if (add_new_files)
-- 
1.5.6.4.570.g052e6
