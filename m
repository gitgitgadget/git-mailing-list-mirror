From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 12/45] cherry-pick: add --skip-empty option
Date: Sun,  9 Jun 2013 11:40:24 -0500
Message-ID: <1370796057-25312-13-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UliiR-0006ex-0o
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab3FIQn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:29 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61731 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3FIQnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:25 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so8924116obb.19
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/IDFlezmUj6AYnvqMj1phl11kMBKphwYrzcUMFrzuNk=;
        b=S92DN0PGXELTvvS8A/YsU7aHERbTlLXl5IAG0mLdcmaHiqLUsFfYzmeq8vRbeyC7Ea
         IP20Qa66vdaUCRagRkNJXOSumJs/f3oHYsc2AuOfATnDXXfyAJBzxEdKmSgt811k3+c1
         pNGP4HqMRbSg3f4HrHLru5tQQLWyNIW7MRzuetKLN/eNrmmBRI8rczsDoRZYVWZtctNt
         pxYoybQ68tAAAL/ndQ3+TJIWlR9eNea3zIpNgRCwrE04/qqOp7CJisMOBbc91gPizUJJ
         8AjNXOC/V1XShtg59n/Htjlqb2+MxCgEHUkD3l6BJKif3P4ARwQAwAsoKm5wzfFaqE3K
         mGXg==
X-Received: by 10.60.93.105 with SMTP id ct9mr5048934oeb.115.1370796205359;
        Sun, 09 Jun 2013 09:43:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ei16sm15145741oeb.7.2013.06.09.09.43.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226982>

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
