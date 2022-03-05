Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8D5C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 14:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiCEOSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 09:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiCEOSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 09:18:09 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5DD22F971
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 06:17:19 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4K9my52MnSz5tlC;
        Sat,  5 Mar 2022 15:17:17 +0100 (CET)
Message-ID: <4118762b-e2f1-4f77-68f3-e61cbe65aff7@kdbg.org>
Date:   Sat, 5 Mar 2022 15:17:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4] userdiff: add builtin diff driver for Kotlin language.
Content-Language: en-US
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220305094004.250570-1-jaydeepjd.8914@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
In-Reply-To: <20220305094004.250570-1-jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.03.22 um 10:40 schrieb Jaydeep P Das:
> +<RED>_32<RESET><GREEN>_33<RESET>.find(arr)
> +X<RED>.fill()<RESET><GREEN>.find()<RESET>
> +X<RED>.u<RESET><GREEN>.f<RESET>+1
> +X.u<RED>-<RESET><GREEN>+<RESET>2

Nice move to include these new tests!

> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..24821a0f69 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -168,6 +168,18 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("kotlin",
> +	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
> +	 /* -- */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 /* hexadecimal and binary numbers */
> +	 "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
> +	 /* integers and floats */
> +	 "|[0-9][0-9_.]*([Ee][-+]?[0-9]+)?[fFlL]*"

Good!

> +	 /* method calls */
> +	 "|[.][a-zA-Z()0-9]+"

This matches both .empty() as well as .125, but only the .5e part of
.5e-3 and only the .find(x part of .find(x/2). Is that intended?

I find the desire to have method calls as an entire token a bit strange.
In other languages, the last expression part is actually split into many
tokens: . find ( x / 2 ).

BTW, I'm in no way saying that this must be changed (personally I do not
care at all as I'm not writing Kotlin), so if you say that is how people
want Kotlin code to be split with --word-diff, I will believe you.

> +	 /* unary and binary operators */
> +	 "|[-+*/<>%&^|=!]?=(=)?|--|\\+\\+|<<?=?|>>?=?|&&?|[|]?\\||\\|->\\*?|\\.\\*"),

Is the part

	 "|\\|->\\*?|"

actually meant to be something else? Does Kotlin have the tokens "|->"
and "|->*"?

A final minor nit: There is "|&&?|[|]?\\||" that could just be
"|&&|\\|\\||" (remember: single character operators are matched implicitly).

>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

-- Hannes
