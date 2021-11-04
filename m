Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757E2C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 19:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507A361212
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 19:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhKDT2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhKDT2m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 15:28:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66903C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 12:26:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s13so10299372wrb.3
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EaNfZsgLhuLVs9hBVELrUwvZXh5TRsVM2ZXLMuy1k4U=;
        b=TpR8fntZlrJYjwEtuOohjAopa/1gJX/XBep8+9enUY/CCh8JjdzJeUWhxDlLKxUksw
         ouvMfPxXgXxd5ab7c85A3yIzw4JmqZlnXbDOJPZ8Q7wJ5TsqxK9Bla0KCsZFSo0yWK1J
         4wbswBgziDjAlxx39KJ/oR8vj6zAW+5F9nRdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EaNfZsgLhuLVs9hBVELrUwvZXh5TRsVM2ZXLMuy1k4U=;
        b=VCQYcmKbuumDBwUADl4IKB0tozsT+8UQNFI/KmLRx4QFCJY8G7gTWCKGWlgKGTSm+R
         Px9SiiONkJrPUhBVExIVnK4GjQxn0IOEkIjJW4bDYJfgbMgUtCKj+yqsOykSBy2yq0pT
         teJ4esfXSFZprkX4+0pUbkBKEU/YXHPp9YLUVEi0tgUZ1iS1RJprttIYms2gNvlw5Zu3
         r1NgOi20bmoTmJVDngkr6DynJsxxvNcagHVuPuvc7AgcjTseur/cIyPVfVXFRoPlE/8C
         DFB+vdxb9PXM+np/PaVdxi2r6AMPvWGlbbwjdiIshRYm8cs2eOrdBHY4Kouuo+ujQ8cL
         Odhw==
X-Gm-Message-State: AOAM530VI80Qdabbe+8p4o3csY/DzLLaiqft1pufNKOAjxZGzDMRJX5i
        t+jPeBEJIW7OSbd7zS8Gdo6eVMQnz0szyw==
X-Google-Smtp-Source: ABdhPJwhE3MTMKLhyZK9X/ZZ73JwSHwoc/f+HC1qoVcxK6ZzxbSeWY3WA9o/r1DIaJjEx+xmFieeww==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr21922708wrs.178.1636053962917;
        Thu, 04 Nov 2021 12:26:02 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:c68a:1a01:159:f855:564c:e3b5])
        by smtp.gmail.com with ESMTPSA id h1sm5876465wmb.7.2021.11.04.12.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 12:26:02 -0700 (PDT)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
Date:   Thu,  4 Nov 2021 19:25:33 +0000
Message-Id: <20211104192533.2520-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSH keys are expected to be created with very restrictive permissions,
and SSH commands will fail if the permissions are not appropriate.  When
creating a directory for SSH keys in test scripts, attempt to clear any
ACLs that might otherwise cause the private key to inherit less
restrictive permissions than it requires.

This change is required in particular to avoid tests relating to SSH
signing failing in Cygwin.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
Helped-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/lib-gpg.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index f99ef3e859..1d8e5b5b7e 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -106,6 +106,7 @@ test_lazy_prereq GPGSSH '
 	test $? = 0 || exit 1;
 	mkdir -p "${GNUPGHOME}" &&
 	chmod 0700 "${GNUPGHOME}" &&
+	(setfacl -k "${GNUPGHOME}" 2>/dev/null || true) &&
 	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_PRIMARY}" >/dev/null &&
 	echo "\"principal with number 1\" $(cat "${GPGSSH_KEY_PRIMARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GPGSSH_KEY_SECONDARY}" >/dev/null &&
-- 
2.33.0

