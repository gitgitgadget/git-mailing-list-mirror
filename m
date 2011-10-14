From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Fri, 14 Oct 2011 17:12:44 -0400
Message-ID: <20111014211244.GA16429@sigill.intra.peff.net>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014210251.GD16371@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 23:12:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REp3l-0006sB-OL
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 23:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756790Ab1JNVMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 17:12:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60896
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab1JNVMt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 17:12:49 -0400
Received: (qmail 15264 invoked by uid 107); 14 Oct 2011 21:12:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 17:12:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 17:12:44 -0400
Content-Disposition: inline
In-Reply-To: <20111014210251.GD16371@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183613>

On Fri, Oct 14, 2011 at 04:02:51PM -0500, Jonathan Nieder wrote:

> > Instead, let's print an "ERR" line, which git clients
> > understand since v1.6.1 (2008-12-24).
> 
> Just to be clear, "git archive --remote" does not understand ERR lines
> in the 'master' branch (though 908aaceb makes it understand them in
> 'next').  But I consider even distinguishing
> 
>  a. fatal: git archive: protocol error
>  b. fatal: git archive: expected ACK/NAK, got EOF
> 
> [(a) is how an ERR response is reported, and (b) a remote hangup] to
> be progress, so it's not so important. :)

Thanks, I forgot to mention that. It's not as nice as the push/fetch
case, but I agree it's a step forward.

> > Because there is a risk of leaking information about
> > non-exported repositories, by default all errors simply say
> > "access denied". Open sites can pass a flag to turn on more
> > specific messages.
> 
> I'm not sure what an "open site" is. :)  But having this flag for
> sites to declare whether they consider whether a repository exists to
> be privileged information seems reasonable to me.

I meant sites which are just serving a bunch of public repos, like
kernel.org.

> Note that this really would be privileged information in some
> not-too-weird cases.  For example, if many users have a repository at
> ~/.git, ~/.config/.git, or ~/src/linux/.git, then someone might try to
> access
> 
> 	/home/alice/.git
> 	/home/alice/.config/.git
> 	/home/alice/src/linux/.git
> 	/home/bob/.git
> 	...
> 
> in turn to find a valid username, as reconnaisance for a later
> attack not involving git.

I sort of assume everybody serves a specific directory hierarchy, but
maybe that is not the case. I don't run git-daemon myself, so I am
probably guilty of generalizing how other people use it.

Anyway, I think the issue is sufficiently nuanced that we should keep
the default to the conservative "access denied" (i.e., throw away my
second patch for now).

> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -20,6 +20,7 @@
> [...]
> > @@ -1167,6 +1176,14 @@ int main(int argc, char **argv)
> >  			make_service_overridable(arg + 18, 0);
> >  			continue;
> >  		}
> > +		if (!prefixcmp(arg, "--informative-errors")) {
> > +			informative_errors = 1;
> > +			continue;
> > +		}
> > +		else if (!prefixcmp(arg, "--no-informative-errors")) {
> > +			informative_errors = 0;
> > +			continue;
> > +		}
> >  		if (!strcmp(arg, "--")) {
> 
> Micronit: uncuddled "else".  The style of the surrounding code is to
> just not include the "else" at all and rely on "continue" to
> short-circuit things.

Oops. Yes, it should just drop the else to match the surrounding code.

-Peff
