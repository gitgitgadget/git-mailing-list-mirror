Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FDA920373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbdCMULa (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:11:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:62455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753410AbdCMUL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:11:26 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ledpu-1cRs4h21WA-00qQ1w; Mon, 13
 Mar 2017 21:11:09 +0100
Date:   Mon, 13 Mar 2017 21:11:08 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 07/12] read_early_config(): avoid .git/config hack when
 unneeded
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de>
Message-ID: <8358f65bab86ba86589bcef15c01a66dd3a87b3d.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6kmpwRhTMMlqWZU3lfVB87vjMUBOJIlDIAH7mLTOMUJaCkGo2MB
 1oU1eHrMB97vpIR9iHakrjsogA24ILyB0ZRepqshjsK+DenNj+0mrVGvZXa9YFqwbQHYPGw
 j3ZbTZXBREJm1RW8Nyk4e1fcDtO1s/HbsDPmegJjxIPm4n58reWLTXiF0kV6TL95wJxBF47
 h+xfuQHPjUBBGWQcg6miw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CdQT8il3iJY=:8PK9/RLkAoLRYLTUhtvc7u
 V0MenHTbkFBih/zQLqZyODO7mFLSyqFs5WCwJhT9Y9moOPVLgVUkq61fpZ/RQF1V3Eo6UljCp
 C1CnajpnK9o3a9FAdPV43gCYnpXoPh0VjaD/GXS7ogrgnmTToxQh1eHu3pOtfDdm3b7Odo7Jv
 PRX+uGm3lR5wfN09Gjavyw6qpVAYHsuVkOag8h3gPYQ/tvFEjYBl5H8FF/ElZHc/fBzeYhdFX
 O+y2s1t/wJHYTCB0uvb70MTAyqEKer8GYIzLltA8CFtQ7z1kY+L/7GnGVvK09L7zetHll4WxY
 rSwZtHrpljlrkJ1uff56zsUXgqQ4aDSwr1Z7rg/ZmBIUBsqRvhY+03u6sk68X/TcY3BzYiDH6
 5td19X0zYG7craFbZ/fPkYZBlDmjhnmdI84tZciZ4ebRrYM8V0D+tIes5vAlvMvJPVHLEAG5T
 kwM3TuV1/4PYs4Y7jXvyalBz81viPdggUkMBKpp8yqNkHLWlN7wBLjFdwcnSU7qpAL05mkkPo
 xJvS3kftWbLovou9QoKqb+8iyWo9mO/7LMD/a7954UfV2VzN3G0pHx+ZPAsqWUpJ/ZT5GnOi/
 hNmuGSr9/iBLKFv5zWeEUsCDNCPaRSobQqeaJLBrbj9yUSLYZeNtSDPy2LHSFaOdGSWResKuN
 tn6uGOttKn0s0Y3HRoSL+m/4V8zhv7bqQ41DVxD603Lm3KZauUZTOTlRk+VtTMExUGeIZnveD
 7dl/iuSqi3RD5CX7LWdA+KKZYCIlvx9vf0yk2Tq7+nkpa4uY3vxrBsrDOZXaaUwqXNMYn0CEr
 0sQaOEG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far, we only look whether the startup_info claims to have seen a
git_dir.

However, do_git_config_sequence() (and consequently the
git_config_with_options() call used by read_early_config() asks the
have_git_dir() function whether we have a .git/ directory, which in turn
also looks at git_dir and at the environment variable GIT_DIR. And when
this is the case, the repository config is handled already, so we do not
have to do that again explicitly.

Let's just use the same function, have_git_dir(), to determine whether we
have to handle .git/config explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 8808b132761..fc4625a71dd 100644
--- a/config.c
+++ b/config.c
@@ -1518,14 +1518,15 @@ void read_early_config(config_fn_t cb, void *data)
 	 * core.repositoryformatversion), we'll read whatever is in .git/config
 	 * blindly. Similarly, if we _are_ in a repository, but not at the
 	 * root, we'll fail to find .git/config (because it's really
-	 * ../.git/config, etc). See t7006 for a complete set of failures.
+	 * ../.git/config, etc), unless setup_git_directory() was already called.
+	 * See t7006 for a complete set of failures.
 	 *
 	 * However, we have historically provided this hack because it does
 	 * work some of the time (namely when you are at the top-level of a
 	 * valid repository), and would rarely make things worse (i.e., you do
 	 * not generally have a .git/config file sitting around).
 	 */
-	if (!startup_info->have_repository) {
+	if (!have_git_dir()) {
 		struct git_config_source repo_config;
 
 		memset(&repo_config, 0, sizeof(repo_config));
-- 
2.12.0.windows.1.7.g94dafc3b124


