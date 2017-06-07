Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6132D1FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbdFGQHD (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:07:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:53365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbdFGQHB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:07:01 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsfrR-1dytD33h1N-012ESO; Wed, 07
 Jun 2017 18:06:52 +0200
Date:   Wed, 7 Jun 2017 18:06:52 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/9] t7006: demonstrate a problem with aliases in
 subdirectories
In-Reply-To: <cover.1496851544.git.johannes.schindelin@gmx.de>
Message-ID: <e56eaa53b87052c670a4d431cc2cefde4088a200.1496851544.git.johannes.schindelin@gmx.de>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SJYLRIcLI9zyPg3QT42yhH6/7ZcJIMOrl3+MUyaDeYPa5WwpoFJ
 kvRe6RQMH8eviqC0rHyTMeIxGSWHNNNzhjJDUgForVKuiovh9x30Xi2+XqvaKxDxZP/Vz51
 UBw1vU8B9mZo6Fq8z1oG7NMulHrkwz42xFBoKqk0TzqQY8q1U+I3EAzXTxJmQmRksSu6IuN
 huTpzGKM9q7ALpnzTcmVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5fvsXLmXcXc=:VN2MqTGLnbd5eLAVDxrgNB
 j0ke4BMFqOlL+r/StNQd++mtvFMbSYL7oMZ3Jk+kHJK6PX5I5X5/k7MuVvcNYVF6G2NZoLXWI
 PFiwZpSJXqWovgwqpW4uaXTxo94+eRG/k4q85vwe/FFAEL64CT8gVUCZ1OI4l+zO9ak7iztH9
 /YqFPn8jlht8j6DAuDNF30fit0m3VdU6IHRup+lmpK9IahSDQxUEoTeyp2B35ozUxqFLKqPDz
 /X3BuCZMbiBURhaqrmJcl/FLgezM+9rMmVhOthXABhk8ziPD3VSn+HxvwGJ2hEsk0lORP05JU
 /NldIbsYot/GKbkJLATXkKM6TyOQKSMvjeE5aufP1sEdwANJ/NU5gyn4I8LhWokMGs/CJfce8
 AKmDL2z8vpA0eKxM7qeFEQB+P2QYn35WNdKNVAugxiRixwTCeKwULNX/KGx9GeFTxcvljjs9G
 sT6c/Qx846Roj8eZBEzRGY+xUJlDVmeNKcCk4gov8PfFu/D1vkaQxaRDtoF5DD86oveIeZ4Ue
 Jy2DfPytArmq6bk3YN1KQn2nh3jWZk8SbLrhGwxxdzI5UyIEDOi6rHmKGr+aCC/BkTnm7oSm2
 TXkuf6juAHmj0N1P7VyyAg3VFJBpP33HK+L4UZfG2bOfuSyGjVWjUG3Xrs0uJ7Ukve9AlOPQz
 U1JhHL+A1Qn+lUn7EvU78MWNY2fntmyCaEwXcduzKVTYPr9Y9MvFFUZQgPfzUtZtjVvR/S0xq
 wtkfn7kyFwAMymom2khPB35O4OQW5P5Le2c4YfGfw00NpeKkpZnbU+H+ImChEHRH3on35B6BO
 WNFSpCX
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


