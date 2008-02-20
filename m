From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Wed, 20 Feb 2008 09:03:07 -0500
Message-ID: <20080220140306.GA6928@sigill.intra.peff.net>
References: <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site> <20080210101756.GB26568@coredump.intra.peff.net> <alpine.LSU.1.00.0802101219280.11591@racer.site> <20080210122321.GA31009@coredump.intra.peff.net> <alpine.LSU.1.00.0802101303140.11591@racer.site> <7vzltwavf9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 15:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRpY3-0002Fm-Ho
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 15:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620AbYBTODM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 09:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756728AbYBTODM
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 09:03:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2305 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756305AbYBTODL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 09:03:11 -0500
Received: (qmail 5807 invoked by uid 111); 20 Feb 2008 14:03:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 20 Feb 2008 09:03:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2008 09:03:07 -0500
Content-Disposition: inline
In-Reply-To: <7vzltwavf9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74514>

On Wed, Feb 20, 2008 at 12:23:06AM -0800, Junio C Hamano wrote:

> [long description of shared repository workflow]
> So perhaps we can have "remote.*.push" that says "current" in
> some way.  Tentatively let's say the syntax is like this:

I think everything you said here makes perfect sense; changing the push
refspec to say "push the current" for a particular remote is much more
sensible than an overall default. In fact, I half-expected this to
just work without a patch, since "git push origin HEAD" already works.
However, we don't treat command line refspecs and config refspecs the
same way, which IMHO is a needless inconsistency. How about this:

diff --git a/builtin-push.c b/builtin-push.c
index 9f727c0..ca90150 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -68,8 +68,7 @@ static int do_push(const char *repo, int flags)
 	if (!refspec
 		&& !(flags & TRANSPORT_PUSH_ALL)
 		&& remote->push_refspec_nr) {
-		refspec = remote->push_refspec;
-		refspec_nr = remote->push_refspec_nr;
+		set_refspecs(remote->push_refspec, remote->push_refspec_nr);
 	}
 	errs = 0;
 	for (i = 0; i < remote->url_nr; i++) {

At which point this now works as you described:

  git config remote.origin.push HEAD

> I was hoping we can do without the "remote.*.push = HEAD" if we
> can detect the remote is a shared repository while talking to
> it, but I think it is a bit too much magic, because we cannot
> visualize what the pushing side and the receiving side  are
> negotiating.

How are you detecting that the remote is a shared repository? By the
core.sharedrepository config option? I use several shared repositories,
and I never set that variable; instead I use filesystem ACLs (which we
could at least detect). It is my understanding that some people even
have repositories where multiple users share the same filesystem uid but
connect with different ssh keys.  I don't think that is even detectable.

-Peff
