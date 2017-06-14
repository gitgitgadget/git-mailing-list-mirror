Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6ABF20401
	for <e@80x24.org>; Wed, 14 Jun 2017 11:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbdFNLgN (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 07:36:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:64384 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbdFNLgM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 07:36:12 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MN0jA-1dRg9t3EOe-006caa; Wed, 14
 Jun 2017 13:35:57 +0200
Date:   Wed, 14 Jun 2017 13:35:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 5/6] t7006: demonstrate a problem with aliases in
 subdirectories
In-Reply-To: <cover.1497440104.git.johannes.schindelin@gmx.de>
Message-ID: <ba1ae3d6cc5c1722d00480267cfa9b4946c0c0ea.1497440104.git.johannes.schindelin@gmx.de>
References: <cover.1497440104.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7AlSbjCmv+6Ut+6jGYVF+lsBlkNQ2PPMKPl5QhyWWE/qktHVMio
 T/FPJspIy6zgUF9DvNS1KvElCmx9j0lKT3dXsEAB2DzCadgm3f/t2Nke9BE97sM3wLNhIkr
 H3Km0gWEOxzFH8WWfXD5UcnNs455IOJwvX11lnKr9oqnoR220z8g4Yg61Je0F6NtRWAqiXc
 lo3nHEPP1Et70ovni0+/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sm6Gf7KZ8ks=:kXXTXiYu+q3LsCmPj6Md0k
 /3sqWOPb2O74LgLa33LxmMMSgPYMM9wglfuCCRAjcJbnBQPyetIaBLAo2XqU6Eodo3JFbp/xv
 KZfPADgbJT8H5iSTLgI1CU8RLW/QA4q3ccDJUThxGd0ZZet+SHmVydYwB9jYekB1IWiEj2TDR
 tRIZ8misOk+0B4OP6dYq522eGtXXIdbfSgSUhK/70XubYdZ2nj0MuqOjCWA1lc5Kw/jdNcuns
 eLuNoGPzfLklBq5RBSfV93Op3GratDDeXcfYS+oH66L5ewoQ4WJiPB5uIm86MrAM/fYsRnuKF
 08KgwHhUOErNzjmijX/cC1o/dr8px4nF7xbHv6ldLsW6apsTHBTCfVRAvgoG1JG73g8tBMaFK
 Uwvj1cT6bK7o8g64AoaRULpssO0FraFd3WUbrsIaGzvvWJCfM2d91XSHj8VucidDcViI0B0Gs
 UQRiFMX+eZ2KwaEzzRtDg+CMtLZan4hErOdRLDwyNXWOx/stiifFW1HewtbM2lvkBOp0jl53A
 ocLSRLUotZFMmoJTRcoHT9s3NfNAUJigUVR5pRWfy1H/15WbLaTnYHIWPU4vVo+9fcw+uJyTd
 HqBtPBa1d5CrVrmulHku7ro/ZfCp5juoNXcqXsd4gzOpAQJkyuaaCaEyoVftZfq7gKFFpv3vn
 fsT5fWCZNYo96ptiv3Bk/v437SzOKMswrAVjW4Iuu9HbzhvOdvfGUo/hjJqIIjA0BsodOlV/f
 4g7ue+UVLwIaB2T16tm0DAcgtuocuV5vmHR0EprVqe2StjolS90fbOEV9TyaoYOgYicKKCl/g
 fv2e+En
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When expanding aliases, the git_dir is set during the alias expansion
(by virtue of running setup_git_directory_gently()).

This git_dir may be relative to the current working directory, and
indeed often is simply ".git/".

When the alias expands to a shell command, we restore the original
working directory, though, yet we do not reset git_dir.

As a consequence, subsequent read_early_config() runs will mistake the
git_dir to be populated properly and not find the correct config.

Demonstrate this problem by adding a test case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7006-pager.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 4f3794d415e..83881ec3a0c 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -391,6 +391,17 @@ test_expect_success TTY 'core.pager in repo config works and retains cwd' '
 	)
 '
 
+test_expect_failure TTY 'core.pager is found via alias in subdirectory' '
+	sane_unset GIT_PAGER &&
+	test_config core.pager "cat >via-alias" &&
+	(
+		cd sub &&
+		rm -f via-alias &&
+		test_terminal git -c alias.r="-p rev-parse" r HEAD &&
+		test_path_is_file via-alias
+	)
+'
+
 test_doesnt_paginate      expect_failure test_must_fail 'git -p nonsense'
 
 test_pager_choices                       'git shortlog'
-- 
2.13.1.windows.1.1.ga36e14b3aaa


