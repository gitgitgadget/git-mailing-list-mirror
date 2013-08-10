From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Sat, 10 Aug 2013 05:43:40 -0400
Message-ID: <20130810094339.GB2518@sigill.intra.peff.net>
References: <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org>
 <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org>
 <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
 <20130809110000.GD18878@sigill.intra.peff.net>
 <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
 <20130809221615.GA7160@sigill.intra.peff.net>
 <CALkWK0kpqyxTyai2Lue7=D4z0kvhxuxKdYSWekT22zUhRis0Og@mail.gmail.com>
 <CACsJy8DtiSupsvDgeBXGGnGE06pDxWvYTNrk3bpta9Bwk5MZwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 11:43:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V85iA-0006rE-En
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 11:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968517Ab3HJJnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 05:43:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:55333 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968514Ab3HJJnp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 05:43:45 -0400
Received: (qmail 3438 invoked by uid 102); 10 Aug 2013 09:43:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Aug 2013 04:43:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Aug 2013 05:43:40 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DtiSupsvDgeBXGGnGE06pDxWvYTNrk3bpta9Bwk5MZwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232082>

On Sat, Aug 10, 2013 at 04:24:48PM +0700, Nguyen Thai Ngoc Duy wrote:

> > Yeah, I read about the --thin option. However, it's only for
> > network-packs (i.e --stdout; why?). Also, is it turned on by default?
> > The documentation says so, but I ran it and found that the value of
> > thin is 0 in builtin/push.c:316. What is going on?
> 
> --thin is enabled by default for fetch (see
> transport.c:transport_get()) but it's only effective when the server
> advertises "thin-pack" capability (see protocol-capabilities.txt).
> push has --thin turned off by default favoring server resources over
> network traffic, see a4503a1 (Make --no-thin the default in git-push
> to save server resources - 2007-09-09)

Hmm. I don't think that is the case anymore.

If I do:

  git init parent &&
  (cd parent && seq 1 10000 >file &&
   git add file && git commit -m base
  ) &&
  git clone parent child &&
  cd child && seq 1 10001 >file &&
  git commit -a -m more &&
  GIT_TRACE=1 git push origin HEAD:foo

I see:

  trace: run_command: 'pack-objects' '--all-progress-implied' '--revs'
    '--stdout' '--thin' '--delta-base-offset' '--progress'

-Peff
