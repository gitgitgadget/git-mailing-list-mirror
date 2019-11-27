Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27B9C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6FF2070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfK0LtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:49:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:33744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726383AbfK0LtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 06:49:09 -0500
Received: (qmail 10611 invoked by uid 109); 27 Nov 2019 11:49:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 11:49:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9477 invoked by uid 111); 27 Nov 2019 11:53:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 06:53:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 06:49:08 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule--helper: advise on fatal alternate error
Message-ID: <20191127114908.GD22221@sigill.intra.peff.net>
References: <cover.1574731649.git.jonathantanmy@google.com>
 <26c3b388a24eef7f03eb423c10e21430bc3f019e.1574731649.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26c3b388a24eef7f03eb423c10e21430bc3f019e.1574731649.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 05:31:00PM -0800, Jonathan Tan wrote:

> When recursively cloning a superproject with some shallow modules
> defined in its .gitmodules, then recloning with "--reference=<path>", an
> error occurs. For example:
> 
>   git clone --recurse-submodules --branch=master -j8 \
>     https://android.googlesource.com/platform/superproject \
>     master
>   git clone --recurse-submodules --branch=master -j8 \
>     https://android.googlesource.com/platform/superproject \
>     --reference master master2
> 
> fails with:
> 
>   fatal: submodule '<snip>' cannot add alternate: reference repository
>   '<snip>' is shallow
> 
> When a alternate computed from the superproject's alternate cannot be
> added, whether in this case or another, advise about configuring the
> "submodule.alternateErrorStrategy" configuration option and using
> "--reference-if-able" instead of "--reference" when cloning.

It sounds like that advice sends people in the right direction, which is
a good thing.

I kind of wonder if the default for alternateErrorStrategy should be
more lenient, but I don't really know much about the feature in the
first place. I'll let people who are more clueful ponder that, but
certainly your patch is an improvement in the meantime.

One minor suggestion:

> +static void advise_submodule_alternate_error_die(void)
> +{
> +	if (!advice_submodule_alternate_error_strategy_die)
> +		return;
> +	advise(_("An alternate computed from a superproject's alternate is invalid."));
> +	advise(_("To allow Git to clone without an alternate in such a case, set submodule.alternateErrorStrategy to 'info' or, equivalently, clone with '--reference-if-able' instead of '--reference'."));
> +}

The advise() function handles newlines gracefully (putting a "hint:" at
the start of each line). So you can put both in a single call, and wrap
the second long line, which also lets translators see the whole message
as a unit. Many of the existing calls define the message outside of any
function (e.g., embedded_advice), which makes it easier to see how long
the lines will be when displayed.

So maybe:

  static const alternate_error_advice[] = N_(
  "An alternate computed from a superproject's alternate is invalid.\n"
  "To allow Git to clone without an alternate in such a case, set\n"
  "submodule.alternateErrorStrategy to 'info' or, equivalently, clone with\n"
  "'--reference-if-able' instead of '--reference'."
  );

  ...
	switch (sas->error_mode) {
	case SUBMODULE_ALTERNATE_ERROR_DIE:
		if (advice_submodule_alternate_error_strategy_die)
			advise(_(alternate_error_advice));
		die(...);

?

-Peff
