Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43630C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 22:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjCCW4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 17:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjCCWzq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 17:55:46 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C5FB
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 14:55:19 -0800 (PST)
Received: (qmail 5711 invoked by uid 109); 3 Mar 2023 22:54:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Mar 2023 22:54:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32013 invoked by uid 111); 3 Mar 2023 22:54:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Mar 2023 17:54:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Mar 2023 17:54:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: Re: `git bundle create -` may not write to `stdout`
Message-ID: <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
 <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
 <xmqqv8jhcvrq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8jhcvrq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2023 at 02:31:05PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The most directed fix is this:
> >
> > diff --git a/builtin/bundle.c b/builtin/bundle.c
> > index acceef6200..145b814f48 100644
> > --- a/builtin/bundle.c
> > +++ b/builtin/bundle.c
> > @@ -59,7 +59,9 @@ static int parse_options_cmd_bundle(int argc,
> >  			     PARSE_OPT_STOP_AT_NON_OPTION);
> >  	if (!argc)
> >  		usage_msg_opt(_("need a <file> argument"), usagestr, options);
> > -	*bundle_file = prefix_filename(prefix, argv[0]);
> > +	*bundle_file = strcmp(argv[0], "-") ?
> > +		       prefix_filename(prefix, argv[0]) :
> > +		       xstrdup(argv[0]);
> >  	return argc;
> >  }
> 
> This fell thru cracks, it seems.

I was waiting to give Michael a chance to respond to my offer. :)

> OPT_FILENAME() needs to do exactly this, and has its own helper
> function in parse-options.c::fix_filename(), but its memory
> ownership rules is somewhat screwed (it was perfectly fine in the
> original context of "we parse the bounded number of options the user
> would give us from the command line, and giving more than one
> instance of these last-one-wins option may leak but we do not
> care---if you do not like leaking, don't give duplicates", but with
> automated leak checking that does not care about such nuances, it
> will trigger unnecessary errors), and cannot be reused here.

Heh, I was worried about it kicking in for spots that "-" was not
meaningful, but I checked only prefix_filename() itself, and didn't
think to check OPT_FILENAME()'s full code path.

(I do still think we don't want to push it down into prefix_filename(),
because it gets used for paths and pathspecs given raw on the command
line. It does make me wonder if there are places where OPT_FILENAME() is
doing the wrong thing).

> Here is your "most directed fix" packaged into a call to a helper
> function.  Given that we may want to slim the cache.h header, it may
> not want to be declared there, but for now, its declaration sits
> next to prefix_filename().

Yeah, a helper may be nice, though if this is the only spot, I'd be
tempted not to even bother until fix_filename() is fixed. The obvious
fix is for it to always allocate, but callers will need to be adjusted.
I suspect it will trigger a bunch of complaints from the leak-checking
tests (because the caller does not expect it to be allocated, so it's a
sometimes-leak now, but it will become an always-leak).

> diff --git c/t/t6020-bundle-misc.sh w/t/t6020-bundle-misc.sh
> index 7d40994991..d14f7cea91 100755
> --- c/t/t6020-bundle-misc.sh
> +++ w/t/t6020-bundle-misc.sh
> @@ -606,4 +606,15 @@ test_expect_success 'verify catches unreachable, broken prerequisites' '
>  	)
>  '
>  
> +test_expect_success 'send a bundle to standard output' '
> +	git bundle create - --all HEAD >bundle-one &&
> +	mkdir -p down &&
> +	git -C down bundle create - --all HEAD >bundle-two &&
> +	git bundle verify bundle-one &&
> +	git bundle verify bundle-two &&
> +	git ls-remote bundle-one >expect &&
> +	git ls-remote bundle-two >actual &&
> +	test_cmp expect actual
> +'

This test looks good to me. Let's also not forget about the doc fixes. I
don't think there's much urgency to get this into v2.40, but I can put
it together in the next day or three.

-Peff
