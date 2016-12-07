Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30E851FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbcLGVwE (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:52:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:59156 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932514AbcLGVwC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:52:02 -0500
Received: from fermat.fritz.box ([92.76.239.239]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtmK9-1cgTkG2u8b-011ELH; Wed, 07
 Dec 2016 22:51:57 +0100
From:   Stephan Beyer <s-beyer@gmx.net>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/5] Make sequencer abort safer
Date:   Wed,  7 Dec 2016 22:51:32 +0100
Message-Id: <20161207215133.13433-4-s-beyer@gmx.net>
X-Mailer: git-send-email 2.11.0.27.g4eed97c
In-Reply-To: <20161207215133.13433-1-s-beyer@gmx.net>
References: <20161207215133.13433-1-s-beyer@gmx.net>
In-Reply-To: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:ekpG6yPzEW6zFdqJfQCjiOyzLVTwkWdFmz4kC60cUFPLj+cX12a
 FD0BhQ0WDA35Bp6SkBoJ1JedqeVgvQERMnaQJKfGI5l1lI/8qy3E6yr8MqtgfLf3ETREuPI
 GIobkqL+K2dOdH0bKFzVX6/xdakog6HyEUDVSGqLZlBNBPHHquF5+QyTL2QaEjxnEH732jU
 klO9y6lQNxB/mg5u9bNjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uWeek2wW/Qw=:5vXyM7gpuEEKc/lwaig6FN
 Cu+gwrbYDwQuJmzLiQa31i+Jj7Rg3hi11nJgYxqiJ5Tup58Yx07VAScc+S1FV6VeGbMFTvpcM
 MMp+h1S8CyVsd2zMNdwyYy55FliwIOJ/BzrnYxl3RewUcNZLVLqnHkqbAVtLMTarymZAOwE0U
 YpPcbsj8sItwyq31gptkUGj1Okyg0p0M28fHKrW0XAZYhxTcqeKE0LXPteQjaVciOIpympBn4
 9unydKNs/3cwHLtD4Kiqo0Qh70JnfmboiF8wNgmBgBPPbB40EgN3d0CYhxg2xLxb8TOw3CL7d
 q6svxzQQg9qU3ZQTnnSDJyKSBk9xRzMoivc+mm00doP9MSnsywMdWSPB8a2uhsVk8phV+G5ZK
 cfEZBm7+6kH5tPawUyyZgFcznxrbovx1Tv9N72bD7ORY4b7CiMkMMRFDxEEDn7qgLr2sd2zOf
 a5CUTiimrdStARikQ0vGixKadyaPiae0io/tUocQHQOVPBScUD2vPKig4NgbvHsbywTqcpc12
 2d/WtAge9G02vbIuUWumN0E0GIk/qugNaKfg7BwTW+yyA8ALLHvDj1HjN9m1hYVc3E1lst6pW
 6L3xcs3WnV2MDTqpOiuiUeRIPs/gSx54tiX8GK9ENnW1lIz3C7li7kO0Mv7wU98FwCxqv/fwI
 glKpplKBUs4J7fA/MgroKN/VUw2R1GBE0Q5TL0djqofNsUjXAb3mmLt1Pvh9i67/Kt8/jOaoV
 8x2kzdgfTQ03d9XofVkybKD/pt/VpyuV6TVHVA8DnvKplHb75Uw6ZO2FOxw=
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
 sequencer.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 30b10ba14..c9b560ac1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -27,6 +27,7 @@ GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
 static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
 static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
+static GIT_PATH_FUNC(git_path_curr_file, "sequencer/current")
 
 /*
  * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
@@ -310,6 +311,20 @@ static int error_dirty_index(struct replay_opts *opts)
 	return -1;
 }
 
+static void update_curr_file()
+{
+	struct object_id head;
+
+	/* Do nothing on a single-pick */
+	if (!file_exists(git_path_seq_dir()))
+		return;
+
+	if (!get_oid("HEAD", &head))
+		write_file(git_path_curr_file(), "%s", oid_to_hex(&head));
+	else
+		write_file(git_path_curr_file(), "%s", "");
+}
+
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
@@ -339,6 +354,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	strbuf_release(&sb);
 	strbuf_release(&err);
 	ref_transaction_free(transaction);
+	update_curr_file();
 	return 0;
 }
 
@@ -813,6 +829,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 
 leave:
 	free_message(commit, &msg);
+	update_curr_file();
 
 	return res;
 }
@@ -1132,9 +1149,34 @@ static int save_head(const char *head)
 	return 0;
 }
 
+static int rollback_is_safe()
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct object_id expected_head, actual_head;
+
+	if (strbuf_read_file(&sb, git_path_curr_file(), 0) >= 0) {
+		strbuf_trim(&sb);
+		if (get_oid_hex(sb.buf, &expected_head)) {
+			strbuf_release(&sb);
+			die(_("could not parse %s"), git_path_curr_file());
+		}
+		strbuf_release(&sb);
+	}
+	else if (errno == ENOENT)
+		oidclr(&expected_head);
+	else
+		die_errno(_("could not read '%s'"), git_path_curr_file());
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
+
 	argv[0] = "reset";
 	argv[1] = "--merge";
 	argv[2] = sha1_to_hex(sha1);
@@ -1189,6 +1231,12 @@ int sequencer_rollback(struct replay_opts *opts)
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
@@ -1393,6 +1441,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return -1;
 	if (save_opts(opts))
 		return -1;
+	update_curr_file();
 	res = pick_commits(&todo_list, opts);
 	todo_list_release(&todo_list);
 	return res;
-- 
2.11.0.27.g4eed97c

