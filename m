Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEFE1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 15:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932770AbdCGPGj (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 10:06:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:52445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932750AbdCGPG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 10:06:28 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbaS9-1d1xiG1J01-00Iz3b; Tue, 07
 Mar 2017 15:33:13 +0100
Date:   Tue, 7 Mar 2017 15:33:11 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v4 07/10] read_early_config(): avoid .git/config hack when
 unneeded
In-Reply-To: <cover.1488897111.git.johannes.schindelin@gmx.de>
Message-ID: <84b39810f2c12a4774f566f857c5014ac65adae8.1488897111.git.johannes.schindelin@gmx.de>
References: <cover.1488562287.git.johannes.schindelin@gmx.de> <cover.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Cgm2Fu9zBb3D6q3JIA0jMVrI7Yph5nLcw3WVuIgk8EJv8XppYtM
 6EJXvp/eQmZxkFkCKuf/YugqW4mLBrkkP97lx/5TDN0mlZFhRK9gCl77M9u+ZXjrN0FBhvU
 TBts4qMQ5XS2dICc4qXeDkq10B5Ia3AqN2pOE0teNG0EXKA0PeLfJE8e5GkqvwkJy5feZyf
 ZCWeinTiEEhgD3DVnTx/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n0Sc16k0m7w=:PxZlsu3U9oefAHBsHBgXLS
 TzamsybCFFbsITonJRUb+GtFKuKKOpYL4U29lCygF17JS8qh4OlvUS44BFjSiOftMqKbqyG46
 vlbbhXKv45duz5vyQHkAAm59TvKp8mCcXYFxf28bEunf4PHA5QXBcmbfC/7i33vh1ay/7bFLp
 FnWpR0IDjkoHtlbQ99wWdXF0IxYW+Ojxx0VYs4BEddx9rYE1Hk/9RcAyN8/vHU/+ezrCuidJJ
 epY19RkakF4AZoyRUuh1P48i/jYtU57qZw9g3HPgQxxKKWxtWkxKmGigHZJMxVH5W6emC/WQT
 5FFaZlNTnIBZvAqKZhUl0ukgFy6hP2KYPA0e2Uq0IG4XaMp5Wlvlb3LA4Mmpto0YA30xtS5/7
 i8oSZgPr7jU/YjyEua8vT9VYE9/G9wQVqoY7pWSPxvS7RU/wXCFPmkizVJiogP4nWBW+vOucX
 uHaWfapOFRZgo2M8OcsdPolyIUoMmVpPRS+gMbopBJdESCh4sc/9TPgzuMFaDx+Gfn/vR11HY
 VG2O8phkENtVZF7hi9f4jJibsH4lglnk+H8OZ1XB3CR4t0MM2KVBqScRm23I0i9NkffICKFzZ
 D5sE0Y2C4qx/MoAZAIvA/sSb7JK/1SsiRA0RCsiMm27YZ7S3kpWSAO7A32vmOUt5gmoblLK/e
 F5S6kZVNphJwOU9ixEtkR9QVww+I5CEKMM23qht9XVMYWGQoYEX5TwOrOKEhBtasQBS6nxqRz
 IpV2Oaewr6CEDlS6GWWEBSJn8Vfco2hhLwG//GpfKYgQV9kaGXK1OwjilB2EAgxIpqMx2Bptj
 ctj+ZQp
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
index 9cfbeafd04c..068fa4dcfa6 100644
--- a/config.c
+++ b/config.c
@@ -1427,14 +1427,15 @@ void read_early_config(config_fn_t cb, void *data)
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


