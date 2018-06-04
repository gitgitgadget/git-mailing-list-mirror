Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9081F403
	for <e@80x24.org>; Mon,  4 Jun 2018 14:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeFDOrt (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 10:47:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:33376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751782AbeFDOrt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 10:47:49 -0400
Received: (qmail 27103 invoked by uid 109); 4 Jun 2018 14:47:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Jun 2018 14:47:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14188 invoked by uid 111); 4 Jun 2018 14:48:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Jun 2018 10:48:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2018 10:47:47 -0400
Date:   Mon, 4 Jun 2018 10:47:47 -0400
From:   Jeff King <peff@peff.net>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Johannes.Schindelin@gmx.de, pstodulk@redhat.com,
        nickh@reactrix.com, jeremy.wyman@microsoft.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH v1] http: add http.keepRejectedCredentials config
Message-ID: <20180604144747.GA27655@sigill.intra.peff.net>
References: <20180604122635.95342-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604122635.95342-1-lars.schneider@autodesk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 05:26:35AM -0700, lars.schneider@autodesk.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> If a Git HTTP server responds with 401 or 407, then Git tells the
> credential helper to reject and delete the credentials. In general
> this is good.
> 
> However, in certain automation environments it is not desired to remove
> credentials automatically. This is in particular the case if credentials
> are only invalid temporarily (e.g. because of problems in the server's
> authentication backend).
> 
> Therefore, add the config "http.keepRejectedCredentials" which tells
> Git to keep invalid credentials if set to "true".

It seems like those servers should be returning a value besides "401" if
it's a temporary error.

But alas, we live in the real world, and your patch seems like a pretty
sensible workaround for clients. This could be done at the helper layer,
but I think in practice doing it here is going to be a lot more
convenient (and doesn't preclude helpers having their own logic if
people care to extend them in that direction).

> It was considered to disable the credential deletion in credential.c
> directly. This approach was not chosen as it could be confusing to
> other callers of credential_reject() if the function does not do what
> its name says (e.g. in imap-send.c).

Yeah, I think "git credential" relies on that code, too, and you
probably should be able to manually forget a credential at that plumbing
layer.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ab641bf5a9..184aee8dbc 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1997,6 +1997,12 @@ http.emptyAuth::
>  	a username in the URL, as libcurl normally requires a username for
>  	authentication.
> 
> +http.keepRejectedCredentials::
> +	Keep credentials in the credential helper that a Git server responded
> +	to with 401 (unauthorized) or 407 (proxy authentication required).
> +	This can be useful in automation environments where credentials might
> +	become temporarily invalid. The default is `false`.

Looks good.

>  http.delegation::
>  	Control GSSAPI credential delegation. The delegation is disabled
>  	by default in libcurl since version 7.21.7. Set parameter to tell
> diff --git a/http.c b/http.c
> index b4bfbceaeb..ff6932813f 100644
> --- a/http.c
> +++ b/http.c
> @@ -138,6 +138,7 @@ static int ssl_cert_password_required;
>  #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
>  static unsigned long http_auth_methods = CURLAUTH_ANY;
>  static int http_auth_methods_restricted;
> +static int keep_rejected_credentials = 0;

Minor nit, but we usually skip the redundant "= 0" for BSS variables.

> @@ -403,6 +404,11 @@ static int http_options(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
> 
> +	if (!strcmp("http.keeprejectedcredentials", var)) {
> +		keep_rejected_credentials = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	/* Fall back on the default ones */
>  	return git_default_config(var, value, cb);
>  }
> @@ -1471,7 +1477,8 @@ static int handle_curl_result(struct slot_results *results)
>  		return HTTP_MISSING_TARGET;
>  	else if (results->http_code == 401) {
>  		if (http_auth.username && http_auth.password) {
> -			credential_reject(&http_auth);
> +			if (!keep_rejected_credentials)
> +				credential_reject(&http_auth);

The rest of the patch looks good.

It's possible we'd eventually want a similar feature for other
protocols, like IMAP. And that we'd in the long run prefer to have a
single credential.keepRejected that covers them all. Or maybe not. Given
that this is kind of a workaround, people might ultimately want
protocol-specific options. So I'm happy to start with "http" for now and
deal with other protocols down the road (if it's even necessary).

Some scripts that use "git credential" may want to support this config
option, too (I'm thinking of git-remote-mediawiki, which I believe
uses it for http requests). But those can be added one by one to the
porcelain scripts.

So modulo the minor "= 0" nit, this all looks good to me.

-Peff
