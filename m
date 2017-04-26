Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D483207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 16:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932405AbdDZQn4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 12:43:56 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:31458 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932371AbdDZQnw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 12:43:52 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wCm9y67sLz5tlG;
        Wed, 26 Apr 2017 18:43:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7FED742BE;
        Wed, 26 Apr 2017 18:43:50 +0200 (CEST)
Subject: Re: [PATCH v5 6/8] Introduce a new data type for timestamps
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1492771484.git.johannes.schindelin@gmx.de>
 <cover.1493042239.git.johannes.schindelin@gmx.de>
 <fea2df0e1ff5869572cf756d75fd3468d184457f.1493042239.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c6bcc382-f526-cf0c-8181-3985216e6c2b@kdbg.org>
Date:   Wed, 26 Apr 2017 18:43:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <fea2df0e1ff5869572cf756d75fd3468d184457f.1493042239.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.2017 um 15:58 schrieb Johannes Schindelin:
> diff --git a/archive-tar.c b/archive-tar.c
> index 380e3aedd23..695339a2369 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -27,9 +27,12 @@ static int write_tar_filter_archive(const struct archiver *ar,
>   */
>  #if ULONG_MAX == 0xFFFFFFFF
>  #define USTAR_MAX_SIZE ULONG_MAX
> -#define USTAR_MAX_MTIME ULONG_MAX
>  #else
>  #define USTAR_MAX_SIZE 077777777777UL
> +#endif

This part of the hunk is fine: if ULONG_MAX is not 2^32-1, then 2^33-1
will fit in a long.

> +#if TIME_MAX == 0xFFFFFFFF
> +#define USTAR_MAX_MTIME TIME_MAX
> +#else
>  #define USTAR_MAX_MTIME 077777777777UL
>  #endif

But this is not: just because TIME_MAX is not 32 bits, does not mean that
long is also more than 32 bits. We need this:

diff --git a/archive-tar.c b/archive-tar.c
index aadd5865f6..b5d6ce27d3 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -33,7 +33,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 #if TIME_MAX == 0xFFFFFFFF
 #define USTAR_MAX_MTIME TIME_MAX
 #else
-#define USTAR_MAX_MTIME 077777777777UL
+#define USTAR_MAX_MTIME 077777777777ULL
 #endif
 
 /* writes out the whole block, but only if it is full */

