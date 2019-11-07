Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C9661F454
	for <e@80x24.org>; Thu,  7 Nov 2019 20:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfKGUfF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 15:35:05 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:29628 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfKGUfF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 15:35:05 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 478FWq0vn9z5tl9;
        Thu,  7 Nov 2019 21:35:02 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 21C2D2204;
        Thu,  7 Nov 2019 21:35:01 +0100 (CET)
Subject: Re: [PATCH v3] userdiff: add Elixir to supported userdiff languages
To:     =?UTF-8?Q?=c5=81ukasz_Niemier?= <lukasz@niemier.pl>
References: <20191106234941.48926-1-lukasz@niemier.pl>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f85a5c31-52ff-85be-b1e0-f3982fd2a7f2@kdbg.org>
Date:   Thu, 7 Nov 2019 21:35:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106234941.48926-1-lukasz@niemier.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please keep the Cc list when you send new patch versions. Also, it is
customary to send them as replies to the earlier iterations, so that
they all end up in the same thread.

Am 07.11.19 um 00:49 schrieb Łukasz Niemier:
> Adds support for xfuncref in Elixir[1] language which is Ruby-like
> language that runs on Erlang[3] Virtual Machine (BEAM).
> 
> [1]: https://elixir-lang.org
> [2]: https://www.erlang.org

Thanks! Much appreciated.

> 
> Signed-off-by: Łukasz Niemier <lukasz@niemier.pl>
> ---

> diff --git a/t/t4018/elixir-do-not-pick-end b/t/t4018/elixir-do-not-pick-end
> new file mode 100644
> index 0000000000..fae08ba7e8
> --- /dev/null
> +++ b/t/t4018/elixir-do-not-pick-end
> @@ -0,0 +1,5 @@
> +defmodule RIGHT do
> +end
> +#
> +#
> +# ChangeMe; do not pick up 'end' line

OK.

> diff --git a/t/t4018/elixir-ex-unit-test b/t/t4018/elixir-ex-unit-test
> new file mode 100644
> index 0000000000..0560a2b697
> --- /dev/null
> +++ b/t/t4018/elixir-ex-unit-test
> @@ -0,0 +1,6 @@
> +defmodule Test do
> +  test "RIGHT" do
> +    assert true == true
> +    assert ChangeMe
> +  end
> +end

A test, and also indented. Good.

> diff --git a/t/t4018/elixir-module-func b/t/t4018/elixir-module-func
> new file mode 100644
> index 0000000000..c9910d0675
> --- /dev/null
> +++ b/t/t4018/elixir-module-func
> @@ -0,0 +1,8 @@
> +defmodule Foo do
> +  def fun(RIGHT) do
> +     # Code
> +     # Code
> +     # Code
> +     ChangeMe
> +  end
> +end

An indented function. Good.

These other tests (which I stripped away) ensure that the hunk header
pattern does not become too restrictive. They all look good.

> diff --git a/userdiff.c b/userdiff.c
> index e187d356f6..577053c10a 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -32,6 +32,18 @@ PATTERNS("dts",
>  	 /* Property names and math operators */
>  	 "[a-zA-Z0-9,._+?#-]+"
>  	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
> +PATTERNS("elixir",
> +	 "^[ \t]*((def(macro|module|impl|protocol|p)?|test)[ \t].*)$",
> +	 /* Atoms, names, and module attributes */
> +	 "|[@:]?[a-zA-Z0-9@_?!]+"

There are no single- and double-quote anymore. An oversight? Or an error
in the earlier iteration?

> +	 /* Numbers with specific base */
> +	 "|[-+]?0[xob][0-9a-fA-F]+"
> +	 /* Numbers */
> +	 "|[-+]?[0-9][0-9_.]*([eE][-+]?[0-9_]+)?"

The leading optional sign may be problematic. When a patch changes "i+1"
to "i+2", it would be highlighted as "i{-+1-}{++2+}" instead of as
"i+{-1-}{+2+}". You could remove the leading optional sign and let it be
processed as an operator. But we also have an optional sign in the cpp
pattern as well, and haven't noticed it until now, so...

> +	 /* Operators and atoms that represent them */
> +	 "|:?(\\+\\+|--|\\.\\.|~~~|<>|\\^\\^\\^|<?\\|>|<<<?|>?>>|<<?~|~>?>|<~>|<=|>=|===?|!==?|=~|&&&?|\\|\\|\\|?|=>|<-|\\\\\\\\|->)"
> +	 /* Not real operators, but should be grouped */
> +	 "|:?%[A-Za-z0-9_.]\\{\\}?"),
>  IPATTERN("fortran",
>  	 "!^([C*]|[ \t]*!)\n"
>  	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
> 

In summary, this version looks good!

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
