From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 08/19] write_or_die: raise SIGPIPE when we get EPIPE
Date: Wed, 20 Feb 2013 17:12:48 -0500
Message-ID: <20130220221248.GC817@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
 <20130220200136.GH25647@sigill.intra.peff.net>
 <20130220215043.GA24236@google.com>
 <20130220215845.GB817@sigill.intra.peff.net>
 <20130220220114.GB24236@google.com>
 <20130220220359.GA1417@sigill.intra.peff.net>
 <20130220220637.GC24236@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:13:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Hui-0001PY-8T
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 23:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040Ab3BTWMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 17:12:51 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54849 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022Ab3BTWMv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 17:12:51 -0500
Received: (qmail 19452 invoked by uid 107); 20 Feb 2013 22:14:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 17:14:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 17:12:48 -0500
Content-Disposition: inline
In-Reply-To: <20130220220637.GC24236@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216742>

On Wed, Feb 20, 2013 at 02:06:37PM -0800, Jonathan Nieder wrote:

> > I don't mind adding a "BUG: " message like you described, but we should
> > still try to exit(141) as the backup, since that is the shell-equivalent
> > code to the SIGPIPE signal death.
> 
> If you want. :)
> 
> I think caring about graceful degradation of behavior in the case of
> an assertion failure is overengineering, but it's mostly harmless.

I am more concerned that the assertion is not "oops, another thread is
doing something crazy, and it is a bug", but rather that there is some
weird platform where SIG_DFL does not kill the program under SIGPIPE.
That seems pretty crazy, though. I think I'd squash in something like
this:

diff --git a/write_or_die.c b/write_or_die.c
index b50f99a..abb64db 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -5,7 +5,9 @@ static void check_pipe(int err)
 	if (err == EPIPE) {
 		signal(SIGPIPE, SIG_DFL);
 		raise(SIGPIPE);
+
 		/* Should never happen, but just in case... */
+		error("BUG: SIGPIPE on SIG_DFL handler did not kill us.");
 		exit(141);
 	}
 }

which more directly reports the assertion that failed, and degrades
reasonably gracefully. Yeah, it's probably overengineering, but it's
easy enough to do.

-Peff
