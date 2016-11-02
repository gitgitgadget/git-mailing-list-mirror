Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C2B20193
	for <e@80x24.org>; Wed,  2 Nov 2016 23:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756599AbcKBXFn (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 19:05:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:37744 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755963AbcKBXFm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 19:05:42 -0400
Received: (qmail 25824 invoked by uid 109); 2 Nov 2016 23:05:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 23:05:41 +0000
Received: (qmail 7458 invoked by uid 111); 2 Nov 2016 23:06:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 19:06:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 19:05:39 -0400
Date:   Wed, 2 Nov 2016 19:05:39 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161102230538.jx3jwa4hqgrrltno@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1478125247-62372-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 03:20:47PM -0700, Brandon Williams wrote:

> Add configuration option 'core.allowProtocol' to allow users to create a
> whitelist of allowed protocols for fetch/push/clone in their gitconfig.
> 
> For git-submodule.sh, fallback to default whitelist only if the user
> hasn't explicitly set `GIT_ALLOW_PROTOCOL` or doesn't have a whitelist
> in their gitconfig.

This says "what", but not "why". What's the use case?

I can see somebody wanting to pare down the whitelist further (e.g.,
because they are carrying ssh credentials that they don't want to use on
behalf of a malicious repo). But in general I'd expect this setting to
be a function of the environment you're operating in, and not the
on-disk config.

Or is the intent to broaden it for cases where you have a clone that
uses some non-standard protocol, and you want it to Just Work on
subsequent recursive fetches?

> +core.allowProtocol::
> +	Provide a colon-separated list of protocols which are allowed to be
> +	used with fetch/push/clone. This is useful to restrict recursive
> +	submodule initialization from an untrusted repository. Any protocol not
> +	mentioned will be disallowed (i.e., this is a whitelist, not a
> +	blacklist). If the variable is not set at all, all protocols are
> +	enabled. If the `GIT_ALLOW_PROTOCOL` enviornment variable is set, it is
> +	used as the protocol whitelist instead of this config option.

The "not set at all, all protocols are enabled" bit is not quite
correct, is it? It is true for a top-level fetch, but not for submodule
recursion (and especially since you are talking about submodule
recursion immediately before, it is rather confusing).

> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -27,7 +27,8 @@ cd_to_toplevel
>  #
>  # If the user has already specified a set of allowed protocols,
>  # we assume they know what they're doing and use that instead.
> -: ${GIT_ALLOW_PROTOCOL=file:git:http:https:ssh}
> +config_whitelist=$(git config core.allowProtocol)
> +: ${GIT_ALLOW_PROTOCOL=${config_whitelist:-file:git:http:https:ssh}}

The original uses "=" without a ":" so that an empty variable takes
precedence over the stock list (i.e., allowing nothing). Would you want
the same behavior for the config variable? I.e.:

  # this should probably allow nothing, right?
  git config core.allowProtocol ""

I think you'd have to check the return code of "git config" to
distinguish those cases.

> diff --git a/transport.c b/transport.c
> index d57e8de..b1098cd 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -652,7 +652,7 @@ static const struct string_list *protocol_whitelist(void)
>  
>  	if (enabled < 0) {
>  		const char *v = getenv("GIT_ALLOW_PROTOCOL");
> -		if (v) {
> +		if (v || !git_config_get_value("core.allowProtocol", &v)) {
>  			string_list_split(&allowed, v, ':', -1);
>  			string_list_sort(&allowed);
>  			enabled = 1;

I thought at first we'd have to deal with leaking "v", but "get_value"
is the "raw" version that gives you the uninterpreted value. I think
that means it may give you NULL, though if we see an implicit bool like:

  [core]
  allowProtocol

That's nonsense, of course, but we would still segfault. I
think the easiest way to test is:

  git -c core.allowProtocol fetch

which seems to segfault for me with this patch.

-Peff
