Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C165CC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FA461405
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhD3O5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 10:57:07 -0400
Received: from elephants.elehost.com ([216.66.27.132]:40920 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhD3O5E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 10:57:04 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 13UEu92x089450
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 10:56:11 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Patch 3/3] t5601: add nonstopssh SSH variant sub-tests
Date:   Fri, 30 Apr 2021 10:56:10 -0400
Message-ID: <012101d73dd0$f4fc0d10$def42730$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Adc90OARSV9oUEwuQEWWeCpm1cr5Vg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 375278eb010a91f0ad3114ca2334cd85c4519208 Mon Sep 17 00:00:00 2001
From: "Randall S. Becker" <rsbecker@nexbridge.com>
Date: Fri, 30 Apr 2021 10:10:28 -0400
Subject: [Patch 3/3] t5601: add nonstopssh SSH variant sub-tests

Tests added are creation of the base configuration for nonstopssh
with defaults, banner suppression, verbosity suppression, and
explicit specification of the platform's SSH2 process name
(for example $ZSSH0).

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t5601-clone.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index e7e6c08955..39b49ef67e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -474,6 +474,40 @@ test_expect_success 'GIT_SSH_VARIANT overrides plink to tortoiseplink' '
        expect_ssh "-batch -P 123" myhost src
 '

+test_expect_success 'nonstopssh base configuration' '
+       copy_ssh_wrapper_as "$TRASH_DIRECTORY/nonstopssh" &&
+       unset SSH2_PROCESS_NAME &&
+       GIT_SSH_VARIANT=nonstopssh \
+       git clone "[myhost:123]:src" ssh-bracket-clone-nonstopssh &&
+       expect_ssh "-p 123 -Z -Q" myhost src
+'
+
+test_expect_success 'nonstopssh suppress banner' '
+       copy_ssh_wrapper_as "$TRASH_DIRECTORY/nonstopssh" &&
+       unset SSH2_PROCESS_NAME &&
+       GIT_SSH_VARIANT=nonstopssh \
+       SSH_SUPPRESS_BANNER=1 \
+       git clone "[myhost:123]:src" ssh-bracket-clone-nonstopssh2 &&
+       expect_ssh "-p 123 -Q" myhost src
+'
+
+test_expect_success 'nonstopssh suppress quiet' '
+       copy_ssh_wrapper_as "$TRASH_DIRECTORY/nonstopssh" &&
+       unset SSH2_PROCESS_NAME &&
+       GIT_SSH_VARIANT=nonstopssh \
+       SSH_SUPPRESS_QUIET=1 \
+       git clone "[myhost:123]:src" ssh-bracket-clone-nonstopssh3 &&
+       expect_ssh "-p 123 -Z" myhost src
+'
+
+test_expect_success 'nonstopssh supply SSH process name' '
+       copy_ssh_wrapper_as "$TRASH_DIRECTORY/nonstopssh" &&
+       GIT_SSH_VARIANT=nonstopssh \
+       SSH2_PROCESS_NAME=\$ZSSH0 \
+       git clone "[myhost:123]:src" ssh-bracket-clone-nonstopssh4 &&
+       expect_ssh "-p 123 -Z -Q -S \$ZSSH0" myhost src
+'
+
 test_expect_success 'clean failure on broken quoting' '
        test_must_fail \
                env GIT_SSH_COMMAND="${SQ}plink.exe -v" \
--
2.29.2


