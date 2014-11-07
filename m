From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 3/5] builtin/notes: Add --allow-empty, to allow storing empty notes
Date: Fri,  7 Nov 2014 10:19:19 +0100
Message-ID: <1415351961-31567-4-git-send-email-johan@herland.net>
References: <1415351961-31567-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 07 10:19:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmfhu-0007O8-GB
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 10:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbaKGJTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 04:19:41 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:55243 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbaKGJTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 04:19:36 -0500
Received: by mail-lb0-f177.google.com with SMTP id z12so2296462lbi.22
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 01:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T/4OTUQ3wyY9mcKgEocYt05ul4axbDEKI4bVLunc9z0=;
        b=PqowJyrdR248nD0uE5czmub2uZOVxAPAvwwMZWPCVbVl3AvYN4NKBxgtPjDXOrGc1s
         sh7DQWISuK2EvtvQmqNjDcObMl2xcANGAqHF+Xb1OKVBjKrf7cMdx60dWmGw/jXR/KFx
         ttH9ZIkWm/lupISfESun0w1o92N91x8936wVW7GpLxV/k5v9N8uFDf1KcHqdJgb16859
         DdBuz3HQGlWOceGPl1wP7o6E3Ns1FAf9upSbl3uCzdAV2x1dhCUReK8DRIKrm7ioKpr+
         NmlQsvyYUpYDa3Ow0YaBNgYQn7BiC2gqTK4aQpoKed1+nb1AkOBPVTbmbCg5A5QHfDiH
         1j8A==
X-Received: by 10.152.29.8 with SMTP id f8mr10132721lah.56.1415351974787;
        Fri, 07 Nov 2014 01:19:34 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm3081897lav.15.2014.11.07.01.19.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Nov 2014 01:19:33 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415351961-31567-1-git-send-email-johan@herland.net>
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
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt | 12 ++++++++----
 builtin/notes.c             | 23 ++++++++++++++---------
 t/t3301-notes.sh            | 10 +++++++++-
 3 files changed, 31 insertions(+), 14 deletions(-)

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
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 33f0558..8280a1a 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1242,7 +1242,8 @@ test_expect_success 'git notes get-ref (--ref)' '
 test_expect_success 'setup testing of empty notes' '
 	git config --unset core.notesRef &&
 	test_commit 16th &&
-	empty_blob=$(git hash-object -w /dev/null)
+	empty_blob=$(git hash-object -w /dev/null) &&
+	echo "$empty_blob" >expect_empty
 '
 
 while read cmd
@@ -1252,6 +1253,13 @@ do
 		MSG= git notes $cmd &&
 		test_must_fail git notes list HEAD
 	"
+
+	test_expect_success "'git notes $cmd --allow-empty' stores empty note" "
+		test_might_fail git notes remove HEAD &&
+		MSG= git notes $cmd --allow-empty &&
+		git notes list HEAD >actual &&
+		test_cmp expect_empty actual
+	"
 done <<\EOF
 add
 add -F /dev/null
-- 
2.0.0.rc4.501.gdaf83ca
