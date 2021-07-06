Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898C5C07E9B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E81C61CA8
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhGFVGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:06:34 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:44579 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhGFVGe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:06:34 -0400
Received: by mail-ej1-f52.google.com with SMTP id he13so17697383ejc.11
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 14:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9rq84VpBeMDfmMkPhWtb9adxd/k4RKngC1L4KY7+Ok=;
        b=XjIC5+TJUu+81pi5bl+1vEt+g2VSOLNJbb7PIt9BcGuJL6GWKbKYD3CQSm41f77hdD
         /McXbPnmrkF/fh3T/iU/fqfzx3JRVv4dbMgFJetm0H2YQJwN+J+hsaMEBiDhk2u7pZEr
         M7wlDIHrKXfThvw/83PUIGylCIxzjyj7xBWL90VWCs63jic7McjfRRYgCYKXbISUkW6N
         Hh1I78AoFSF7iWVgdMpidpUK1SxpHZEwfAyV8wCWkSkFdBnXWXtOFRznnEA5or1VySma
         vya6Cf7NP22zlCn2icvyXaDvLzep04L9Hxi0Nw6cVltlhMztmBaPTywPnhP0la4Qv/tE
         3f4g==
X-Gm-Message-State: AOAM533BFNEe/EyXVBz0wDTGEpg1o54XrC4zdBtpNgHpB9tvsdsFUJ5U
        TcfcOT8K2U9F4etTdC/iq5x0DIoRRf+WiA==
X-Google-Smtp-Source: ABdhPJzfZPm2KLhnh6kaYmOSpgBzeaYxts67QyxLZUol1u4IRKrJo5OlBvyOllLmedWbkZyNHFXMZA==
X-Received: by 2002:a17:907:3e89:: with SMTP id hs9mr11623773ejc.509.1625605432386;
        Tue, 06 Jul 2021 14:03:52 -0700 (PDT)
Received: from localhost.localdomain (IGLD-83-130-17-216.inter.net.il. [83.130.17.216])
        by smtp.gmail.com with ESMTPSA id t6sm7690284edd.3.2021.07.06.14.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 14:03:52 -0700 (PDT)
From:   Avishay Matayev <me@avishay.dev>
To:     git@vger.kernel.org
Cc:     code@tpope.net, Avishay Matayev <me@avishay.dev>
Subject: [PATCH 3/3] Add tests for GIT_FORCE_TTY
Date:   Wed,  7 Jul 2021 00:03:18 +0300
Message-Id: <20210706210317.706313-4-me@avishay.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210706210317.706313-1-me@avishay.dev>
References: <20210706210317.706313-1-me@avishay.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Avishay Matayev <me@avishay.dev>
---
 t/t9904-git-force-tty.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100755 t/t9904-git-force-tty.sh

diff --git a/t/t9904-git-force-tty.sh b/t/t9904-git-force-tty.sh
new file mode 100755
index 0000000000..c954e27c9a
--- /dev/null
+++ b/t/t9904-git-force-tty.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='Test GIT_FORCE_TTY'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo test_data > test_file &&
+	git add test_file &&
+	git commit -m first
+'
+
+test_expect_success 'no output without force' '
+    GIT_FORCE_TTY=0 GIT_PAGER="cat - > log_data" git log > /dev/null &&
+    test ! -f log_data
+'
+
+test_expect_success 'output with force' '
+    GIT_FORCE_TTY=1 GIT_PAGER="cat - > log_data2" git log > /dev/null &&
+    test -f log_data2
+'
+
+test_expect_success 'cant tell pager present in git reflog without force' '
+    GIT_FORCE_TTY=false PAGER="touch pager2" git reflog > /dev/null &&
+    test ! -f pager2
+'
+
+test_expect_success 'pager present in git reflog' '
+    GIT_FORCE_TTY=yes PAGER="touch pager" git reflog > /dev/null &&
+    test -f pager
+'
+
+test_expect_success 'pager not present in git reflog expire' '
+    GIT_FORCE_TTY=true PAGER="touch pager3" git reflog expire > /dev/null &&
+    test ! -f pager3
+'
+
+test_done
-- 
2.25.1

