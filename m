From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 02/28] cherry-pick: add --skip-empty option
Date: Fri, 30 Aug 2013 00:55:56 -0500
Message-ID: <1377842182-18724-3-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHlk-000788-0x
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435Ab3H3GBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:06 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35999 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab3H3GBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:05 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so1477783obc.10
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iqDZjfEn4YwP6ab4AKg6zz+hjVv56Lw64TZCUVl0tQw=;
        b=ZtDT7/8G8MxHMQPg6Q1gSwLl5Gseg30muwTyPQ8wHd8qANQUQitdaIeHXhaXTJRPXM
         OGKNq0nUWfV5ZWEGnoZsVF4NP8IQNU++EEcUBqhvEOL5PGz9dE01EEhfVX+aGU5Yo1kr
         XOPXGbx+A25QgSnHidk2Vf/4OND75WUpom1rqhwORihcUq3aN4phvPm/85AFHqvb4O4K
         pehqwvcnY/Cklpwf+I5Fq/qlfLCtaAYNv/adwWZ7AYMeB4DghCqDPhQgGSiwpltAKrHA
         cinKq1vGfTCan+fx0fBH9DEzOSSAHLJxJnT8+iNkJjIDSzG/nvkmnU28C54SdhRvBZ+x
         9pGA==
X-Received: by 10.60.96.131 with SMTP id ds3mr5576179oeb.50.1377842464782;
        Thu, 29 Aug 2013 23:01:04 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ps5sm36996001oeb.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233399>

Pretty much what it says on the tin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt   |  3 +++
 builtin/revert.c                    |  8 ++++++++
 sequencer.c                         |  6 ++++++
 sequencer.h                         |  1 +
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
index 1d2648b..6e7cb2a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -120,6 +120,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
@@ -129,6 +130,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOLEAN(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOLEAN(0, "skip-empty", &opts->skip_empty, N_("skip empty commits")),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
@@ -146,6 +148,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
diff --git a/sequencer.c b/sequencer.c
index a962b33..c387828 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -633,6 +633,12 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
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
diff --git a/sequencer.h b/sequencer.h
index 1fc22dc..3b04844 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -34,6 +34,7 @@ struct replay_opts {
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
1.8.4-fc
