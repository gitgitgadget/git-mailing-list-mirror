Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B4E1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbcLITBp (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:01:45 -0500
Received: from mout.gmx.net ([212.227.15.18]:62802 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbcLITBo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:01:44 -0500
Received: from fermat.fritz.box ([88.70.156.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOx4J-1cKcp61TJH-006L82; Fri, 09
 Dec 2016 20:01:35 +0100
From:   Stephan Beyer <s-beyer@gmx.net>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 4/5] Make sequencer abort safer
Date:   Fri,  9 Dec 2016 20:01:10 +0100
Message-Id: <20161209190111.9571-4-s-beyer@gmx.net>
X-Mailer: git-send-email 2.11.0.27.g74d6bea
In-Reply-To: <20161209190111.9571-1-s-beyer@gmx.net>
References: <20161209190111.9571-1-s-beyer@gmx.net>
In-Reply-To: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:fGGL32sRlRCELAVyvtb/zDQDQjo8EA1qBH2ydoGU2vXV+MUnwJ7
 7aUqzrbiw0/rMoSzEP2Ijum1eOZDPOJhldxbiMQpPNNNXvxpfrVsf/utEytLBe0ZviG2FTd
 KQM20Daa9It8w+qYbQ1gNhIaGE309Ih3xNRn9syF8/tmu9ty8RWiuW1zGniMpRqRCzwNv0E
 iZaiC7Rmt9DH1roVEs9tA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4NquM+bquU0=:9CThccUeNN/SSqlAXRVNjz
 hQmWxTOFQFGDiXEAh0X8jJfUAbwbaiKaD32NuJxJn/EHTWyBd+4VyULk5vhM/XhOM4b3QTGdW
 +HXt8AMfBmLZ1DskmaHwd2wOpQaHC/vl8yKDHfdG8IIAl5TW0HO3iAadCMn9my5aJByfDOQPM
 S9oHWYe2vnYFte8QUx4BzaxEhGYgAJUL/JOEo0b5aIDbz25ziyOxItE/n9Cu/VyDGIO7GaMRG
 MYhnDJ6dvb3XS7FKQNoEgcWJpAVmB2suG3fXnyM1/fprbMqnh6Zh3GvcNOQuFqihr7r2ofcbY
 KBneIDvdSQilr8Qj/MGvuiVdtT5NGRoHu4z3DgS2Ey6NOASLV8INeY/14PlwUC9T4YnidTVOq
 gkhWTfV8xUfYIHvswPnaNMwFrzgFrehhvkIROkPTxjldox41OBlUw+BiDyX3Q6QQAd5HA2FhB
 /pBjgT8FJI0NSIZx1YGYZaQEHtPIUI09WklVvWHF/UwhkO9JvpGFUspILS9bVH+V/Z5iUxwzu
 tbY4ThiErAn49FlgY+SHsttFmYIS1mDUSzIxBj9GGRWAp1s9Pn/Ug21LjTx3l64+ggtOAa9q6
 XE55CAodRob3tbFLUBv+/T4d6BdWdh8jNXkWgOE+p07n5QERs+aufNzkNxqBUSyNLOwTZZEky
 KmNp95vVSznrIXAAuvNJLNseIM+S3Yg578uIP+6HSH36mTHS1MWS2Xu8wP3/h9RrIaY3ecmcW
 IoY6FTNTw3FnJJNiGlIJINSl4fbpIcqma2KdGDyOGm8gG5xMht4sd2Qjzd0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In contrast to "git am --abort", a sequencer abort did not check
whether the current HEAD is the one that is expected. This can
lead to loss of work (when not spotted and resolved using reflog
before the garbage collector chimes in).

This behavior is now changed by mimicking "git am --abort":
the abortion is done but HEAD is not changed when the current HEAD
is not the expected HEAD.

A new file "sequencer/current" is added to save the expected HEAD.

The new behavior is only active when --abort is invoked on multiple
picks. The problem does not occur for the single-pick case because
it is handled differently.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 sequencer.c                     | 48 +++++++++++++++++++++++++++++++++++++++++
 t/t3510-cherry-pick-sequence.sh |  2 +-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 30b10ba14..35c158471 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -27,6 +27,7 @@ GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
 static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
 static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
+static GIT_PATH_FUNC(git_path_abort_safety_file, "sequencer/abort-safety")
 
 /*
  * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
@@ -310,6 +311,20 @@ static int error_dirty_index(struct replay_opts *opts)
 	return -1;
 }
 
+static void update_abort_safety_file(void)
+{
+	struct object_id head;
+
+	/* Do nothing on a single-pick */
+	if (!file_exists(git_path_seq_dir()))
+		return;
+
+	if (!get_oid("HEAD", &head))
+		write_file(git_path_abort_safety_file(), "%s", oid_to_hex(&head));
+	else
+		write_file(git_path_abort_safety_file(), "%s", "");
+}
+
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
@@ -339,6 +354,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	strbuf_release(&sb);
 	strbuf_release(&err);
 	ref_transaction_free(transaction);
+	update_abort_safety_file();
 	return 0;
 }
 
@@ -813,6 +829,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 
 leave:
 	free_message(commit, &msg);
+	update_abort_safety_file();
 
 	return res;
 }
@@ -1132,6 +1149,30 @@ static int save_head(const char *head)
 	return 0;
 }
 
+static int rollback_is_safe(void)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct object_id expected_head, actual_head;
+
+	if (strbuf_read_file(&sb, git_path_abort_safety_file(), 0) >= 0) {
+		strbuf_trim(&sb);
+		if (get_oid_hex(sb.buf, &expected_head)) {
+			strbuf_release(&sb);
+			die(_("could not parse %s"), git_path_abort_safety_file());
+		}
+		strbuf_release(&sb);
+	}
+	else if (errno == ENOENT)
+		oidclr(&expected_head);
+	else
+		die_errno(_("could not read '%s'"), git_path_abort_safety_file());
+
+	if (get_oid("HEAD", &actual_head))
+		oidclr(&actual_head);
+
+	return !oidcmp(&actual_head, &expected_head);
+}
+
 static int reset_for_rollback(const unsigned char *sha1)
 {
 	const char *argv[4];	/* reset --merge <arg> + NULL */
@@ -1189,6 +1230,12 @@ int sequencer_rollback(struct replay_opts *opts)
 		error(_("cannot abort from a branch yet to be born"));
 		goto fail;
 	}
+
+	if (!rollback_is_safe()) {
+		/* Do not error, just do not rollback */
+		warning(_("You seem to have moved HEAD. "
+			  "Not rewinding, check your HEAD!"));
+	} else
 	if (reset_for_rollback(sha1))
 		goto fail;
 	strbuf_release(&buf);
@@ -1393,6 +1440,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return -1;
 	if (save_opts(opts))
 		return -1;
+	update_abort_safety_file();
 	res = pick_commits(&todo_list, opts);
 	todo_list_release(&todo_list);
 	return res;
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index efcd4fc48..372307c21 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -147,7 +147,7 @@ test_expect_success '--abort to cancel single cherry-pick' '
 	git diff-index --exit-code HEAD
 '
 
-test_expect_failure '--abort does not unsafely change HEAD' '
+test_expect_success '--abort does not unsafely change HEAD' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick picked anotherpick &&
 	git reset --hard base &&
-- 
2.11.0.27.g74d6bea

