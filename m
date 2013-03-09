From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] git add <pathspec>... defaults to "-A"
Date: Sat,  9 Mar 2013 00:22:38 -0800
Message-ID: <1362817358-24356-4-git-send-email-gitster@pobox.com>
References: <1362817358-24356-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 09:23:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEF3x-00042m-T6
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 09:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631Ab3CIIWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 03:22:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756605Ab3CIIWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 03:22:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C969B9FBB
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=i6sd
	ddhsJ82dQH9jUGUbJOQL8jE=; b=ZrA/p6LgRH18myL19EVNA+ctTgZU28Sam+vH
	/f0P2awGWnADH8yXGJNQiIHzH2OGj3Surea7/eqBRVp/PC/iBLR0aTdpLZpARZC7
	SpIq16LinQM1RoYb4fVqFMl0La3cyR4DioS99J//Ez7HpO9F1IZWuU5FGjajh1oo
	77aHQqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=e4a4A0
	5eNpuXnReiP1C2q4J+AGNESdkTD92Jh3c6+npCKEoJZPFULcTXM/amN6DDrFzRty
	7rqkVaV7ETrnTzbLfzP3YX3gj/xxXVVsCkiP6FL2lZUEZZv+6N65XSnFy2GBeI9Q
	DPl06QykFxTWqxJb7hgK54CtR1BwETZrAQJ2w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEBAF9FBA
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 208F39FB9 for
 <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:46 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-203-gc9aaab5
In-Reply-To: <1362817358-24356-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8587A116-8892-11E2-8788-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217708>

Make "git add <pathspec>..." notice paths that have been removed
from the working tree, i.e. a synonym to "git add -A <pathspec>...".

Given that "git add <pathspec>" is to update the index with the
state of the named part of the working tree as a whole, it makes it
more intuitive, and also makes it possible to simplify the advice we
give while marking the paths the user finished resolving conflicts
with.  We used to say "to record removal as a resolution, remove the
path from the working tree and say 'git rm'; for all other cases,
edit the path in the working tree and say 'git add'", but we can now
say "update the path in the working tree and say 'git add'" instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.txt | 18 +++++++++++-------
 builtin/add.c             | 33 +++------------------------------
 2 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 5c501a2..e96fa84 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -53,8 +53,14 @@ OPTIONS
 	Files to add content from.  Fileglobs (e.g. `*.c`) can
 	be given to add all matching files.  Also a
 	leading directory name (e.g. `dir` to add `dir/file1`
-	and `dir/file2`) can be given to add all files in the
-	directory, recursively.
+	and `dir/file2`) can be given to update the index to
+	match the current state of the directory as a whole (e.g.
+	specifying `dir` will record not just a file `dir/file1`
+	modified in the working tree, a file `dir/file2` added to
+	the working tree, but also a file `dir/file3` removed from
+	the working tree.  Note that older versions of 	Git used
+	to ignore removed files; use `--no-all` option if you want
+	to add modified or new files but ignore removed	ones.
 
 -n::
 --dry-run::
@@ -127,11 +133,9 @@ of Git, hence the form without <pathspec> should not be used.
 	files that have been removed from the working tree.  This
 	option is a no-op when no <pathspec> is used.
 +
-This option is primarily to help the current users of Git, whose
-"git add <pathspec>..." ignores removed files.  In future versions
-of Git, "git add <pathspec>..." will be a synonym to "git add -A
-<pathspec>..." and "git add --no-all <pathspec>..." will behave like
-today's "git add <pathspec>...", ignoring removed files.
+This option is primarily to help users who are used to older
+versions of Git, whose "git add <pathspec>..." was a synonym
+to "git add --no-all <pathspec...", i.e. ignored removed files.
 
 -N::
 --intent-to-add::
diff --git a/builtin/add.c b/builtin/add.c
index f8f6c9e..21c685f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -273,7 +273,7 @@ N_("The following paths are ignored by one of your .gitignore files:\n");
 static int verbose, show_only, ignored_too, refresh_only;
 static int ignore_add_errors, intent_to_add, ignore_missing;
 
-#define ADDREMOVE_DEFAULT 0 /* Change to 1 in Git 2.0 */
+#define ADDREMOVE_DEFAULT 1
 static int addremove = ADDREMOVE_DEFAULT;
 static int addremove_explicit = -1; /* unspecified */
 
@@ -354,18 +354,6 @@ static void warn_pathless_add(const char *option_name, const char *short_name) {
 		option_name, short_name);
 }
 
-static int directory_given(int argc, const char **argv)
-{
-	struct stat st;
-
-	while (argc--) {
-		if (!lstat(*argv, &st) && S_ISDIR(st.st_mode))
-			return 1;
-		argv++;
-	}
-	return 0;
-}
-
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -401,24 +389,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
 
-	/*
-	 * Warn when "git add pathspec..." was given without "-u" or "-A"
-	 * and pathspec... contains a directory name.
-	 */
-	if (!take_worktree_changes && addremove_explicit < 0 &&
-	    directory_given(argc, argv))
-		warning(_("In Git 2.0, 'git add <pathspec>...' will also update the\n"
-			  "index for paths removed from the working tree that match\n"
-			  "the given pathspec. If you want to 'add' only changed\n"
-			  "or newly created paths, say 'git add --no-all <pathspec>...'"
-			  " instead."));
-
 	if (!take_worktree_changes && addremove_explicit < 0 && argc)
-		/*
-		 * Turn "git add pathspec..." to "git add -A pathspec..."
-		 * in Git 2.0 but not yet
-		 */
-		; /* addremove = 1; */
+		/* Turn "git add pathspec..." to "git add -A pathspec..." */
+		addremove = 1;
 
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
-- 
1.8.2-rc3-203-gc9aaab5
