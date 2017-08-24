Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB49220285
	for <e@80x24.org>; Thu, 24 Aug 2017 20:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753771AbdHXUcX (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 16:32:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52516 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753722AbdHXUcW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 16:32:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF7949E8F3;
        Thu, 24 Aug 2017 16:32:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TlZkG8yB+ieFoLEsunCfEk/kHWk=; b=gY7Rw1
        TA8NBKwRYL60PuR4WLrCTWYKXIwkRfHU/CgTefhV2u05RJkkIqs//6S50YX69QgS
        DlXxK7Fcn32Dg3LgVTNzs4JrI25DTI1CVwrDB+vvip6uzkxzbM/GljoSyN/hoNv4
        dZoyukxE6569VqhOGlM0tXyJ8uIMDlbI+R2ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eeC0Zgxvz6ldNNsHZb6ZLOlpJSGG+5qJ
        tivDUQFSiHAR/oEHriNPPy7TZXOy1uyb9sGYJmj7q0GKV1wWZq2QbNb+yVJaWBKf
        OH1tPMRonBKBfwwKBKAQJiQLLW9GCsUEDOkbyWzlXfEJpwUgaYvypHGbsxkWAm33
        htS9YgTGyhQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6F519E8F2;
        Thu, 24 Aug 2017 16:32:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07CB69E8EF;
        Thu, 24 Aug 2017 16:32:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] send-email: fix garbage removal after address
References: <vpqo9r6lhzq.fsf@anie.imag.fr>
        <20170823102102.20120-1-git@matthieu-moy.fr>
Date:   Thu, 24 Aug 2017 13:32:19 -0700
In-Reply-To: <20170823102102.20120-1-git@matthieu-moy.fr> (Matthieu Moy's
        message of "Wed, 23 Aug 2017 12:21:01 +0200")
Message-ID: <xmqqk21svh9o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54539338-890B-11E7-94BB-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <git@matthieu-moy.fr> writes:

> This is a followup over 9d33439 (send-email: only allow one address
> per body tag, 2017-02-20). The first iteration did allow writting
>
>   Cc: <foo@example.com> # garbage
>
> but did so by matching the regex ([^>]*>?), i.e. stop after the first
> instance of '>'. However, it did not properly deal with
>
>   Cc: foo@example.com # garbage
>
> Fix this using a new function strip_garbage_one_address, which does
> essentially what the old ([^>]*>?) was doing, but dealing with more
> corner-cases. Since we've allowed
>
>   Cc: "Foo # Bar" <foobar@example.com>
>
> in previous versions, it makes sense to continue allowing it (but we
> still remove any garbage after it). OTOH, when an address is given
> without quoting, we just take the first word and ignore everything
> after.
>
> Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
> ---
> Also available as: https://github.com/git/git/pull/398
>
>  git-send-email.perl   | 26 ++++++++++++++++++++++++--
>  t/t9001-send-email.sh |  4 ++++
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index fa6526986e..33a69ffe5d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1089,6 +1089,26 @@ sub sanitize_address {
>  
>  }
>  
> +sub strip_garbage_one_address {
> +	my ($addr) = @_;
> +	chomp $addr;
> +	if ($addr =~ /^(("[^"]*"|[^"<]*)? *<[^>]*>).*/) {
> +		# "Foo Bar" <foobar@example.com> [possibly garbage here]
> +		# Foo Bar <foobar@example.com> [possibly garbage here]
> +		return $1;
> +	}
> +	if ($addr =~ /^(<[^>]*>).*/) {
> +		# <foo@example.com> [possibly garbage here]
> +		# if garbage contains other addresses, they are ignored.
> +		return $1;
> +	}

Isn't this already covered by the first one, which allows an
optional "something", followed by an optional run of SPs, in front
of this exact pattern, so the case where the optional "something"
does not appear and the number of optional SP is zero would exactly
match the one this pattern is meant to cover.

> +	if ($addr =~ /^([^"#,\s]*)/) {
> +		# address without quoting: remove anything after the address
> +		return $1;
> +	}
> +	return $addr;
> +}

By the way, these three regexps smell like they were written
specifically to cover three cases you care about (perhaps the ones
in your proposed log message), but what will be our response when
somebody else comes next time to us and says that their favourite
formatting of "Cc:" line is not covered by these rules?  

Will we add yet another pattern?  Where will it end?  There will be
a point where we instead start telling them to update the convention
of their project so that it will be covered by one of the patterns
we have already developed, I would imagine.

So, from that point of view, I, with devil's advocate hat on, wonder
why we are not saying

	"Cc: s@k.org # cruft"?  Use "Cc: <s@k.org> # cruft" instead
	and you'd be fine.

right now, without this patch.

I do not _mind_ us trying to be extra nice for a while, and I
certainly do not mind _this_ particular patch that gives us a single
helper function that future "here is another way to spell cruft"
rules can go, but I feel that there should be some line that lets us
say that we've done enough.

Thanks.
