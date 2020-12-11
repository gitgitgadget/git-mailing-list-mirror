Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A031AC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703EE207A6
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405668AbgLKNVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:21:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:58096 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406124AbgLKNVm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 08:21:42 -0500
Received: (qmail 8794 invoked by uid 109); 11 Dec 2020 13:21:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Dec 2020 13:21:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6385 invoked by uid 111); 11 Dec 2020 13:21:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Dec 2020 08:21:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Dec 2020 08:21:01 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 3/3] config: store "git -c" variables using more robust
 format
Message-ID: <X9NyPfvPjgg1mfZH@coredump.intra.peff.net>
References: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
 <X9D5SnXca2rGnJFl@coredump.intra.peff.net>
 <87pn3hwfd5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pn3hwfd5.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 09:55:18PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> > index bd602e7720..e06961767f 100755
> > --- a/t/t1300-config.sh
> > +++ b/t/t1300-config.sh
> > @@ -1413,6 +1413,14 @@ test_expect_success 'git -c and --config-env override each other' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success '--config-env handles keys with equals' '
> > +	echo value=with=equals >expect &&
> > +	ENVVAR=value=with=equals git \
> > +		--config-env=section.subsection=with=equals.key=ENVVAR \
> > +		config section.subsection=with=equals.key >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> 
> Maybe worth adding a test for the strrchr() semantics here with:
> 
>     perl -we '$ENV{"Y=Z"}="why and zed"; system "Z=zed git --config-env=X=Y=Z ..."'
> 
> Which would show that we can't look up "Y=Z", but will always get "Z".

We're already testing those here, though. If we used strchr(), then we'd
end up setting section.subsection in the above test.

I.e., your X=Y=Z can be tested in either of two ways:

  - check that X=Y is set to $Z

  - check that X is not set to Y=Z

It's sufficient to test only one, because success in one implies the
other. And of the two, I think testing the first is much more
interesting (because testing "this expected thing happened" is much more
robust than "this unexpected thing didn't happen").

> I.e. I can't imagine someone wants an env var with "=" in it, even
> though POSIX makes such a thing possible (you just can't do it in a
> shellscript).

Yeah, I'm definitely OK with that limitation, but we should document it.

-Peff
