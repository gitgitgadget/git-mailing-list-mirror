From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 26/30] builtin-notes: Deprecate the -m/-F options for
 "git notes edit"
Date: Sat, 13 Feb 2010 22:28:34 +0100
Message-ID: <1266096518-2104-27-git-send-email-johan@herland.net>
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
	id 1NgPan-0002mJ-7c
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137Ab0BMVaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:30:10 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62641 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758130Ab0BMV36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:58 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FKZUDX5490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:57 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:57 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211825
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139858>

The semantics for "git notes edit -m/-F" overlap with those for
"git notes add -f", and the behaviour (i.e. overwriting existing
notes with the given message/file) is more intuitively captured
by (and better documented with) "git notes add -f".

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |    2 +-
 builtin-notes.c             |   10 ++++++++--
 t/t3304-notes-mixed.sh      |    2 +-
 t/t3305-notes-fanout.sh     |    2 +-
 t/t3306-notes-prune.sh      |    6 +++---
 5 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 35dd8fa..53c5d90 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git notes' [list [<object>]]
 'git notes' add [-f] [-F <file> | -m <msg>] [<object>]
 'git notes' append [-F <file> | -m <msg>] [<object>]
-'git notes' edit [-F <file> | -m <msg>] [<object>]
+'git notes' edit [<object>]
 'git notes' show [<object>]
 'git notes' remove [<object>]
 'git notes' prune
diff --git a/builtin-notes.c b/builtin-notes.c
index c88df00..572b477 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -21,7 +21,7 @@ static const char * const git_notes_usage[] = {
 	"git notes [list [<object>]]",
 	"git notes add [-f] [-m <msg> | -F <file>] [<object>]",
 	"git notes append [-m <msg> | -F <file>] [<object>]",
-	"git notes edit [-m <msg> | -F <file>] [<object>]",
+	"git notes edit [<object>]",
 	"git notes show [<object>]",
 	"git notes remove [<object>]",
 	"git notes prune",
@@ -233,7 +233,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct option options[] = {
-		OPT_GROUP("Notes edit options"),
+		OPT_GROUP("Notes options"),
 		OPT_CALLBACK('m', "message", &msg, "msg",
 			     "note contents as a string", parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, "note contents in a file"),
@@ -270,6 +270,12 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_usage, options);
 	}

+	if ((msg.given || msgfile) && edit) {
+		fprintf(stderr, "The -m and -F options has been deprecated for"
+			" the 'edit' subcommand.\n"
+			"Please use 'git notes add -f -m/-F' instead.\n");
+	}
+
 	if (msg.given && msgfile) {
 		error("mixing -m and -F options is not allowed.");
 		usage_with_options(git_notes_usage, options);
diff --git a/t/t3304-notes-mixed.sh b/t/t3304-notes-mixed.sh
index c975a6d..1709e8c 100755
--- a/t/t3304-notes-mixed.sh
+++ b/t/t3304-notes-mixed.sh
@@ -188,7 +188,7 @@ test_expect_success "verify contents of non-notes" '
 test_expect_success "git-notes preserves non-notes" '

 	test_tick &&
-	git notes edit -m "foo bar"
+	git notes add -f -m "foo bar"
 '

 test_expect_success "verify contents of non-notes after git-notes" '
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index c6d263b..b1ea64b 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -14,7 +14,7 @@ test_expect_success 'creating many notes with git-notes' '
 		echo "file for commit #$i" > file &&
 		git add file &&
 		git commit -q -m "commit #$i" &&
-		git notes edit -m "note #$i" || return 1
+		git notes add -m "note #$i" || return 1
 	done
 '

diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
index b0adc7e..a0ed035 100755
--- a/t/t3306-notes-prune.sh
+++ b/t/t3306-notes-prune.sh
@@ -10,17 +10,17 @@ test_expect_success 'setup: create a few commits with notes' '
 	git add file1 &&
 	test_tick &&
 	git commit -m 1st &&
-	git notes edit -m "Note #1" &&
+	git notes add -m "Note #1" &&
 	: > file2 &&
 	git add file2 &&
 	test_tick &&
 	git commit -m 2nd &&
-	git notes edit -m "Note #2" &&
+	git notes add -m "Note #2" &&
 	: > file3 &&
 	git add file3 &&
 	test_tick &&
 	git commit -m 3rd &&
-	git notes edit -m "Note #3"
+	git notes add -m "Note #3"
 '

 cat > expect <<END_OF_LOG
--
1.7.0.rc1.141.gd3fd
