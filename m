Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19613207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 16:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbdDZQhB (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 12:37:01 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:32955 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752242AbdDZQgy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 12:36:54 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wCm1v5kbgz5tlD;
        Wed, 26 Apr 2017 18:36:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D815642BE;
        Wed, 26 Apr 2017 18:36:50 +0200 (CEST)
Subject: Re: [PATCH v5 8/8] Use uintmax_t for timestamps
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1492771484.git.johannes.schindelin@gmx.de>
 <cover.1493042239.git.johannes.schindelin@gmx.de>
 <50b62ed69c3239c076c28c5048bbd07396a25c5c.1493042239.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <02b74d66-97e6-c633-888a-0c6a628cc5bd@kdbg.org>
Date:   Wed, 26 Apr 2017 18:36:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <50b62ed69c3239c076c28c5048bbd07396a25c5c.1493042239.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.2017 um 15:58 schrieb Johannes Schindelin:
>  #define PRIo32 "o"
>  #endif
>  
> -typedef unsigned long timestamp_t;
> -#define PRItime "lu"
> -#define parse_timestamp strtoul
> +typedef uintmax_t timestamp_t;
> +#define PRItime PRIuMAX
> +#define parse_timestamp strtoumax
> +#ifdef ULLONG_MAX
> +#define TIME_MAX ULLONG_MAX
> +#else
>  #define TIME_MAX ULONG_MAX
> +#endif
>  
>  #ifndef PATH_SEP
>  #define PATH_SEP ':'
> 

I think you should squash in this:

diff --git a/git-compat-util.h b/git-compat-util.h
index 26d2643667..b5f4a7bb2f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -322,11 +322,7 @@ extern char *gitdirname(char *);
 typedef uintmax_t timestamp_t;
 #define PRItime PRIuMAX
 #define parse_timestamp strtoumax
-#ifdef ULLONG_MAX
-#define TIME_MAX ULLONG_MAX
-#else
-#define TIME_MAX ULONG_MAX
-#endif
+#define TIME_MAX UINTMAX_MAX
 
 #ifndef PATH_SEP
 #define PATH_SEP ':'

UINTMAX_MAX is already used git-compat-util.h

-- Hannes

