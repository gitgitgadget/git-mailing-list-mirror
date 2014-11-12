From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 7/9] builtin/notes: Add --allow-empty, to allow storing empty notes
Date: Wed, 12 Nov 2014 01:40:14 +0100
Message-ID: <1415752816-22782-8-git-send-email-johan@herland.net>
References: <1415752816-22782-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, peff@peff.net, blume.mike@gmail.com,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 01:40:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoLzT-0005vi-Up
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 01:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbaKLAkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 19:40:45 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:64920 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbaKLAkn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 19:40:43 -0500
Received: by mail-la0-f51.google.com with SMTP id q1so10538333lam.38
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 16:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rHjFeJNy59fRdiinPLumV+I6yhjdeivUDcDieiF/b7o=;
        b=d9BYvWnxNw5zxW611WIcTtr1YYnDqmxopkG/8vRmHiazIPsTlX6LOtWpgT2Rtg/sYf
         1fBC9DbkW8NtQ0WxbNwhvy3wiot7OOI+uu64zPWCZZIl2iURv3YwHVv2xUvKv2AnTlK7
         PAc6mN9uxVSFyb2RtmIVFwUnd56gwB50951NFux60oT59T+s6cLBxE+gX0GKi5meqZjP
         13BXm0y+nIsdzd2dI/HdRFADtWF1f8UQ5fWr7xdYA5xsT3zJhd0a2ALiPh42rw81dZvd
         V4IbBp3Vm0EvNIr5YJNPm9nC53aqsmzyqEFlnB1xabKpDdQhPgAaUkGUEUhz0rzZ0Bra
         sldw==
X-Received: by 10.152.29.8 with SMTP id f8mr39155187lah.56.1415752841379;
        Tue, 11 Nov 2014 16:40:41 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm6341174lav.15.2014.11.11.16.40.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Nov 2014 16:40:40 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415752816-22782-1-git-send-email-johan@herland.net>
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
 builtin/notes.c             | 17 +++++++++++------
 t/t3301-notes.sh            | 10 +++++++++-
 3 files changed, 28 insertions(+), 11 deletions(-)

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
index ed32d63..a9f37d0 100644
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
@@ -381,7 +381,7 @@ static int append_edit(int argc, const char **argv, const char *prefix);
 
 static int add(int argc, const char **argv, const char *prefix)
 {
-	int force = 0;
+	int force = 0, allow_empty = 0;
 	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
@@ -400,6 +400,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', "reuse-message", &d, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg},
+		OPT_BOOL(0, "allow-empty", &allow_empty,
+			N_("allow storing empty note")),
 		OPT__FORCE(&force, N_("replace existing notes")),
 		OPT_END()
 	};
@@ -445,7 +447,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	}
 
 	prepare_note_data(object, &d, note);
-	if (d.buf.len) {
+	if (d.buf.len || allow_empty) {
 		write_note_data(&d, new_note);
 		if (add_note(t, object, new_note, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
@@ -540,6 +542,7 @@ out:
 
 static int append_edit(int argc, const char **argv, const char *prefix)
 {
+	int allow_empty = 0;
 	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
@@ -560,6 +563,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', "reuse-message", &d, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg},
+		OPT_BOOL(0, "allow-empty", &allow_empty,
+			N_("allow storing empty note")),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
@@ -602,7 +607,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		free(prev_buf);
 	}
 
-	if (d.buf.len) {
+	if (d.buf.len || allow_empty) {
 		write_note_data(&d, new_note);
 		if (add_note(t, object, new_note, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index f74b3fa..70ec5c3 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1242,7 +1242,8 @@ test_expect_success 'git notes get-ref (--ref)' '
 test_expect_success 'setup testing of empty notes' '
 	test_unconfig core.notesRef &&
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
