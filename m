Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11338C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 03:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0583206C2
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 03:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a3Kfw1H6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKVDeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:34:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50088 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKVDeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 22:34:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F9888C345;
        Thu, 21 Nov 2019 22:34:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3l/Sl2GJfV8NDsboQPLNbgw5Dp0=; b=a3Kfw1
        H6pvgySdE8J3hUjfnaiKnRk/IqlPMcraJrVoa9giHVwexkprZlbgWdg5/+XdURwI
        Sgf1/gl/RzXm4a2ncKgqU2sx1rkjwwrqMhY6T+GWJrkikszVlwsOHakkCN/QvBOJ
        kIVCAXZkfuS8ZZyds8yR2WSDfyPKwFg/Q51Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uwp615nplgwXiZE6VqU4w4krG26msinJ
        8aXa0Ic3Yr/4OYUClwJAY6wmN1D6FE93nItpzpj4hT8BIlPmYSBUIPuc7vn7UQV/
        wmT25Yd1HpoCDefRAq1K2reHtSot+qKmVIANrzYpWwAxaHVnmWV3f97jHIXGisRH
        Rn2j8yJb3SU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F3868C343;
        Thu, 21 Nov 2019 22:34:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88A9E8C342;
        Thu, 21 Nov 2019 22:34:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] gpg-interface: limit search for primary key fingerprint
References: <20191116215850.3919-1-hji@dyntopia.com>
        <20191121234336.26300-1-hji@dyntopia.com>
        <20191121234336.26300-3-hji@dyntopia.com>
Date:   Fri, 22 Nov 2019 12:34:09 +0900
In-Reply-To: <20191121234336.26300-3-hji@dyntopia.com> (Hans Jerry
        Illikainen's message of "Thu, 21 Nov 2019 23:43:36 +0000")
Message-ID: <xmqqimnc7ff2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2E466F0-0CD8-11EA-BE94-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> The VALIDSIG status line from GnuPG with --status-fd is documented to
> have 9 required and 1 optional fields [1].  The final, and optional,
> field is used to specify the fingerprint of the primary key that made
> the signature in case it was made by a subkey.  However, this field is
> only available for OpenPGP signatures; not for CMS/X.509.
>
> The current code assumes that the VALIDSIG status line always has 10
> fields.  Furthermore, the current code assumes that each field is
> separated by a space (0x20) character.

This make it sound as if the "assumption" of splitting at SP is a wrong
one, so I went back to the source.  The DETAILS document curiously
forgets to say that these are "usual space delimited arguments" for the
VALIDSIG, unlike it does for a few other entries in the "General status
codes" section.  But with the presense of "usual space delimited" in
another seciton with the lack of explicit delimiter definition in this
section, I would say it is safe to assume that the authors meant these
fields to be separated by SPs. 

In any case, I think this paragraph can safely disappear and would make
the overall clarity of the problem analysis even better.  We already
said that assuming 10th field is wrong in the earlier paragraph, and we
say what happens when the is only 9 fields in the next paragraph.

> If the VALIDSIG status line does not have the optional 10th field, the
> current code will continue reading onto the next status line -- because
> only 0x20 is considered a field separator, not 0xa.  And this is the
> case for non-OpenPGP signatures [1].

I actually think stresing on 0x20 vs 0x0a misleads readers in a wrong
direction.  If the code were written in such a way that both can be used
as a field separator, we would still continue reading into the next
line.  IOW, treating only SP as field delimiter is correct; what is
wrong is we do not limit the search to the current/single line.

	... because the code does not pay attention to the end of the
	current line when it looks for the end of the 10th (and
	optional) field that it incorrectly assumes to exist.

> The consequence is that a subsequent status line may be considered as
> the "primary key" for signatures that does not have an actual primary
> key.

Overall, all of the description in the above paragraphs are nicely
analysed and explained.  I wish all contributors' wrote their proposed
log messages clearly like you.

> The solution introduced by this commit is to add 0xa as a bound for the
> search for a primary key.  The search for the 10th VALIDSIG field is
> aborted as soon as it sees a newline character.  This keeps the parser
> from interpreting subsequent lines as the primary key.

Rather than "... to add 0xa as ... primary key.", I would probably write
it as "... to limit the search for the primary key on the single line."
The end of line being represented (internally as C string) with a byte
whose value is 0x0a or a newline character is an implementation detail.

Also we tend to describe the change we make as if the author is ordering
the codebase to "become like so" in imperative mood, so, perhaps

	Limit the search of these 9 or 10 fields to the single line
	to avoid this problem.  If the 10th field is missing, report
	that there is no primary key fingerprint.

would be sufficient, as the last sentence, i.e. "The consequence
is...", has already hinted what needs to be fixed clearly and quite
directly.


> [1] https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS#l483

I actually wrote the URL with the exact revision in my earlier example
because the URL written without is a moving target.  IOW, "Find the tip
commit of whichever the default branch is, and then look at the path
doc/DETAILS in it and hope that line 483 will stay forever what we want
to refer to" was what I wanted to avoid.  Perhaps in addition to the
above URL (which can go stale), leave a textual reference so that
readers can notice that the link is stale and look for what you meant to
point them at?  Like so:

	[Reference]

        *1* The description for VALIDSIG in the "General status codes"
	section of GnuPG document that is at

	https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS#l483

	says:

        VALIDSIG <args>

        The args are:

        - <fingerprint_in_hex>
        - <sig_creation_date>
        - <sig-timestamp>
        - <expire-timestamp>
        - <sig-version>
        - <reserved>
        - <pubkey-algo>
        - <hash-algo>
        - <sig-class>
        - [ <primary-key-fpr> ]

        This status indicates that the signature is cryptographically
        valid. ... PRIMARY-KEY-FPR is the fingerprint of the primary key
        or identical to the first argument.  This is useful to get back
        to the primary key without running gpg again for this purpose.

        The primary-key-fpr parameter is used for OpenPGP and not
        available for CMS signatures. ...

> @@ -160,18 +161,27 @@ static void parse_gpg_output(struct signature_check *sigc)
>  					next = strchrnul(line, ' ');
>  					replace_cstring(&sigc->fingerprint, line, next);
>  
> -					/* Skip interim fields */
> +					/*
> +					 * Skip interim fields.  The search is
> +					 * limited to the same line since only
> +					 * OpenPGP signatures has a field with
> +					 * the primary fingerprint.
> +					 */
> +					limit = strchrnul(line, '\n');
>  					for (j = 9; j > 0; j--) {
> -						if (!*next)
> +						if (!*next || limit <= next)
>  							break;
>  						line = next + 1;
>  						next = strchrnul(line, ' ');
>  					}

Nice.  We try not to go beyond the end of the current line, and
otherwise break out which leaves j non-zero.

> -					next = strchrnul(line, '\n');
> -					free(sigc->primary_key_fingerprint);
> -					replace_cstring(&sigc->primary_key_fingerprint,
> -							line, next);

And doing the above unconditionally was wrong, but ...

> +					field = &sigc->primary_key_fingerprint;
> +					if (!j) {
> +						next = strchrnul(line, '\n');
> +						replace_cstring(field, line, next);
> +					} else {
> +						replace_cstring(field, NULL, NULL);
> +					}

... we correct it by doing the replacing only when we did find the
10th field.

Nicely done.

By the way, now you have another new variable "field" together with
"limit" both of whose uses are limited to this narrower scope, I no
longer mind seeing declarations of them inside this scope, as opposed to
make them function-wide.  That's a fairly minor point.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index e803ba402e..17ec2401ec 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1570,6 +1570,14 @@ test_expect_success GPG 'setup signed branch' '
>  	git commit -S -m signed_commit
>  '
>  
> +test_expect_success GPG 'setup signed branch with subkey' '
> +        test_when_finished "git reset --hard && git checkout master" &&
> +        git checkout -b signed-subkey master &&
> +        echo foo >foo &&
> +        git add foo &&
> +        git commit -SB7227189 -m signed_commit
> +'
> +

The new tests (not only this one) are indented with 8 SPs---will fix
to use HT while queuing (no need to resend only to fix these).

> +test_expect_success GPGSM 'log x509 fingerprint' '
> +        echo "F8BF62E0693D0694816377099909C779FA23FD65 | " >expect &&
> +        git log -n1 --format="%GF | %GP" signed-x509 >actual &&
> +        test_cmp expect actual
> +'
> +
> +test_expect_success GPGSM 'log OpenPGP fingerprint' '
> +        echo "D4BE22311AD3131E5EDA29A461092E85B7227189" > expect &&
> +        git log -n1 --format="%GP" signed-subkey >actual &&
> +        test_cmp expect actual
> +'

These two tests are really to the point.  Nice.

Thanks.
