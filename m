From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Tue, 28 May 2013 22:56:23 -0500
Message-ID: <1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:58:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXWt-0002wT-1v
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934782Ab3E2D6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:58:19 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:47507 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933578Ab3E2D6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:58:17 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so10884460oag.20
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0+6DGlXzMBQ07WLZxZvvmdcqZ/6kasLQ/91bobwxiGE=;
        b=Qy/m3YRyMUaCF4eY7P8YGKQ099Cl1nHVrUqLHyCwrkUwncQ935xB434Ct2wZTqENQA
         6w/oCfxKMCPY6/5ozZT04v0UMRf5IosK+3UdJugxtcRCUl5HQJCJ5/MVpS5/TFHffk12
         +Vnng9b6KQvANHYsXz9FycW1BpTP7jv58baIkTwJViD6rsfSC4t/WAokmo14J/C83os4
         99xony0sa1Pc3b8za9Gdm6L9GdygkpmDgNcNTWzUNMLvIaNrAr1UXgaxPGlk7K/MXZTQ
         RmPSn5WYsD2OCZVy5AlpjiSm3YgdPHVkpoR/fJFFM4KObaMmSems3fA6+587HpPKsDKw
         bu/A==
X-Received: by 10.182.236.104 with SMTP id ut8mr467524obc.75.1369799897394;
        Tue, 28 May 2013 20:58:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm38257858oby.12.2013.05.28.20.58.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:58:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225716>

Pretty much what it says on the tin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt   |  3 +++
 builtin/revert.c                    |  2 ++
 sequencer.c                         |  6 ++++++
 sequencer.h                         |  1 +
 t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
 5 files changed, 25 insertions(+)

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
index f7be7d8..d3c7d72 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -627,6 +627,12 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
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
1.8.3.rc3.312.g47657de
