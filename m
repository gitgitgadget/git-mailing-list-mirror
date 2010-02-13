From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 17/30] builtin-notes: Add "remove" subcommand for removing
 existing notes
Date: Sat, 13 Feb 2010 22:28:25 +0100
Message-ID: <1266096518-2104-18-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:30:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPZG-0001iD-Hw
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111Ab0BMV3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:45 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62442 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758099Ab0BMV3h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:37 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FK4UDB5490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:35 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:35 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139843>

Using "git notes remove" is equivalent to specifying an empty note message.

The patch includes tests verifying correct behaviour of the new subcommand.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   15 ++++++---
 builtin-notes.c             |   65 +++++++++++++++++++++++-------------------
 t/t3301-notes.sh            |   27 ++++++++++++++++++
 3 files changed, 73 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 0d1ada6..a52d23a 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -8,14 +8,14 @@ git-notes - Add/inspect commit notes
 SYNOPSIS
 --------
 [verse]
-'git notes' (edit [-F <file> | -m <msg>] | show) [commit]
+'git notes' (edit [-F <file> | -m <msg>] | show | remove) [commit]
 
 DESCRIPTION
 -----------
-This command allows you to add notes to commit messages, without
-changing the commit.  To discern these notes from the message stored
-in the commit object, the notes are indented like the message, after
-an unindented line saying "Notes:".
+This command allows you to add/remove notes to/from commit messages,
+without changing the commit.  To discern these notes from the message
+stored in the commit object, the notes are indented like the message,
+after an unindented line saying "Notes:".
 
 To disable commit notes, you have to set the config variable
 core.notesRef to the empty string.  Alternatively, you can set it
@@ -32,6 +32,11 @@ edit::
 show::
 	Show the notes for a given commit (defaults to HEAD).
 
+remove::
+	Remove the notes for a given commit (defaults to HEAD).
+	This is equivalent to specifying an empty note message to
+	the `edit` subcommand.
+
 
 OPTIONS
 -------
diff --git a/builtin-notes.c b/builtin-notes.c
index 7b4cb13..7c40075 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -20,6 +20,7 @@
 static const char * const git_notes_usage[] = {
 	"git notes edit [-m <msg> | -F <file>] [<object>]",
 	"git notes show [<object>]",
+	"git notes remove [<object>]",
 	NULL
 };
 
@@ -197,9 +198,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
 	const unsigned char *note;
-	const char *object_ref, *logmsg;
+	const char *object_ref;
+	char logmsg[100];
 
-	int edit = 0, show = 0;
+	int edit = 0, show = 0, remove = 0;
 	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct option options[] = {
@@ -218,10 +220,22 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		edit = 1;
 	else if (argc && !strcmp(argv[0], "show"))
 		show = 1;
+	else if (argc && !strcmp(argv[0], "remove"))
+		remove = 1;
 
-	if (edit + show != 1)
+	if (edit + show + remove != 1)
 		usage_with_options(git_notes_usage, options);
 
+	if ((msg.given || msgfile) && !edit) {
+		error("cannot use -m/-F options with %s subcommand.", argv[0]);
+		usage_with_options(git_notes_usage, options);
+	}
+
+	if (msg.given && msgfile) {
+		error("mixing -m and -F options is not allowed.");
+		usage_with_options(git_notes_usage, options);
+	}
+
 	object_ref = argc == 2 ? argv[1] : "HEAD";
 	if (argc > 2) {
 		error("too many parameters");
@@ -236,7 +250,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	if (prefixcmp(t->ref, "refs/notes/"))
 		die("Refusing to %s notes in %s (outside of refs/notes/)",
-		    edit ? "edit" : "show", t->ref);
+		    argv[0], t->ref);
 
 	note = get_note(t, object);
 
@@ -250,35 +264,28 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		return execv_git_cmd(show_args);
 	}
 
-	/* edit command */
-
-	if (msg.given || msgfile) {
-		if (msg.given && msgfile) {
-			error("mixing -m and -F options is not allowed.");
-			usage_with_options(git_notes_usage, options);
-		}
-		if (msg.given)
-			strbuf_addbuf(&buf, &(msg.buf));
-		else {
-			if (!strcmp(msgfile, "-")) {
-				if (strbuf_read(&buf, 0, 1024) < 0)
-					die_errno("cannot read '%s'", msgfile);
-			} else {
-				if (strbuf_read_file(&buf, msgfile, 1024) < 0)
-					die_errno("could not open or read '%s'",
-						msgfile);
-			}
-		}
+	/* edit/remove command */
+
+	if (remove)
+		strbuf_reset(&buf);
+	else if (msg.given)
+		strbuf_addbuf(&buf, &(msg.buf));
+	else if (msgfile) {
+		if (!strcmp(msgfile, "-")) {
+			if (strbuf_read(&buf, 0, 1024) < 0)
+				die_errno("cannot read '%s'", msgfile);
+		} else if (strbuf_read_file(&buf, msgfile, 1024) < 0)
+			die_errno("could not open or read '%s'", msgfile);
 	}
 
-	create_note(object, &buf, msg.given || msgfile, note, new_note);
-	if (is_null_sha1(new_note)) {
+	create_note(object, &buf, msg.given || msgfile || remove, note,
+		    new_note);
+	if (is_null_sha1(new_note))
 		remove_note(t, object);
-		logmsg = "Note removed by 'git notes edit'";
-	} else {
+	else
 		add_note(t, object, new_note, combine_notes_overwrite);
-		logmsg = "Note added by 'git notes edit'";
-	}
+	snprintf(logmsg, sizeof(logmsg), "Note %s by 'git notes %s'",
+		 is_null_sha1(new_note) ? "removed" : "added", argv[0]);
 	commit_notes(t, logmsg);
 
 	free_notes(t);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index fe59e73..d29daac 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -265,6 +265,33 @@ test_expect_success 'verify non-creation of note with -m ""' '
 	! git notes show
 '
 
+test_expect_success 'remove note with "git notes remove" (setup)' '
+	git notes remove HEAD^
+'
+
+cat > expect-rm-remove << EOF
+commit bd1753200303d0a0344be813e504253b3d98e74d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:17:13 2005 -0700
+
+    5th
+
+commit 15023535574ded8b1a89052b32673f84cf9582b8
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:16:13 2005 -0700
+
+    4th
+EOF
+
+printf "\n" >> expect-rm-remove
+cat expect-multiline >> expect-rm-remove
+
+test_expect_success 'verify note removal with "git notes remove"' '
+	git log -4 > output &&
+	test_cmp expect-rm-remove output &&
+	! git notes show HEAD^
+'
+
 test_expect_success 'create other note on a different notes ref (setup)' '
 	: > a6 &&
 	git add a6 &&
-- 
1.7.0.rc1.141.gd3fd
