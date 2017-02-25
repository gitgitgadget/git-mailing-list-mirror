Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F8D201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 19:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbdBYTWP (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 14:22:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:34100 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751926AbdBYTWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 14:22:14 -0500
Received: (qmail 31693 invoked by uid 109); 25 Feb 2017 19:15:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 19:15:08 +0000
Received: (qmail 20532 invoked by uid 111); 25 Feb 2017 19:15:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 14:15:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 14:15:06 -0500
Date:   Sat, 25 Feb 2017 14:15:06 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     David Turner <David.Turner@twosigma.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] http: add an "auto" mode for http.emptyauth
Message-ID: <20170225191506.4it7pdsi6ijanfft@sigill.intra.peff.net>
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
 <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net>
 <b5778a7988ad4dfa9adfc8d312432189@exmbdft7.ad.twosigma.com>
 <20170223013746.lturqad7lnehedb4@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702251243390.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1702251243390.3767@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 12:48:54PM +0100, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 22 Feb 2017, Jeff King wrote:
> 
> > [two beautiful patches]
> 
> I applied them and verified that the reported issue is fixed. Thank you!
> 
> Hopefully you do not mind that I cherry-picked them in preparation for
> Git for Windows v2.12.0?

No, I don't mind. I'm happy that more people with a non-Basic setup are
verifying that they work. :)

Of the changes:

> diff --git a/http.c b/http.c
> index f8eb0f23d6c..fb94c444c80 100644
> --- a/http.c
> +++ b/http.c
> @@ -334,7 +334,10 @@ static int http_options(const char *var, const char *value, void *cb)
>  		return git_config_string(&user_agent, var, value);
>  
>  	if (!strcmp("http.emptyauth", var)) {
> -		curl_empty_auth = git_config_bool(var, value);
> +		if (value && !strcmp("auto", value))
> +			curl_empty_auth = -1;
> +		else
> +			curl_empty_auth = git_config_bool(var, value);
>  		return 0;
>  	}

Obviously good, I should have included this in the original.

> +#ifndef LIBCURL_CAN_HANDLE_AUTH_ANY
> +	/*
> +	 * Our libcurl is too old to do AUTH_ANY in the first place;
> +	 * just default to turning the feature off.
> +	 */
>  #else
> -		/*
> -		 * Our libcurl is too old to do AUTH_ANY in the first place;
> -		 * just default to turning the feature off.
> -		 */

The ifdef reordering here is good.

> +	/*
> +	 * In the automatic case, kick in the empty-auth
> +	 * hack as long as we would potentially try some
> +	 * method more exotic than "Basic".
> +	 *
> +	 * But only do this when this is our second or
> +	 * subsequent * request, as by then we know what
> +	 * methods are available.
> +	 */
> +	if (http_auth_methods_restricted)
> +		switch (http_auth_methods) {
> +		case CURLAUTH_BASIC:
> +		case CURLAUTH_DIGEST:
> +#ifdef CURLAUTH_DIGEST_IE
> +		case CURLAUTH_DIGEST_IE:
>  #endif
> [...]
> +			return 0;
> +		default:
> +			return 1;
> +		}

This is an improvement over my basic-only, but I think you actually want
to bitmask here. A server which advertises only BASIC|DIGEST should not
do empty-auth, but wouldn't match your switch statement.

Patch below.

> Now, how to get this into upstream Git, too? Jeff, do you want to submit a
> v2? In that case, would you please consider the fixup! I mentioned above?
> Otherwise I'd be happy to take it from here.

I don't mind doing a v2. I'm unsure of whether we want to default to
"auto" or not upstream. It seems from your releases that you think it is
safe enough to do in Windows. And I guess nobody outside of that is
really doing NTLM. So it's OK, I guess?

<shrug> I don't have enough information to make an intelligent opinion,
so I'm happy to defer.

I'll send my v2 in a minute. Here's the interdiff/fixup if you need to
apply it separately:

diff --git a/http.c b/http.c
index 523c43cf9..dd637d031 100644
--- a/http.c
+++ b/http.c
@@ -126,6 +126,13 @@ static int ssl_cert_password_required;
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 static unsigned long http_auth_methods = CURLAUTH_ANY;
 static int http_auth_methods_restricted;
+/* Modes for which empty_auth cannot actually help us. */
+static unsigned long empty_auth_useless =
+	CURLAUTH_BASIC
+#ifdef CURLAUTH_DIGEST_IE
+	| CURLAUTH_DIGEST_IE
+#endif
+	| CURLAUTH_DIGEST;
 #endif
 
 static struct curl_slist *pragma_header;
@@ -400,23 +407,15 @@ static int curl_empty_auth_enabled(void)
 	/*
 	 * In the automatic case, kick in the empty-auth
 	 * hack as long as we would potentially try some
-	 * method more exotic than "Basic".
+	 * method more exotic than "Basic" or "Digest".
 	 *
 	 * But only do this when this is our second or
 	 * subsequent * request, as by then we know what
 	 * methods are available.
 	 */
-	if (http_auth_methods_restricted)
-		switch (http_auth_methods) {
-		case CURLAUTH_BASIC:
-		case CURLAUTH_DIGEST:
-#ifdef CURLAUTH_DIGEST_IE
-		case CURLAUTH_DIGEST_IE:
-#endif
-			return 0;
-		default:
-			return 1;
-		}
+	if (http_auth_methods_restricted &&
+	    (http_auth_methods & ~empty_auth_useless))
+		return 1;
 #endif
 	return 0;
 }
