Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DD96201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 00:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbdKPAyU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 19:54:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58512 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753066AbdKPAyT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 19:54:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4E3BA1D5E;
        Wed, 15 Nov 2017 19:54:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qmD0NOLuxc+nQgDVsf3DfYn5TO8=; b=Yawq7S
        MemEgTtplDFTG8R0L81hIl0Q7jlB0MABu3bZdDrERvWJetzS+UlFyU65Md7eKcvz
        d0+KfDwV41QtC35SIBCSiUkQxdg3d1kr6UYm3xh61rAXDoALGat9hruNKIYq3dTv
        YiIJ5j1+l6TxE5F75OlFj7u3d1cRlZlv9y/QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w0EUyrKwa4QeAAS6lPSJVqHc7CxFrx0L
        DN/xjx+S/gNYYTy8rgnaSqQl23s/HZq1aK9Cawqv2psxjJHHw/oVDzpWFTjJnr9E
        MqH9R/Jw4KUSXWq6BsNNOkKuqjN6nEQatGKMo2Yd7On0H02fdVHCvSu7R3v9hEpm
        M/TnhqNAsvY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBD1DA1D5D;
        Wed, 15 Nov 2017 19:54:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31746A1D5C;
        Wed, 15 Nov 2017 19:54:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     hsed@unimetic.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V3] config: add --expiry-date
References: <xmqqshdh2wln.fsf@gitster.mtv.corp.google.com>
        <20171116000547.3246-1-hsed@unimetic.com>
Date:   Thu, 16 Nov 2017 09:54:16 +0900
In-Reply-To: <20171116000547.3246-1-hsed@unimetic.com> (hsed@unimetic.com's
        message of "Thu, 16 Nov 2017 00:05:47 +0000")
Message-ID: <xmqqlgj7xcuf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACC66CE0-CA68-11E7-BEB4-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hsed@unimetic.com writes:

> From: Haaris Mehmood <hsed@unimetic.com>
>
> Add --expiry-date as a data-type for config files when
> 'git config --get' is used. This will return any relative
> or fixed dates from config files  as a timestamp value.
>
> This is useful for scripts (e.g. gc.reflogexpire) that work
> with timestamps so that '2.weeks' can be converted to a format
> acceptable by those scripts/functions.
>
> Following the convention of git_config_pathname(), move
> the helper function required for this feature from
> builtin/reflog.c to builtin/config.c where other similar
> functions exist (e.g. for --bool or --path), and match
> the order of parameters with other functions (i.e. output
> pointer as first parameter).
>
> Signed-off-by: Haaris Mehmood <hsed@unimetic.com>

Very nicely explained.  I often feel irritated when people further
rewrite what I wrote for them as an example and make it much worse,
but this one definitely is a lot more readable than the "something
like this perhaps?" in my response to the previous round.

> @@ -273,12 +280,13 @@ static char *normalize_value(const char *key, const char *value)
>  	if (!value)
>  		return NULL;
>  
> -	if (types == 0 || types == TYPE_PATH)
> +	if (types == 0 || types == TYPE_PATH || types == TYPE_EXPIRY_DATE)
>  		/*
>  		 * We don't do normalization for TYPE_PATH here: If
>  		 * the path is like ~/foobar/, we prefer to store
>  		 * "~/foobar/" in the config file, and to expand the ~
>  		 * when retrieving the value.
> +		 * Also don't do normalization for expiry dates.
>  		 */
>  		return xstrdup(value);

Sensible.  Just like we want to save "~u/path" as-is without
expanding the "~u"/ part, we want to keep "2 weeks ago" as-is.

> -	if (parse_expiry_date(value, expire))
> -		return error(_("'%s' for '%s' is not a valid timestamp"),
> -			     value, var);
> ...
> +	if (parse_expiry_date(value, timestamp))
> +		die(_("failed to parse date_string in: '%s'"), value);

This is an unintended change in behaviour (or at least undocumented
in the log message) for the "git reflog" command, no?

Not just the error message is different, but the original gave the
calling code a chance to react to the failure by returning -1 from
the function, but this makes the command fail outright here.

Would it break anything if you did "return error()" just like the
original used to?  Are your callers of this new function not
prepared to see an error return?
