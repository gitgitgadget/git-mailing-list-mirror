Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E891FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 13:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbcHZNsl (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:63628 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MDR21-1bu6Rt21Hh-00Gmso; Fri, 26 Aug 2016 15:47:32
 +0200
Date:   Fri, 26 Aug 2016 15:47:17 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/14] sequencer: lib'ify write_message()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <6cc2e834ae9e595625fbbc6922613994098fd7dc.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2ekO3as9FKQbgRaxSP5+GuX/e4G4MZw3zTZrGIdJOb1Gk3E6PLR
 /Syz7/q+f1R/CgAAJIdGyOSDaLkbSdeoeyNRnRqN3WE4U4QgcMBpWjC4I6ZJaw/a8YTkWTX
 ibALkI5VVxQcLndpCTlteZBbO/uqTFiOxtwNwo4ejte60JEq2GV2ZQB8DlOlNtvFxOu8/tk
 0aZF8rIKMxhX3q8OoBYew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SmFrJl2HSgk=:U3rX7+M6JYQUN3f8YgYsTh
 d4W2Gw6LQj5izJSSDdLTzmx7bsNQinUH/ZxblsEaSW/A9O3E2KYPTi+WyWIQo2nM3a3grUouh
 enKSPu/VRP6Fgb+PEHYtKvtaSEH5kouh8T0NFc+9hRawJ5tL4ef8waFKsGTVp6Kb7Y2QAvyPp
 7WIa+45wSxXW3McF+MQO0Jv89oXBMm/RWDNPz2Q0z6HcxSaqciKXgHZt1cJPToAVa/GkeYZcB
 kCrAzuXD386NHA3KBKsSPnnLRMvWKeIoWdBns8ZU1OzY0q+tahV0s+L4UvgxyN81sZQKM1srR
 mP1Q4yVVWpKG5dBOadri2IW+SMyFjmrvGgy6w+e3ppS/mpw7Op5UyTImXQqnYYPEZ+3kdf+vE
 eSGO18x7C/BheG1L/06ewyo4v3qQkNbRIvEeEcYkhr8TO6x+azypJGMrl0Kktpx++o6POUZZ4
 wPvuWaAhj/orQ4lH9PtRxQhk6A4dvli+LAOig/PpSHf7ZutVdbIa7Gov+ndC7RWWWa38ysVcw
 l/B43qwbgU0rJvukKBCFKl4ASWijmgfhBKAUFIXl/cusZeOnE37/TD0zrF4q7iIclpTzLxbjo
 2y46cMFZWKyzIAptkX7A+KPdDhD+4uFMBQJK9CkfWo62utsbzKd6hgCu9BqmJaM7Ssn4EKw1S
 jG/Mu31vVrFXlGQhN4mmrD/2mRwLyBJJGXuM2If33mWf5AiARzLm5KZrTRSvlMGMPKH4lXAoY
 DkQMoaGOBwFobtEtKGZsszUtTWlzlzaqfXTj9aiAb1ajITYr22ORPF3nc9V44De9CGBU/pCe7
 0hTu0NH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain
notice the error and handle it (by dying, still).

The only caller of write_message(), do_pick_commit() already checks
the return value and passes it on to its callers, so its caller must
be already prepared to handle error returns, and with this step, we
make it notice an error return from this function.

So this is a safe conversion to make write_message() callable
from new callers that want it not to die, without changing the
external behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index baf6b40..17bee60 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -180,17 +180,20 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	}
 }
 
-static void write_message(struct strbuf *msgbuf, const char *filename)
+static int write_message(struct strbuf *msgbuf, const char *filename)
 {
 	static struct lock_file msg_file;
 
-	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
-					       LOCK_DIE_ON_ERROR);
+	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
+	if (msg_fd < 0)
+		return error_errno(_("Could not lock '%s'"), filename);
 	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		die_errno(_("Could not write to %s"), filename);
+		return error_errno(_("Could not write to %s"), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
-		die(_("Error wrapping up %s."), filename);
+		return error(_("Error wrapping up %s."), filename);
+
+	return 0;
 }
 
 static struct tree *empty_tree(void)
@@ -223,7 +226,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
-		exit(128); /* the callee should have complained already */
+		return -1; /* the callee should have complained already */
 
 	strbuf_addf(&sb, _("%s: fast-forward"), action_name(opts));
 
@@ -564,16 +567,16 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 					 head, &msgbuf, opts);
 		if (res < 0)
 			return res;
-		write_message(&msgbuf, git_path_merge_msg());
+		res |= write_message(&msgbuf, git_path_merge_msg());
 	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		write_message(&msgbuf, git_path_merge_msg());
+		res = write_message(&msgbuf, git_path_merge_msg());
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res = try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
+		res |= try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
 					common, sha1_to_hex(head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
-- 
2.10.0.rc1.99.gcd66998


