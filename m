Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA31520A40
	for <e@80x24.org>; Tue,  5 Dec 2017 23:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbdLEXjj (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 18:39:39 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:33812 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbdLEXjj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 18:39:39 -0500
Received: from desky.robertabel.eu (x4d075e6a.dyn.telefonica.de [77.7.94.106])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 3E9A2140CB2;
        Wed,  6 Dec 2017 00:39:38 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.94.106) smtp.mailfrom=rabel@robertabel.eu smtp.helo=desky.robertabel.eu
Received-SPF: pass (mxf98a: connection is authenticated)
From:   Robert Abel <rabel@robertabel.eu>
To:     git@vger.kernel.org
Cc:     Robert Abel <rabel@robertabel.eu>
Subject: [PATCH v4 2/2] git-prompt: fix reading files with windows line endings
Date:   Wed,  6 Dec 2017 00:39:12 +0100
Message-Id: <20171205233912.5824-2-rabel@robertabel.eu>
X-Mailer: git-send-email 2.13.0.windows.1
In-Reply-To: <20171205233912.5824-1-rabel@robertabel.eu>
References: <23f95ab7-4ece-5252-5bae-16eec8f34824@robertabel.eu>
 <20171205233912.5824-1-rabel@robertabel.eu>
X-PPP-Message-ID: <20171205233938.14449.56072@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If any of the files read by __git_eread have \r\n line endings, read
will only strip \n, leaving \r. This results in an ugly prompt, where
instead of

    user@pc MINGW64 /path/to/repo (BARE:master)

the last parenthesis is printed over the beginning of the prompt like

    )ser@pc MINGW64 /path/to/repo (BARE:master

This patch fixes the issue by changing the internal field separator
variable IFS to $'\r\n' before using the read builtin command.

Note that ANSI-C Quoting/POSIX Quoting ($'...') is supported by bash
as well as zsh, which are the current targets of git-prompt, cf.
contrib/completion/git-prompt.sh.

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 41a471957a..983e419d2b 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -283,7 +283,7 @@ __git_ps1_colorize_gitstring ()
 # variable, in that order.
 __git_eread ()
 {
-	test -r "$1" && read "$2" <"$1"
+	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
 }
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
-- 
2.13.0.windows.1

