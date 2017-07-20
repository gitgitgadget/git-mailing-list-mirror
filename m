Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833BA1F600
	for <e@80x24.org>; Thu, 20 Jul 2017 16:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754068AbdGTQ6Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 12:58:24 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33075 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbdGTQ6X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 12:58:23 -0400
Received: by mail-qt0-f196.google.com with SMTP id 50so4281000qtz.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ybGLe7vC5Q+w+KVf8oEKhiG7lY8l54FXUQI2asDYMlM=;
        b=HO8cVN7GAfaKUETbMSd/cXjDhRA6EHZ4gkvmKpU/SGQgS2umtup/nyZ6hUZPL185nA
         sa5GREeZTWNtRoNOGxqqp1q+cjVfRxedWUKV2eZ11KlRDYQyJkbE+kRV6mphdCIjsjyX
         aeD/Q802s9Sm9GwMj7Sb24IUCwqMmFgoPXJ6oTwSY4Nx6REcQrsK3onXAQgArkXLWGzJ
         D2rQ+JMm+LGbNNdgurOz5rWjIe/CDHDPkAaWG5H4WapSJlkHpRYs69aIDdVJnRiJSlS9
         4hiY7TN97ZouCprR6Y5DoxqYjVB/6z5a26v8Nf/96YMev66WPX5Fs7e7yBai41KHFT6y
         OlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ybGLe7vC5Q+w+KVf8oEKhiG7lY8l54FXUQI2asDYMlM=;
        b=IdV9xorN/xIiiOCM2MPOya+6Q/jfkzlo8FVbr/kRuq7ukJazqTygvkxsDqbQ14CWHd
         Iyhd83lGQQjvYKPMhtjVoW+DlVRFRfweU/Ru2yNbRN+rlzTy10HV8NqLyPclTMV2yaCy
         UpZ6RO4zFIFwnXsLDc9AR8xfkjktkX/+Y9ru1HfepOU1jWYnHaaTLNPL/KO8rLqkFDru
         ZW5fQNhajDxQ1JWfYuL8F33asfNAtgT7F0cNxuS0/+1wwl9T4Zubzqz5qGVmcLIDpdan
         1Hgm7TS0PJ7FWLrCJiYJsYq2GqRP053PBnDoLuR3ZxLJmcBIIDMmY0MW1fv89fKvf1wE
         rHew==
X-Gm-Message-State: AIVw110w02uTEG/9IJqgHNn7KsGD8M8tRbeUlxU+2yG587UFCdBCwi00
        Zx7hyhl13TySukVF/jM=
X-Received: by 10.237.35.110 with SMTP id i43mr5759664qtc.250.1500569902135;
        Thu, 20 Jul 2017 09:58:22 -0700 (PDT)
Received: from localhost.localdomain (ENG-KCG295-01.ENGINEERING.NYU.EDU. [216.165.113.136])
        by smtp.gmail.com with ESMTPSA id f15sm2079077qtf.93.2017.07.20.09.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 09:58:21 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH] t: lib-gpg: flush gpg agent on startup
Date:   Thu, 20 Jul 2017 12:58:14 -0400
Message-Id: <20170720165814.30037-1-santiago@nyu.edu>
X-Mailer: git-send-email 2.13.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

When running gpg-relevant tests, a gpg-daemon is spawned for each
GNUPGHOME used. This daemon may stay running after the test and cache
file descriptors for the trash directories, even after the trash
directory is removed. This leads to ENOENT errors when attempting to
create files if tests are run multiple times.

Add a cleanup script to force flushing the gpg-agent for that GNUPGHOME
(if any) before setting up the GPG relevant-environment.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/lib-gpg.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index ec2aa8f68..7a6c7ee6f 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -31,6 +31,7 @@ then
 		chmod 0700 ./gpghome &&
 		GNUPGHOME="$(pwd)/gpghome" &&
 		export GNUPGHOME &&
+		gpgconf --kill gpg-agent 2>&1 >/dev/null
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
-- 
2.13.3

