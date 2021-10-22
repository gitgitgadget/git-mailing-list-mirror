Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F3BC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998FB611BD
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 16:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhJVQww (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 12:52:52 -0400
Received: from srv1.79p.de ([213.239.234.118]:45704 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhJVQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 12:52:50 -0400
Received: from srv1.79p.de (localhost [127.0.0.1])
        by srv1.79p.de (Postfix) with ESMTP id 82910600695;
        Fri, 22 Oct 2021 18:50:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: by srv1.79p.de (Postfix, from userid 1000)
        id B104E6014F0; Fri, 22 Oct 2021 18:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2021; t=1634921430;
        bh=YWLynZkiqFcvPGxHCr8RLn4PezLsextmTn24XAxgziU=;
        h=From:To:References:In-Reply-To:Date:Subject:From;
        b=cF93KNRBjJ5DbZPh3IImwWiyh6ttqgrodNKGzA6lvwxE2hefFffsM/mzesdFiBPIQ
         VwQs1p1mAlIP+QAcc+V5zJCPwjjOkibGrQdymzQO1kHswXfq9xYe6zmC6VETKdpfyf
         hYXq7mRKNDM7KinExhJcNPB1zuy6G+hI1/mTFzV6CMXS34HSab9S/BpPWsU6qI8Xk6
         KMsLJsuABw/VZ59/1pA9Hnc2Z3szMA54ze0vi49z0jBjGG69YQQb5QPZDP8pGWreH7
         4sT7/Bw5LWYidbXqb5AS/kXRyra+OZC6TPtdpkWLMPrpoqYDSXWd4AshQdSgl5cnX2
         cJ9Cdqzy2vb5A==
From:   Sven Strickroth <email@cs-ware.de>
To:     Sven Strickroth <email@cs-ware.de>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <82c63c23-446a-1945-0083-f1f5af6d43e8@cs-ware.de>
References: <dad761bf-3121-8934-fad6-78610bc21121@cs-ware.de>
In-Reply-To: <dad761bf-3121-8934-fad6-78610bc21121@cs-ware.de>
Date:   Fri, 22 Oct 2021 18:45:29 +0200
Subject: [PATCH] Drop unneeded special handling of ssh variant tortoiseplink
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"-p" is supported and "--batch" is ignored in TortoisePLink from
TortoiseSVN and TortoiseGit since at least March 2015 (and TortoiseCVS
is not maintained any more). Therefore, there is no need any more to
keep these parameters for ancient versions of tortoiseplink.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 Documentation/config/ssh.txt | 2 +-
 connect.c                    | 5 +----
 t/t5601-clone.sh             | 4 ++--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/ssh.txt b/Documentation/config/ssh.txt
index 2ca4bf93e1..3902c8371d 100644
--- a/Documentation/config/ssh.txt
+++ b/Documentation/config/ssh.txt
@@ -27,7 +27,7 @@ follows:
 
 * `plink` or `putty` - [-P port] [-4] [-6] [username@]host command
 
-* `tortoiseplink` - [-P port] [-4] [-6] -batch [username@]host command
+* `tortoiseplink` - [-p port] [-4] [-6] [username@]host command
 
 --
 +
diff --git a/connect.c b/connect.c
index eaf7d6d261..2628c2fc17 100644
--- a/connect.c
+++ b/connect.c
@@ -1269,9 +1269,6 @@ static void push_ssh_options(struct strvec *args, struct strvec *env,
 		}
 	}
 
-	if (variant == VARIANT_TORTOISEPLINK)
-		strvec_push(args, "-batch");
-
 	if (port) {
 		switch (variant) {
 		case VARIANT_AUTO:
@@ -1279,11 +1276,11 @@ static void push_ssh_options(struct strvec *args, struct strvec *env,
 		case VARIANT_SIMPLE:
 			die(_("ssh variant 'simple' does not support setting port"));
 		case VARIANT_SSH:
+		case VARIANT_TORTOISEPLINK:
 			strvec_push(args, "-p");
 			break;
 		case VARIANT_PLINK:
 		case VARIANT_PUTTY:
-		case VARIANT_TORTOISEPLINK:
 			strvec_push(args, "-P");
 		}
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 83c24fc97a..41e1670328 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -430,7 +430,7 @@ test_expect_success 'plink.exe is treated specially (as putty)' '
 test_expect_success 'tortoiseplink is like putty, with extra arguments' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/tortoiseplink" &&
 	git clone "[myhost:123]:src" ssh-bracket-clone-plink-2 &&
-	expect_ssh "-batch -P 123" myhost src
+	expect_ssh "-p 123" myhost src
 '
 
 test_expect_success 'double quoted plink.exe in GIT_SSH_COMMAND' '
@@ -472,7 +472,7 @@ test_expect_success 'GIT_SSH_VARIANT overrides plink to tortoiseplink' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
 	GIT_SSH_VARIANT=tortoiseplink \
 	git clone "[myhost:123]:src" ssh-bracket-clone-variant-4 &&
-	expect_ssh "-batch -P 123" myhost src
+	expect_ssh "-p 123" myhost src
 '
 
 test_expect_success 'clean failure on broken quoting' '
-- 
2.33.1.windows.1

