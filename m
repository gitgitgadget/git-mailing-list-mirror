Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69EA81FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 13:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbcLINVu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 08:21:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61728 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752625AbcLINVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 08:21:49 -0500
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Dec 2016 08:21:49 EST
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B80155609;
        Fri,  9 Dec 2016 08:13:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=cGUVsmknzg1arVMBDMx06/jOK6k
        =; b=BguImxElP+LqC/CPFz5k1NOVYh2a01oyPWIvKrYjQEBI8iLZeCccgpqQjAP
        omvZM5lZFKrORD4bo8ghD0nS4bkfsB0XUbB5qqeobdHUpcQhtEPUcmFLzJa2GNyq
        lXxQisxPdmiZWy++uXyKdj53EHVuMI95FvSm+KFvilX4rOpw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FFAF55607;
        Fri,  9 Dec 2016 08:13:19 -0500 (EST)
Received: from localhost.localdomain (unknown [207.161.55.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56C03555FE;
        Fri,  9 Dec 2016 08:13:18 -0500 (EST)
From:   Quinn Grier <quinn@quinngrier.com>
To:     git@vger.kernel.org
Cc:     Quinn Grier <quinn@quinngrier.com>
Subject: [PATCH] describe: add tests for unusual graphs
Date:   Fri,  9 Dec 2016 07:11:41 -0600
Message-Id: <20161209131141.3096-1-quinn@quinngrier.com>
X-Mailer: git-send-email 2.8.3
X-Pobox-Relay-ID: 405EE88E-BE11-11E6-9107-B2917B1B28F4-75739717!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git describe may give incorrect results if there are backdated commits
or multiple roots. This commit adds two test_expect_failure tests that
demonstrate these problems.

Signed-off-by: Quinn Grier <quinn@quinngrier.com>
---
 t/t6120-describe.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 85f2694..ca82837 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -206,4 +206,52 @@ test_expect_success 'describe --contains with the exact tags' '
 	test_cmp expect actual
 '
 
+#
+# A---B*--D master
+#  \     /
+#   .---C topic
+#
+
+test_expect_failure 'backdated commit' '(
+	test_tick &&
+	b=$GIT_COMMITTER_DATE && test_tick &&
+	test_create_repo backdated-commit &&
+	cd backdated-commit &&
+	git commit --allow-empty -m A && test_tick &&
+	GIT_COMMITTER_DATE=$b git commit --allow-empty -m B && test_tick &&
+	git checkout -b topic :/A &&
+	git commit --allow-empty -m C && test_tick &&
+	git checkout master &&
+	git merge -m D topic && test_tick &&
+	git tag -m B B :/B && test_tick &&
+	git describe :/D >tmp &&
+	sed s/-g.\*// tmp >actual &&
+	echo B-2 >expected &&
+	test_cmp expected actual
+)'
+
+#
+# A---B*--D master
+#        /
+#       C* other
+#
+
+test_expect_failure 'multiple roots' '(
+	test_tick &&
+	test_create_repo multiple-roots &&
+	cd multiple-roots &&
+	git commit --allow-empty -m A && test_tick &&
+	git commit --allow-empty -m B && test_tick &&
+	git checkout --orphan other &&
+	git commit --allow-empty -m C && test_tick &&
+	git checkout master &&
+	git merge --allow-unrelated-histories -m D other && test_tick &&
+	git tag -m B B :/B && test_tick &&
+	git tag -m C C :/C && test_tick &&
+	git describe :/D >tmp &&
+	sed s/-g.\*// tmp >actual &&
+	echo B-2 >expected &&
+	test_cmp expected actual
+)'
+
 test_done
-- 
2.8.3

