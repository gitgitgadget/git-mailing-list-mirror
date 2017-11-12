Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCCBA201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 15:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbdKLPpV (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 10:45:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:54042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751220AbdKLPpU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 10:45:20 -0500
Received: (qmail 4726 invoked by uid 109); 12 Nov 2017 15:45:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 15:45:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15499 invoked by uid 111); 12 Nov 2017 15:45:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 10:45:33 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 15:45:18 +0000
Date:   Sun, 12 Nov 2017 15:45:18 +0000
From:   Jeff King <peff@peff.net>
To:     Soukaina NAIT HMID <nhsoukaina@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [add-default-config 4/5] add defaults for path/int/bool
Message-ID: <20171112154518.ozbbebzazhko7byl@sigill.intra.peff.net>
References: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
 <0102015fb0bf3086-fe6c887d-592b-45f0-8f8e-bdbe2d18a218-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102015fb0bf3086-fe6c887d-592b-45f0-8f8e-bdbe2d18a218-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 03:00:40PM +0000, Soukaina NAIT HMID wrote:

> @@ -256,8 +258,15 @@ static int get_value(const char *key_, const char *regex_)
>  			fwrite(buf->buf, 1, buf->len, stdout);
>  		strbuf_release(buf);
>  	}
> -	free(values.items);
>  
> +	if (values.nr == 0 && default_value) {
> +		if(types == TYPE_INT || types == TYPE_BOOL || types == TYPE_BOOL_OR_INT || types == TYPE_PATH ) {
> +			char* xstr = normalize_value(key, default_value);
> +			fwrite(xstr, 1, strlen(xstr), stdout);
> +			fwrite("\n", 1, 1, stdout);
> +		}
> +	}
> +	free(values.items);

OK, this location makes more sense to me for handling --default. I think
it's still a bit lower in the function than I'd expect, though.

The loop just above the code you added is showing all of the values we
found. So I think that's the spot where'd say "we didn't find any
values; pretend like we found default_value". Including, I think, making
sure that the return value from the function is still 0. So realy right
after config_with_options() returns, I'd expect to check something like:

  if (!values.nr && default_value) {
          /* insert default_value into values list */
  }

We'd also want to use format_config(), not normalize_config(). We do
format_config() to show values, whereas normalize_config() is usually
for values we're putting into a config file (so for example TYPE_PATH
doesn't get normalized, but we would want it converted here to show the
user).

I'm also not sure that we need to check "types" as you have here.
Wouldn't we want to apply the default regardless of type, and let
format_config() handle it?

> @@ -272,6 +281,7 @@ static int get_value(const char *key_, const char *regex_)
>  	return ret;
>  }
>  
> +
>  static char *normalize_value(const char *key, const char *value)

Watch out for stray changes like this one creeping into your commits.

> diff --git a/t/t4026-color2.sh b/t/t4026-color2.sh
> deleted file mode 100755
> index 695ce9dd6f8d4..0000000000000

This part is obviously good and rectifying the problem from patch 3.
Once they're squashed together, we won't see it at all. :)

-Peff
