Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876E9C83F3F
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 22:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjIBWRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 18:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIBWRF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 18:17:05 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0157ACED
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 15:16:57 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 6C2A03FA92;
        Sun,  3 Sep 2023 00:16:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 2EBAC3F8DB;
        Sun,  3 Sep 2023 00:16:56 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NVCEHyLyTpPk; Sun,  3 Sep 2023 00:16:56 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 8E6893F5E0;
        Sun,  3 Sep 2023 00:16:54 +0200 (CEST)
From:   Wesley Schwengle <wesleys@opperschaap.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 1/3] rebase.c: Make a distiction between rebase.forkpoint and --fork-point arguments
Date:   Sat,  2 Sep 2023 18:16:39 -0400
Message-ID: <20230902221641.1399624-2-wesleys@opperschaap.net>
X-Mailer: git-send-email 2.42.0.114.g06b8c4a877
In-Reply-To: <20230902221641.1399624-1-wesleys@opperschaap.net>
References: <xmqq1qfiubg5.fsf@gitster.g>
 <20230902221641.1399624-1-wesleys@opperschaap.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=zNV7Rl7Rt7sA:10 a=N3miCFJ7AAAA:8 a=Xo0aMB8y-PSjzptChXEA:9
        a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you call `git rebase --root' we are not interested in the
rebase.forkpoint configuration. The two options are not to be combined.

Because the implementation checks if the configured value for using a
forkpoint > 0 I've opted to give the configured forkpoint the value 2.
If the user supplies --fork-point on the command line this has a value
of 1. Now we can make a distinction between user input and the configured
value of rebase.forkpoint.

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 builtin/rebase.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 50cb85751f..2108001600 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -824,7 +824,7 @@ static int rebase_config(const char *var, const char =
*value,
 	}
=20
 	if (!strcmp(var, "rebase.forkpoint")) {
-		opts->fork_point =3D git_config_bool(var, value) ? -1 : 0;
+		opts->fork_point =3D git_config_bool(var, value) ? 2 : 0;
 		return 0;
 	}
=20
@@ -1264,8 +1264,12 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
 		if (options.fork_point < 0)
 			options.fork_point =3D 0;
 	}
-	if (options.root && options.fork_point > 0)
+	if (options.root && options.fork_point =3D=3D 1) {
 		die(_("options '%s' and '%s' cannot be used together"), "--root", "--f=
ork-point");
+	} else if (options.root && options.fork_point > 1) {
+	    options.fork_point =3D 0;
+	}
+
=20
 	if (options.action !=3D ACTION_NONE && !in_progress)
 		die(_("No rebase in progress?"));
--=20
2.42.0.103.g5622fd1409.dirty

