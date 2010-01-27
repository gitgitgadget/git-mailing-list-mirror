From: Johan Herland <johan@herland.net>
Subject: [PATCHv12 16/23] Teach builtin-notes to remove empty notes
Date: Wed, 27 Jan 2010 12:51:53 +0100
Message-ID: <1264593120-4428-17-git-send-email-johan@herland.net>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 27 12:53:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6Sd-0000gj-3o
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab0A0Lwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454Ab0A0Lwp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:52:45 -0500
Received: from smtp.getmail.no ([84.208.15.66]:52905 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752988Ab0A0Lwn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:52:43 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00JDDMBU2M00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:42 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00EZ7MAZN340@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:42 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.113919
X-Mailer: git-send-email 1.6.6.405.g80ed6
In-reply-to: <1264593120-4428-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138146>

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
index a764811..5a0234f 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -71,7 +71,7 @@ static void create_note(const unsigned char *object,
 
 	stripspace(buf, 1);
 
-	if (!skip_editor && !buf->len) {
+	if (!buf->len) {
 		fprintf(stderr, "Removing note for object %s\n",
 			sha1_to_hex(object));
 		hashclr(result);
@@ -155,7 +155,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
 	const unsigned char *note;
-	const char *object_ref;
+	const char *object_ref, *logmsg;
+
 	int edit = 0, show = 0;
 	const char *msgfile = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
@@ -229,8 +230,14 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
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
1.6.6.405.g80ed6
