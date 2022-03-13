Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098F4C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 21:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiCMV4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 17:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiCMV4I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 17:56:08 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5BA15A16
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 14:54:59 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4KGtkT505pz5tl9;
        Sun, 13 Mar 2022 22:54:57 +0100 (CET)
Message-ID: <21ca0635-8a70-14ff-6dbc-213eeba85750@kdbg.org>
Date:   Sun, 13 Mar 2022 22:54:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [GSoC][PATCH v2] Add a diff driver for JavaScript languages.
Content-Language: en-US
To:     xing zhi jiang <a97410985new@gmail.com>
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220312164803.57909-1-a97410985new@gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220312164803.57909-1-a97410985new@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you send a new iteration of a patch or patch set, it is customary
on this list to include everyone who took part in the earlier rounds in
the Cc: list.

Am 12.03.22 um 17:48 schrieb xing zhi jiang:
> In the xfunction part that matches normal functions,
> a variable declaration with an assignment of function, the function declaration
> in the class, and also the function is object literal's property[1].
> 
> And in the word regex part, that matches numbers, punctuations, and also the
> JavaScript identifier.
> This part reference the formal ECMA specification[2].
> 
> [1]https://github.com/jquery/jquery/blob/de5398a6ad088dc006b46c6a870a2a053f4cd663/src/core.js#L201
> [2]https://262.ecma-international.org/12.0/#sec-ecmascript-language-lexical-grammar
> 
> Signed-off-by: xing zhi jiang <a97410985new@gmail.com>
> ---

> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..51bfe4021d 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -168,6 +168,38 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +
> +PATTERNS("javascript",
> +	 /* don't match the expression may contain parenthesis, because it is not a function declaration */
> +	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
> +	 /* don't match statement */
> +	 "!;\n"
> +	 /* match normal function */
> +	 "^((export[\t ]+)?(async[\t ]+)?function[\t ]*[\t *]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"
> +	 /* match JavaScript variable declaration with a lambda expression */
> +	 "^[\t ]*((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
> +	 "(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>[\t ]*\\{?)\n"

It would help readability if this second line of this regex were
indented because it is a continuation of the first line.

> +	 /* match exports for anonymous fucntion */
> +	 "^(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
> +	 /* match assign function to LHS */
> +	 "^(.*=[\t ]*function[\t ]*([$_[:alpha:]][$_[:alnum:]]*)?[\t ]*\\(.*)\n"

This should be written as

	 "^(.*=[\t ]*function[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*)?\\(.*)\n"

Notice that the whitespace after the identifier can only appear when
there is actually an identifier. The point is to reduce the different
matches permitted by the sub-expression "[\t ]*[\t ]*" when there is no
identifier in the text.

Can the keyword function ever be followed by a number? I guess not. Then
[$_[:alpha:]][$_[:alnum:]]* could be reduced to [$_[:alnum:]]+

> +	 /* match normal function in object literal */
> +	 "^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function[\t ].*)\n"
> +	 /* don't match the function in class, which has more than one ident level */
> +	 "!^(\t{2,}|[ ]{5,})\n"
> +	 /* match function in class */
> +	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)",> +	 /* word regex */
> +	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, DecimalLiteral and its big version */
> +	 "(0[xXoObB])?[0-9a-fA-F][_0-9a-fA-F]*n?"
> +	 /* DecimalLiteral may be float */
> +	 "|(0|[1-9][_0-9]*)?\\.?[0-9][_0-9]*([eE][+-]?[_0-9]+)?"

Having alternatives that begin with an optional part make the regex
evaluation comparatively inefficient. In particular, both alternatives
above match a decimal integer. I suggest to have the first alternative
only for hex, octal, and binary integers, and the second for all decimal
numbers including floatingpoint:

	 /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, and
their big versions */
	 "0[xXoObB][_0-9a-fA-F]+n?"
	 /* DecimalLiteral may be float */
	 "|[0-9][_0-9]*(\\.[_0-9]*|n)?([eE][+-]?[_0-9]+)?"

and if floating point literals can begin with a decimal point, then we
also need

	 "|\\.[0-9][_0-9]*([eE][+-]?[_0-9]+)?"

> +	 /* punctuations */
> +	 "|\\.{3}|<=|>=|==|!=|={3}|!==|\\*{2}|\\+{2}|--|<<|>>"
> +	 "|>>>|&&|\\|{2}|\\?{2}|\\+=|-=|\\*=|%=|\\*{2}="
> +	 "|<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"
> +	 /* identifiers */
> +	 "|[$_[:alpha:]][$_[:alnum:]]*"),
>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

-- Hannes
