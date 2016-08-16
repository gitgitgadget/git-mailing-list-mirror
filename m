Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925E61F6C1
	for <e@80x24.org>; Tue, 16 Aug 2016 01:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbcHPBDN (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 21:03:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:55971 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932182AbcHPBDN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 21:03:13 -0400
Received: (qmail 26047 invoked by uid 109); 16 Aug 2016 01:03:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 01:03:12 +0000
Received: (qmail 21917 invoked by uid 111); 16 Aug 2016 01:03:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 21:03:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 21:03:09 -0400
Date:	Mon, 15 Aug 2016 21:03:09 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 3/3] receive-pack: allow a maximum input size to be
 specified
Message-ID: <20160816010309.zstrljqknc3vjziq@sigill.intra.peff.net>
References: <20160815195729.16826-1-chriscool@tuxfamily.org>
 <20160815195729.16826-4-chriscool@tuxfamily.org>
 <20160815204034.rrjn57wigxtjpgye@sigill.intra.peff.net>
 <xmqqr39pejhk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr39pejhk.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 03:48:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The simple fix is to call register_tempfile() in open_pack_file(), and
> > just have index-pack clean up the file on its way out.
> >
> > But there are harder cases. For instance, imagine somebody pushes a
> > 500MB file, and you have a pre-receive hook that says "too big; I won't
> > accept this". And then they push in a loop, as before. You've accepted
> > the incoming pack into the repository by the time the pre-receive runs.
> > You can't just delete it, because you don't know if other simultaneous
> > processes have started to depend on the objects.
> >
> > To solve that, I have patches that put incoming packfiles into a
> > "quarantine" area, then run the connectivity check and pre-receive hooks
> > with the quarantine accessible via GIT_ALTERNATE_OBJECT_DIRECTORIES. And
> > then we either move the quarantine packs into the real repo, or blow
> > away the tmpdir, depending on whether the hooks said the objects were
> > OK.
> >
> > Those are patches I plan to share upstream but just haven't gotten
> > around to yet.
> 
> I think these other patches can come later, independent from this
> three-patch series resurrected from the archive, so I can take a
> reroll of these once the integer-size issues you pointed out are
> sorted out.

Yeah, definitely it's independent. I was mostly suggesting to Christian
that he may want to look into the "easy" register_tempfile() case, as
GitLab may find this is only half of the fix that they want.

Also a patch I may try to polish and share in the future, but not as
high priority as some of the other stuff.

-Peff
