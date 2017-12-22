Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54111F404
	for <e@80x24.org>; Fri, 22 Dec 2017 11:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754013AbdLVLvC (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 06:51:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:60852 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751770AbdLVLu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 06:50:58 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkP8Z-1f02u802Id-00cNHT; Fri, 22
 Dec 2017 12:50:51 +0100
Date:   Fri, 22 Dec 2017 12:50:50 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [PATCH] sequencer: assign only free()able strings to gpg_sign
Message-ID: <f4420880aa4ee73b7c8e435de1efccf9a969fd41.1513943347.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:c4S5J7PHDDkT03M2LLmA7qQ0od9f6hZOmdHd512zQ9MwHBMndjD
 LviQuVj6hQu81wX4od/1nSTuan+YuBCGpSHfn/OG9T/ct03HFuyKbFNs0YgYJIidsRulRNm
 IguhESLsLZoR6YlzvIk6L0sLBHXVa69ZKBaRX90DllatmL1dYTNL+SQxsmzSFQeLjtKa+Kf
 eGLw0KVaEZWVNsDJ+R1tA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G/A58KGOwO4=:umGObzMuYd185OADwTaXNY
 bvD2HBOToHU76VKpyyShHICjDN/VVzs4/MSNfyXruiOWncs2EtuSw3UYuLnvbFgyvNgtbljwL
 vXuVtYbwWrNutHtaLSoDLy3uHTwyqYwZ2PLzmLc2cR6Ww0yHrD0MjW3Ng5K5c2UZx2EF7ZKuy
 Epfa1tFoxbW4Ncup0C6D8J42T67w6ue/tlm4jgq0vJC5Kz0RXbvlDfhddcrwJqoUmFHze8z25
 P6wLd+Qz+XBDyHBkKiK/fCCjjsj+iH7SbXZsbPpXe4xyZCaYKZrwXf5DXzhtRdU8mgoangjBd
 cPw9P0y0fJyTRJda82ivNPz4TWi7BuTqrNyhQJxaViXOhH+ZUb5FJl51IUvUDRLPWbSYzqLU+
 b4+UL6aAw2/uR5q1VH7Elf69QdtZMWtWVuvPL5n6eShEraJvU2xGIKuvbSb0FkJzDXpM2mwE4
 ghwspJVU0OvOWmB4NIY9EjEkIPxFHR8uSDL8m3sgRSxfG39Aa+I2C/nsSAQB8dujpkZYeNN8Y
 peswtVk5YezRPHnFnQK3eFM8rFjDiM0egtLw3GTu4ECrqTHdh+bWFTfz8OKIB7wLOQknqRZc7
 64lXkiWhv4e3J9OOQ7VhhopSQERv1yxMsS5NNdQYqt6zzrgnzEG0IlG/3asa7omPvAQ/zHLlA
 h+lIxS8fLScdqL7g2EyVf1nSjmJO6u2v5LQ1suLBpX54vfmDde5/0A6ldGsPhaXbs7AOdrAgx
 RoQ/9vzqCKE7OMF/txbxCe/xQqIMMGL3bVcVNhXeAZfhp7rT20rG+fgBgED/UfA2KT5O/M+8v
 wSX6vk4CA6x0hKjoTS/EnOPhRIfh8C/APgYonsJibIxs9/bfTc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gpg_sign member of the replay_opts structure is of type `char *`,
meaning that the sequencer deems the string to which gpg_sign points to
be under its custody, i.e. it needs to be free()d by the sequencer.

Therefore, let's only assign malloc()ed buffers to it.

Reported-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Phillip, if you want to squash these changes into your patches,
	I'd totally fine with that.

Based-On: pw/sequencer-in-process-commit at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git pw/sequencer-in-process-commit
Published-As: https://github.com/dscho/git/releases/tag/sequencer-owns-gpg-sign-v1
Fetch-It-Via: git fetch https://github.com/dscho/git sequencer-owns-gpg-sign-v1
 sequencer.c                   |  2 +-
 t/t3404-rebase-interactive.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 7051b20b762..1b2599668f5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -160,7 +160,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 	}
 
 	if (!strcmp(k, "commit.gpgsign")) {
-		opts->gpg_sign = git_config_bool(k, v) ? "" : NULL;
+		opts->gpg_sign = git_config_bool(k, v) ? xstrdup("") : NULL;
 		return 0;
 	}
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9ed0a244e6c..040ef1a4dbc 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1318,6 +1318,16 @@ test_expect_success 'editor saves as CR/LF' '
 
 SQ="'"
 test_expect_success 'rebase -i --gpg-sign=<key-id>' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	set_fake_editor &&
+	FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" HEAD^ \
+		>out 2>err &&
+	test_i18ngrep "$SQ-S\"S I Gner\"$SQ" err
+'
+
+test_expect_success 'rebase -i --gpg-sign=<key-id> overrides commit.gpgSign' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	test_config commit.gpgsign true &&
 	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" HEAD^ \
 		>out 2>err &&

base-commit: 28d6daed4f119940ace31e523b3b272d3d153d04
-- 
2.15.1.windows.2
