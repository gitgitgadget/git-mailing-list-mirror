Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08AEE1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 17:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKKR1b (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 12:27:31 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:21529 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfKKR1a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 12:27:30 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47Bd9V4zFXz5tlC;
        Mon, 11 Nov 2019 18:27:26 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 435E31C93;
        Mon, 11 Nov 2019 18:27:25 +0100 (CET)
Subject: Re: [PATCH] userdiff: support Python async functions
To:     Josh Holland <anowlcalledjosh@gmail.com>
References: <20191111010148.2812-1-anowlcalledjosh@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <f8a729c6-7b27-cac8-815e-b5c02a5c7b44@kdbg.org>
Date:   Mon, 11 Nov 2019 18:27:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191111010148.2812-1-anowlcalledjosh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.11.19 um 02:01 schrieb Josh Holland:
> Python's async functions (declared with "async def" rather than "def")
> were not being displayed in hunk headers. This commit teaches git about
> the async function syntax, and adds tests for the Python userdiff regex.
> 
> Signed-off-by: Josh Holland <anowlcalledjosh@gmail.com>
> ---
>  t/t4018/python-async-def | 4 ++++
>  t/t4018/python-class     | 4 ++++
>  t/t4018/python-def       | 4 ++++
>  userdiff.c               | 2 +-
>  4 files changed, 13 insertions(+), 1 deletion(-)
>  create mode 100644 t/t4018/python-async-def
>  create mode 100644 t/t4018/python-class
>  create mode 100644 t/t4018/python-def
> 
> diff --git a/t/t4018/python-async-def b/t/t4018/python-async-def
> new file mode 100644
> index 000000000..87640e03d
> --- /dev/null
> +++ b/t/t4018/python-async-def
> @@ -0,0 +1,4 @@
> +async def RIGHT(pi: int = 3.14):
> +    while True:
> +        break
> +    return ChangeMe()
> diff --git a/t/t4018/python-class b/t/t4018/python-class
> new file mode 100644
> index 000000000..ba9e74143
> --- /dev/null
> +++ b/t/t4018/python-class
> @@ -0,0 +1,4 @@
> +class RIGHT(int, str):
> +    # comment
> +    # another comment
> +    # ChangeMe
> diff --git a/t/t4018/python-def b/t/t4018/python-def
> new file mode 100644
> index 000000000..e50b31b0a
> --- /dev/null
> +++ b/t/t4018/python-def
> @@ -0,0 +1,4 @@
> +def RIGHT(pi: int = 3.14):
> +    while True:
> +        break
> +    return ChangeMe()

Thank you for providing test cases for Python.

I have one gripe with this set of test, though: They do not demonstrate
that the Python-specific pattern is better than the default pattern. In
fact, if you remove the Python patterns from userdiff.c, you will
observe that these tests still pass.

The one thing that the language specific pattern would do better than
the default is that it picks up indented text. Could we have a test case
or two that show that it indeed does?

> diff --git a/userdiff.c b/userdiff.c
> index e74a6d402..057fdcc55 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -124,7 +124,7 @@ PATTERNS("php",
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
>  	 "|[-+*/<>%&^|=!.]=|--|\\+\\+|<<=?|>>=?|===|&&|\\|\\||::|->"),
> -PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
> +PATTERNS("python", "^[ \t]*((class|(async[ \t]+)?def)[ \t].*)$",
>  	 /* -- */
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
> 

-- Hannes
