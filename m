Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C3CC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 20:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347761AbiCKUIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 15:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiCKUIN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 15:08:13 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CD0FE432
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 12:07:09 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4KFcQy69HJz5tl9;
        Fri, 11 Mar 2022 21:07:06 +0100 (CET)
Message-ID: <16543315-8515-a4d7-d75b-e7fe9731a7cf@kdbg.org>
Date:   Fri, 11 Mar 2022 21:07:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6] userdiff: add builtin diff driver for kotlin language.
Content-Language: en-US
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220311072716.674808-1-jaydeepjd.8914@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
In-Reply-To: <20220311072716.674808-1-jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.03.22 um 08:27 schrieb Jaydeep P Das:
> The xfuncname pattern finds func/class declarations
> in diffs to display as a hunk header. The word_regex
> pattern finds individual tokens in Kotlin code to generate
> appropriate diffs.
> 
> This patch adds xfuncname regex and word_regex for Kotlin
> language.
> 
> Signed-off-by: Jaydeep P Das <jaydeepjd.8914@gmail.com>
> ---

Thank you. At first, I thought this round is it, but then I noticed this
line:

> +<RED>0xFF_EC_DE_5E 0b100_000 1<RESET><GREEN>0xFF_E1_DE_5E 0b100_100 2<RESET>00_000

Notice how the change from 100_000 to 200_000 breaks out the first digit
into its own token.

> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..c416c9b426 100644
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
> +	 "|[0-9][0-9_]*([.][0-9_]*)([Ee][-+]?[0-9]+)?[fFlLuU]*"

This line matches a non-empty digit sequence of any length, and I
thought the longest match would win. Why is that not the case here?
Frankly, I'm scratching my head over it. Any ideas?

> +	 /* floating point numbers beginning with decimal point */
> +	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
> +	 /* unary and binary operators */
> +	 "|[-+*/<>%&^|=!]==?|--|\\+\\+|<<=|>>=|&&|\\|\\||->|\\.\\*|!!|[?:.][.:]"),
>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

-- Hannes
