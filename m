From: Jeff King <peff@peff.net>
Subject: Re: propagating repo corruption across clone
Date: Mon, 25 Mar 2013 16:05:25 -0400
Message-ID: <20130325200525.GA3902@sigill.intra.peff.net>
References: <20130324183133.GA11200@sigill.intra.peff.net>
 <7vboa7xn7s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 21:05:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDeX-0007DO-EI
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758382Ab3CYUF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:05:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39284 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab3CYUF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:05:29 -0400
Received: (qmail 27584 invoked by uid 107); 25 Mar 2013 20:07:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:07:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:05:26 -0400
Content-Disposition: inline
In-Reply-To: <7vboa7xn7s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219073>

On Mon, Mar 25, 2013 at 01:01:59PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We _do_ see a problem during the checkout phase, but we don't propagate
> > a checkout failure to the exit code from clone.  That is bad in general,
> > and should probably be fixed. Though it would never find corruption of
> > older objects in the history, anyway, so checkout should not be relied
> > on for robustness.
> 
> It is obvious that we should exit with non-zero status when we see a
> failure from the checkout, but do we want to nuke the resulting
> repository as in the case of normal transport failure?  A checkout
> failure might be due to being under quota for object store but
> running out of quota upon populating the working tree, in which case
> we probably do not want to.

I'm just running through my final tests on a large-ish patch series
which deals with this (among other issues). I had the same thought,
though we do already die on a variety of checkout errors. I left it as a
die() for now, but I think we should potentially address it with a
further patch.

> >   $ git init non-local && cd non-local && git fetch ..
> >   remote: Counting objects: 3, done.
> >   remote: Total 3 (delta 0), reused 3 (delta 0)
> >   Unpacking objects: 100% (3/3), done.
> >   fatal: missing blob object 'd95f3ad14dee633a758d2e331151e950dd13e4ed'
> >   error: .. did not send all necessary objects
> >
> > we do notice.
> 
> Yes, it is OK to add connectedness check to "git clone".

That's in my series, too. Unfortunately, in the local clone case, it
slows down the clone considerably (since we otherwise would not have to
traverse the objects at all).

-Peff
