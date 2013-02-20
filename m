From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 08/19] write_or_die: raise SIGPIPE when we get EPIPE
Date: Wed, 20 Feb 2013 16:58:45 -0500
Message-ID: <20130220215845.GB817@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
 <20130220200136.GH25647@sigill.intra.peff.net>
 <20130220215043.GA24236@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 22:59:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Hh4-0000my-23
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 22:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390Ab3BTV6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 16:58:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54819 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384Ab3BTV6r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 16:58:47 -0500
Received: (qmail 19134 invoked by uid 107); 20 Feb 2013 22:00:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 17:00:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 16:58:45 -0500
Content-Disposition: inline
In-Reply-To: <20130220215043.GA24236@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216738>

On Wed, Feb 20, 2013 at 01:51:11PM -0800, Jonathan Nieder wrote:

> > This distinction doesn't typically matter in git, because we
> > do not ignore SIGPIPE in the first place. Which means that
> > we will not get EPIPE, but instead will just die when we get
> > a SIGPIPE. But it's possible for a default handler to be set
> > by a parent process,
> 
> Not so much "default" as "insane inherited", as in the example
> of old versions of Python's subprocess.Popen.

It's possible that somebody could have a legitimate reason for doing so.
I just can't think of one. :)

> I suspect this used exit(0) instead of raise(SIGPIPE) in the first
> place to work around a bash bug (too much verbosity about SIGPIPE).
> If any programs still have that kind of bug, I'd rather put pressure
> on them to fix it by *not* working around it.  So the basic idea here
> looks good to me.

Yeah, if you look for old discussions on SIGPIPE in the git list, it is
mostly Linus complaining about the bash behavior, and this code does
date back to that era. The bash bug is long since fixed.

> > +	if (err == EPIPE) {
> > +		signal(SIGPIPE, SIG_DFL);
> > +		raise(SIGPIPE);
> > +		/* Should never happen, but just in case... */
> > +		exit(141);
> 
> How about
> 
> 		die("BUG: another thread changed SIGPIPE handling behind my back!");
> 
> to make it easier to find and fix such problems?

You mean for the "should never happen" bit, not the first part, right? I
actually wonder if we should simply exit(141) in the first place. That
is shell exit-code for SIGPIPE death already (so it's what our
run_command would show us, and what anybody running us through shell
would see).

-Peff
