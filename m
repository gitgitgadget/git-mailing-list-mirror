Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849ED1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 20:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKFUjW (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 15:39:22 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:48917 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfKFUjV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 15:39:21 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 477dgB3NBzz5tlB;
        Wed,  6 Nov 2019 21:39:18 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2B18520A1;
        Wed,  6 Nov 2019 21:39:17 +0100 (CET)
Subject: Re: [PATCH v2] feat: add Elixir to supported userdiff languages
To:     =?UTF-8?Q?=c5=81ukasz_Niemier?= <lukasz@niemier.pl>
References: <20191106174844.23482-1-lukasz@niemier.pl>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <672bdea4-180a-89e0-c420-df2704ed887e@kdbg.org>
Date:   Wed, 6 Nov 2019 21:39:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106174844.23482-1-lukasz@niemier.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your contribution!

Am 06.11.19 um 18:48 schrieb Łukasz Niemier:
> ---

Please use "subsystem: short description" in the subject. For example:

   userdiff: support Elixir

would be sufficient in this case.

Please add your sign-off before the three-dash line so that we know that
you are entitled to publish this patch. See Documentation/SubmittingPatches.

It would be enlightening to know what Elixir is. (I haven't googled it,
yet.) If it were a popular language, I think I would have heard about
it. But it may well be possible that I have lived under a rock for too
long... ;)

> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 6f5ef0035e..194310377e 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -31,6 +31,7 @@ diffpatterns="
>  	cpp
>  	csharp
>  	css
> +	elixir
>  	dts
>  	fortran
>  	fountain

This list is sorted, basically, but your addition perturbates the order.

> diff --git a/t/t4018/elixir-function b/t/t4018/elixir-function
> new file mode 100644
> index 0000000000..d452f495a7
> --- /dev/null
> +++ b/t/t4018/elixir-function
> @@ -0,0 +1,5 @@
> +def function(RIGHT, arg) do
> +  # comment
> +  # comment
> +  ChangeMe
> +end
> diff --git a/t/t4018/elixir-module b/t/t4018/elixir-module
> new file mode 100644
> index 0000000000..91a4e7aa20
> --- /dev/null
> +++ b/t/t4018/elixir-module
> @@ -0,0 +1,9 @@
> +defmodule RIGHT do
> +  @moduledoc """
> +  Foo bar
> +  """
> +
> +  def ChangeMe(a) where is_map(a) do
> +    a
> +  end
> +end

The default hunk header pattern picks up lines that begin with a letter
without leading whitespace. The tests that you present here do not show
that the language specific hunk header pattern is better. The default
would have picked up the correct lines. And, in fact, when I remove the
pattern from the code, these tests still pass!

I'm not saying that the pattern is bad; I say that the tests do not show
its worthiness. More tests are needed. For example:

--- 8< ---
defmodule RIGHT do
end
#
#
# ChangeMe; do not pick up 'end' line
--- 8< ---

BTW, I guess that any def, defmodule, etc. as the first word on a line
in the docstring would be picked up incorrectly. Is that a problem?

> diff --git a/userdiff.c b/userdiff.c
> index e187d356f6..31fff34e1e 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -32,6 +32,13 @@ PATTERNS("dts",
>  	 /* Property names and math operators */
>  	 "[a-zA-Z0-9,._+?#-]+"
>  	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
> +PATTERNS("elixir",
> +	 "^[ \t]*((def(macro|module|impl|guard|protocol)?p?|test)[ \t].*)$",

Good. A test case that shows that indented def lines are picked up, if
that is the intent, would be appreciated.

> +	 "[a-zA-Z0-9_.]+"
> +	 "|:[a-zA-Z0-9@_]+"
> +	 "|:'a-zA-Z0-9@_]+'"

The opening bracket is missing here.

> +	 "|:\"[a-zA-Z0-9@_]+\""
> +	 "|@[a-zA-Z0-9_]+"),
Would it be an option to collapse all but the first pattern (because I
do not want to start the pattern with an optional part) to

	"[:@]['\"]?[a-zA-Z0-9@_]"

This assumes that @"x1 and @'y2 cannot occur in a syntactically valid
program. Remember: the patterns can be loose; they do not have to
validate the input, but can assume that it is syntactically valid.

Does the language not have any two-character operators, such as '<='?

>  IPATTERN("fortran",
>  	 "!^([C*]|[ \t]*!)\n"
>  	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
> 

-- Hannes
