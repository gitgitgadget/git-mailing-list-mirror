Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1C71FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 08:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbdDKIdg (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 04:33:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36793 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbdDKIdf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 04:33:35 -0400
Received: by mail-wr0-f193.google.com with SMTP id o21so27022387wrb.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m1SWiqS/FpsKi0Hru1bOUOr9DxV2qwSx+X8T1WByxew=;
        b=ZGzQKl/oj7ikqaAvNLjE1ZcVV1xaCocKkCPa5cwGoSVfg41/NjNklApz9zDUzYo2q9
         51WToN9b7vjI79pYuYLpyMXWTkthe65jRIQQwNnsWduMpXpdciNz//Re2CLphdc8aPkr
         f3tah8uIQofLqZWjrD/RHFK2f8JV0lhZwlTHt8/9SVCXlTjfDSNkga5mgZ7HywV2hXHJ
         IvDUiwu0Bmxh+BnOILbpvAUNi3rDYbk+ItU2BhXil1Ov+iWWGvty4jo4j3KC8JzZRaJv
         tRCh8t/zGKJdLnSzFytpxNSLPeDNzzyVGapboWSn6fhgYHVpEVOTf6gQrHWNL2yH2J/l
         8spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m1SWiqS/FpsKi0Hru1bOUOr9DxV2qwSx+X8T1WByxew=;
        b=Yf0BaxXJHvmlWsmvPw3CmOHzZhVBEnBpqjmD6UuP/Ch3XbmVLrOoEKZD8wPqZB8olR
         3OcfDzpNo/3hIA3hQFGlg65Ozvgeu8bTrmmesfGfEUJO4Tpf2wL9Ka1+TRkCVYkaZOzS
         YqKmCBcREsWgigYRpj+mv6JRACRiHnwBnC+nYH63mlBa9sYuLzqoxQr1ITggpTCqAUpK
         ZhtyOJn8tSwYmIoQlATIQyeQk8WNvA4wUCViqZ6il3v2AEYsCrPldIgqUgdTZv8LYtXX
         +KKAhJYLWW19fy0rKvYDXD9Ug4xqruDEJXZuasouO9KRrvInlAluaxbAXjNyjM7B1skH
         sHrA==
X-Gm-Message-State: AN3rC/6QwxQC0m0gEpo4NPDQjnB/iNqT0cRf8dTZ+hZqy1SEI/I17BKSnFx3fXHaFxDq9g==
X-Received: by 10.223.170.194 with SMTP id i2mr11203210wrc.44.1491899613835;
        Tue, 11 Apr 2017 01:33:33 -0700 (PDT)
Received: from localhost.localdomain (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id d17sm1499083wmi.21.2017.04.11.01.33.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 01:33:33 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net
Subject: [PATCH v1 2/3] travis-ci: parallelize documentation build
Date:   Tue, 11 Apr 2017 10:33:08 +0200
Message-Id: <20170411083309.58315-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170411083309.58315-1-larsxschneider@gmail.com>
References: <20170411083309.58315-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation job without parallelization takes ~10min on TravisCI.
With parallelization ("--jobs=2") it takes ~6min.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 ci/test-documentation.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index e47d2ea611..81f123e68d 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -9,7 +9,7 @@ make check-builtins
 make check-docs
 
 # Build docs with AsciiDoc
-make doc
+make --jobs=2 doc
 test -s Documentation/git.html
 test -s Documentation/git.xml
 test -s Documentation/git.1
@@ -17,6 +17,6 @@ grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
 
 # Build docs with AsciiDoctor
 make clean
-make doc USE_ASCIIDOCTOR=1
+make --jobs=2 doc USE_ASCIIDOCTOR=1
 test -s Documentation/git.html
 grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
-- 
2.12.2

