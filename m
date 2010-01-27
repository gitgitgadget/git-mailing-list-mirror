From: Johan Herland <johan@herland.net>
Subject: [PATCHv12 22/23] builtin-notes: Add "list" subcommand for listing note
 objects
Date: Wed, 27 Jan 2010 12:51:59 +0100
Message-ID: <1264593120-4428-23-git-send-email-johan@herland.net>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 27 12:54:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6Sg-0000gj-Rb
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab0A0LxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732Ab0A0LxP
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:53:15 -0500
Received: from smtp.getmail.no ([84.208.15.66]:59320 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753313Ab0A0LxA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:53:00 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00FEKMC4FU60@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:52 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00EZ7MAZN340@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:52 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.113919
X-Mailer: git-send-email 1.6.6.405.g80ed6
In-reply-to: <1264593120-4428-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138152>

"git notes list" will list all note objects in the current notes ref (in the
format "<note object> <annotated object>"). "git notes list <object>" will
list the note object associated with the given <object>, if any.

If no arguments are given to "git notes", it defaults to the "list"
subcommand. This is for pseudo-compatibility with "git tag" and "git branch".

The patch includes tests verifying correct behaviour of the new subcommand.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   13 ++++++++++++-
 builtin-notes.c             |   33 +++++++++++++++++++++++++++++----
 t/t3301-notes.sh            |   24 ++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 5 deletions(-)

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
index e84ab7a..a322642 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -17,6 +17,7 @@
 #include "parse-options.h"
 
 static const char * const git_notes_usage[] = {
+	"git notes [list [<object>]]",
 	"git notes edit [-m <msg> | -F <file>] [<object>]",
 	"git notes show [<object>]",
 	"git notes remove [<object>]",
@@ -30,6 +31,14 @@ static const char note_template[] =
 	"# Write/edit the note contents\n"
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
@@ -160,7 +169,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	const char *object_ref;
 	char logmsg[100];
 
-	int edit = 0, show = 0, remove = 0, prune = 0;
+	int list = 0, edit = 0, show = 0, remove = 0, prune = 0;
+	int given_object;
 	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct option options[] = {
@@ -175,7 +185,9 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage, 0);
 
-	if (argc && !strcmp(argv[0], "edit"))
+	if (argc && !strcmp(argv[0], "list"))
+		list = 1;
+	else if (argc && !strcmp(argv[0], "edit"))
 		edit = 1;
 	else if (argc && !strcmp(argv[0], "show"))
 		show = 1;
@@ -183,8 +195,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		remove = 1;
 	else if (argc && !strcmp(argv[0], "prune"))
 		prune = 1;
+	else if (!argc)
+		list = 1; /* Default to 'list' if no other subcommand given */
 
-	if (edit + show + remove + prune != 1)
+	if (list + edit + show + remove + prune != 1)
 		usage_with_options(git_notes_usage, options);
 
 	if ((msg.given || msgfile) && !edit) {
@@ -197,7 +211,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_usage, options);
 	}
 
-	object_ref = argc == 2 ? argv[1] : "HEAD";
+	given_object = argc == 2;
+	object_ref = given_object ? argv[1] : "HEAD";
 	if (argc > 2 || (prune && argc > 1)) {
 		error("too many parameters");
 		usage_with_options(git_notes_usage, options);
@@ -215,6 +230,16 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	note = get_note(t, object);
 
+	/* list command */
+
+	if (list) {
+		if (given_object) {
+			puts(sha1_to_hex(note));
+			return 0;
+		} else
+			return for_each_note(t, 0, list_each_note, NULL);
+	}
+
 	/* show command */
 
 	if (show && !note) {
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d29daac..13f307a 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -292,6 +292,30 @@ test_expect_success 'verify note removal with "git notes remove"' '
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
 test_expect_success 'create other note on a different notes ref (setup)' '
 	: > a6 &&
 	git add a6 &&
-- 
1.6.6.405.g80ed6
