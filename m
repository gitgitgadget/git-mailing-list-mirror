Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3081F404
	for <e@80x24.org>; Fri, 13 Apr 2018 16:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeDMQwg (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 12:52:36 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:7619 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753104AbeDMQwd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 12:52:33 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 40N3jT5jzPz5tlC;
        Fri, 13 Apr 2018 18:52:29 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F2772108;
        Fri, 13 Apr 2018 18:52:28 +0200 (CEST)
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Bug: rebase -i creates committer time inversions on 'reword'
Message-ID: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
Date:   Fri, 13 Apr 2018 18:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just noticed that all commits in a 70-commit branch have the same
committer timestamp. This is very unusual on Windows, where rebase -i of
such a long branch takes more than one second (but not more than 3 or
so thanks to the builtin nature of the command!).

And, in fact, if you mark some commits with 'reword' to delay the quick
processing of the patches, then the reworded commits have later time
stamps, but subsequent not reworded commits receive the earlier time
stamp. This is clearly not intended.

Perhaps something like this below is needed.

diff --git a/ident.c b/ident.c
index 327abe557f..2c6bff7b9d 100644
--- a/ident.c
+++ b/ident.c
@@ -178,8 +178,8 @@ const char *ident_default_email(void)
 
 static const char *ident_default_date(void)
 {
-	if (!git_default_date.len)
-		datestamp(&git_default_date);
+	strbuf_reset(&git_default_date);
+	datestamp(&git_default_date);
 	return git_default_date.buf;
 }
 

