Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8AD20954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbdLDXtw (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:49:52 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:56063 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751846AbdLDXtv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:49:51 -0500
Received: from desky.robertabel.eu (x4d077b3a.dyn.telefonica.de [77.7.123.58])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 875BB14080D;
        Tue,  5 Dec 2017 00:49:50 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.123.58) smtp.mailfrom=rabel@robertabel.eu smtp.helo=desky.robertabel.eu
Received-SPF: pass (mxf98a: connection is authenticated)
From:   Robert Abel <rabel@robertabel.eu>
To:     git@vger.kernel.org
Cc:     Robert Abel <rabel@robertabel.eu>
Subject: [PATCH v3 2/2] git-prompt: fix reading files with windows line endings
Date:   Tue,  5 Dec 2017 00:49:23 +0100
Message-Id: <20171204234923.9600-2-rabel@robertabel.eu>
X-Mailer: git-send-email 2.13.0.windows.1
In-Reply-To: <20171204234923.9600-1-rabel@robertabel.eu>
References: <20171201233133.30011-1-rabel@robertabel.eu>
 <20171204234923.9600-1-rabel@robertabel.eu>
X-PPP-Message-ID: <20171204234950.18564.95626@mxf98a.netcup.net>
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

This patch fixes the issue by setting the IFS to $'\r\n' for the read
operation. Note that ANSI-C Quoting ($'...') is supported by bash as
well as zsh, which are the current targets of git-prompt.sh, cf.
<20171130010811.17369-1-szeder.dev@gmail.com>.

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

