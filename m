Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0815BC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 11:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6B9610CD
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 11:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhFPLwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 07:52:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:57434 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhFPLwv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 07:52:51 -0400
Received: (qmail 12726 invoked by uid 109); 16 Jun 2021 11:50:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jun 2021 11:50:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25923 invoked by uid 111); 16 Jun 2021 11:50:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jun 2021 07:50:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Jun 2021 07:50:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] test-lib: fix "$remove_trash" regression and
 match_pattern_list() bugs
Message-ID: <YMnllMXvRJKSdGID@coredump.intra.peff.net>
References: <xmqqa6nqsd2i.fsf@gitster.g>
 <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
 <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net>
 <xmqqeed2p3jx.fsf@gitster.g>
 <YMnRC8v4RLDk2+K9@coredump.intra.peff.net>
 <87k0muxcd7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0muxcd7.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 01:38:55PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > +	# We need to use "$*" to get field-splitting, but we want to
> > +	# disable globbing, since we are matching against an arbitrary
> > +	# $arg, not what's in the filesystem. Using "set -f" accomplishes
> > +	# that, but we must do it in a subshell to avoid impacting the
> > +	# rest of the script. The exit value of the subshell becomes
> > +	# the function's return value.
> > +	(
> > +		set -f
> > +		for pattern_ in $*
> > +		do
> > +			case "$arg" in
> > +			$pattern_)
> > +				exit 0
> > +				;;
> > +			esac
> > +		done
> > +		exit 1
> > +	)
> >  }
> 
> Why not just start with a ret=1, set ret=0 if we have a match and break
> from the loop, and then do a "set +f" afterwards? I.e. is there an
> actual need for the subshell here.

My thought was that the subshell takes us back to the original state,
regardless of what it was. As opposed to "set +f" which takes us back to
a particular state. But it is unlikely that we'd have done a global "set
-f" before calling this, so maybe that is being overly conservative.

> I'm mildly paranoid about a new "set -<flag>" in the codebase for vague
> fears of portability (as noted in my linked message), but whatever shell
> supports "set -<flag>" surely supports the inverse with "set +<flag>",
> no?

Yes, I think we can assume that if it supports one, it supports the
other.

-Peff
