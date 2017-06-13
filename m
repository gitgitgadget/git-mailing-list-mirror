Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C26A51FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 12:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbdFMMEi (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 08:04:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:54953 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752627AbdFMMEg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 08:04:36 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWk7n-1dM5Kg05UZ-00Xsnh; Tue, 13
 Jun 2017 14:04:29 +0200
Date:   Tue, 13 Jun 2017 14:04:28 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 3/6] help: use early config when autocorrecting aliases
In-Reply-To: <cover.1497355444.git.johannes.schindelin@gmx.de>
Message-ID: <2ecd0c526be76e78a2b7589f465401c3a13d13ca.1497355444.git.johannes.schindelin@gmx.de>
References: <cover.1497355444.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BVeoIn9ptr6rF78ZPDerAlUJ1Ggx+9UxjGq49ZjSB+cnwRHPMYk
 IS07sXJmtVgLYkpYbWxTVYSlwJGRyfR4vSl2/aF5GOtaoTYtZBvGPldEtYHdTZf5A2DamrU
 e9VX3/DTgGNYjp1oAxHLxIDftlwWIN2yOLTw2DydFrH6BvyeICdBt7KU6dDDI01ZtXwaQLu
 wxCDCm1iHBrhuN4q4fLMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/X2ORjohPX8=:SU3SntPf2rM6Ayoh6a/+iU
 9m5W/jJwutqkQjAABT/rMZKMQqQzbdjPGXcZGigG3MWEgc0v51KyOcFueiT0UN5C9c+sDf7Fu
 dqg6rVi5/Ti9zjaDwzJ1cMHZV0c4gemodPT8piPvzthbG2gwJAZ8Ldjaaj81ho8oOcfafEwtb
 6yHiQtmnG6LzcAVuEGDeZHKGmuxRYjk6GHTTMoM+4hiDzZNyserGPuXaD0pJil0aJnEvqv1mm
 1EUDApW8Y1Dk6ofe1a0MZgfAh9NmKg7kJDkyWulTUblguWLt7IfTxv0s2RlKWGGP4eNdtZW6v
 fFhcDj726BUIKAC/+OLHWUphJMGCzDiR1TQeQdqXVnAezhZaNFULkRoOr3a5/T6A76d7DBr/R
 5vvtORFSzweVQ3K/vPTRmgkwdqzAJYXzsLTY3rqC9TD9cGjHSD/xaDh8GtXR/MG3zJeDyFlom
 jdU0/nkH8wZqTEx/r8ruYjnDnvcc5f71AmTuD97HmSnomAPFRWpt+/5XUXF7/zAE2FhyvGKgD
 RRd6IP5hkWhnApmbmIQXduryeaEGPwQ0PtRt1DbqQGTW2b0ZKMgz7mhAtaDnd/Ba8Um21Xxka
 Xziw5pMpfzqNXNi5BOS+HqXBlEyT1GKiojbWsCkqfY6k0U5XoFCcsRkr7P1/lJHQJXgEa8tBe
 c/orw3xcJ56nvZgjTBgNDwg/WdLRmr3PJ4TTZCBqEMKWgiRUPziZKeXBi0gRCWYyYr9K1evA6
 +NNN4pSoWwhyEEYNpFwfwSkg+IVHPVqBqMxf70RyTaujkwFV+ohxmvLUkOAH9XFpdmNd4xqs3
 wQkY1UK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git has this feature which suggests similar commands (including aliases)
in case the user specified an unknown command.

This feature currently relies on a side effect of the way we expand
aliases right now: when a command is not a builtin, we use the regular
config machinery (meaning: discovering the .git/ directory and
initializing global state such as the config cache) to see whether the
command refers to an alias.

However, we will change the way aliases are expanded in the next
commits, to use the early config instead. That means that the
autocorrect feature can no longer discover the available aliases by
looking at the config cache (because it has not yet been initialized).

So let's just use the early config machinery instead.

This is slightly less performant than the previous way, as the early
config is used *twice*: once to see whether the command refers to an
alias, and then to see what aliases are most similar. However, this is
hardly a performance-critical code path, so performance is less important
here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/help.c b/help.c
index db7f3d79a01..b44c55ec2da 100644
--- a/help.c
+++ b/help.c
@@ -289,7 +289,7 @@ const char *help_unknown_cmd(const char *cmd)
 	memset(&other_cmds, 0, sizeof(other_cmds));
 	memset(&aliases, 0, sizeof(aliases));
 
-	git_config(git_unknown_cmd_config, NULL);
+	read_early_config(git_unknown_cmd_config, NULL);
 
 	load_command_list("git-", &main_cmds, &other_cmds);
 
-- 
2.13.0.windows.1.460.g13f583bedb5


