From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Fri, 9 Aug 2013 07:00:00 -0400
Message-ID: <20130809110000.GD18878@sigill.intra.peff.net>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
 <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
 <7v61vihg6k.fsf@alter.siamese.dyndns.org>
 <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
 <7va9ksbqpl.fsf@alter.siamese.dyndns.org>
 <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org>
 <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org>
 <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 13:00:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7kQW-0007W4-FY
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 13:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967404Ab3HILAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 07:00:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:46408 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966958Ab3HILAE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 07:00:04 -0400
Received: (qmail 29300 invoked by uid 102); 9 Aug 2013 11:00:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Aug 2013 06:00:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Aug 2013 07:00:00 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231971>

On Fri, Aug 09, 2013 at 01:34:48AM +0530, Ramkumar Ramachandra wrote:

> Certainly. A push will never use an existing pack as-is, as it's very
> highly unlikely that the server requested exactly what gc --auto
> packed for us locally.
> 
> Sure, undeltified objects in the pack are probably better for push
> performance, but I'm talking about the majority: deltified objects.
> Don't you need to apply the deltas (ie. explode the pack), before you
> can recompute the deltas for the information you're sending across for
> the push?

It depends on what each side has it, doesn't it? We generally try to
reuse on-disk deltas when we can, since they require no computation. If
I have object A delta'd against B, and I know that the other side wants
A and has B (or I am also sending B), I can simply send what I have on
disk. So we do not just blit out the existing pack as-is, but we may
reuse portions of it as appropriate.

Of course we may have to reconstruct deltas for trees in order to find
the correct set of objects (i.e., the history traversal). But that is a
separate phase from generating the pack's object content, and we do not
reuse any of the traversal work in later phases.

-Peff
