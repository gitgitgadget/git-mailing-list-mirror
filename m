From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 11/11] Document protocol version 2
Date: Thu, 4 Jun 2015 09:18:52 -0400
Message-ID: <20150604131852.GB12404@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-12-git-send-email-sbeller@google.com>
 <xmqqsiafazr7.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbELvZ6otnNwGHsgiC9EjgS2vrDGU2KCgF2c_Azm=-rWg@mail.gmail.com>
 <xmqqk2vraw6p.fsf@gitster.dls.corp.google.com>
 <20150529222120.GB15678@peff.net>
 <CAGZ79kaRTLX7eBCOA=yQHVwcN-H-o_aZFfQ1gw7Nx-NC82pbag@mail.gmail.com>
 <CAGZ79kYD--dZ_V=_X_Eo31KYTKXt2njuf56XqRRdaTJeLhDjaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 15:19:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0V2x-0006Le-L5
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 15:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbbFDNS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 09:18:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:41088 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752103AbbFDNSz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 09:18:55 -0400
Received: (qmail 30013 invoked by uid 102); 4 Jun 2015 13:18:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 08:18:54 -0500
Received: (qmail 31940 invoked by uid 107); 4 Jun 2015 13:18:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 09:18:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jun 2015 09:18:52 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYD--dZ_V=_X_Eo31KYTKXt2njuf56XqRRdaTJeLhDjaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270774>

On Mon, Jun 01, 2015 at 04:40:54PM -0700, Stefan Beller wrote:

> Thinking about this further, maybe it is a good idea to restrict the
> capabilities advertising to alphabetical order?

This seems like an unnecessary restriction. The main impetus seems to
be:

> So how does parse_capability scale w.r.t the number of capabilities?
> If parse_capability is just a linear search then it is O(n) and with n
> capabilities the client faces an O(n^2) computation which is bad. So
> if we were to require alphabetic capabilities, you could internally
> keep track and the whole operation is O(n). I just wonder if this is
> premature optimization or some thought we need to think of.

but that is an implementation problem, not a protocol problem. The
parsing side can easily use something better than O(n) lookups (e.g., a
binary search). I think we can live with O(n lg n) to parse the whole
list. A true in-order merge would be O(n), but the difference is
probably negligible here, because...

> Now if we assume the number of capabilities grows over time a lot
> (someone may "abuse" it for a cool feature, similar to the refs
> currently. Nobody thought about having so many refs in advance)

I think if it grows without bound, we are doing it wrong. We should
generally only be adding capabilities that require a single short tag in
the list (server supports "foo", client asks for "foo"). I'd find it
acceptable to add ones that repeat, as long as we are very sure that the
repetition is going to be small, or scales with the size of the config
(e.g., servers says "here is a mirror you can seed from; here is another
mirror you can seed from").

We should definitely _not_ add anything that scales with the repository
size. For instance, the "symref" field only shows the "HEAD" now. That's
OK, as it's constant size. We do not show _all_ symrefs right now
because of pkt-line length limitations. With v2, we could in theory
start doing so (one per pkt-line). But that does not make it a good
idea. The right way to implement that is:

  1. the server says "I can tell you about symrefs"

  2. client says "OK, I understand how to parse your symref data"

  3. for each ref in the advertisement, tack on "\0symref=..." (or
     whatever).

The capability portion of the conversation remains constant-sized, and
the O(# of refs) portion is part of the ref advertisement, which is
inherently of that magnitude.

-Peff
