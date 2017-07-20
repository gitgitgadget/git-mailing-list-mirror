Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1721F600
	for <e@80x24.org>; Thu, 20 Jul 2017 21:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934981AbdGTVGB (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 17:06:01 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36293 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbdGTVGA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 17:06:00 -0400
Received: by mail-qk0-f194.google.com with SMTP id d136so2606907qkg.3
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=8D52EbZrysjUF61+MpBg3dEoFX8LNgAPHLi5MtZgGcc=;
        b=fiGzig6jHmdIfRFjF2aOl8/Nr/UYY/VxdzIemHcgTIbzqsXpughkDp5RM3Z6IOfdfv
         yvVTIPgXcX9D35y2SLU1ZHgTvqk7Tt8Pw4YqrqHdRnWF5iqzka11F6WM5ypyHBfBzhGA
         0q1/qxs1r1a8RyzJuYzGIrYqxJ5/zGbpSy1G10reW44eHrjl+ruhEyj16QMffp5JSw8M
         QhCDouT9OeU3ANm0tem/eSJFtLrph8/qgMXcYnP6Wo/7Wgn8i7tUyfn4XBZI1dCg58Pl
         Aj3VhGczhkjMAFlNezZvStIACI0WqNoGUB4fLbArvXLBCs/JVoByFMulO83U/VtCdWVo
         jHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8D52EbZrysjUF61+MpBg3dEoFX8LNgAPHLi5MtZgGcc=;
        b=leYCiJCZuY7GIGUH8o1J9zkSeAlBALMYM+INP+7Z4/7Oy32kyDLF3nbz68RPWq8hYv
         CsjVld2bxAWqjXsOaQuGWwD0mq5oYRwJx1HoWnrQOYaqHCbFgMP8m/0CP76gP/MYexPG
         1UB6H3/Kb0QSKHaVXExyOTidEQ1ceISz4i5WtJ7q/P4LnW53lC8QJsmky2zWUuTa6+xH
         mHEvGfx5HQYwXaeZ+p3lAPdrSetgbWV8B3E0B1IqTVbsbpt5QUgMSZVwWydG4uXyIRvm
         Q+Ruoyrr2P+9wh2uq2SFbf8Ox4ZNu4J0LA34NjVnnlb+NnfyDWY9MKE3crcxUrfccD9c
         8GIw==
X-Gm-Message-State: AIVw111wrg5GHIySTwNBmcshYkTKNSEYenjVYWmxKbR4qcYhEpDhZdLM
        EIo/UqYz20co99TQuuI=
X-Received: by 10.55.20.230 with SMTP id 99mr6387744qku.236.1500584759315;
        Thu, 20 Jul 2017 14:05:59 -0700 (PDT)
Received: from localhost.localdomain (ENG-KCG295-01.ENGINEERING.NYU.EDU. [216.165.113.136])
        by smtp.gmail.com with ESMTPSA id o25sm2290972qkl.40.2017.07.20.14.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 14:05:58 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v2] t: lib-gpg: flush gpg agent on startup
Date:   Thu, 20 Jul 2017 17:05:52 -0400
Message-Id: <20170720210552.3076-1-santiago@nyu.edu>
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
index ec2aa8f68..43679a4c6 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -31,6 +31,7 @@ then
 		chmod 0700 ./gpghome &&
 		GNUPGHOME="$(pwd)/gpghome" &&
 		export GNUPGHOME &&
+		(gpgconf --kill gpg-agent 2>&1 >/dev/null || : ) &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
-- 
2.13.3

