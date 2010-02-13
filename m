From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 30/30] builtin-notes: Add "copy" subcommand for copying
 notes between objects
Date: Sat, 13 Feb 2010 22:28:38 +0100
Message-ID: <1266096518-2104-31-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPan-0002mJ-Ov
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758151Ab0BMVaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:30:30 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62746 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758140Ab0BMVaK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:30:10 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FLGUE85490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:30:08 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:30:08 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211825
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139855>

This is useful for keeping notes to objects that are being rewritten by e.g.
'git commit --amend', 'git rebase', or 'git cherry-pick'.

"git notes copy <from> <to>" is in practice equivalent to
"git notes add -C $(git notes list <from>) <to>", although it is somewhat
more convenient for regular users.

"git notes copy" takes the same -f option as "git add", to overwrite existing
notes at the target (instead of aborting with an error message).

If the <from>-object has no notes, "git notes copy" will abort with an error
message.

The patch includes tests verifying correct behaviour of the new subcommand.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |    8 +++++
 builtin-notes.c             |   39 +++++++++++++++++++++-----
 t/t3301-notes.sh            |   63 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 15de4b3..14f73b9 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git notes' [list [<object>]]
 'git notes' add [-f] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' copy [-f] <from-object> <to-object>
 'git notes' append [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [<object>]
 'git notes' show [<object>]
@@ -48,6 +49,13 @@ add::
 	object already has notes, abort. (use `-f` to overwrite an
 	existing note).
 
+copy::
+	Copy the notes for the first object onto the second object.
+	Abort if the second object already has notes, or if the first
+	objects has none. (use -f to overwrite existing notes to the
+	second object). This subcommand is equivalent to:
+	`git notes add [-f] -C $(git notes list <from-object>) <to-object>`
+
 append::
 	Append to the notes of an existing object (defaults to HEAD).
 	Creates a new notes object if needed.
diff --git a/builtin-notes.c b/builtin-notes.c
index bbf98a9..123ecad 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -20,6 +20,7 @@
 static const char * const git_notes_usage[] = {
 	"git notes [list [<object>]]",
 	"git notes add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
+	"git notes copy [-f] <from-object> <to-object>",
 	"git notes append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
 	"git notes edit [<object>]",
 	"git notes show [<object>]",
@@ -280,13 +281,13 @@ int commit_notes(struct notes_tree *t, const char *msg)
 int cmd_notes(int argc, const char **argv, const char *prefix)
 {
 	struct notes_tree *t;
-	unsigned char object[20], new_note[20];
+	unsigned char object[20], from_obj[20], new_note[20];
 	const unsigned char *note;
 	const char *object_ref;
 	char logmsg[100];
 
-	int list = 0, add = 0, append = 0, edit = 0, show = 0, remove = 0,
-	    prune = 0, force = 0;
+	int list = 0, add = 0, copy = 0, append = 0, edit = 0, show = 0,
+	    remove = 0, prune = 0, force = 0;
 	int given_object = 0, i = 1, retval = 0;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
 	struct option options[] = {
@@ -311,6 +312,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		list = 1;
 	else if (argc && !strcmp(argv[0], "add"))
 		add = 1;
+	else if (argc && !strcmp(argv[0], "copy"))
+		copy = 1;
 	else if (argc && !strcmp(argv[0], "append"))
 		append = 1;
 	else if (argc && !strcmp(argv[0], "edit"))
@@ -326,7 +329,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		i = 0;
 	}
 
-	if (list + add + append + edit + show + remove + prune != 1)
+	if (list + add + copy + append + edit + show + remove + prune != 1)
 		usage_with_options(git_notes_usage, options);
 
 	if (msg.given && !(add || append || edit)) {
@@ -341,11 +344,22 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 			"Please use 'git notes add -f -m/-F/-c/-C' instead.\n");
 	}
 
-	if (force && !add) {
+	if (force && !(add || copy)) {
 		error("cannot use -f option with %s subcommand.", argv[0]);
 		usage_with_options(git_notes_usage, options);
 	}
 
+	if (copy) {
+		const char *from_ref;
+		if (argc < 3) {
+			error("too few parameters");
+			usage_with_options(git_notes_usage, options);
+		}
+		from_ref = argv[i++];
+		if (get_sha1(from_ref, from_obj))
+			die("Failed to resolve '%s' as a valid ref.", from_ref);
+	}
+
 	given_object = argc > i;
 	object_ref = given_object ? argv[i++] : "HEAD";
 
@@ -394,11 +408,11 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	/* add/append/edit/remove/prune command */
 
-	if (add && note) {
+	if ((add || copy) && note) {
 		if (!force) {
-			error("Cannot add notes. Found existing notes for object"
+			error("Cannot %s notes. Found existing notes for object"
 			      " %s. Use '-f' to overwrite existing notes",
-			      sha1_to_hex(object));
+			      argv[0], sha1_to_hex(object));
 			retval = 1;
 			goto end;
 		}
@@ -416,6 +430,15 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		hashclr(new_note);
 		prune_notes(t);
 		goto commit;
+	} else if (copy) {
+		const unsigned char *from_note = get_note(t, from_obj);
+		if (!from_note) {
+			error("Missing notes on source object %s. Cannot copy.",
+			      sha1_to_hex(from_obj));
+			retval = 1;
+			goto end;
+		}
+		hashcpy(new_note, from_note);
 	} else
 		create_note(object, &msg, append, note, new_note);
 
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 6447e5f..90178f9 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -581,4 +581,67 @@ test_expect_success 'append to note from other note with "git notes append -c"'
 	test_cmp expect actual
 '
 
+cat > expect << EOF
+commit 6352c5e33dbcab725fe0579be16aa2ba8eb369be
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:23:13 2005 -0700
+
+    11th
+
+Notes:
+    other note
+$whitespace
+    yet another note
+EOF
+
+test_expect_success 'copy note with "git notes copy"' '
+	: > a11 &&
+	git add a11 &&
+	test_tick &&
+	git commit -m 11th &&
+	git notes copy HEAD^ HEAD &&
+	git log -1 > actual &&
+	test_cmp expect actual &&
+	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
+'
+
+test_expect_success 'prevent overwrite with "git notes copy"' '
+	test_must_fail git notes copy HEAD~2 HEAD &&
+	git log -1 > actual &&
+	test_cmp expect actual &&
+	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
+'
+
+cat > expect << EOF
+commit 6352c5e33dbcab725fe0579be16aa2ba8eb369be
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:23:13 2005 -0700
+
+    11th
+
+Notes:
+    yet another note
+$whitespace
+    yet another note
+EOF
+
+test_expect_success 'allow overwrite with "git notes copy -f"' '
+	git notes copy -f HEAD~2 HEAD &&
+	git log -1 > actual &&
+	test_cmp expect actual &&
+	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)"
+'
+
+test_expect_success 'cannot copy note from object without notes' '
+	: > a12 &&
+	git add a12 &&
+	test_tick &&
+	git commit -m 12th &&
+	: > a13 &&
+	git add a13 &&
+	test_tick &&
+	git commit -m 13th &&
+	test_must_fail git notes copy HEAD^ HEAD
+'
+
 test_done
-- 
1.7.0.rc1.141.gd3fd
