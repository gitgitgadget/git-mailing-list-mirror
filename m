From: Johan Herland <johan@herland.net>
Subject: [PATCHv12 20/23] builtin-notes: Add "prune" subcommand for removing
 notes for missing objects
Date: Wed, 27 Jan 2010 12:51:57 +0100
Message-ID: <1264593120-4428-21-git-send-email-johan@herland.net>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 27 12:53:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6Sf-0000gj-8R
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab0A0LxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590Ab0A0LxA
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:53:00 -0500
Received: from smtp.getmail.no ([84.208.15.66]:59320 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753454Ab0A0Lw4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:52:56 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00FE8MC1FU60@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:49 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00EZ7MAZN340@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:49 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.113919
X-Mailer: git-send-email 1.6.6.405.g80ed6
In-reply-to: <1264593120-4428-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138144>

"git notes prune" will remove all notes that annotate unreachable/non-
existing objects.

The patch includes tests verifying correct behaviour of the new subcommand.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |    4 +-
 builtin-notes.c             |   28 ++++++++-----
 t/t3306-notes-prune.sh      |   94 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 11 deletions(-)
 create mode 100755 t/t3306-notes-prune.sh

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index a52d23a..3973f90 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -8,7 +8,7 @@ git-notes - Add/inspect commit notes
 SYNOPSIS
 --------
 [verse]
-'git notes' (edit [-F <file> | -m <msg>] | show | remove) [commit]
+'git notes' (edit [-F <file> | -m <msg>] | show | remove | prune) [commit]
 
 DESCRIPTION
 -----------
@@ -37,6 +37,8 @@ remove::
 	This is equivalent to specifying an empty note message to
 	the `edit` subcommand.
 
+prune::
+	Remove all notes for non-existing/unreachable objects.
 
 OPTIONS
 -------
diff --git a/builtin-notes.c b/builtin-notes.c
index 88b99a7..e84ab7a 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -20,6 +20,7 @@ static const char * const git_notes_usage[] = {
 	"git notes edit [-m <msg> | -F <file>] [<object>]",
 	"git notes show [<object>]",
 	"git notes remove [<object>]",
+	"git notes prune",
 	NULL
 };
 
@@ -159,7 +160,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	const char *object_ref;
 	char logmsg[100];
 
-	int edit = 0, show = 0, remove = 0;
+	int edit = 0, show = 0, remove = 0, prune = 0;
 	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct option options[] = {
@@ -180,8 +181,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		show = 1;
 	else if (argc && !strcmp(argv[0], "remove"))
 		remove = 1;
+	else if (argc && !strcmp(argv[0], "prune"))
+		prune = 1;
 
-	if (edit + show + remove != 1)
+	if (edit + show + remove + prune != 1)
 		usage_with_options(git_notes_usage, options);
 
 	if ((msg.given || msgfile) && !edit) {
@@ -195,7 +198,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	}
 
 	object_ref = argc == 2 ? argv[1] : "HEAD";
-	if (argc > 2) {
+	if (argc > 2 || (prune && argc > 1)) {
 		error("too many parameters");
 		usage_with_options(git_notes_usage, options);
 	}
@@ -222,7 +225,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		return execv_git_cmd(show_args);
 	}
 
-	/* edit/remove command */
+	/* edit/remove/prune command */
 
 	if (remove)
 		strbuf_reset(&buf);
@@ -236,12 +239,17 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 			die_errno("could not open or read '%s'", msgfile);
 	}
 
-	create_note(object, &buf, msg.given || msgfile || remove, note,
-		    new_note);
-	if (is_null_sha1(new_note))
-		remove_note(t, object);
-	else
-		add_note(t, object, new_note, combine_notes_overwrite);
+	if (prune) {
+		hashclr(new_note);
+		prune_notes(t);
+	} else {
+		create_note(object, &buf, msg.given || msgfile || remove, note,
+			    new_note);
+		if (is_null_sha1(new_note))
+			remove_note(t, object);
+		else
+			add_note(t, object, new_note, combine_notes_overwrite);
+	}
 	snprintf(logmsg, sizeof(logmsg), "Note %s by 'git notes %s'",
 		 is_null_sha1(new_note) ? "removed" : "added", argv[0]);
 	commit_notes(t, logmsg);
diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
new file mode 100755
index 0000000..b0adc7e
--- /dev/null
+++ b/t/t3306-notes-prune.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+
+test_description='Test git notes prune'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: create a few commits with notes' '
+
+	: > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m 1st &&
+	git notes edit -m "Note #1" &&
+	: > file2 &&
+	git add file2 &&
+	test_tick &&
+	git commit -m 2nd &&
+	git notes edit -m "Note #2" &&
+	: > file3 &&
+	git add file3 &&
+	test_tick &&
+	git commit -m 3rd &&
+	git notes edit -m "Note #3"
+'
+
+cat > expect <<END_OF_LOG
+commit 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3rd
+
+Notes:
+    Note #3
+
+commit 08341ad9e94faa089d60fd3f523affb25c6da189
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    2nd
+
+Notes:
+    Note #2
+
+commit ab5f302035f2e7aaf04265f08b42034c23256e1f
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    1st
+
+Notes:
+    Note #1
+END_OF_LOG
+
+test_expect_success 'verify commits and notes' '
+
+	git log > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'remove some commits' '
+
+	git reset --hard HEAD~2 &&
+	git reflog expire --expire=now HEAD &&
+	git gc --prune=now
+'
+
+test_expect_success 'verify that commits are gone' '
+
+	! git cat-file -p 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	! git cat-file -p 08341ad9e94faa089d60fd3f523affb25c6da189 &&
+	git cat-file -p ab5f302035f2e7aaf04265f08b42034c23256e1f
+'
+
+test_expect_success 'verify that notes are still present' '
+
+	git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
+	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
+'
+
+test_expect_success 'prune notes' '
+
+	git notes prune
+'
+
+test_expect_success 'verify that notes are gone' '
+
+	! git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	! git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
+	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
+'
+
+test_done
-- 
1.6.6.405.g80ed6
