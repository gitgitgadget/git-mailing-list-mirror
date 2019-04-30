Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964ED1F45F
	for <e@80x24.org>; Tue, 30 Apr 2019 06:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfD3G03 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 02:26:29 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:18587 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfD3G03 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 02:26:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44tWkq0Zxxz5tlT;
        Tue, 30 Apr 2019 08:26:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A95534212;
        Tue, 30 Apr 2019 08:26:26 +0200 (CEST)
Subject: Re: [PATCH 2/2] mingw: enable DEP and ASLR
Cc:     =?UTF-8?Q?=c4=b0smail_D=c3=b6nmez_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <pull.134.git.gitgitgadget@gmail.com>
 <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com>
To:     =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@i10z.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8e59dbf6-a339-74f3-4e60-e56b3817aea5@kdbg.org>
Date:   Tue, 30 Apr 2019 08:26:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[had to add Dscho as recipient manually, mind you]

Am 29.04.19 um 23:56 schrieb İsmail Dönmez via GitGitGadget:
> From: =?UTF-8?q?=C4=B0smail=20D=C3=B6nmez?= <ismail@i10z.com>
> 
> Enable DEP (Data Execution Prevention) and ASLR (Address Space Layout
> Randomization) support. This applies to both 32bit and 64bit builds
> and makes it substantially harder to exploit security holes in Git by
> offering a much more unpredictable attack surface.
> 
> ASLR interferes with GDB's ability to set breakpoints. A similar issue
> holds true when compiling with -O2 (in which case single-stepping is
> messed up because GDB cannot map the code back to the original source
> code properly). Therefore we simply enable ASLR only when an
> optimization flag is present in the CFLAGS, using it as an indicator
> that the developer does not want to debug in GDB anyway.
> 
> Signed-off-by: İsmail Dönmez <ismail@i10z.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.mak.uname | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/config.mak.uname b/config.mak.uname
> index e7c7d14e5f..a9edcc5f0b 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -570,6 +570,12 @@ else
>  	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
>  		# MSys2
>  		prefix = /usr/
> +		# Enable DEP
> +		BASIC_LDFLAGS += -Wl,--nxcompat
> +		# Enable ASLR (unless debugging)
> +		ifneq (,$(findstring -O,$(CFLAGS)))
> +			BASIC_LDFLAGS += -Wl,--dynamicbase
> +		endif
>  		ifeq (MINGW32,$(MSYSTEM))
>  			prefix = /mingw32
>  			HOST_CPU = i686
> 

I'm a bit concerned that this breaks my debug sessions where I use -O0.
But I'll test without -O0 before I really complain.

-- Hannes
