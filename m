Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6575B1F461
	for <e@80x24.org>; Thu, 16 May 2019 20:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfEPU3I (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 16:29:08 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:12000 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfEPU3H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 16:29:07 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 454jgj432sz5tl9;
        Thu, 16 May 2019 22:29:05 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E5BCC20BA;
        Thu, 16 May 2019 22:29:04 +0200 (CEST)
Subject: Re: [PATCH] RFC: userdiff: add built-in pattern for rust
To:     marcandre.lureau@redhat.com
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>
References: <20190515183415.31383-1-marcandre.lureau@redhat.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c8b6e9c6-12a4-c6dd-bea9-7f07c8af7d15@kdbg.org>
Date:   Thu, 16 May 2019 22:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515183415.31383-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.05.19 um 20:34 schrieb marcandre.lureau@redhat.com:
> From: Marc-André Lureau <mlureau@redhat.com>
> 
> This adds xfuncname and word_regex patterns for Rust, a quite
> popular programming language. It also includes test cases for the
> xfuncname regex (t4018) and updated documentation.
> 
> The word_regex pattern finds identifiers, integers, floats and
> operators, according to the Rust Reference Book.
> 
> RFC: since I don't understand why when there are extra lines such as the
> one with FIXME, the funcname is not correctly reported. Help welcome!
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  Documentation/gitattributes.txt | 2 ++
>  t/t4018-diff-funcname.sh        | 1 +
>  t/t4018/rust-fn                 | 5 +++++
>  t/t4018/rust-struct             | 5 +++++
>  t/t4018/rust-trait              | 5 +++++

Nice to see tests!

> diff --git a/userdiff.c b/userdiff.c
> index 3a78fbf504..9e1e2fa03f 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -130,6 +130,15 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
>  	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
>  	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
> +PATTERNS("rust",
> +	 "^[\t ]*(((pub|pub\\([^)]+\\))[\t ]+)?(struct|enum|union|mod)[ \t].*)$\n"
> +	 "^[\t ]*(((pub|pub\\([^)]+\\))[\t ]+)?(unsafe[\t ]+)?trait[ \t].*)$\n"
> +	 "^[\t ]*(((pub|pub\\([^)]+\\))[\t ]+)?((const|unsafe|extern(([\t ]+)*\"[^)]+\")?)[\t ]+)*fn[ \t].*)$\n",

The last \n there is the reason for the test failures: it adds an empty
pattern that matches everywhere and does not capture any text.

Can we simplify these patterns as in

   ^
   space*
   ( pub ( "(" stuff ")" )? space* )?
   ( struct|enum|union|mod|unsafe|trait|const|extern|fn )
   stuff
   $

You don't have to check for a correct syntax rigorously because you can
assume that only correct Rust code will be passed to the patterns.

> +	 /* -- */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 "|[-+_0-9.eE]+(f32|f64|u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"

I assume that

       +e_1.ei8-e_2.eu128

is correct syntax, but not a single token. Yet, your number pattern
would take it as a single word.

> +	 "|0[box]?[0-9a-fA-F_]+(u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"

You should really subsume your number patterns under a single pattern
that requires an initial digit, because you can again assume that only
correct syntax will be shown to the patterns:

	"|[0-9][0-9_a-fA-Fuisxz]*([.][0-9]*([eE][+-]?[0-9]+)?)?"

(very likely, I have mistaken the meaning of f32 and f64 here).

> +	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
>  PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
>  	 "[={}\"]|[^={}\" \t]+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
> 
> base-commit: ab15ad1a3b4b04a29415aef8c9afa2f64fc194a2
> 

-- Hannes
