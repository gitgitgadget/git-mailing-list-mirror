Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C45F1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 13:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbcHZNsn (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:53646 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752371AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lhwt0-1bI1VL3PMI-00n7rf; Fri, 26 Aug 2016 15:47:53
 +0200
Date:   Fri, 26 Aug 2016 15:47:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/14] sequencer: lib'ify read_populate_todo()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <3a472f0d39080f9a98df0e85b447007a582eb11f.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:D4ErFd6hgkYmfhxK3YF6foRNHgMfWGU2cvsvaZToRqFx4TMlQXW
 6hseogF0yxsb/gEv2pUM2qdy+ObiGfq7hbFpDA9bBixjXVx6qYDKrRzIwRU90jPSMlQ9J9r
 QnPoj0IjfmFqoby+VUGlAud8O7d1CkrhJb8GPEs/5sAq3+nOr6B+SUkuoTmNzQN/gC5U7U+
 ZmO2h52+xlXb6YKGGEHsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VZKQFlOB/vg=:AQh7RBVrD4yFJxs9RPM1yR
 FXGSzZ6563/jckWrDwOeBNDQxobObl/Lhk6KFN0s2EAkYM+T/virCIHrlBaiuHSLYknzA3yAI
 1sFFoBWDrZuv/HE857vhBxxzfH30vDuAU+D5MKUCvTy2YbM6a0JlmOpG+Hz91+vpBy9z0EX2o
 B0pWfShNYH4INpeAtuetWpwxLDq7IrMvZgcEKQvBwElfGFPRbUMmatEe1mtzvRt6sXFcjcQDZ
 aTp4dRTw9cmHr1Cy0G85X1uunobSPwXckMhC7ZQsG0O/3mk1WK32dFBAZjJntm+OX7iNJRMax
 fxTtWXJ/2qdvXgud353Ebb1ijvImOcIu+2gHYaTkvkC2oENQaD0mfObZvk7dOBvYUpFFoPzil
 UjXtofoH8cGbiSugZs680054OeuCOQQ9oa/lXMqVZv3ohieX/u8XwU+/v9ewcB1VIodKksOGh
 NwftzyYUZPzV14YsPU98lwYF1BMrHdhVg4dkH4/tk01Yeqeta0fmbWHgYg71KpKS2vc+6kiZS
 scxlSpHah5RN1M2AESCUdqH9fSw692tPBgIxBXyvh0CRE5uqK3SZMf3ilVDECFo15M9gAyF2q
 5tHyYviLzWumALtUZMRhDA9OLbNqcYPXk5lSwFiUdYK+GOST3MbwIqGQjEhHQQu2ygaHy4XOs
 NH+u0K3OHlG+2XXRdpZ2nv1KA6gLm4wN8k1rlRiFcDHZPshPSAP0At6nUJEXJt0RzETPkI9RR
 QENUIgRUzvTgR0UqiV+QamseGN+w+g4XKUkM7rtzX/iuem2KF/sjCsmErcGIN2yuq6g92hVHP
 AEa7aAf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain
notice the error and handle it (by dying, still).

The only caller of read_populate_todo(), sequencer_continue() can
already return errors, so its caller must be already prepared to
handle error returns, and with this step, we make it notice an
error return from this function.

So this is a safe conversion to make read_populate_todo() callable
from new callers that want it not to die, without changing the
external behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e30aa82..e11b24f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -748,7 +748,7 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 	return 0;
 }
 
-static void read_populate_todo(struct commit_list **todo_list,
+static int read_populate_todo(struct commit_list **todo_list,
 			struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -756,18 +756,21 @@ static void read_populate_todo(struct commit_list **todo_list,
 
 	fd = open(git_path_todo_file(), O_RDONLY);
 	if (fd < 0)
-		die_errno(_("Could not open %s"), git_path_todo_file());
+		return error_errno(_("Could not open %s"),
+				   git_path_todo_file());
 	if (strbuf_read(&buf, fd, 0) < 0) {
 		close(fd);
 		strbuf_release(&buf);
-		die(_("Could not read %s."), git_path_todo_file());
+		return error(_("Could not read %s."), git_path_todo_file());
 	}
 	close(fd);
 
 	res = parse_insn_buffer(buf.buf, todo_list, opts);
 	strbuf_release(&buf);
 	if (res)
-		die(_("Unusable instruction sheet: %s"), git_path_todo_file());
+		return error(_("Unusable instruction sheet: %s"),
+			git_path_todo_file());
+	return 0;
 }
 
 static int populate_opts_cb(const char *key, const char *value, void *data)
@@ -1019,7 +1022,8 @@ static int sequencer_continue(struct replay_opts *opts)
 	if (!file_exists(git_path_todo_file()))
 		return continue_single_pick();
 	read_populate_opts(&opts);
-	read_populate_todo(&todo_list, opts);
+	if (read_populate_todo(&todo_list, opts))
+		return -1;
 
 	/* Verify that the conflict has been resolved */
 	if (file_exists(git_path_cherry_pick_head()) ||
-- 
2.10.0.rc1.99.gcd66998


