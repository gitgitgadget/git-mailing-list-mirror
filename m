From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 7/9] builtin/notes: Add --allow-empty, to allow storing empty notes
Date: Sun,  9 Nov 2014 13:30:53 +0100
Message-ID: <1415536255-19961-8-git-send-email-johan@herland.net>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 09 13:31:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnRea-00085I-5F
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 13:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbaKIMbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 07:31:20 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:38467 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbaKIMbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 07:31:16 -0500
Received: by mail-la0-f51.google.com with SMTP id q1so6396638lam.24
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 04:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FJHudMODZAZ4OzWNnj93aEaHyjNZvlNXpMMWi+RSZoI=;
        b=kC0hTNBLJx4YUy3iAASLLsyi6Aq9M8FWp+o9C0wP3oBGCLdN90Jsd5wj4FeKyQKHAj
         xu0crk4sPcX3OG84Dv2+1oWLlXjCP+sdFl4PBRCVKxjndWPET+Wd/BZLz+GJ1cMV3aJZ
         xkH94LVCSKMXj9t0vXEhoSTwmQMcQ+Qt9EgJ2pnHHczThUKsvpDqBLeXE73yGBjpW9XJ
         GHJA9Jo+UFgX9OVK+8EjM0ztf1jr/t6rHeDTaAVF2fgAOfRO5Z8KubNNK9xIMyg1451m
         TIO/kXkCcWSyuF2d1hmjhxsN6VEGm9DK8T4LtNI7GJQwMTcWQ21fiXiSKsIIZJZ7ZWvu
         AVDA==
X-Received: by 10.112.36.197 with SMTP id s5mr23636811lbj.30.1415536274751;
        Sun, 09 Nov 2014 04:31:14 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id l7sm4555178lah.27.2014.11.09.04.31.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Nov 2014 04:31:13 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <1415536255-19961-1-git-send-email-johan@herland.net>
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
index 7017434..4605210 100644
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
@@ -444,7 +446,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	}
 
 	prepare_note_data(object, &d, note);
-	if (d.buf.len) {
+	if (d.buf.len || allow_empty) {
 		write_note_data(&d, new_note);
 		if (add_note(t, object, new_note, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
@@ -539,6 +541,7 @@ out:
 
 static int append_edit(int argc, const char **argv, const char *prefix)
 {
+	int allow_empty = 0;
 	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
@@ -559,6 +562,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', "reuse-message", &d, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg},
+		OPT_BOOL(0, "allow-empty", &allow_empty,
+			N_("allow storing empty note")),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
@@ -601,7 +606,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
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
2.1.1.392.g062cc5d
