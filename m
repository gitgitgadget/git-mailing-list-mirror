Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A403CC433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 22:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696416198B
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 22:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhC0Wu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 18:50:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62119 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhC0Wu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 18:50:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 771F9B7434;
        Sat, 27 Mar 2021 18:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vEmAwaQonlH9EQvgvHVi/TRehBA=; b=IgZsVY
        07ll8jjfnMWYrs+L3a8h60MU1uha6OXYcoPP4bCcVTBFhogBkb61cL4JVMtCFQ8N
        +YSFRrje1jt8798+FMDEfyzAAA+LIvyreVvuTTR2rbRZripx0zsuGILvg6r3QQzi
        0VJJiYJ8TT0RRfucmAp4KhSrtIoSY6bblnMcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y3xdC8wYmgCSCOmMw2HbHkk4p2bL40SX
        BmXlRrL6lEV+n8ExUP92Mar6d/3YfB3zb1GMAJQUWuFrBiBSziUL7h/wpHNI3msx
        lRWAaM8fBGSI9XSwvtQ573kCc+JTKXh2hplWQi4eeOFLyTT4rKgJvjFzZz+1g1qW
        RoiIu2LBNFU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F9DDB7433;
        Sat, 27 Mar 2021 18:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F195FB7430;
        Sat, 27 Mar 2021 18:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
References: <20210327173938.59391-1-raykar.ath@gmail.com>
Date:   Sat, 27 Mar 2021 15:50:24 -0700
In-Reply-To: <20210327173938.59391-1-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Sat, 27 Mar 2021 23:09:38 +0530")
Message-ID: <xmqq5z1cqki7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1810208-8F4E-11EB-80DF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

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
> +       (let ((tests
> +              `((name . ,test) ...)))
> +         (lambda ()
> +           (ChangeMe 'suite-name tests)))))))
> \ No newline at end of file

Is there a good reason to leave the final line incomplete?  If there
isn't, complete it (applies to other newly-created files in the patch).

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

Didn't "git diff HEAD" before committing (or "git show") highlighted
these whitespace errors?

.git/rebase-apply/patch:183: indent with spaces.
         "^[\t ]*(\\(define-?.*)$",
.git/rebase-apply/patch:184: trailing whitespace, indent with spaces.
         /* 
.git/rebase-apply/patch:185: indent with spaces.
          * Scheme allows symbol names to have any character,
.git/rebase-apply/patch:186: indent with spaces.
          * as long as it is not a form of a parenthesis.
.git/rebase-apply/patch:187: indent with spaces.
          * The spaces must be escaped.
warning: squelched 2 whitespace errors
warning: 7 lines applied after fixing whitespace errors.


> +         /* 
> +          * Scheme allows symbol names to have any character,
> +          * as long as it is not a form of a parenthesis.
> +          * The spaces must be escaped.
> +          */
> +         "(\\.|[^][)(\\}\\{ ])+"),

One or more "dot or anything other than SP or parentheses"?  But
a dot "." is neither a space or any {bra-ce} letter, so would the
above be equivalent to

	"[^][()\\{\\} \t]+"

I wonder...

I am also trying to figure out what you wanted to achieve by
mentioning "The spaces must be escaped.".  Did you mean something
like (string->symbol "a symbol with SP in it") is a symbol?  Even
so, I cannot quite guess the significance of that fact wrt the
regexp you added here?

As we are trying to catch program identifiers (symbols in scheme)
and numeric literals, treating any group of non-whitespace letters
that is delimited by one or more whitespaces as a "word" would be a
good first-order approximation, but in addition, as can be seen in
an example like (a(b(c))), parentheses can also serve as such "word
delimiters" in addition to whitespaces.  So the regexp given above
makes sense to me from that angle, especially if you do not limit
the whitespace to only SP, but include HT (\t) as well.  But was
that how you came up with the regexp?

Thanks.

>  PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
>  	 "[={}\"]|[^={}\" \t]+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
