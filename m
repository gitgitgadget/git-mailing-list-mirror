Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8407B1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 13:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbcHZNsz (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:52199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752944AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LjLwB-1b8LO41vuZ-00dUCp; Fri, 26 Aug 2016 15:48:07
 +0200
Date:   Fri, 26 Aug 2016 15:48:06 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 14/14] sequencer: lib'ify save_opts()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <2d6d71e2a2d410b12d783f0a8edd22791f303c12.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:awtwTP3WCgonhIu2MqJA53v4/108dCPcVDEHXqzDXLiGsKTW3WK
 iFEh337AD/i2TggapIy/o9SwiVmtGTffsXZWX8Z/NPZaLeIYuwn4i6tmhvBGviFC3HAXPzA
 24+xX9CsvyIKSMFsw3lx/HZxhrS6CfRuypXvwu50Zu92OgOrKqYmMgGZzH3WEjAVnnUsqML
 xmScjSu9acFF2QWff0haw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9I8SeX59Kyc=:KYcpKxnNPE6iMP0FrAsOsN
 ntzUeihOCjoHDZck55OsmRk/fchUBGOoa4ZXUyr1PZeIM9Ewn/rxYjfq3WFgqiuOx2556J+9o
 gkYEtl+ATvnffTxVhaRck9ICvEN+w5Ee76pW4vkm+Xfwh/X/H5DY0gcOsayuya/wPQPpOV/xQ
 CoZglmVJbkkOc4Y9biw8+bfXl+pdVb9x/1/vE1YlCquxGhGlcLgpAkP1JHpSiobL6A3rp5uBW
 Cxc/gAM76H8Iq62uGPsuEV1mWQ0BbqrA8LK0xMfW+Im/+qL89QmFoMYb7qY0HjVbFQ+m28POE
 snnouH6H/u12Q1nUvdLJFaJEa5irdH+dBa027/Kzfkr6QaYPAeFfhd52c3w+5SfN15HASUQEY
 lR/pyrHIj54apwRPH34t626uNEhMQ12v0R7GLltM1BThdgFiBPTN4AKt41X4Vwop9/iiNYtc0
 Sbz7llxKYd1Pjp7qdDr4p4OuZVTkgQzqdkABBK3n+oeeRJBT+GKscaIOoyyWMJ/ZvWgpBKOXa
 lV7pGNcGRH0QNoUnQglim3ykxBCTzB8JEJh18Ul64D/rb99At15xW5K4nQBbKYvci2wdVnRFu
 PyIPUKto/TFSJBI7gtMRh8G2uDMZ6Kt5JumjkuQqVt1g9sE+ayzVhEI1H5Ylg6A5b2yB1/pB7
 B9uCOwJ5ehMD0JepLM8/bEFk18RlF/SGPUuaN/OEZOpJlHuObhDsIWScFsRJEcJFRmVH0cLDI
 6DJiF2vnFxYonSnGLKEqUaiUsLIv1m7rjBiajxU0BCzjvbUWeITc2B27xvfHBeBvFht4JOfoo
 s11GQtz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The only caller of save_opts(), sequencer_pick_revisions() can already
return errors, so its caller must be already prepared to handle error
returns, and with this step, we make it notice an error return from
this function.

So this is a safe conversion to make save_opts() callable from new
callers that want it not to die, without changing the external
behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3e877f1..b6481bb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -958,37 +958,39 @@ static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	return 0;
 }
 
-static void save_opts(struct replay_opts *opts)
+static int save_opts(struct replay_opts *opts)
 {
 	const char *opts_file = git_path_opts_file();
+	int res = 0;
 
 	if (opts->no_commit)
-		git_config_set_in_file(opts_file, "options.no-commit", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.no-commit", "true");
 	if (opts->edit)
-		git_config_set_in_file(opts_file, "options.edit", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.edit", "true");
 	if (opts->signoff)
-		git_config_set_in_file(opts_file, "options.signoff", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.signoff", "true");
 	if (opts->record_origin)
-		git_config_set_in_file(opts_file, "options.record-origin", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.record-origin", "true");
 	if (opts->allow_ff)
-		git_config_set_in_file(opts_file, "options.allow-ff", "true");
+		res |= git_config_set_in_file_gently(opts_file, "options.allow-ff", "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
-		git_config_set_in_file(opts_file, "options.mainline", buf.buf);
+		res |= git_config_set_in_file_gently(opts_file, "options.mainline", buf.buf);
 		strbuf_release(&buf);
 	}
 	if (opts->strategy)
-		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
+		res |= git_config_set_in_file_gently(opts_file, "options.strategy", opts->strategy);
 	if (opts->gpg_sign)
-		git_config_set_in_file(opts_file, "options.gpg-sign", opts->gpg_sign);
+		res |= git_config_set_in_file_gently(opts_file, "options.gpg-sign", opts->gpg_sign);
 	if (opts->xopts) {
 		int i;
 		for (i = 0; i < opts->xopts_nr; i++)
-			git_config_set_multivar_in_file(opts_file,
+			res |= git_config_set_multivar_in_file_gently(opts_file,
 							"options.strategy-option",
 							opts->xopts[i], "^$", 0);
 	}
+	return res;
 }
 
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
@@ -1133,9 +1135,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return -1;
 	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
 		return error(_("Can't revert as initial commit"));
-	if (save_head(sha1_to_hex(sha1)))
+	if (save_head(sha1_to_hex(sha1)) ||
+			save_opts(opts))
 		return -1;
-	save_opts(opts);
 	return pick_commits(todo_list, opts);
 }
 
-- 
2.10.0.rc1.99.gcd66998
