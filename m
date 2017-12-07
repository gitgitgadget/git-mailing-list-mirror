Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D77B20C32
	for <e@80x24.org>; Thu,  7 Dec 2017 00:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbdLGA4m (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 19:56:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:50446 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751941AbdLGA4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 19:56:41 -0500
Received: (qmail 2842 invoked by uid 109); 7 Dec 2017 00:56:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Dec 2017 00:56:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16805 invoked by uid 111); 7 Dec 2017 00:57:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 06 Dec 2017 19:57:02 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Dec 2017 19:56:39 -0500
Date:   Wed, 6 Dec 2017 19:56:39 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: git commit file completion recently broke
Message-ID: <20171207005639.GB1975@sigill.intra.peff.net>
References: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
 <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
 <20171207002234.GA21003@sigill.intra.peff.net>
 <20171207002439.GB21003@sigill.intra.peff.net>
 <CA+P7+xpoaa5zaF13ageKKjpPKTECU6XjaRdSZy6WOP7Q0TX+yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xpoaa5zaF13ageKKjpPKTECU6XjaRdSZy6WOP7Q0TX+yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 06, 2017 at 04:38:29PM -0800, Jacob Keller wrote:

> >> But nope, it looks like the culprit is f7923a5ece (diff: use
> >> skip_to_optional_val(), 2017-12-04), which switched over parsing of
> >> "--relative".
> >
> > Oh, actually, I guess I was half-right. It feeds &options->prefix as the
> > "default", meaning that we overwrite it with the empty string. I don't
> > think "--relative" works for the semantics of skip_to_optional_value,
> > since it needs:
> >
> >   --relative=foo: set prefix to "foo"
> >
> >   --relative: leave prefix untouched
> >
> > -Peff
> 
> Yep, and apparently our test suite completely lacked any tests of
> --relative on its own.
> 
> I've sent a patch to add some tests.

Great. I was also saddened by our lack of tests.

> I don't know the exact best way to fix this, I guess we could just
> revert it the changes to relative... but maybe we could add or modify
> the semantics of skip_to_optional_val()?? What if it was changed so
> that it left the value alone if no value was provided? This would
> require callers to pre-set the value they want as default, but that
> would solve relative's problem.

I think that would work for this case. But just looking at others from
the same series, I think they'd get pretty awkward. For instance we now
have:

  else if (!strcmp(arg, "--color))
	options->use_color = 1;
  else if (skip_prefix(arg, "--color=", &arg))
	/* parse "arg" as colorbool */

which became:

  else if (skip_to_optional_val_default(arg, "--color", &arg, "always"))
	/* parse "arg" as colorbool */

How would that look with the "leave it alone instead of assigning a
default" semantics? It gets pretty clumsy, because you have to
pre-assign "always" to some pointer. But then we can't reuse "arg", so
we end up with something more like:

  const char *color_val = "always";
  ...
  else if (skip_to_optional_val(arg, "--color", &color_val))

But we need one such "color_val" for every option we test for, and we
have to set all of them up before any matches (because we don't know
which one we'll actually match). Yuck.

I think we'd do better to just assign NULL when there's "=", so we can
tell the difference between "--relative", "--relative=", and
"--relative=foo" (all of which are distinct).

I think that's possible with the current scheme by doing:

  else if (skip_to_optional_val_default(arg, "--relative", &arg, NULL)) {
	options->flags.relative_name = 1;
	if (arg)
		options->prefix = arg;
  }

IOW, the problem isn't in the design of the skip function, but just how
it was used in this particular case. I do think it may make sense for
the "short" one to use NULL, like:

  skip_to_optional_val(arg, "--relative, &arg)

but maybe some other callers would be more inconvenienced (they may have
to current NULL back into the empty string if they want to string
"--foo" the same as "--foo=").

-Peff
