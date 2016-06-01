From: Jeff King <peff@peff.net>
Subject: Re: [RCF/PATCH] Makefile: move 'ifdef DEVELOPER' after config.mak*
 inclusion
Date: Wed, 1 Jun 2016 04:03:48 -0400
Message-ID: <20160601080348.GA22528@sigill.intra.peff.net>
References: <20160531132443.5033-1-Matthieu.Moy@imag.fr>
 <20160601073037.GA14096@sigill.intra.peff.net>
 <vpqpos11gv3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 01 10:04:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b818H-0001S6-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 10:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537AbcFAID7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 04:03:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:47054 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757659AbcFAIDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 04:03:52 -0400
Received: (qmail 25584 invoked by uid 102); 1 Jun 2016 08:03:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 04:03:52 -0400
Received: (qmail 31160 invoked by uid 107); 1 Jun 2016 08:03:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 04:03:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 04:03:48 -0400
Content-Disposition: inline
In-Reply-To: <vpqpos11gv3.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296066>

On Wed, Jun 01, 2016 at 09:57:20AM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. So I think this does fix some issues, but it also means that one's
> > config.mak cannot use DEVELOPER as a base and then override particular
> > flags.
> 
> You mean, using "make DEVELOPER=1" and then tweak CFLAGS in config.mak?
> 
> Well, you still can do "CFLAGS += ..." (the extra CFLAGS will come
> before the ones added by DEVELOPER instead of after), which should cover
> 99% use-cases.

I specifically meant this, that your flags will now come before the
DEVELOPER ones. So they will not override for any options which are
parsed in command-line order (e.g., -Wno-error=something-specific).

> You can't do "CFLAGS = $(filter-out ..., $(CFLAGS))" anymore indeed. But
> if you are at that level of customization, I'd say DEVELOPER isn't for
> you and you should just set CFLAGS directly.

Yes, though it would be nice if the developer cflags were in a separate
variable to make that easier to play with.

Perhaps:

  DEVELOPER_CFLAGS += -Wfoo
  DEVELOPER_CFLAGS += -Wbar
  ...
  -include config.mak
  ...
  ifdef DEVELOPER
  CFLAGS += $(DEVELOPER_CFLAGS)
  endif

would be more flexible.

I don't currently use filter-out, but I do have compiler-specific flags
(which I accomplish by just not adding them in the first place for
certain compilers). For example, you may notice that:

  make DEVELOPER=1 CC=clang

is broken (clang doesn't know -Wold-style-declaration).

-Peff
