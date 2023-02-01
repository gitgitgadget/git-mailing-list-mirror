Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CA0C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 12:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjBAMKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjBAMKr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 07:10:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAEA29426
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 04:10:45 -0800 (PST)
Received: (qmail 31624 invoked by uid 109); 1 Feb 2023 12:10:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 12:10:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19883 invoked by uid 111); 1 Feb 2023 12:10:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 07:10:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 07:10:44 -0500
From:   Jeff King <peff@peff.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] credential: new attribute password_expiry_utc
Message-ID: <Y9pWxHfgPtgCKO+B@coredump.intra.peff.net>
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
 <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 09:39:51AM +0000, M Hickford via GitGitGadget wrote:

> +`password_expiry_utc`::
> +
> +	If password is a personal access token or OAuth access token, it may have an
> +	expiry date. When getting credentials from a helper, `git credential fill`
> +	ignores the password attribute if the expiry date has passed. Storage
> +	helpers should store this attribute if possible. Helpers should not
> +	implement expiry logic themselves. Represented as Unix time UTC, seconds
> +	since 1970.

This "should not" seems weird to me. The logic you have here throws out
entries that have expired when they pass through Git. But wouldn't
helpers which store things want to know about and act on the expiration,
too?

For example, if Git learns about a credential that expires in 60
seconds and passes it to credential-cache which is configured
--timeout=300, wouldn't it want to set its internal ttl on the
credential to 60, rather than 300?

I think your plan here is that Git would then reject the credential if a
request is made at time now+65. But the cache is holding onto it much
longer than necessary.

Likewise, wouldn't anything that stores credentials at least want to be
able to store and regurgitate the expiration? For instance, even
credential-store would want to do this. I'm OK if it doesn't, and we can
consider it a quality-of-implementation issue and see if anybody cares
enough to implement it. But I'd think most "real" helpers would want to
do so.

So it seems like helpers really do need to support this "expiration"
notion. And it's actually Git itself which doesn't need to care about
it, assuming the helpers are doing something sensible (though it is OK
if Git _also_ throws away expired credentials to support helpers which
don't).

> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index f3c89831d4a..338058be7f9 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
>  		if (e) {
>  			fprintf(out, "username=%s\n", e->item.username);
>  			fprintf(out, "password=%s\n", e->item.password);
> +			if (e->item.password_expiry_utc != TIME_MAX)
> +				fprintf(out, "password_expiry_utc=%"PRItime"\n",
> +					e->item.password_expiry_utc);
>  		}

Is there a particular reason to use TIME_MAX as the sentinel value here,
and not just "0"? It's not that big a deal either way, but it's more
usual in our code base to use "0" if there's no reason not to (and it
seems like nothing should be expiring in 1970 these days).

> @@ -195,15 +196,20 @@ static void credential_getpass(struct credential *c)
>  	if (!c->username)
>  		c->username = credential_ask_one("Username", c,
>  						 PROMPT_ASKPASS|PROMPT_ECHO);
> -	if (!c->password)
> +	if (!c->password || c->password_expiry_utc < time(NULL)) {

This is comparing a timestamp_t to a time_t, which may mix
signed/unsigned. I can't offhand think of anything that would go too
wrong there before 2038, so it's probably OK, but I wanted to call it
out.

> @@ -225,6 +231,7 @@ int credential_read(struct credential *c, FILE *fp)
>  		} else if (!strcmp(key, "password")) {
>  			free(c->password);
>  			c->password = xstrdup(value);
> +			password_updated = 1;
>  		} else if (!strcmp(key, "protocol")) {
>  			free(c->protocol);
>  			c->protocol = xstrdup(value);
> @@ -234,6 +241,11 @@ int credential_read(struct credential *c, FILE *fp)
>  		} else if (!strcmp(key, "path")) {
>  			free(c->path);
>  			c->path = xstrdup(value);
> +		} else if (!strcmp(key, "password_expiry_utc")) {
> +			this_password_expiry = parse_timestamp(value, NULL, 10);
> +			if (this_password_expiry == 0 || errno) {
> +				this_password_expiry = TIME_MAX;
> +			}
>  		} else if (!strcmp(key, "url")) {
>  			credential_from_url(c, value);
>  		} else if (!strcmp(key, "quit")) {
> @@ -246,6 +258,9 @@ int credential_read(struct credential *c, FILE *fp)
>  		 */
>  	}
>  
> +	if (password_updated)
> +		c->password_expiry_utc = this_password_expiry;

Do we need this logic? It seems weird that a helper would output an
expiration but not a password in the first place. I guess ignoring the
expiration is probably a reasonable outcome, but I wonder if a helper
would ever want to just add an expiration to the data coming from
another helper.

I.e., could we just read the value directly into c->password_expiry_utc
as we do with other fields?

-Peff
