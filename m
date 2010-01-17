From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 17/20] builtin-notes: Teach -d option for deleting existing
 notes
Date: Sun, 17 Jan 2010 22:04:34 +0100
Message-ID: <1263762277-31419-18-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:06:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcKN-0007dl-2C
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab0AQVFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754801Ab0AQVFk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:40 -0500
Received: from smtp.getmail.no ([84.208.15.66]:56386 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754725Ab0AQVFf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:35 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002L1T90Y850@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:24 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:24 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137332>

Using -d is equivalent to specifying an empty note message. This option is
provided largely for consistency with other git commands, such as git tag
and git branch.

The patch includes tests verifying the correct behaviour of the new option.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   13 ++++++++-----
 builtin-notes.c             |   16 ++++++++++------
 t/t3301-notes.sh            |   27 +++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index bb73b02..bac34bb 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -8,14 +8,14 @@ git-notes - Add/inspect commit notes
 SYNOPSIS
 --------
 [verse]
-'git-notes' (edit [-F <file> | -m <msg>] | show) [commit]
+'git-notes' (edit [-F <file> | -m <msg> | -d] | show) [commit]
 
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
@@ -44,6 +44,9 @@ OPTIONS
 	Take the note message from the given file.  Use '-' to
 	read the note message from the standard input.
 
+-d::
+	Remove the note. This is equivalent to specifying an
+	empty note message.
 
 Author
 ------
diff --git a/builtin-notes.c b/builtin-notes.c
index 0cce608..a166ad0 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -17,7 +17,7 @@
 #include "parse-options.h"
 
 static const char * const git_notes_usage[] = {
-	"git notes edit [-m <msg>|-F <file>] [<object>]",
+	"git notes edit [-m <msg> | -F <file> | -d] [<object>]",
 	"git notes show [<object>]",
 	NULL
 };
@@ -159,7 +159,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	const unsigned char *note;
 	const char *object_ref, *logmsg;
 
-	int edit = 0, show = 0;
+	int edit = 0, show = 0, delete = 0;
 	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct option options[] = {
@@ -167,6 +167,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('m', NULL, &msg, "msg",
 			     "note contents as a string", parse_msg_arg),
 		OPT_FILENAME('F', NULL, &msgfile, "note contents in a file"),
+		OPT_BOOLEAN('d', NULL, &delete, "delete existing note"),
 		OPT_END()
 	};
 
@@ -212,13 +213,15 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	/* edit command */
 
-	if (msg.given || msgfile) {
-		if (msg.given && msgfile) {
-			error("mixing -m and -F options is not allowed.");
+	if (msg.given || msgfile || delete) {
+		if (msg.given + delete + (msgfile ? 1 : 0) > 1) {
+			error("mixing -m/-F/-d options is not allowed.");
 			usage_with_options(git_notes_usage, options);
 		}
 		if (msg.given)
 			strbuf_addbuf(&buf, &(msg.buf));
+		else if (delete)
+			strbuf_reset(&buf);
 		else {
 			if (!strcmp(msgfile, "-")) {
 				if (strbuf_read(&buf, 0, 1024) < 0)
@@ -231,7 +234,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	create_note(object, &buf, msg.given || msgfile, note, new_note);
+	create_note(object, &buf, msg.given || msgfile || delete, note,
+		    new_note);
 	if (is_null_sha1(new_note)) {
 		remove_note(t, object);
 		logmsg = "Note removed by 'git notes edit'";
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 404a94b..8617c2f 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -212,6 +212,33 @@ test_expect_success 'verify non-creation of note with -m ""' '
 	! git notes show
 '
 
+test_expect_success 'remove note with -d (setup)' '
+	git notes edit -d HEAD^
+'
+
+cat > expect-rm-d << EOF
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
+printf "\n" >> expect-rm-d
+cat expect-multiline >> expect-rm-d
+
+test_expect_success 'verify note removal with -d' '
+	git log -4 > output &&
+	test_cmp expect-rm-d output &&
+	! git notes show HEAD^
+'
+
 test_expect_success 'create other note on a different notes ref (setup)' '
 	: > a6 &&
 	git add a6 &&
-- 
1.6.6.rc1.321.g0496e
