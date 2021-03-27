Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EADCC433C1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137696198D
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhC0Xq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 19:46:56 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:37131 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhC0XqU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 19:46:20 -0400
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4F7Fpy5RMKz5tr1
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 00:46:18 +0100 (CET)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4F7Fps6dzkz5tlD;
        Sun, 28 Mar 2021 00:46:12 +0100 (CET)
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
To:     Atharva Raykar <raykar.ath@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
Date:   Sun, 28 Mar 2021 00:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210327173938.59391-1-raykar.ath@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.03.21 um 18:39 schrieb Atharva Raykar:
>  - By best-effort attempt at the wordregex, I mean that it is a little
>    more permissive than it has to be, as it accepts a few words that are
>    technically invalid in Scheme.
>    Making it handle all cases like numbers and identifiers with separate
>    regexen would be greatly complicated (Eg: #x#e10.2f3 is a valid number
>    but #x#f10.2e3 is not; 10t1 is a valid identifier, but 10s1 is a number
>    -- my wordregex just clubs all of these into a generic 'word match' which
>    trades of granularity for simplicity, and it usually does the right thing).

It is ok to have regex that capture tokens that are not valid. A
userdiff driver can assume that it operates only text that is valid in
the language.

> diff --git a/t/t4018/scheme-define-syntax b/t/t4018/scheme-define-syntax
> new file mode 100644
> index 0000000000..603b99cea4
> --- /dev/null
> +++ b/t/t4018/scheme-define-syntax
> @@ -0,0 +1,8 @@
> +(define-syntax define-test-suite RIGHT
> +  (syntax-rules ()
> +    ((_ suite-name (name test) ChangeMe ...)
> +     (define suite-name

This test is suspicious. Notice the "ChangeMe" above? That is sufficient
to let the test case succeed. The "ChangeMe" in the last line below
should be the only one.

But then there is this indented '(define' that is not marked as RIGHT,
and I wonder how is it different from...

> +       (let ((tests
> +              `((name . ,test) ...)))
> +         (lambda ()
> +           (ChangeMe 'suite-name tests)))))))
> \ No newline at end of file
> diff --git a/t/t4018/scheme-local-define b/t/t4018/scheme-local-define
> new file mode 100644
> index 0000000000..90e75dcce8
> --- /dev/null
> +++ b/t/t4018/scheme-local-define
> @@ -0,0 +1,4 @@
> +(define (higher-order)
> +  (define local-function RIGHT

... this one, which is also indented and *is* marked as RIGHT.

BTW, it's good to see test cases for both indented and not-indented
trigger lines.

> +    (lambda (x)
> +     (car "this is" "ChangeMe"))))
> \ No newline at end of file

> diff --git a/userdiff.c b/userdiff.c
> index 3f81a2261c..c51a8c98ba 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -191,6 +191,14 @@ PATTERNS("rust",
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
>  	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
> +PATTERNS("scheme",
> +         "^[\t ]*(\\(define-?.*)$",

This "optional hyphen followed by anything" in the regex is strange.
Wouldn't that also capture a line that looks like, e.g.,

    (defined-foo bar)

Perhaps we want "define[- \t].*" in the regex?

> +         /* 
> +          * Scheme allows symbol names to have any character,
> +          * as long as it is not a form of a parenthesis.
> +          * The spaces must be escaped.
> +          */
> +         "(\\.|[^][)(\\}\\{ ])+"),
>  PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
>  	 "[={}\"]|[^={}\" \t]+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
> 

-- Hannes
