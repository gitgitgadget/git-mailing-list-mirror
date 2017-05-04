Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790C2207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755459AbdEDN5U (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:57:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:62735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755381AbdEDN46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:56:58 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MD9J6-1dIL0B3mdY-00GVYQ; Thu, 04
 May 2017 15:56:52 +0200
Date:   Thu, 4 May 2017 15:56:51 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 14/25] setup_discovered_git_dir(): plug memory leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <30ae776cee0d07706679d8f310ad97860a311e16.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:znGAPVm/MJujYgr/ZYpkk8V6mfOiZdTyrETK6qxfqlwo9mXREQF
 GwMruXJN43ChvgmcpaMDY3fEw/z31lWfKD9GD/V5RH1xa8LfVfK+r6j2wNn+QPZTl0l2w28
 V6sZsOlG1fEQpEIDL8Wc33o0dyhg+1NurtikVVpjCZwmso41NpiM6bAZ4oj5YmkfJRt4PFh
 UMQ9pHxvRMJ3SxuG/z3mw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mBHf/elGQ6o=:5xPxUkDO1SjZ0MduH3u4f2
 mmejH5HKuL5M+yFe/TTgHpGGNhKQkPc8soomjZpD2L13N8lNQ4MkrXUnePTynZZxyrE2C0FNP
 ogE5TMHviFgk961cysbSWdHDAuLjKs9+FCu5SdkSXbo8/jP0BmUuiaKt5NT4W4YDtYgaNicTs
 Gg8mF5nTrCIsCyCgKPyq05YXaWHGEnIyCz9oWT6+++th3BTKb/3vR4xoAZrW7LXmR79KM02mv
 3EN/RV8PHCF+xHnHJqQSd7ukIRBB/sL9Td6wRjcH3khsTPFx6Ri4y4JD7LmZ1BIReWmyfAKTP
 ogxAEg6KR2Ox05tcR7Fgvj192BGm1y2Vvuf0u6KL1SwryjaqfzMwEdwsxYHyZE5zuxBXRLGOc
 gI35qIeftULCACWPR4T9WcPzL7kZlk5mcZhXPbDolLWAQrayGN0yk2V/OdPvfurNtEtbiYvXg
 UfWapW4w3i02M4+fk/IvMevre4nBnGcIFGGPedfHHg//Sh5TgA3u9bB3rCRqn1ruP7v5UHfc9
 4H034t+mdtFSsED6reBIQrCRAK/q9CApF6K7Jtuc0O+7ykEOPpTX7oLN9Mom+krE4kEF8zNlp
 vonM8ddUrMcA1ibW9gWi+lD5uk52g1klS5/3JKUr+ZvXDvmTFlrnI6OVphwJz4kcuXhjb0lsN
 IQGEPBxxMa2ovywCEiLm8KUgvKtglye8Udxoc/8Lii3HhFTbHQLPIeq9OvXg81IUfQ0xiZD+O
 1HaDRvBosMT2M/+n50T6QH0sZG/9S6gQYi6tDrvmDYVzxCC1mAhkUYQSd5WHC+FIOoLOqoJ4w
 xZHuxII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The setup_explicit_git_dir() function does not take custody of the string
passed as first parameter; we have to release it if we turned the value of
git_dir into an absolute path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 0320a9ad14c..e3f7699a902 100644
--- a/setup.c
+++ b/setup.c
@@ -703,11 +703,16 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
+		char *to_free = NULL;
+		const char *ret;
+
 		if (offset != cwd->len && !is_absolute_path(gitdir))
-			gitdir = real_pathdup(gitdir, 1);
+			gitdir = to_free = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		ret = setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		free(to_free);
+		return ret;
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
-- 
2.12.2.windows.2.800.gede8f145e06


