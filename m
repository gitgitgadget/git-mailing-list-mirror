From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] cherry-pick: add --skip-commits option
Date: Mon, 27 May 2013 11:52:19 -0500
Message-ID: <1369673539-28692-3-git-send-email-felipe.contreras@gmail.com>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 27 18:54:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh0gb-0005YC-35
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 18:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab3E0QyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 12:54:11 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:54122 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab3E0QyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 12:54:08 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so9079198oag.14
        for <git@vger.kernel.org>; Mon, 27 May 2013 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gvfkIGOQvImIBcyU14kaNIeORvFyFVSD4a5BEXfRWAQ=;
        b=x4S1nt/yrW7W/DTTr/Ub7tKBy/EssXemplV7KsFqqySuSxDfLEgdUPBsTmu2or/D1Q
         qKMkziB87Re3MUtpyYN3oKtjd4LvJYGK3DoTFij62WulDFSvWHmZ3tdEkS0jZ4LbyV//
         g5EUOjqgal4WrfjpAwgd2BgsE9+vcQGeGldi7SRf86jk5PdizcssSBl88tihmiP/EUd1
         5/pWvzBPhdqja1qjbI9WTUTTctPhKk3WPbtmV2AkuMoGLvvCBKK14H1Si5DSr2NTaJax
         PasXv4kJm5Wus0kgsSRsw9ZwOztmS88zTjIRTK5YHEF0u2rZzSlZzSzjqaKJK/zIbD3O
         ZAhg==
X-Received: by 10.182.135.161 with SMTP id pt1mr18426897obb.3.1369673648176;
        Mon, 27 May 2013 09:54:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id z5sm30776280obw.4.2013.05.27.09.54.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 May 2013 09:54:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225611>

Pretty much what it says on the tin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt   |  3 +++
 builtin/revert.c                    |  2 ++
 sequencer.c                         |  5 ++++-
 sequencer.h                         |  1 +
 t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
 5 files changed, 23 insertions(+), 1 deletion(-)

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
index 0401fdb..0e5ce71 100644
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
diff --git a/sequencer.c b/sequencer.c
index 7eeae2f..86e8e78 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -625,7 +625,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		print_advice(res == 1, opts);
 		rerere(opts->allow_rerere_auto);
 	} else {
-		int allow = allow_empty(opts, commit);
+		int allow;
+		if (opts->skip_empty && is_index_unchanged() == 1)
+			goto leave;
+		allow = allow_empty(opts, commit);
 		if (allow < 0) {
 			res = allow;
 			goto leave;
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
1.8.3.rc3.312.g47657de
