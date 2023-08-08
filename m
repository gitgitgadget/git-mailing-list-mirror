Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F5C001E0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 21:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjHHV1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHHV1W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 17:27:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113E890
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 14:27:21 -0700 (PDT)
Received: (qmail 12898 invoked by uid 109); 8 Aug 2023 21:27:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Aug 2023 21:27:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24523 invoked by uid 111); 8 Aug 2023 21:27:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Aug 2023 17:27:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Aug 2023 17:27:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
Message-ID: <20230808212720.GA760752@coredump.intra.peff.net>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
 <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2023 at 03:41:33PM +0200, René Scharfe wrote:

> +static int option_parse_exact_match(const struct option *opt, const char *arg,
> +				    int unset)
> +{
> +	BUG_ON_OPT_ARG(arg);
> +
> +	max_candidates = unset ? DEFAULT_CANDIDATES : 0;
> +	return 0;
> +}

I wanted to call out a style question here. The "opt" parameter is
unused, since it manipulates the "max_candidates" global directly. I can
add an UNUSED annotation to satisfy -Wunused-parameter, but in such
cases I've usually been modifying them like:

  int *value = opt->value;
  ...
  *value = unset ? DEFAULT_CANDIDATES : 0;

so that the callback operates on the value passed in the options list.

But I see you converted that value to NULL here:

> @@ -568,8 +578,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
>  		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first parent")),
>  		OPT__ABBREV(&abbrev),
> -		OPT_SET_INT(0, "exact-match", &max_candidates,
> -			    N_("only output exact matches"), 0),
> +		OPT_CALLBACK_F(0, "exact-match", NULL, NULL,
> +			       N_("only output exact matches"),
> +			       PARSE_OPT_NOARG, option_parse_exact_match),

so at least the result does not have the subtle gotcha that existed in
other cases I changed. :)

So before I sent a patch (either to switch to using opt->value, or to
add an UNUSED annotation), I wanted to see what you (or others) thought
between the two. I.e., should we have a rule of "try not to operate on
global data via option callbacks" or is that just being too pedantic for
one-off callbacks like this?

-Peff
