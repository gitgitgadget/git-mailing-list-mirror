From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 22/30] builtin-notes: Add "list" subcommand for listing note
 objects
Date: Sat, 13 Feb 2010 22:28:30 +0100
Message-ID: <1266096518-2104-23-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPZI-0001iD-6R
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758127Ab0BMV34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:56 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62509 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758103Ab0BMV3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:53 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FKNUDN5490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:47 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:47 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139845>

"git notes list" will list all note objects in the current notes ref (in the
format "<note object> <annotated object>"). "git notes list <object>" will
list the note object associated with the given <object>, or fail loudly if
the given <object> has no associated notes.

If no arguments are given to "git notes", it defaults to the "list"
subcommand. This is for pseudo-compatibility with "git tag" and "git branch".

The patch includes tests verifying correct behaviour of the new subcommand.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   13 ++++++++++++-
 builtin-notes.c             |   37 ++++++++++++++++++++++++++++++++-----
 t/t3301-notes.sh            |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 84db2a4..4d29d5f 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -8,7 +8,12 @@ git-notes - Add/inspect object notes
 SYNOPSIS
 --------
 [verse]
-'git notes' (edit [-F <file> | -m <msg>] | show | remove | prune) [object]
+'git notes' [list [<object>]]
+'git notes' edit [-F <file> | -m <msg>] [<object>]
+'git notes' show [<object>]
+'git notes' remove [<object>]
+'git notes' prune
+
 
 DESCRIPTION
 -----------
@@ -30,6 +35,12 @@ by the environment variable "GIT_NOTES_REF".
 SUBCOMMANDS
 -----------
 
+list::
+	List the notes object for a given object. If no object is
+	given, show a list of all note objects and the objects they
+	annotate (in the format "<note object> <annotated object>").
+	This is the default subcommand if no subcommand is given.
+
 edit::
 	Edit the notes for a given object (defaults to HEAD).
 
diff --git a/builtin-notes.c b/builtin-notes.c
index 48bc455..b808534 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -18,6 +18,7 @@
 #include "parse-options.h"
 
 static const char * const git_notes_usage[] = {
+	"git notes [list [<object>]]",
 	"git notes edit [-m <msg> | -F <file>] [<object>]",
 	"git notes show [<object>]",
 	"git notes remove [<object>]",
@@ -31,6 +32,14 @@ static const char note_template[] =
 	"# Write/edit the notes for the following object:\n"
 	"#\n";
 
+static int list_each_note(const unsigned char *object_sha1,
+		const unsigned char *note_sha1, char *note_path,
+		void *cb_data)
+{
+	printf("%s %s\n", sha1_to_hex(note_sha1), sha1_to_hex(object_sha1));
+	return 0;
+}
+
 static void write_note_data(int fd, const unsigned char *sha1)
 {
 	unsigned long size;
@@ -202,7 +211,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	const char *object_ref;
 	char logmsg[100];
 
-	int edit = 0, show = 0, remove = 0, prune = 0;
+	int list = 0, edit = 0, show = 0, remove = 0, prune = 0;
+	int given_object;
 	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct option options[] = {
@@ -217,7 +227,9 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage, 0);
 
-	if (argc && !strcmp(argv[0], "edit"))
+	if (argc && !strcmp(argv[0], "list"))
+		list = 1;
+	else if (argc && !strcmp(argv[0], "edit"))
 		edit = 1;
 	else if (argc && !strcmp(argv[0], "show"))
 		show = 1;
@@ -225,8 +237,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		remove = 1;
 	else if (argc && !strcmp(argv[0], "prune"))
 		prune = 1;
+	else if (!argc)
+		list = 1; /* Default to 'list' if no other subcommand given */
 
-	if (edit + show + remove + prune != 1)
+	if (list + edit + show + remove + prune != 1)
 		usage_with_options(git_notes_usage, options);
 
 	if ((msg.given || msgfile) && !edit) {
@@ -239,7 +253,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_usage, options);
 	}
 
-	object_ref = argc == 2 ? argv[1] : "HEAD";
+	given_object = argc == 2;
+	object_ref = given_object ? argv[1] : "HEAD";
 	if (argc > 2 || (prune && argc > 1)) {
 		error("too many parameters");
 		usage_with_options(git_notes_usage, options);
@@ -257,9 +272,21 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	note = get_note(t, object);
 
+	/* list command */
+
+	if (list) {
+		if (given_object) {
+			if (note) {
+				puts(sha1_to_hex(note));
+				return 0;
+			}
+		} else
+			return for_each_note(t, 0, list_each_note, NULL);
+	}
+
 	/* show command */
 
-	if (show && !note) {
+	if ((list || show) && !note) {
 		error("No note found for object %s.", sha1_to_hex(object));
 		return 1;
 	} else if (show) {
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d29daac..768a1cb 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -292,6 +292,38 @@ test_expect_success 'verify note removal with "git notes remove"' '
 	! git notes show HEAD^
 '
 
+cat > expect << EOF
+c18dc024e14f08d18d14eea0d747ff692d66d6a3 1584215f1d29c65e99c6c6848626553fdd07fd75
+c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 268048bfb8a1fb38e703baceb8ab235421bf80c5
+EOF
+
+test_expect_success 'list notes with "git notes list"' '
+	git notes list > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'list notes with "git notes"' '
+	git notes > output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
+c18dc024e14f08d18d14eea0d747ff692d66d6a3
+EOF
+
+test_expect_success 'list specific note with "git notes list <object>"' '
+	git notes list HEAD^^ > output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
+EOF
+
+test_expect_success 'listing non-existing notes fails' '
+	test_must_fail git notes list HEAD > output &&
+	test_cmp expect output
+'
+
 test_expect_success 'create other note on a different notes ref (setup)' '
 	: > a6 &&
 	git add a6 &&
-- 
1.7.0.rc1.141.gd3fd
