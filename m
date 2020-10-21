Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C500C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 07:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8EC221FC
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 07:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436982AbgJUHHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 03:07:19 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:49909 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391394AbgJUHHT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 03:07:19 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4CGM4f5jk2z5tlC;
        Wed, 21 Oct 2020 09:07:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2042720FA;
        Wed, 21 Oct 2020 09:07:12 +0200 (CEST)
Subject: Re: [PATCH v2] userdiff: support Bash
To:     Victor Engmark <victor@engmark.name>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <373640ea4d95f3b279b9d460d9a8889b4030b4e9.camel@engmark.name>
 <xmqqk0vk8o20.fsf@gitster.c.googlers.com>
 <1442e85cfbe70665890a79a5054ee07c9c16b7c6.camel@engmark.name>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a07042af-d16c-1975-c0d1-f22f4fec5827@kdbg.org>
Date:   Wed, 21 Oct 2020 09:07:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1442e85cfbe70665890a79a5054ee07c9c16b7c6.camel@engmark.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.10.20 um 05:00 schrieb Victor Engmark:
> Supports POSIX, bashism and mixed function declarations, all four compound
> command types, trailing comments and mixed whitespace.
> 
> Uses the POSIX.1-2017 definition of allowed characters in names
> <https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_235>
> since actual allowed characters in Bash function names are locale
> dependent <https://unix.stackexchange.com/a/245336/3645>.

So, this is more like

   Even though bash allows locale-dependet characters in function names,
   only the allowed characters per the POSIX.1-2017 definition are
   implemented for simplicity. We can expect that this catches the vast
   majority of use-cases.

> 
> Uses the default `IFS` characters to define words.

We could do better than this, I think. At a minimum, the equal sign,
single quote, double quote, parentheses, and braces should also
delineate words. $(, ${, $((, ((, )), [[, ]], should be words. I would
exclude single brackets because they could only occur in globs, IIRC,
and they need not be broken into words at brackets. $var should be a
single word, IMO.

That said, this can be presented as a patch on top of this one.

> 
> Adds testing functionality to verify non-matches by including the
> literal string "non-match" somewhere in the test file. To verify that
> only the matching files are syntactically valid:
> 
> for file in t/t4018/bash*
> do
>     echo "$file"
>     if grep non-match "$file"
>     then
>         . "$file" && echo FAILED
>     else
>         . "$file" || echo FAILED
>     fi
> done 2>/dev/null | grep FAILED

This complication is not necessary. See below for an example how to do
negative tests.

While speaking of that: it is very refreshing to see negative tests!

> 
> Signed-off-by: Victor Engmark <victor@engmark.name>
> ---

When you write a commit message, please always answer the question WHY
the change should be made. For example, the notice "use IFS characters"
alone does not add value; that much can be seen in the patch text. How
about:

   Since a word pattern has to be specified, but there is no easy way
   to request the default word pattern, use the standard IFS characters
   for a starter. A later patch can improve this.

In general, a justification of why something should be added, should
also be answered. But in the case of "bash pattern for userdiff" the
answer is too obvious and trivial, that an exception is warranted.

Please write the commit message in imperative mood. "Support" instead of
"Supports", etc.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 2d0a03715b..8a15ff6bdf 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -802,6 +802,8 @@ patterns are available:
>  
>  - `ada` suitable for source code in the Ada language.
>  
> +- `bash` suitable for source code in the Bourne-Again SHell language.

Can we mention POSIX shell language as well?

> diff --git a/t/t4018/bash-missing-parentheses b/t/t4018/bash-missing-parentheses
> new file mode 100644
> index 0000000000..d112761300
> --- /dev/null
> +++ b/t/t4018/bash-missing-parentheses
> @@ -0,0 +1,4 @@
> +functionRIGHT { # non-match
> +    :
> +    echo 'ChangeMe'
> +}

To check for a non-match, you write the test like this:

	function RIGHT () {
	}
	# the following must not be picked up:
	functionWrong {
		:
		ChangeMe
	}

That is, you present a positive match, and then expect that the
subsequent negative match is not picked up.

> diff --git a/t/t4018/bash-posix-style-compact b/t/t4018/bash-posix-style-compact
> new file mode 100644
> index 0000000000..045bd2029b
> --- /dev/null
> +++ b/t/t4018/bash-posix-style-compact
> @@ -0,0 +1,4 @@
> +RIGHT(){
> +
> +    ChangeMe
> +}
> diff --git a/t/t4018/bash-posix-style-function b/t/t4018/bash-posix-style-function
> new file mode 100644
> index 0000000000..a4d144856e
> --- /dev/null
> +++ b/t/t4018/bash-posix-style-function
> @@ -0,0 +1,4 @@
> +RIGHT() {
> +
> +    ChangeMe
> +}
> diff --git a/t/t4018/bash-posix-style-whitespace b/t/t4018/bash-posix-style-whitespace
> new file mode 100644
> index 0000000000..4d984f0aa4
> --- /dev/null
> +++ b/t/t4018/bash-posix-style-whitespace
> @@ -0,0 +1,4 @@
> +	 RIGHT 	( 	) 	{
> +
> +	    ChangeMe
> +	 }

Good to see POSIX-style function tests.

> diff --git a/userdiff.c b/userdiff.c
> index fde02f225b..8830019f05 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -23,6 +23,28 @@ IPATTERN("ada",
>  	 "[a-zA-Z][a-zA-Z0-9_]*"
>  	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
>  	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
> +PATTERNS("bash",
> +	 /* Optional leading indentation */
> +	 "^[ \t]*"
> +	 /* Start of function definition */
> +	 "("

The purpose of this outer-most pair of parentheses is actually to mark
the captured text, not so much "the function definition".

> +	 /* Start of POSIX/Bashism grouping */
> +	 "("

You could omit the comment if you indent the parts that are inside the
parentheses:

	"("
		"..."
	"|"
		"..."
	")"

(But perhaps don't indent between the outer-most parentheses; it would
get us too far to the right. But judge yourself.)

> +	 /* POSIX identifier with mandatory parentheses */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
> +	 /* Bashism identifier with optional parentheses */
> +	 "|(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
> +	 /* End of POSIX/Bashism grouping */
> +	 ")"
> +	 /* Optional whitespace */
> +	 "[ \t]*"
> +	 /* Compound command starting with `{`, `(`, `((` or `[[` */
> +	 "(\\{|\\(\\(?|\\[\\[)"
> +	 /* End of function definition */
> +	 ")",
> +	 /* -- */
> +	 /* Characters not in the default $IFS value */
> +	 "[^ \t]+"),
