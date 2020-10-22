Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D31C388F2
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 06:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A402245F
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 06:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503275AbgJVGIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 02:08:34 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:2777 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390174AbgJVGIe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 02:08:34 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4CGxkR08Rhz5tlF;
        Thu, 22 Oct 2020 08:08:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 082002100;
        Thu, 22 Oct 2020 08:08:30 +0200 (CEST)
Subject: Re: [PATCH v3] userdiff: support Bash
To:     Victor Engmark <victor@engmark.name>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <a07042af-d16c-1975-c0d1-f22f4fec5827@kdbg.org>
 <6c6b5ed2166ec2c308c53bf87c78b422fdc5084f.camel@engmark.name>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0d9f9ad1-2ba7-567e-97a1-a96f0b7cd4be@kdbg.org>
Date:   Thu, 22 Oct 2020 08:08:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6c6b5ed2166ec2c308c53bf87c78b422fdc5084f.camel@engmark.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.10.20 um 01:45 schrieb Victor Engmark:
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 2d0a03715b..5e8a973449 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -802,6 +802,9 @@ patterns are available:
>  
>  - `ada` suitable for source code in the Ada language.
>  
> +- `bash` suitable for source code in the Bourne-Again SHell language.
> +  Covers a superset of POSIX function definitions.

OK. POSIX *shell* function definitions would have been even better, but
I think I can live with this version.

> diff --git a/t/t4018/bash-bashism-style-compact b/t/t4018/bash-bashism-style-compact
> new file mode 100644
> index 0000000000..1ca3126f61
> --- /dev/null
> +++ b/t/t4018/bash-bashism-style-compact
> @@ -0,0 +1,6 @@
> +function RIGHT {
> +    function InvalidSyntax{

Nicely done!

> +        :
> +        echo 'ChangeMe'
> +    }
> +}

> diff --git a/t/t4018/bash-nested-functions b/t/t4018/bash-nested-functions
> new file mode 100644
> index 0000000000..2c9237ead4
> --- /dev/null
> +++ b/t/t4018/bash-nested-functions
> @@ -0,0 +1,6 @@
> +outer() {
> +    RIGHT() {
> +        :
> +        echo 'ChangeMe'
> +    }
> +}

That's another very good addition!

> diff --git a/userdiff.c b/userdiff.c
> index fde02f225b..eb698eaca7 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -23,6 +23,27 @@ IPATTERN("ada",
>  	 "[a-zA-Z][a-zA-Z0-9_]*"
>  	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
>  	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
> +PATTERNS("bash",
> +	 /* Optional leading indentation */
> +	 "^[ \t]*"
> +	 /* Start of captured text */
> +	 "("
> +	 "("
> +	     /* POSIX identifier with mandatory parentheses */
> +	     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
> +	 "|"
> +	     /* Bashism identifier with optional parentheses */
> +	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
> +	 ")"
> +	 /* Optional whitespace */
> +	 "[ \t]*"
> +	 /* Compound command starting with `{`, `(`, `((` or `[[` */
> +	 "(\\{|\\(\\(?|\\[\\[)"
> +	 /* End of captured text */
> +	 ")",
> +	 /* -- */
> +	 /* Characters not in the default $IFS value */
> +	 "[^ \t]+"),
>  PATTERNS("dts",
>  	 "!;\n"
>  	 "!=\n"
> 

This is very well done. Thank you!

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
