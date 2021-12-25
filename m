Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6063C433F5
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 08:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhLYIW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 03:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhLYIW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 03:22:28 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD17C061401
        for <git@vger.kernel.org>; Sat, 25 Dec 2021 00:22:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r17so21439621wrc.3
        for <git@vger.kernel.org>; Sat, 25 Dec 2021 00:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vk17lwo295tEXhynL8WnYpobLnyJkGLIbMnZwmllfi8=;
        b=YR+i4Bx0wbjDXSxGwNuC8rv2zyeAO84NAloWeJ1okHo9sR3ITER6ticNHm24/3069K
         kLRSGF5QZ/k2RpO9ZZ22BkvFZAAeazirmNiGeRpu2OpscW10OVnKPehaibvszrFAqb0K
         mjDKcfDtovg6tj4TOA0BGN4hElQVqF1R5y+etS+TkgyNuYGMcspmi8NZnxuU4BdBxu6H
         qLPhNrJovfiVaffCX8suCh+UvkmGuQRiGvZVHET+jl9OovXaUVLZvwqOxROxEmrLhTn1
         bVHu9GdRwdO+ELEHZpFbh1xYI31z5q7dEyXci+ZHASEF01V0ybKd9qqGEjKYiic3fhGw
         uYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vk17lwo295tEXhynL8WnYpobLnyJkGLIbMnZwmllfi8=;
        b=dbeh6r+Ghgs3OJ/X4aevv9VIndV8lSly4+o4CEkMvkskcnjzWVwDEwJQl//6gzvH1X
         Vi3MoieSzgrTuJNqgAjqtd9TezSSCgiOOlewTQJiEwR7/ZPZSCv0pOQqBxq+w3HAoUxG
         xcLJmwYZ4bTde7mG8+P2dIv7YdN2cUi61BmH5dJemT7lCJgxNDM9VPXR3Bi6lkWCaHEA
         Gc5Ws2LtSjTcsMlVa6h/BpxxABNRNwd0dtvsL0Io9YGdPE+j7n7/7gw1ZjMAEXHyhrhh
         ftzBUY7DV7ZAmEFLPlt47K5xPKCUE82cIZjYHtq3FR3VZHTKjoHsRMf+Jj1HQhwO2ZI5
         N4tw==
X-Gm-Message-State: AOAM532AV4OmyligMJyrpJZUzRBq93qscCR6XDVl6UZnsn8A6Hvw/Bwc
        TZGXEXl1HqLw5TqrdSOi7rc=
X-Google-Smtp-Source: ABdhPJyp1iRdRXGjXSQYQ8aq2nHy2rqePv7OIRprbvI6E803s/RBg256y3FJyFh1SDYVx5DCOyPa/g==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr6948218wrd.362.1640420546535;
        Sat, 25 Dec 2021 00:22:26 -0800 (PST)
Received: from lesale.home (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id n41sm12365456wms.32.2021.12.25.00.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 00:22:26 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes Altmanninger <aclopte@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2] t/perf: do not run tests in user's $SHELL
Date:   Sat, 25 Dec 2021 09:16:58 +0100
Message-Id: <20211225081656.1311583-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <xmqqilvjugu0.fsf@gitster.g>
References: <xmqqilvjugu0.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The environment variable $SHELL is usually set to the user's
interactive shell. Our build and test scripts never use $SHELL because
there are no guarantees about its input language.  Instead, we use
/bin/sh which should be a POSIX shell.

For systems with a broken /bin/sh, we allow to override that path via
SHELL_PATH.  To run tests in yet another shell we allow to override
SHELL_PATH with TEST_SHELL_PATH.

Perf tests run in $SHELL via a wrapper defined in t/perf/perf-lib.sh,
so they break with e.g. SHELL=python.  Use TEST_SHELL_PATH like
in other tests.  TEST_SHELL_PATH is always defined because
t/perf/perf-lib.sh includes t/test-lib.sh, which includes
GIT-BUILD-OPTIONS.

Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I extended the commit message because in hindsight it was overly terse
(judging from both re-reading it and from review comments).

We could add more Acked-bys but one seems enough here.

range-diff to the first version:

    @@ Commit message
         t/perf: do not run tests in user's $SHELL
     
         The environment variable $SHELL is usually set to the user's
    -    interactive shell. We never use that shell for build and test scripts
    -    because it might not be a POSIX shell.
    +    interactive shell. Our build and test scripts never use $SHELL because
    +    there are no guarantees about its input language.  Instead, we use
    +    /bin/sh which should be a POSIX shell.
     
    -    Perf tests are run inside $SHELL via a wrapper defined in
    -    t/perf/perf-lib.sh. Use $TEST_SHELL_PATH like elsewhere.
    +    For systems with a broken /bin/sh, we allow to override that path via
    +    SHELL_PATH.  To run tests in yet another shell we allow to override
    +    SHELL_PATH with TEST_SHELL_PATH.
    +
    +    Perf tests run in $SHELL via a wrapper defined in t/perf/perf-lib.sh,
    +    so they break with e.g. SHELL=python.  Use TEST_SHELL_PATH like
    +    in other tests.  TEST_SHELL_PATH is always defined because
    +    t/perf/perf-lib.sh includes t/test-lib.sh, which includes
    +    GIT-BUILD-OPTIONS.
    +
    +    Acked-by: Jeff King <peff@peff.net>

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 780a7402d5..407252bac7 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -161,7 +161,7 @@ test_run_perf_ () {
 	test_cleanup=:
 	test_export_="test_cleanup"
 	export test_cleanup test_export_
-	"$GTIME" -f "%E %U %S" -o test_time.$i "$SHELL" -c '
+	"$GTIME" -f "%E %U %S" -o test_time.$i "$TEST_SHELL_PATH" -c '
 . '"$TEST_DIRECTORY"/test-lib-functions.sh'
 test_export () {
 	test_export_="$test_export_ $*"
-- 
2.34.1

