Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E931FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 19:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbdFHTx4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 15:53:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:65113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbdFHTxv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 15:53:51 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdHqj-1dj0Sz02VN-00iSEl; Thu, 08
 Jun 2017 21:53:48 +0200
Date:   Thu, 8 Jun 2017 21:53:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/8] t7006: demonstrate a problem with aliases in
 subdirectories
In-Reply-To: <cover.1496951503.git.johannes.schindelin@gmx.de>
Message-ID: <d20265ec04b02a58d9537813e85b5c842436ee22.1496951503.git.johannes.schindelin@gmx.de>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xWCxhEe2aRSDnEwjfmceeHDzp4tG8zMEtzZ9mvMdTIDuKXUsR5P
 WVxRsTIMG/xj8m0606HDDwWWriBeYD8WVnVfsFym/jzgukRvgtU9CO7ezwLpgwYoN6CDXMY
 9lf4Q02FbIGD0sWEByw2LtIPdW6lvIaJRs/wJVE9sXioHdFPWiQ9LtT97hTHysXzAmhmWj0
 SycMSxnVsWDHUXgRcElGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7RwwZdscxBU=:wBI08hAKWdmGDS+eMAmvVP
 Ai+0Z2thnDfB3o9mPHlNoLZjhqPJ5Nv5OiweRlSB0tKxLXzseGM1/+vSRzuTJLwVpgFdKLTxY
 j53HjUW0uvcwQAvP6jrEVKLShcHAeXDSujz+aaNfC7g424ysjFeystelA2s8wAQZSnlLCqLew
 eAsRd0/HZWNmdijWmZ/OpKjkrRVQSO52ZWECiPUR8ue45NAusAxxf2fNYaxDK5fhwtJ8zMIOu
 9VZC0cyk6VGqlE6F4GXbmbJ6AuSXH6Vj0ICsO6kQ/nXH/R3PcQ0p+14zSy6hCKS6qjsKJrT00
 xIZrhnxmuitiU/SUbyaDvcquSpsd4SOtqlKFgMAWZL3bhRQc8PGk1MFaLJhPxmg2N2vbL8mpc
 jK6fdZI2cJk6xkzKRtM3svmA+ODmZTak00Zv2SNY733nYL/0Thy7Bwwn4mzKWX+wRITvg6bh6
 5HRFddX6IYNlhQDG8LuVcsdY1sXTIMbL4arg0XciWJ5WuxATepEit/Fbci/HGdZfraeZI01xl
 P+/LFam/MugpMCPF2rXtf7CKVVFRMVPA54M0VvSa4PSp+daJZlyPv6K9MmBXKuB5cRYsArpVD
 T8Cm0U8Yd5O5j2vhA81DUmTqgVW12SNGY931gbvhVj7HdbAfAV6yzDJ1k7p1sZcvLt6jOojd+
 T7QE1+i46NlLqRPxi5wBXMG6Onpo6tidjAoPlfjhLYZpC4EO1TiRfmzOZBUdyzj4QqRbH84Hy
 aGv8czJxrYFtEmE88NugCK4LneJRoXdarsGzmq8UsD+wDteJjrQEXwBhx6UFsil88aJnrXu2y
 +CE8KI7
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
2.13.0.windows.1.460.g13f583bedb5


