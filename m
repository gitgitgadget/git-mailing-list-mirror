Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1871FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 06:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdDAGBV (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 02:01:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:55250 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbdDAGBU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 02:01:20 -0400
Received: (qmail 21535 invoked by uid 109); 1 Apr 2017 06:01:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 06:01:18 +0000
Received: (qmail 15858 invoked by uid 111); 1 Apr 2017 06:01:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 02:01:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 02:01:16 -0400
Date:   Sat, 1 Apr 2017 02:01:16 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] http.postbuffer: allow full range of ssize_t values
Message-ID: <20170401060116.b2v7tyoi7fcxwbvo@sigill.intra.peff.net>
References: <20170331172631.12024-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170331172631.12024-1-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 01:26:31PM -0400, David Turner wrote:

> Unfortunately, in order to push some large repos, the http postbuffer
> must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
> we just malloc a larger buffer.

I'm still not sure why a 2GB post-buffer is necessary. It sounds like
something is broken in your setup. Large pushes should be sent chunked.

I know broken setups are a fact of life, but this feels like a really
hacky work-around.

> diff --git a/cache.h b/cache.h
> index fbdf7a815a..5e6747dbb4 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1900,6 +1900,7 @@ extern int git_parse_maybe_bool(const char *);
>  extern int git_config_int(const char *, const char *);
>  extern int64_t git_config_int64(const char *, const char *);
>  extern unsigned long git_config_ulong(const char *, const char *);
> +extern ssize_t git_config_ssize_t(const char *, const char *);

For most of our other "big" values we use git_config_ulong(). E.g.,
core.bigfilethreshold. I suspect that would be fine for your purposes
here, though using size_t is more correct (on Windows "unsigned long" is
still only 32 bits, even on 64-bit systems).

The ultimate fate of this number, though, is to be handed to:

  curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, rpc->len);

where the final argument is interpreted as a long. So I suspect that on
64-bit Windows, setting http.postbuffer to "3G" would cause some kind of
weird error (either a truncated post or some internal curl error due to
the negative size, depending on how curl handles it). And in that sense
it's worse than the status quo, which rejects this at the config level.

I think a "git_config_long()" would probably do everything correctly.

> +static int git_parse_ssize_t(const char *value, ssize_t *ret)
> +{
> +	ssize_t tmp;
> +	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
> +		return 0;
> +	*ret = tmp;
> +	return 1;
> +}

I saw the earlier iteration used a size_t, but you switched it after the
compiler (rightfully) complained about the signedness. But I'm not sure
why we would want ssize_t here instead of just using git_parse_unsigned().

All of that's moot if we switch to parsing it as a "long" anyway,
though.

-Peff
