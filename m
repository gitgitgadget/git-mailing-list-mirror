Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC62C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhK2WW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhK2WUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:20:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3BC08EACC
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c4so39299550wrd.9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8wC/tVZloAyHrjeRo0BTEr//VJeh8EbGwmmH/weufU=;
        b=CzpYifym1iYHSI34UY1vobMGAeCl2FAMnQKzAQP62AF1t239fWwO/VGnXJgs5EuzBs
         aCCrxS0HxW6S1xx0w7mkMjOYUKPwMRrg4mov2cwcdGQWpfM5uAROd49SX74d/wHxnLU8
         WS2JCFeaZ7K9A4G97MEXBJb7m8SxwEV0OcEmZoPH0djRoZzkyCW2BDDbATD4pXMMrfxO
         y3cN09Hc4dJNe4Gg5rnv8krNrwN62Zr/hTRkDU0/FNLQoQD3Z+L4k/fOv3Sjd0ZEVb+3
         fB2y+lVcHOrrY65t2DVf4HWckCfmi3mmlWsVjtbf3HM+zeM/MOeFjxhAEKSo1iVwY0ld
         qxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8wC/tVZloAyHrjeRo0BTEr//VJeh8EbGwmmH/weufU=;
        b=G61agOmGhwMFczkW7Q+kJU162tjd2S4k4lbWfMpikDGs+KtiFaBDYqlsFFhr23pOnB
         Ow1dl2CWtQweXR6edlp3niSOp0dZCSKLkrbRuif4Xre7XgQsfr8OUPrlgM6Jk7lsuTxt
         jA+Ar0EDe1L9+i1XIWAVsqJ9Ze4WSOhFc+0RIq+uFfl/wWhsEdbUXBc7x/agP9+FzY/S
         0StvKCr6wkWnB6c1GqPTcTqCRqQYXNdh0FTwDWi2GIY2fd+4Kw5WiBj+dVRnhynKx+Yx
         M3ONyMc3A6E0DMBrveMPI2u1JS0CsxxYY/ZnqI5fbiOiSg3b+66t6QNO+Ii4L5DmL52h
         8CvQ==
X-Gm-Message-State: AOAM533Cg3Dp3p7Q4yHT4Aw4FPWt9e/mEW99j0A/K4/mNlTL+u9zemeh
        qxQ1ytguu37RXlLYcQ5Wmsv8vFE19WTF7w==
X-Google-Smtp-Source: ABdhPJxfGFswFKt66dHUWIcFelqLlbuTlZ6V2QBOqg+eR4NhQmuBkPtQPl5N53B3ar5Ftna2aV5xlA==
X-Received: by 2002:a05:6000:1885:: with SMTP id a5mr37247726wri.258.1638215955914;
        Mon, 29 Nov 2021 11:59:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm298200wmq.32.2021.11.29.11.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:59:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/10] cat-file tests: test messaging on bad objects/paths
Date:   Mon, 29 Nov 2021 20:57:42 +0100
Message-Id: <patch-v3-02.10-ab21a69864f-20211129T195357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for the output that's emitted when we disambiguate
<obj>:<path> in cat-file. This gives us a baseline for improving these
messages.

For e.g. "git blame" we'll emit:

    $ git blame HEAD:foo
    fatal: no such path 'HEAD:foo' in HEAD

But cat-file doesn't disambiguate these two cases, and just gives the
rather unhelpful:

    $ git cat-file --textconv HEAD:foo
    fatal: Not a valid object name HEAD:foo

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t8007-cat-file-textconv.sh | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index eacd49ade63..71ea2ac987e 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -19,6 +19,48 @@ test_expect_success 'setup ' '
 	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
 '
 
+test_expect_success 'usage: <bad rev>' '
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD2
+	EOF
+	test_must_fail git cat-file --textconv HEAD2 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'usage: <bad rev>:<bad path>' '
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD2:two.bin
+	EOF
+	test_must_fail git cat-file --textconv HEAD2:two.bin 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'usage: <rev>:<bad path>' '
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD:two.bin
+	EOF
+	test_must_fail git cat-file --textconv HEAD:two.bin 2>actual &&
+	test_cmp expect actual
+'
+
+
+test_expect_success 'usage: <rev> with no <path>' '
+	cat >expect <<-\EOF &&
+	fatal: git cat-file --textconv HEAD: <object> must be <sha1:path>
+	EOF
+	test_must_fail git cat-file --textconv HEAD 2>actual &&
+	test_cmp expect actual
+'
+
+
+test_expect_success 'usage: <bad rev>:<good (in HEAD) path>' '
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD2:one.bin
+	EOF
+	test_must_fail git cat-file --textconv HEAD2:one.bin 2>actual &&
+	test_cmp expect actual
+'
+
 cat >expected <<EOF
 bin: test version 2
 EOF
-- 
2.34.1.841.gf15fb7e6f34

