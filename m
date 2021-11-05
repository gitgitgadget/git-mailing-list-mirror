Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A30C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 19:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2818B60EDF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 19:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhKETeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 15:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhKETeW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 15:34:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75A4C061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 12:31:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so7164694wme.4
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jjHORktoZHUgjZHDi/JXRZE6f1chDtYhTLjY0wfuiYs=;
        b=pmgnLlYAoUNIUFlGLbr0v9qo/nA4NpIPC8P4YkA+FEB/2EkexgKZxvaPsQjr2LBOPp
         euhAJ1NCgjDU4VACLMWnsafnaLQfTf43N2SauIHH8yRxq7P+SKvnuHuJSpOicxmA+ioS
         qnuEpCOc83/JfKROXPrBxieM/TH6emuAzW6sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jjHORktoZHUgjZHDi/JXRZE6f1chDtYhTLjY0wfuiYs=;
        b=jFWGS6QzKDohJFQ+8b0V5iON5BWCMaHSZ9D6YYEXI5fIy2ebQMhW6DVcTTCUiSF+ol
         /81AzzU8fB1ASlmsGh7Voq8AX5jkRqdQEbAUgoqJZCaTggjbI1weuSJq79Wy+bXS+l+B
         x5zDezhvpfQO/4Kn+hzWspH+mGepnlD+sOWVf580MXC/GSTtfUPAIp7QCDra9nwnX10E
         +Z3YsAMZbSCub0UdqvofIGow2K1wfny/Y/jVZ1qHTkPuo6wEkKi/OnsIYJvGJKUM8m1h
         LyRJE85aWU0itbCuP0V1LqHgDbc8BwZ+IQvnGD+gBC6nfebgVH/CYijSlIM9u5jn26fl
         qbEA==
X-Gm-Message-State: AOAM530PoQS/pnpNq1auWQ10zw7/28kqPkrveyVDJCqJkDd3t8luZCMU
        r0Fdb4oo6YunST3LCOXfcWqcZ0rT/0puRg==
X-Google-Smtp-Source: ABdhPJxEUwa5mhL6GumCsZhNgpIe0XdQCm1mFcQQ4rSkw51ISqFU2IIBofr86jmy7pRRR1LvQwseYw==
X-Received: by 2002:a05:600c:4f8a:: with SMTP id n10mr22055371wmq.54.1636140701383;
        Fri, 05 Nov 2021 12:31:41 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:c68a:1a01:a526:ad51:24cb:f2cf])
        by smtp.gmail.com with ESMTPSA id l4sm8372468wrv.94.2021.11.05.12.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:31:40 -0700 (PDT)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v2] t/lib-git.sh: fix ACL-related permissions failure
Date:   Fri,  5 Nov 2021 19:31:06 +0000
Message-Id: <20211105193106.3195-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211104192533.2520-1-adam@dinwoodie.org>
References: <20211104192533.2520-1-adam@dinwoodie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As well as checking that the relevant functionality is available, the
GPGSSH prerequisite check creates the SSH keys that are used by the test
functions it gates.  If these keys are created in a directory that
has a default Access Control List, the key files can inherit those
permissions.

This can result in a scenario where the private keys are created
successfully, so the prerequisite check passes and the tests are run,
but the key files have permissions that are too permissive, meaning
OpenSSH will refuse to load them and the tests will fail.

To avoid this happening, before creating the keys, clear any default ACL
set on the directory that will contain them.  This step allowed to fail;
if setfacl isn't present, that's a very likely indicator that the
filesystem in question simply doesn't support default ACLs.

Helped-by: Fabian Stelzer <fs@gigacodes.de>
Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
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

