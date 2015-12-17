From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Thu, 17 Dec 2015 02:44:43 -0500
Message-ID: <20151217074443.GA4830@sigill.intra.peff.net>
References: <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
 <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
 <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
 <xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
 <CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
 <xmqqy4cvco25.fsf@gitster.mtv.corp.google.com>
 <20151216024605.GA618@sigill.intra.peff.net>
 <xmqqwpsfdl5y.fsf@gitster.mtv.corp.google.com>
 <xmqqoadrdj22.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 08:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9TF5-0002Ph-FA
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 08:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbbLQHor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 02:44:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:43469 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750811AbbLQHoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 02:44:46 -0500
Received: (qmail 9013 invoked by uid 102); 17 Dec 2015 07:44:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 01:44:46 -0600
Received: (qmail 9632 invoked by uid 107); 17 Dec 2015 07:44:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 02:44:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Dec 2015 02:44:43 -0500
Content-Disposition: inline
In-Reply-To: <xmqqoadrdj22.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282635>

On Tue, Dec 15, 2015 at 10:05:57PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > This is why the_index.has_untracked_cache is not just a simple "Do I
> > want to use this feature?" boolean configuration.  The index also
> > stores the real data, and "Am I using this feature?" bit goes hand
> > in hand with that real data.  Thinking that this is merely a boolean
> > configuration is the real source of the confusion, and introducing a
> > config that overrules what the user has stored in the index needs to
> > add complexity.
> >
> > The additional complexity may (or may not) be justifiable, but in
> > any case "all other things being equal, this is a config" feels like
> > a flawed observation.
> 
> To put it another way, the "bit" in the index (i.e. the presence of
> the cached data) is "Am I using the feature now?".  The effect of
> the feature has to (and is designed to) persist, as it is a cache
> and you do not want a stale cache to give you wrong answers.  There
> is no "Do I want to use the feature?" preference, in other words.
> 
> And I do not mind creating such a preference bit as a configuration.
> 
> That is why I suggested such a configuration to cause the equivalent
> of "update-index --untracked-cache" when a new index is created from
> scratch (as opposed to the case where the previously created cache
> data is carried forward across read_cache() -> do things to the
> index -> write_cache() flow).  Doing it that way will not have to
> involve additional complexity that comes from the desire that
> setting a single configuration on (or off) has to suddenly change
> the behaviour of an index file that is already using (or not using)
> the feature.

I think we may actually be thinking of the same thing. Naively, I would
expect:

  - if there is untracked cache data in the index, we will make use of
    it when enumerating untracked files (and my understanding is that if
    it is stale, we can detect that)

  - if core.untrackedCache is set, we will update and write out an
    untracked cache when we are enumerating the untracked files

  - if there is cache data in the index but that config flag is not set,
    presumably we would not update it (we could even explicitly drop it,
    but my understanding is that is not necessary for correctness, but
    only as a possible optimization).

You could have a config option for "if there is a cache there, pretend
it isn't and ignore it", but I don't see much point.

-Peff
