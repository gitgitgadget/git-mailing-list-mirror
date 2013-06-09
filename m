From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 12/36] cherry-pick: add --skip-empty option
Date: Sun,  9 Jun 2013 14:24:26 -0500
Message-ID: <1370805890-3453-13-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllH2-0003Xe-Da
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab3FIT1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:23 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:50135 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245Ab3FIT1S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:18 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so8892373obb.22
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/IDFlezmUj6AYnvqMj1phl11kMBKphwYrzcUMFrzuNk=;
        b=nk5QiRbfeGZzk4YGi6aCqyb4CKTfaUn1b4zX93+54J79C64JsSH2+jaTS8zlyVcvyO
         y6DfDQh0wygZpR6eZ9zNXJm2G2sijqJRHRmIaWrYh6sM3WDDbRnZpQirpwDTYO9hNtKv
         aLbldfaCNdbiOC2Bk9iBzhAlB9iHmsjA+8ucrRhR9Wj3XUknbVYnFi+xa93PYeWyU/Z7
         9X1T14jMiswKLaJ6kwp91OBmDvB5HkfdpArnAGLFb93s5Hi7w/uC5LMZ5YMnMm3lB5Bb
         jgPv8TwgJpBqZy5qlT5EPPIyIzhEai9L/wST7f9bUjeWU3DcAB7qEvwGv8G3aFXicara
         VOKQ==
X-Received: by 10.60.179.42 with SMTP id dd10mr5544860oec.124.1370806038120;
        Sun, 09 Jun 2013 12:27:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wz1sm16025338obc.3.2013.06.09.12.27.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227120>

Pretty much what it says on the tin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt   |  3 +++
 builtin/revert.c                    |  8 ++++++++
 builtin/sequencer.c                 |  6 ++++++
 builtin/sequencer.h                 |  1 +
 t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
 5 files changed, 31 insertions(+)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index c205d23..fccd936 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -129,6 +129,9 @@ effect to your index in a row.
 	redundant commits are ignored.  This option overrides that behavior and
 	creates an empty commit object.  Implies `--allow-empty`.
 
+--skip-empty::
+	Instead of failing, skip commits that are or become empty.
+
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
 	See the MERGE STRATEGIES section in linkgit:git-merge[1]
diff --git a/builtin/revert.c b/builtin/revert.c
index 0401fdb..5a8453d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -118,6 +118,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
@@ -127,6 +128,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOLEAN(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOLEAN(0, "skip-empty", &opts->skip_empty, N_("skip empty commits")),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
@@ -144,6 +146,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				"--abort", rollback,
 				NULL);
 
+	verify_opt_mutually_compatible(me,
+				"--allow-empty", opts->allow_empty,
+				"--skip-empty", opts->skip_empty,
+				"--keep-redundant-commits", opts->keep_redundant_commits,
+				NULL);
+
 	/* implies allow_empty */
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index 4d7dc8b..56551bb 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -538,6 +538,12 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		goto leave;
 	}
 
+	if (opts->skip_empty && is_index_unchanged() == 1) {
+		warning(_("skipping %s... %s"),
+			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
+			msg.subject);
+		goto leave;
+	}
 	allow = allow_empty(opts, commit);
 	if (allow < 0) {
 		res = allow;
diff --git a/builtin/sequencer.h b/builtin/sequencer.h
index c341918..86e2eee 100644
--- a/builtin/sequencer.h
+++ b/builtin/sequencer.h
@@ -32,6 +32,7 @@ struct replay_opts {
 	int allow_empty;
 	int allow_empty_message;
 	int keep_redundant_commits;
+	int skip_empty;
 
 	int mainline;
 
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 19c99d7..3dc19c6 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -187,4 +187,17 @@ test_expect_success 'cherry-pick --stdin works' '
 	check_head_differs_from fourth
 '
 
+test_expect_success 'cherry-pick skip empty' '
+	git clean -fxd &&
+	git checkout -b empty fourth &&
+	git commit --allow-empty -m empty &&
+	test_commit ontop &&
+	git checkout -f master &&
+	git reset --hard fourth &&
+	git cherry-pick --skip-empty fourth..empty &&
+	echo ontop > expected &&
+	git log --format=%s fourth..HEAD > actual
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.3.698.g079b096
