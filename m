From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] git add: start preparing for "git add <pathspec>..." to
 default to "-A"
Date: Sat,  9 Mar 2013 00:22:37 -0800
Message-ID: <1362817358-24356-3-git-send-email-gitster@pobox.com>
References: <1362817358-24356-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 09:23:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEF3n-0003sY-EH
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 09:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174Ab3CIIWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 03:22:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756145Ab3CIIWp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 03:22:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D50F39FB7
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=B10U
	Q8mQDA0KNd2qWk/r4EHYCNQ=; b=Z5wdP8srkaBxKhLXPXyfPqZFkmPFvwoIKqZv
	f9fph72Sdw2nwrxWQL27K7aoLWNKpEKYTrnK7drdjTWbLZs8V7HkqxAt1AoK7eo8
	i2S6PaeW3950Q1Q5XDj/NFh8M6HL7XN1DQeh8oJdTFHG8hb5Uvl1z0ZyMQfCHfwJ
	SoDKhPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=OmQH3Z
	IggNCRlYqjcBRTa8XosI+N5iC0sqb7aS0jUxtOt/2HiJlzzQ2MZglz2ODyijX+d4
	+ArVg6vAddYAtGDwycMpnGYilEHJVycb+RN9p1ADqPqfuSDohbKEvWpUJfO7Ka8D
	q+9H53jl9BHm+qVygl3mgYssfSKmwd2TbhwOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB209FB6
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD4849FB1 for
 <git@vger.kernel.org>; Sat,  9 Mar 2013 03:22:43 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-203-gc9aaab5
In-Reply-To: <1362817358-24356-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8429D2F8-8892-11E2-B13F-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217707>

When "git add subdir/" is run without "-u" or "-A" option, e.g.

    $ edit subdir/x
    $ create subdir/y
    $ rm subdir/z
    $ git add subdir/

the command does not notice removal of paths (e.g. subdir/z) from
the working tree.  This sometimes confuses new people, as arguably
"git add" is told to record the current state of "subdir/" as a
whole, not the current state of the paths that exist in the working
tree that matches that pathspec (the latter by definition excludes
the state of "subdir/z" because it does not exist in the working
tree).

Plan to eventually make "git add" pretend as if "-A" is given when
there is a pathspec on the command line.  When resolving a conflict
to remove a path, the current code tells you to "git rm $path", but
with such a change, you will be able to say "git add $path" (of
course you can do "git add -A $path" today).  That means that we can
simplify the advice messages given by "git status".  That all will
be in Git 2.0 or later, if we are going to do so.

For that transition to work, people need to learn either to say "git
add --no-all subdir/" when they want to ignore the removed paths
like "subdir/z", or to say "git add -A subdir/" when they want to
take the state of the directory as a whole.

"git add" without any argument will continue to be a no-op.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.txt | 14 +++++++++++++-
 builtin/add.c             | 45 +++++++++++++++++++++++++++++++++++++++++++--
 t/t2200-add-update.sh     |  6 +++---
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index b0944e5..5c501a2 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--edit | -e] [--all | [--update | -u]] [--intent-to-add | -N]
+	  [--edit | -e] [--[no-]all | [--update | -u]] [--intent-to-add | -N]
 	  [--refresh] [--ignore-errors] [--ignore-missing] [--]
 	  [<pathspec>...]
 
@@ -121,6 +121,18 @@ If no <pathspec> is given, the current version of Git defaults to
 and its subdirectories. This default will change in a future version
 of Git, hence the form without <pathspec> should not be used.
 
+--no-all::
+	Update the index by adding new files that are unknown to the
+	index and files modified in the working tree, but ignore
+	files that have been removed from the working tree.  This
+	option is a no-op when no <pathspec> is used.
++
+This option is primarily to help the current users of Git, whose
+"git add <pathspec>..." ignores removed files.  In future versions
+of Git, "git add <pathspec>..." will be a synonym to "git add -A
+<pathspec>..." and "git add --no-all <pathspec>..." will behave like
+today's "git add <pathspec>...", ignoring removed files.
+
 -N::
 --intent-to-add::
 	Record only the fact that the path will be added later. An entry
diff --git a/builtin/add.c b/builtin/add.c
index 220321b..f8f6c9e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -271,7 +271,11 @@ static const char ignore_error[] =
 N_("The following paths are ignored by one of your .gitignore files:\n");
 
 static int verbose, show_only, ignored_too, refresh_only;
-static int ignore_add_errors, addremove, intent_to_add, ignore_missing;
+static int ignore_add_errors, intent_to_add, ignore_missing;
+
+#define ADDREMOVE_DEFAULT 0 /* Change to 1 in Git 2.0 */
+static int addremove = ADDREMOVE_DEFAULT;
+static int addremove_explicit = -1; /* unspecified */
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
@@ -283,7 +287,7 @@ static struct option builtin_add_options[] = {
 	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files")),
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
 	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
-	OPT_BOOL('A', "all", &addremove, N_("add changes from all tracked and untracked files")),
+	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
@@ -350,6 +354,18 @@ static void warn_pathless_add(const char *option_name, const char *short_name) {
 		option_name, short_name);
 }
 
+static int directory_given(int argc, const char **argv)
+{
+	struct stat st;
+
+	while (argc--) {
+		if (!lstat(*argv, &st) && S_ISDIR(st.st_mode))
+			return 1;
+		argv++;
+	}
+	return 0;
+}
+
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -377,8 +393,33 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	argc--;
 	argv++;
 
+	if (0 <= addremove_explicit)
+		addremove = addremove_explicit;
+	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
+		addremove = 0; /* "-u" was given but not "-A" */
+
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
+
+	/*
+	 * Warn when "git add pathspec..." was given without "-u" or "-A"
+	 * and pathspec... contains a directory name.
+	 */
+	if (!take_worktree_changes && addremove_explicit < 0 &&
+	    directory_given(argc, argv))
+		warning(_("In Git 2.0, 'git add <pathspec>...' will also update the\n"
+			  "index for paths removed from the working tree that match\n"
+			  "the given pathspec. If you want to 'add' only changed\n"
+			  "or newly created paths, say 'git add --no-all <pathspec>...'"
+			  " instead."));
+
+	if (!take_worktree_changes && addremove_explicit < 0 && argc)
+		/*
+		 * Turn "git add pathspec..." to "git add -A pathspec..."
+		 * in Git 2.0 but not yet
+		 */
+		; /* addremove = 1; */
+
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 	if (addremove) {
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 4cdebda..32f932a 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -150,9 +150,9 @@ test_expect_success 'add -u resolves unmerged paths' '
 	echo 2 >path3 &&
 	echo 2 >path5 &&
 
-	# Explicit resolving by adding removed paths should fail
-	test_must_fail git add path4 &&
-	test_must_fail git add path6 &&
+	# Fail to explicitly resolve removed paths with "git add"
+	test_must_fail git add --no-all path4 &&
+	test_must_fail git add --no-all path6 &&
 
 	# "add -u" should notice removals no matter what stages
 	# the index entries are in.
-- 
1.8.2-rc3-203-gc9aaab5
