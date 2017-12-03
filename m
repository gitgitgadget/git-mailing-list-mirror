Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2E520C11
	for <e@80x24.org>; Sun,  3 Dec 2017 18:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdLCSpy (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 13:45:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62934 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751269AbdLCSpx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 13:45:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64299C16BB;
        Sun,  3 Dec 2017 13:45:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yx5JTEMj0pGHUIKvrF/jo6/Q/do=; b=bixdgD
        /gdf52rifPk8FdVaBAh/i0HawesyHDwl1uDpwJGg8ztBUyJWEQo0Svj7v9Z6ED8R
        tid3slVX/qRJy1/7mBvz9J+pjG8nAyuyoIsb1ggFwzlIncxa/jwyQYnSzoxLlGvr
        hRpJjxFj1viO0xxCTi/CFijWOXz58NJWIQUfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=owFNFs44xY85N3meFjuNi8xGtsZoCs6/
        2wAbVKKZ/9gY6tPhHmTkmBwKGfAF9CMfOqF1pn4vnDdQgmFH2J0G2b818dtOit9U
        OlepPNUXZMCmCAZ4K+80CHMcneUR+eLqcNz1k9zzUiWVbYL4xIpBotSVq1Thpo9f
        en4M4EIxwj4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B310C16BA;
        Sun,  3 Dec 2017 13:45:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9BF5C16B9;
        Sun,  3 Dec 2017 13:45:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] git-compat-util: introduce skip_to_opt_val()
References: <20171203170415.15939-1-chriscool@tuxfamily.org>
Date:   Sun, 03 Dec 2017 10:45:50 -0800
In-Reply-To: <20171203170415.15939-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 3 Dec 2017 18:04:13 +0100")
Message-ID: <xmqqk1y3ira9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FC8D430-D85A-11E7-B9D2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> From: Christian Couder <christian.couder@gmail.com>
>
> We often accept both a "--key" option and a "--key=<val>" option.
>
> These options currently are parsed using something like:
>
> if (!strcmp(arg, "--key")) {
> 	/* do something */
> } else if (skip_prefix(arg, "--key=", &arg)) {
> 	/* do something with arg */
> }
>
> which is a bit cumbersome compared to just:
>
> if (skip_to_opt_val(arg, "--key", &arg)) {
> 	/* do something with arg */
> }

Sounds sensible; especially if there are many existing code that can
be shortened by using this helper, that is.

> Note that, when using skip_to_opt_val(), it is not possible any more
> to do something different when the first argument is exactly "--key"
> than when it is exactly "--key=", but in most cases we already don't
> make any difference, which is a good thing.

Note that "it is not possible" is misleading.  skip_to_opt_val()
could be written to allow the caller to tell the difference if you
chose to, but *you* made it impossible by assigning "" to arg upon
seeing "--key".  You could assign NULL to arg in that case, and
"--key" and "--key=" can be differenciated by checking arg; the
former will give you NULL and the latter "".

Not that I am convinced that it is a bad idea to deliberately lose
information like this implementation does.  At least not yet.

If there will be no conceivable caller that wants to differenticate
between the two, the implementation that "loses information" can
claim to be easier to use, as the callers do not have to be forced
to write something like:

	if (skip_to_optional_val(arg, "--key", &arg)
		do_something(arg ? arg : "");

to treat them the same.

Having said all that, I would expect skip_to_optional_val() (as a
name of the helper I suspect skip_to_optional_arg() is more
appropriate, though) to store NULL in the arg thing if there is no
optional argument given.  Also, the caller does not have to even do
the 'arg ? arg : ""' dance if it is so common and natural for the
application to treat "--key" and "--key=" equivalently, as it is
expected that the actual code to work on the arg, i.e. do_something()
in the above example, _should_ be prepared to take NULL and "" and
treat them the same way (that is the definition of "it is so common
and natural for the application to treat them the same).

So, I think you identified interesting pattern that can be cleaned
up by introducing a helper, but I am not sure if I agree with the
exact design of the helper.

> Note that "opt" in the function name actually means "optional" as
> the function can be used to parse any "key=value" string where "key"
> is also considered as valid, not just command line options.

Yup.  This paragraph is a good thing to have in the proposed log
message, to explain the reason why you force callers of this helper
to spell out the leading dashes like "--key" (not "key").  I think
that it is a sane design of the input side of this function---it
does not limit it to an overly narrow case of command line option
processing.  For the same reason, I think it is saner design of the
output side to allow callers to tell between "key=" and "key".

While staring at this helper and writing "does not limit to command
line option processing", it occurs to me that a helper that allows
you to look for an optional ':' (instead of '=') may also be useful,
so the final version might become a pair of functions, perhaps like
so:

    int skip_to_optional_delim(const char *s,
			       const char *prefix, char delim,
			       const char **rest)
    {
	const char *p;

	if (!skip_prefix(str, prefix, &p))
		return 0;
	if (!*p)
		*rest = NULL;
	else if (*p != delim)
		return 0;
	else
		*rest = p + 1;
	return 1;
    }

    int skip_to_optional_arg(const char *s,
			     const char *prefix,
			     const char **arg)
    {
	return skip_to_optional_delim(s, prefix, '=', arg);
    }

As the first one would not (by definition) have any callers
initially after your series, it can be static to a file that
implements both of them and it is OK to expose only the latter to
the public.  

I do think it is a premature optimization to inline this function,
whose initial callers will be (from the look of the remainder of
your patches) command line parsing that sits farthest from any
performance critical code.

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  git-compat-util.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> Another possibility would be to add a "const char *default"
> argument to the function, and to do: 
>
> 	if (!*p) {
> 		*val = default;
> 		return 1;
> 	}
>
> This could make the function more useful in some cases.
>
> I also wonder if the function is too big to be inlined, and
> in that case, in which file it should be added. 
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index cedad4d581..7ee040388f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -534,6 +534,41 @@ static inline int ends_with(const char *str, const char *suffix)
>  	return strip_suffix(str, suffix, &len);
>  }
>  
> +/*
> + * If the string "str" is the same as the string in "prefix", then the "val"
> + * parameter is set to the empty string and 1 is returned.
> + * If the string "str" begins with the string found in "prefix" and then a
> + * "=" sign, then the "val" parameter is set to "str + strlen(prefix) + 1"
> + * (i.e., to the point in the string right after the prefix and the "=" sign),
> + * and 1 is returned.
> + *
> + * Otherwise, return 0 and leave "val" untouched.
> + *
> + * When we accept both a "--key" and a "--key=<val>" option, this function
> + * can be used instead of !strcmp(arg, "--key") and then
> + * skip_prefix(arg, "--key=", &arg) to parse such an option.
> + */
> +static inline int skip_to_opt_val(const char *str, const char *prefix,
> +				  const char **val)
> +{
> +	const char *p;
> +
> +	if (!skip_prefix(str, prefix, &p))
> +		return 0;
> +
> +	if (!*p) {
> +		*val = "";
> +		return 1;
> +	}
> +
> +	if (*p == '=') {
> +		*val = p + 1;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  #define SWAP(a, b) do {						\
>  	void *_swap_a_ptr = &(a);				\
>  	void *_swap_b_ptr = &(b);				\
