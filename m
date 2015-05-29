From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 11/11] Document protocol version 2
Date: Fri, 29 May 2015 18:21:20 -0400
Message-ID: <20150529222120.GB15678@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-12-git-send-email-sbeller@google.com>
 <xmqqsiafazr7.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbELvZ6otnNwGHsgiC9EjgS2vrDGU2KCgF2c_Azm=-rWg@mail.gmail.com>
 <xmqqk2vraw6p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 30 00:21:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YySee-0001Hf-EV
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 00:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190AbbE2WVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 18:21:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:37958 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756834AbbE2WVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 18:21:23 -0400
Received: (qmail 27635 invoked by uid 102); 29 May 2015 22:21:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 17:21:23 -0500
Received: (qmail 9790 invoked by uid 107); 29 May 2015 22:21:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 18:21:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2015 18:21:20 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2vraw6p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270276>

On Fri, May 29, 2015 at 02:52:14PM -0700, Junio C Hamano wrote:

> > Currently we can do a = as part of the line after the first ref, such as
> >
> >     symref=HEAD:refs/heads/master agent=git/2:2.4.0
> >
> > so I thought we want to keep this.
> 
> I do not understand that statement.
> 
> Capability exchange in v2 is one packet per cap, so the above
> example would be expressed as:
> 
> 	symref=HEAD:refs/heads/master
>         agent=git/2:2.4.0
> 
> right?  Your "keyvaluepair" is limited to [a-z0-9-_=]*, and neither
> of the above two can be expressed with that, which was why I said
> you need two different set of characters before and after "=".  Left
> hand side of "=" is tightly limited and that is OK.  Right hand side
> may contain characters like ':', '.' and '/', so your alphabet need
> to be more lenient, even in v1 (which I would imagine would be "any
> octet other than SP, LF and NUL").

Yes. See git_user_agent_sanitized(), for example, which allows basically
any printable ASCII except for SP.

I think the v2 capabilities do not even need to have that restriction.
It can allow arbitrary binary data, because it has an 8bit-clean framing
mechanism (pkt-lines). Of course, that means such capabilities cannot be
represented in a v1 conversation (whose framing mechanism involves SP
and NUL). But it's probably acceptable to introduce new capabilities
which are only available in a v2 conversation. Old clients that do not
understand v2 would not understand the capability either. It does
require new clients implementing the capability to _also_ implement v2
if they have not done so, but I do not mind pushing people in that
direction.

The initial v2 client implementation should probably do a few cautionary
things, then:

  1. Do _not_ fold the per-pkt capabilities into a v1 string; that loses
     the robust framing. I suggested string_list earlier, but probably
     we want a list of ptr/len pair, so that it can remain NUL-clean.

  2. Avoid holding on to unknown packets longer than necessary. Some
     capability pkt-lines may be arbitrarily large (up to 64K). If we do
     not understand them during the v2 read of the capabilities, there
     is no point hanging on to them. It's not _wrong_ to do so, but just
     inefficient; if we know that clients will just throw away unknown
     packets, then we can later introduce new packets with large data,
     without worrying about wasting the client's resources.

     I suspect it's not that big a deal either way, though. I have no
     plans for sending a bunch of large packets, and anyway network
     bandwidth is probably more precious than client memory.

-Peff
