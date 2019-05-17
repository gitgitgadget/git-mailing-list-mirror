Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3FED1F4B6
	for <e@80x24.org>; Fri, 17 May 2019 06:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfEQG0j (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 02:26:39 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:37648 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfEQG0j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 02:26:39 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 454yx90GYVz5tlD;
        Fri, 17 May 2019 08:26:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E2CCF20BA;
        Fri, 17 May 2019 08:26:35 +0200 (CEST)
Subject: Re: [PATCH v2] userdiff: add built-in pattern for rust
To:     =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>
Cc:     git@vger.kernel.org
References: <20190516235815.13886-1-marcandre.lureau@redhat.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1bc4ff0c-4283-a7ff-311f-6415e71bce92@kdbg.org>
Date:   Fri, 17 May 2019 08:26:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516235815.13886-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.05.19 um 01:58 schrieb marcandre.lureau@redhat.com:
> From: Marc-André Lureau <mlureau@redhat.com>
> 
> This adds xfuncname and word_regex patterns for Rust, a quite
> popular programming language. It also includes test cases for the
> xfuncname regex (t4018) and updated documentation.
> 
> The word_regex pattern finds identifiers, integers, floats and
> operators, according to the Rust Reference Book.
> 
> Cc: Johannes Sixt <j6t@kdbg.org>

In this code base, Cc: footers are disliked.

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

> diff --git a/t/t4018/rust-trait b/t/t4018/rust-trait
> new file mode 100644
> index 0000000000..ea397f09ed
> --- /dev/null
> +++ b/t/t4018/rust-trait
> @@ -0,0 +1,5 @@
> +unsafe trait RIGHT<T> {
> +    fn len(&self) -> u32;
> +    fn ChangeMe(&self, n: u32) -> T;
> +    fn iter<F>(&self, f: F) where F: Fn(T);
> +}

You mentioned that 'unsafe' is commonly used for blocks, and these cases
should not be picked up. Can we have a test case that demonstrates that
this is indeed the case?

> diff --git a/userdiff.c b/userdiff.c
> index 3a78fbf504..8d7e62e2a5 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -130,6 +130,13 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
>  	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
>  	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
> +PATTERNS("rust",
> +	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl(<.+>)?)[ \t]+[^;]*)$",
> +	 /* -- */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 "|[-+_0-9.eE]+(f32|f64|u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"

This pattern did not change. Doesn't it still mark "+e_1.e_8-e_2.eu128"
as a single word?

> +	 "|0[box]?[0-9a-fA-F_]+(u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"

I still think that you should reduce the complexity of these patterns.
They do not have to be restrictive to dismiss wrong syntax, just liberal
enough to catch correct syntax. Let me try again:

	"|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"

> +	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::")
-- Hannes
