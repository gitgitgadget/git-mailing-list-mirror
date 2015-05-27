From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 04/11] upload-pack-2: Implement the version 2 of
 upload-pack
Date: Wed, 27 May 2015 16:34:52 -0400
Message-ID: <20150527203451.GD14309@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-5-git-send-email-sbeller@google.com>
 <20150527063558.GB885@peff.net>
 <CAGZ79kYaoViDrz9TKXWebif4mfyUjzJ6b3id8ozTqtwsmjAC1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:35:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxi2V-0006Th-HP
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbbE0Uey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:34:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:36843 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751492AbbE0Uey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:34:54 -0400
Received: (qmail 12687 invoked by uid 102); 27 May 2015 20:34:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 15:34:54 -0500
Received: (qmail 10195 invoked by uid 107); 27 May 2015 20:34:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:34:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 16:34:52 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYaoViDrz9TKXWebif4mfyUjzJ6b3id8ozTqtwsmjAC1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270085>

On Wed, May 27, 2015 at 10:40:37AM -0700, Stefan Beller wrote:

> > If we are upload-pack-2, should we advertise that in the capabilities? I
> > think it may make things easier later if we try to provide some
> > opportunistic out-of-band data. E.g., if see tell git-daemon:
> >
> >   git-upload-pack repo\0host=whatever\0\0version=2
> >
> > how do we know whether version=2 was understood and kicked us into v2
> > mode, versus an old server that ignored it?
> 
> So in my vision we would call git-upload-pack-2 instead of having a "version=2".
> and if git-upload-pack-2 doesn't exist, the whole conversation is
> over, the client
> it is left to make up some good error message or retry version 1.

I'd like for that to be a starting point for us, and then to be able to
add-on "hints" to ease the transition path in whatever way we want. We
may even not do that in the long run, but I want to leave the door open
if we can.

> But I think advertising both which versions the server could deal
> with, as well as
> the currently expected version is a good thing.
> 
> capability: can_speak=1,2
> capability: speaking_now=2

I was thinking just "speaking_now=2", but it probably makes sense to do
both. I do not think using it to "downgrade" will ever be particularly
useful (certainly not from v2 to v1, since to understand the flag both
sides must be v2 in the first place). But advertising that via the v1
conversation will be a good way to tell the other side that upgrade is
possible.

> > Also, do we need the capability noise-word?
> 
> I thought it opens up a new possible door in the future.
> As we ignore anything not starting with "capability" for now, you
> could introduce
> your foo and bar ping pong easily and still be version 2 compatible.
> 
> S: capability: thin
> S: capability: another-capability
> S: ping-pong foo
> S: done
> C: (not having understood ping-pong) just answering with capability: thin
> C: done, let's proceed to refs advertisement
> 
> The alternative client would do:
> 
> C: ping-pong: foo-data1a
> S: ping-pong: foo-data1b
> C: ping-pong: foo-data2a
> C: capability: thin
> ...

Right, but I think (and please correct me if there's a case I'm missing)
that the behavior is the same whether it is spelled "ping-pong" or
"capability:ping-pong". That is, the rule for "capability:" is "if you
do not understand it, ignore it and do not mention it in your
capabilities; the server is required to assume you were written before
that capability was invented". But that is _also_ the rule for
ping-pong, I think.

> > Eric mentioned the underflow problems here, but I wonder even more:
> > what's wrong with the global ends_with() that we already provide?
> 
> I was missing knowledge we have that, and apparently I was thinking it's
> faster to come up with my own version than to look for it. :)

Makes sense. :)

-Peff
