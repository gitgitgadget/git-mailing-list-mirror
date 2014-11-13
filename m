From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Thu, 13 Nov 2014 14:26:55 -0500
Message-ID: <20141113192655.GA3413@peff.net>
References: <20141107081324.GA19845@peff.net>
 <xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
 <20141107191745.GB5695@peff.net>
 <CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
 <CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
 <CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
 <20141108083040.GA15833@peff.net>
 <xmqqbnoge1ci.fsf@gitster.dls.corp.google.com>
 <20141113183033.GA24107@peff.net>
 <xmqqbnoa29ps.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 20:27:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp02p-0005bo-8q
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 20:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933697AbaKMT07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 14:26:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:40043 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933423AbaKMT05 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 14:26:57 -0500
Received: (qmail 11236 invoked by uid 102); 13 Nov 2014 19:26:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 13:26:57 -0600
Received: (qmail 30213 invoked by uid 107); 13 Nov 2014 19:27:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 14:27:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 14:26:55 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbnoa29ps.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 11:15:27AM -0800, Junio C Hamano wrote:

> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index 5410dac..67cab4e 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -65,21 +65,40 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
> >  static int update_some(const unsigned char *sha1, const char *base, int baselen,
> >  		const char *pathname, unsigned mode, int stage, void *context)
> >  {
> > ...
> >  }
> 
> Makes sense, including the use of strbuf (otherwise you would
> allocate ce and then discard when it turns out that it is not
> needed, which is probably with the same allocation pressure, but
> looks uglier).

Exactly. Constructing it in ce->name does save you an allocation/memcpy
in the case that we actually use the new entry, but I thought it would
look weirder. It probably doesn't matter much either way, so I tried to
write the most obvious thing.

(I also experimented with using make_cache_entry at one point, which
requires the strbuf; some of my thinking on what looks reasonable may be
left over from that approach).

> > +test_expect_success 'do not touch files that are already up-to-date' '
> > +	git reset --hard &&
> > +	echo one >file1 &&
> > +	echo two >file2 &&
> > +	git add file1 file2 &&
> > +	git commit -m base &&
> > +	echo modified >file1 &&
> > +	test-chmtime =1000000000 file2 &&
> 
> Is the idea behind the hardcoded timestamp that this is sufficiently
> old (Sep 2001) that we will not get in trouble comparing with the
> real timestamp we get from the filesystem (which will definitely newer
> than that anyway) no matter when we run this test (unless you have a
> time-machine, that is)?

I didn't actually calculate what the timestamp was. The important thing
is that it is not the timestamp that your system would give to the file
if git-checkout opened and rewrote it. :)

I initially used "123", but was worried that would cause weird
portability problems on systems. So I opted for something closer to
"normal", but in the past. I think it is fine (modulo time machines),
but I'd be happy to put in some more obvious sentinel, too.

And the worst case if you did have a time machine is that we might
accidentally declare a buggy git to be correct (racily!). I can live
with that, but I guess you could use a relative value (like "-10000")
instead of a fixed sentinel (but then you'd have to record it for the
"expect" check).

-Peff
