From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Thu, 13 Oct 2011 14:28:16 -0400
Message-ID: <20111013182816.GA17573@sigill.intra.peff.net>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 20:28:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQ12-0001VO-W3
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab1JMS2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:28:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59798
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929Ab1JMS2U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:28:20 -0400
Received: (qmail 27564 invoked by uid 107); 13 Oct 2011 18:28:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Oct 2011 14:28:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2011 14:28:16 -0400
Content-Disposition: inline
In-Reply-To: <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183505>

On Thu, Oct 13, 2011 at 03:45:44PM +1100, Nguyen Thai Ngoc Duy wrote:

> On Wed, Oct 12, 2011 at 04:09:16PM -0400, Jeff King wrote:
> > On Tue, Oct 04, 2011 at 08:55:09AM +1100, Nguyen Thai Ngoc Duy wrote:
> > 
> > > The message is chosen to avoid leaking information, yet let users know
> > > that they are deliberately not allowed to use the service, not a fault
> > > in service configuration or the service itself.
> > 
> > I do think this is an improvement, but I wonder if the verbosity should
> > be configurable. Then open sites like kernel.org could be friendlier to
> > their users. Something like this instead:
> 
> How about allow users to select which messages they want to print? We
> can even go further, allowing users to specify the messages themselves..

I thought about that, but it just seemed like it was making things way
more complex than it needed to be. GitHub does do this kind of
customization, but we also have a custom layer that intercepts git://
connections, anyway, so we added the relevant code there.

I don't know if medium-sized sites (i.e., ones that aren't so big they
are running custom proxies on the frontend) would care about adding
custom messages here or not.

> I don't know. I'm not a real server admin so maybe I'm just too
> paranoid. Any admins care to speak up?

I doubt anybody would care that much about turning individual messages
on and off. I think the real value is in being able to say "don't push
by git://. The right way to push to this site is...".

But your patch kind of falls short of what people would want to do for
two reasons:

  1. The message isn't dynamic at all. So I can't say:

        You tried to push to git://host.tld/foo.git. The right way to do
        that is:

          git push https://host.tld/foo.git

     That's what the GitHub message does if you try to push over git://;
     it gives you a new remote name that will actually work, customized
     to the repo you wanted to push to.

  2. Tweaking just the message for anything but "service not enabled"
     isn't all that useful. What do you say about "no such repository"
     in a simple message, even with placeholders?

     If you _really_ want to get fancy, a server could do a fuzzy
     search on the available repos and say "did you mean...?".
     But now we are talking about hooking arbitrary code into the
     message.

So if we want to do anything, I would think it would be a hook. Except
that we may or may not have a repo, so it would not be a hook in
$GIT_DIR/hooks, but rather some script to be run passed on the command
line, like:

  git daemon --informative-errors=/path/to/hook

-Peff
