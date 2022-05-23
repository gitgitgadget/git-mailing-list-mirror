Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B280C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 19:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiEWT1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiEWT05 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 15:26:57 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59451BE8D
        for <git@vger.kernel.org>; Mon, 23 May 2022 12:06:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D00A11D2ED;
        Mon, 23 May 2022 15:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lf8/KioMT7M0qA3Dere/Z3g5cPBT0D7TqtH2LU
        lrItI=; b=gnIbUeDajyq3WG8EL928//AeyWLvHXADpqYJgKUJ6QqXKXYFfyaWQy
        FqsZwLaNXyKIFut/R3HLjXRoZ89u9AkKlc1hJert7Y91h36I87jG76ps+U5NNpjW
        YK+ERz7c8evZGRUOfVJf0Llg77VZ4vs6RUiY3zbPL5CF5hN8ncEPA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3445811D2EB;
        Mon, 23 May 2022 15:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 839BD11D2EA;
        Mon, 23 May 2022 15:06:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 12:06:31 -0700
In-Reply-To: <pull.1237.git.1653329044940.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 23 May 2022 18:04:04
        +0000")
Message-ID: <xmqqr14kqdag.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7577CE28-DACB-11EC-8B57-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Create a new "fetch.credentialsInUrl" config option and teach Git to
> warn or die when seeing a URL with this kind of information. The warning
> anonymizes the sensitive information of the URL to be clear about the
> issue.

The issue sounds vaguely familiar---I must have heard something
similar on this list not in too distant past.

> This change currently defaults the behavior to "ignore" which does
> nothing with these URLs. We can consider changing this behavior to
> "warn" by default if we wish. At that time, we may want to add some
> advice about setting fetch.credentialsInUrl=ignore for users who still
> want to follow this pattern (and not receive the warning).

It sounds more like "pass" than "ignore", the latter of which can be
read as "strip" instead of "pass it as-is".

The name "warn", and its stronger form "die", both sound right.

> ... Running the test suite succeeds except for the
> explicit username:password URLs used in t5550-http-fetch-dumb.s and
> t5541-http-push-smart.sh. This means that all other tested URLs did not
> trigger this logic.

We are not testing the form we are not encouraging, in other words ;-).

>     urlmatch: create fetch.credentialsInUrl config
>     
>     This is a modified version of the patch I submitted a while ago [1].
>     
>     Based on the feedback, changing the behavior to fail by default was not
>     a good approach. Further, the idea to stop storing the credentials in
>     config and redirect them to a credential manager was already considered
>     by Peff [2] but not merged.

I just peeked [2] and I am not sure why we didn't X-<.  The solution
there covers "git clone" that records the origin URL but this one
would cover URL regardless of where the URL came from---as long as
an insecure URL is used, we warn or die, and it is even against the
URL that came from the command line.

In a sense, I think these are more or less orthogonal.  [2]'s "clone
can strip the user:pass from the URL it writes to the config, while
passing user:pass to the credential API", especially if it is
extended to "git remote add", would stop two common avenues that
such an insecure URL can go to the configuration file.  The approach
taken by this patch would complement it to a degree, as long as the
user cares.

I am not sure if there is a legitimate case where the user does not
care, though.  For a script, it may be handy if a URL can contain an
ever-changing user:pass pair, where the pass is generated by
something like s/key, for example, and for such a command line that
knowingly have user:pass pair, having to set the configuration to
"ignore" may be cumbersome.

> +fetch.credentialsInUrl::
> +	A URL can contain plaintext credentials in the form
> +	`protocol://<user>:<password>@domain/path`. Using such URLs is not
> +	recommended as it exposes the password in multiple ways. The
> +	`fetch.credentialsInUrl` option provides instruction for how Git
> +	should react to seeing such a URL, with these values:
> ++
> +* `ignore` (default): Git will proceed with its activity without warning.
> +* `warn`: Git will write a warning message to `stderr` when parsing a URL
> +  with a plaintext credential.
> +* `die`: Git will write a failure message to `stderr` when parsing a URL
> +  with a plaintext credential.

Sounds sensible (modulo I would suggest "ignore" -> "pass").

> +	grep "warning: URL '\''https://username:\*\*\*\*\*\*\*\*@localhost/'\'' uses plaintext credentials" err &&

Makes sure that the password part is redacted, which is good.

> +	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
> +	grep "fatal: URL '\''https://username:\*\*\*\*\*\*\*\*@localhost/'\'' uses plaintext credentials" err

Ditto.

> diff --git a/urlmatch.c b/urlmatch.c
> index b615adc923a..6b91fb648a7 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "urlmatch.h"
> +#include "config.h"

Yuck.  Having to do config lookups at this deep a level in the
callchain does not look too attractive to me.

I am wondering if we can make it the responsibility of the callers
to figure out and pass down the settings of the new configuration
variable.

Offhand I do not think of an easy and clean way to do so (well,
"easy" is easy---add one to the list of globals in environment.c;
"clean" is the harder part).

>  #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
>  #define URL_DIGIT "0123456789"
> @@ -106,6 +107,46 @@ static int match_host(const struct url_info *url_info,
>  	return (!url_len && !pat_len);
>  }
>  
> +static void detected_credentials_in_url(const char *url, size_t scheme_len)
> +{
> +	char *value = NULL;
> +	const char *at_ptr;
> +	const char *colon_ptr;
> +	struct strbuf anonymized = STRBUF_INIT;
> +
> +	/* "ignore" is the default behavior. */
> +	if (git_config_get_string("fetch.credentialsinurl", &value) ||
> +	    !strcasecmp("ignore", value))
> +		goto cleanup;
> +
> +	at_ptr = strchr(url, '@');
> +	colon_ptr = strchr(url + scheme_len + 3, ':');

We expect that at_ptr would come after colon_ptr (i.e. in
"scheme://<u>:<p>@host", no @ exists in <u> or <p> part) and the
while() loop below assumes that for redacting.  Are we better off if
we assert it here, or has the calling parser already rejected such
cases?

> +	if (!colon_ptr)
> +		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
> +		    url, (uintmax_t) scheme_len);
> +
> +	/* Include everything including the colon. */
> +	colon_ptr++;
> +	strbuf_add(&anonymized, url, colon_ptr - url);
> +
> +	while (colon_ptr < at_ptr) {
> +		strbuf_addch(&anonymized, '*');
> +		colon_ptr++;
> +	}
> +
> +	strbuf_addstr(&anonymized, at_ptr);
> +
> +	if (!strcasecmp("warn", value))
> +		warning(_("URL '%s' uses plaintext credentials"), anonymized.buf);
> +	if (!strcasecmp("die", value))
> +		die(_("URL '%s' uses plaintext credentials"), anonymized.buf);
> +
> +cleanup:
> +	free(value);
> +	strbuf_release(&anonymized);
> +}
> +

So far, looking good.

> @@ -144,6 +185,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
>  	 */
>  
>  	size_t url_len = strlen(url);
> +	const char *orig_url = url;
>  	struct strbuf norm;
>  	size_t spanned;
>  	size_t scheme_len, user_off=0, user_len=0, passwd_off=0, passwd_len=0;
> @@ -191,6 +233,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
>  			}
>  			colon_ptr = strchr(norm.buf + scheme_len + 3, ':');
>  			if (colon_ptr) {
> +				detected_credentials_in_url(orig_url, scheme_len);
>  				passwd_off = (colon_ptr + 1) - norm.buf;
>  				passwd_len = norm.len - passwd_off;
>  				user_len = (passwd_off - 1) - (scheme_len + 3);
>
> base-commit: f9b95943b68b6b8ca5a6072f50a08411c6449b55

Thanks.
