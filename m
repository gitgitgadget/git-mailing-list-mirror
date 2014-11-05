From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 3/3] notes: Add --allow-empty, to allow storing empty notes
Date: Wed,  5 Nov 2014 09:32:27 +0100
Message-ID: <1415176347-18694-3-git-send-email-johan@herland.net>
References: <1415176347-18694-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 05 09:33:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xlw1g-0006Mv-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 09:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbaKEIdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 03:33:07 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:53430 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaKEIdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 03:33:04 -0500
Received: by mail-la0-f48.google.com with SMTP id gq15so222222lab.35
        for <git@vger.kernel.org>; Wed, 05 Nov 2014 00:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GDOLtoVi0UcqANxWQQuiVmnngkS7fkM1cw2fVPBYi0g=;
        b=PkkIVWa34ucPpWmeMtiPYZ+JKjXS5Ix0EdcbmqAUvGi5Pr7gup3X4cmHKh6dkR5kkp
         1pywU4Xak5eXGSNWk3AfUqVVMy88Nx+8Oml7pC3aSaRboAb4UNQTj0yXRGIVvDm7jQbV
         yDMxXEd+4jJee5AyLXzvBev4rVBdop692xOiWN8DlC76UhnKhaCybN7uWIDvTT2nv4gR
         Zuca92KCWf8O8H0gmGQ8k5KKKmUIoQN8vps36w2Ru4AibtsRZg3qncZh07g9P1Cd/N8v
         VVlK8vkUayv1chNV701EV6c4PJC2yEMRuqfxLrGMgKXcc3UAi2ieAP13feYBE/JP4dus
         Ddtw==
X-Received: by 10.152.7.193 with SMTP id l1mr10699738laa.57.1415176383170;
        Wed, 05 Nov 2014 00:33:03 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id ro7sm1072041lbb.14.2014.11.05.00.33.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Nov 2014 00:33:01 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415176347-18694-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although the "git notes" man page advertises that we support binary-safe
notes addition (using the -C option), we currently do not support adding
the empty note (i.e. using the empty blob to annotate an object). Instead,
an empty note is always treated as an intent to remove the note
altogether.

Introduce the --allow-empty option to the add/append/edit subcommands,
to explicitly allow an empty note to be stored into the notes tree.

Also update the documentation, and add test cases for the new option.

Reported-by: James H. Fisher <jhf@trifork.com>
Improved-by: Kyle J. McKay <mackyle@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt | 12 ++++++++----
 builtin/notes.c             | 23 ++++++++++++++---------
 notes.c                     |  3 +--
 t/t3312-notes-empty.sh      | 17 ++++++++++++++++-
 4 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 310f0a5..851518d 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -9,10 +9,10 @@ SYNOPSIS
 --------
 [verse]
 'git notes' [list [<object>]]
-'git notes' add [-f] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' copy [-f] ( --stdin | <from-object> <to-object> )
-'git notes' append [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
-'git notes' edit [<object>]
+'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' edit [--allow-empty] [<object>]
 'git notes' show [<object>]
 'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
 'git notes' merge --commit [-v | -q]
@@ -155,6 +155,10 @@ OPTIONS
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the note message.
 
+--allow-empty::
+	Allow an empty note object to be stored. The default behavior is
+	to automatically remove empty notes.
+
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	'GIT_NOTES_REF' and the "core.notesRef" configuration.  The ref
@@ -287,7 +291,7 @@ arbitrary files using 'git hash-object':
 ------------
 $ cc *.c
 $ blob=$(git hash-object -w a.out)
-$ git notes --ref=built add -C "$blob" HEAD
+$ git notes --ref=built add --allow-empty -C "$blob" HEAD
 ------------
 
 (You cannot simply use `git notes --ref=built add -F a.out HEAD`
diff --git a/builtin/notes.c b/builtin/notes.c
index 9ee6816..038a419 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -22,10 +22,10 @@
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes_ref>] [list [<object>]]"),
-	N_("git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes_ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
 	N_("git notes [--ref <notes_ref>] copy [-f] <from-object> <to-object>"),
-	N_("git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
-	N_("git notes [--ref <notes_ref>] edit [<object>]"),
+	N_("git notes [--ref <notes_ref>] append [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes_ref>] edit [--allow-empty] [<object>]"),
 	N_("git notes [--ref <notes_ref>] show [<object>]"),
 	N_("git notes [--ref <notes_ref>] merge [-v | -q] [-s <strategy> ] <notes_ref>"),
 	N_("git notes merge --commit [-v | -q]"),
@@ -150,8 +150,8 @@ static void write_commented_object(int fd, const unsigned char *object)
 }
 
 static void create_note(const unsigned char *object, struct msg_arg *msg,
-			int append_only, const unsigned char *prev,
-			unsigned char *result)
+			int append_only, int allow_empty,
+			const unsigned char *prev, unsigned char *result)
 {
 	char *path = NULL;
 
@@ -202,7 +202,7 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
 		free(prev_buf);
 	}
 
-	if (!msg->buf.len) {
+	if (!allow_empty && !msg->buf.len) {
 		fprintf(stderr, _("Removing note for object %s\n"),
 			sha1_to_hex(object));
 		hashclr(result);
@@ -397,7 +397,7 @@ static int append_edit(int argc, const char **argv, const char *prefix);
 
 static int add(int argc, const char **argv, const char *prefix)
 {
-	int retval = 0, force = 0;
+	int retval = 0, force = 0, allow_empty = 0;
 	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
@@ -417,6 +417,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg},
+		OPT_BOOL(0, "allow-empty", &allow_empty,
+			N_("allow storing empty note")),
 		OPT__FORCE(&force, N_("replace existing notes")),
 		OPT_END()
 	};
@@ -460,7 +462,7 @@ static int add(int argc, const char **argv, const char *prefix)
 			sha1_to_hex(object));
 	}
 
-	create_note(object, &msg, 0, note, new_note);
+	create_note(object, &msg, 0, allow_empty, note, new_note);
 
 	if (is_null_sha1(new_note))
 		remove_note(t, object);
@@ -554,6 +556,7 @@ out:
 
 static int append_edit(int argc, const char **argv, const char *prefix)
 {
+	int allow_empty = 0;
 	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
@@ -574,6 +577,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg},
+		OPT_BOOL(0, "allow-empty", &allow_empty,
+			N_("allow storing empty note")),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
@@ -600,7 +605,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	t = init_notes_check(argv[0]);
 	note = get_note(t, object);
 
-	create_note(object, &msg, !edit, note, new_note);
+	create_note(object, &msg, !edit, allow_empty, note, new_note);
 
 	if (is_null_sha1(new_note))
 		remove_note(t, object);
diff --git a/notes.c b/notes.c
index 5fe691d..62bc6e1 100644
--- a/notes.c
+++ b/notes.c
@@ -1218,8 +1218,7 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (!sha1)
 		return;
 
-	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen ||
-			type != OBJ_BLOB) {
+	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || type != OBJ_BLOB) {
 		free(msg);
 		return;
 	}
diff --git a/t/t3312-notes-empty.sh b/t/t3312-notes-empty.sh
index 44074f6..6fce25f 100755
--- a/t/t3312-notes-empty.sh
+++ b/t/t3312-notes-empty.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Test adding/editing of empty notes'
+test_description='Test adding/editing of empty notes with/without --allow-empty'
 . ./test-lib.sh
 
 write_script fake_editor <<\EOF
@@ -12,6 +12,9 @@ export GIT_EDITOR
 test_expect_success 'setup' '
 	test_commit one &&
 	git log -1 >expect_missing &&
+	cp expect_missing expect_empty &&
+	echo >>expect_empty &&
+	echo "Notes:" >>expect_empty &&
 	empty_blob=$(git hash-object -w /dev/null)
 '
 
@@ -25,6 +28,12 @@ verify_missing() {
 	! git notes list HEAD
 }
 
+verify_empty() {
+	git log -1 > actual &&
+	test_cmp expect_empty actual &&
+	test "$(git notes list HEAD)" = "$empty_blob"
+}
+
 for cmd in \
 	'add' \
 	'add -F /dev/null' \
@@ -43,6 +52,12 @@ do
 		MSG= git notes $cmd &&
 		verify_missing
 	"
+
+	test_expect_success "'git notes $cmd --allow-empty' stores empty note" "
+		cleanup_notes &&
+		MSG= git notes $cmd --allow-empty &&
+		verify_empty
+	"
 done
 
 test_done
-- 
2.0.0.rc4.501.gdaf83ca
