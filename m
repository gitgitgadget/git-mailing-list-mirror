From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/10] cat-file: add --batch-check=<format>
Date: Thu, 11 Jul 2013 07:24:13 -0400
Message-ID: <20130711112413.GC6015@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
 <20130710114546.GF21963@sigill.intra.peff.net>
 <CALkWK0=RtB2ddpGhZO0RAjzQXNfxHBE47bnp6KaVFz=Hicj8sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 13:24:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxEyy-0004ik-Av
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 13:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905Ab3GKLYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 07:24:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:57185 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471Ab3GKLYP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 07:24:15 -0400
Received: (qmail 26895 invoked by uid 102); 11 Jul 2013 11:25:33 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Jul 2013 06:25:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jul 2013 07:24:13 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=RtB2ddpGhZO0RAjzQXNfxHBE47bnp6KaVFz=Hicj8sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230086>

On Wed, Jul 10, 2013 at 08:21:15PM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > +If `--batch` or `--batch-check` is given, `cat-file` will read objects
> > +from stdin, one per line, and print information about them.
> > +
> > +You can specify the information shown for each object by using a custom
> > +`<format>`. The `<format>` is copied literally to stdout for each
> > +object, with placeholders of the form `%(atom)` expanded, followed by a
> > +newline. The available atoms are:
> > +
> > +If no format is specified, the default format is `%(objectname)
> > +%(objecttype) %(objectsize)`.
> > +
> > +If `--batch` is specified, the object information is followed by the
> > +object contents (consisting of `%(objectsize)` bytes), followed by a
> > +newline.
> 
> I find this slightly hideous, and would have expected an
> %(objectcontents) or similar.

I looked into doing that, but it makes the code significantly more
complicated, assuming you do not want to copy the full object contents
in memory. You cannot use strbuf_expand, and you need to worry about
buffering/flushing more (you do not want to write() each individual
item, but if you are using printf(), you need to flush before using the
unbuffered streaming interface).

My thinking was to leave it until somebody actually wants it, at which
point they can do the necessary refactoring (and hopefully this would be
part of unifying it with other format-parsers).

If we were designing from scratch and this was the difference between
having "--batch-check" and "--batch", or having a single "--batch", I'd
care more about doing %(objectcontents) right away. But because we must
support the historical --batch/--batch-check distinction anyway, I don't
think this is any worse.

-Peff
