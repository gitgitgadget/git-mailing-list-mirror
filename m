From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] upload-pack: keep poll(2)'s timeout to -1
Date: Fri, 22 Aug 2014 12:03:34 -0400
Message-ID: <20140822160334.GA20789@peff.net>
References: <20140822151911.GA8531@debian>
 <20140822154445.GA19135@peff.net>
 <xmqqr408plgj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 18:03:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKrJV-0004BG-K3
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 18:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbaHVQDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 12:03:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:56888 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932137AbaHVQDg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 12:03:36 -0400
Received: (qmail 6396 invoked by uid 102); 22 Aug 2014 16:03:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Aug 2014 11:03:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2014 12:03:34 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr408plgj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255682>

On Fri, Aug 22, 2014 at 08:56:12AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Since we're now translating the keepalive value, and since there's no
> > way to set it to "0" (nor would that really have any meaning), I guess
> > we could switch the internal "no keepalive" value to 0, and do:
> >
> >   ret = poll(pfd, pollsize, keepalive ? 1000 * keepalive : -1);
> >
> > which would let us avoid setting it to -1 in some other spots.  I dunno
> > if that actually makes a real difference to maintainability, though.
> 
> Where we parse and set the value of the variable, we do this:
> 
> 	else if (!strcmp("uploadpack.keepalive", var)) {
> 		keepalive = git_config_int(var, value);
> 		if (!keepalive)
> 			keepalive = -1;
> 	}
> 
> The condition may have to become "if (keepalive <= 0)".

Yeah, I wasn't thinking we would get negative values from the user (we
don't document them at all), but we should probably do something
sensible. Let's just leave it at Ed's patch.

-Peff
