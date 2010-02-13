From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 16/30] Teach builtin-notes to remove empty notes
Date: Sat, 13 Feb 2010 22:28:24 +0100
Message-ID: <1266096518-2104-17-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPZF-0001iD-9y
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758102Ab0BMV3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:40 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51385 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757975Ab0BMV3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:33 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00EFUUD8VE80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:32 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:32 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139842>

When the result of editing a note is an empty string, the associated note
entry should be deleted from the notes tree.

This allows deleting notes by invoking either "git notes -m ''" or
"git notes -F /dev/null".

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-notes.c  |   15 +++++++++++----
 t/t3301-notes.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/builtin-notes.c b/builtin-notes.c
index 89aa6e0..7b4cb13 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -113,7 +113,7 @@ static void create_note(const unsigned char *object,
 
 	stripspace(buf, 1);
 
-	if (!skip_editor && !buf->len) {
+	if (!buf->len) {
 		fprintf(stderr, "Removing note for object %s\n",
 			sha1_to_hex(object));
 		hashclr(result);
@@ -197,7 +197,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
 	const unsigned char *note;
-	const char *object_ref;
+	const char *object_ref, *logmsg;
+
 	int edit = 0, show = 0;
 	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
@@ -271,8 +272,14 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	}
 
 	create_note(object, &buf, msg.given || msgfile, note, new_note);
-	add_note(t, object, new_note, combine_notes_overwrite);
-	commit_notes(t, "Note added by 'git notes edit'");
+	if (is_null_sha1(new_note)) {
+		remove_note(t, object);
+		logmsg = "Note removed by 'git notes edit'";
+	} else {
+		add_note(t, object, new_note, combine_notes_overwrite);
+		logmsg = "Note added by 'git notes edit'";
+	}
+	commit_notes(t, logmsg);
 
 	free_notes(t);
 	strbuf_release(&buf);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index fd5e593..fe59e73 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -234,6 +234,37 @@ test_expect_success 'show -m notes' '
 	test_cmp expect-m output
 '
 
+test_expect_success 'remove note with -F /dev/null (setup)' '
+	git notes edit -F /dev/null
+'
+
+cat > expect-rm-F << EOF
+commit bd1753200303d0a0344be813e504253b3d98e74d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:17:13 2005 -0700
+
+    5th
+EOF
+
+printf "\n" >> expect-rm-F
+cat expect-F >> expect-rm-F
+
+test_expect_success 'verify note removal with -F /dev/null' '
+	git log -4 > output &&
+	test_cmp expect-rm-F output &&
+	! git notes show
+'
+
+test_expect_success 'do not create empty note with -m "" (setup)' '
+	git notes edit -m ""
+'
+
+test_expect_success 'verify non-creation of note with -m ""' '
+	git log -4 > output &&
+	test_cmp expect-rm-F output &&
+	! git notes show
+'
+
 test_expect_success 'create other note on a different notes ref (setup)' '
 	: > a6 &&
 	git add a6 &&
-- 
1.7.0.rc1.141.gd3fd
