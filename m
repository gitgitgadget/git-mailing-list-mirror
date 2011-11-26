From: Jeff King <peff@peff.net>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Sat, 26 Nov 2011 18:31:33 -0500
Message-ID: <20111126233133.GA31129@sigill.intra.peff.net>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
 <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
 <20111125144007.GA4047@sigill.intra.peff.net>
 <7v7h2my0ky.fsf@alter.siamese.dyndns.org>
 <20111126225519.GA29482@sigill.intra.peff.net>
 <7vr50uwk7x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 27 00:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RURu6-0006UN-Gw
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 00:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066Ab1KZXbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 18:31:36 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53536
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181Ab1KZXbf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 18:31:35 -0500
Received: (qmail 8643 invoked by uid 107); 26 Nov 2011 23:38:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Nov 2011 18:38:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Nov 2011 18:31:33 -0500
Content-Disposition: inline
In-Reply-To: <7vr50uwk7x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185961>

On Sat, Nov 26, 2011 at 03:13:38PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Bob could run a specialized server for (b) that listens on a unix socket
> > and triggers his hook. But why? Why not just do the whole thing over
> > git-daemon or smart http, which already exist?
> 
> If that "whole thing" is "to allow an arbitrary code to run anywhere as
> incoming user", I would apply the "why?" to a different part of the
> statemennt. Why allow running an arbitrary code at all?

Because there are useful hooks that Bob wants to run when somebody
fetches or pushes to/from his repository?

> A pre-anything hook wants to see if the accessing user, not the owner of
> the repository, can or cannot do something to the repository and decide
> what to do.

It depends on what you want your hook to do. I thought Sitaram's
use-case was putting something like "git fetch upstream" into a hook
that runs before upload-pack, to create a transparent proxy. That has
nothing to do with the accessing user.

At GitHub, we run a pre-upload-pack hook to keep statistics. That has
nothing to do with the accessing user. We have to patch git to provide
the hook.

And even if you _did_ want to know something about the accessing user,
that doesn't mean you necessarily can or want to be running code as
them. If I'm running a smart-http server, I might have verified the user
already via cookie, client cert, or basic auth. That information could
be passed down to a pre-upload-pack hook where it could make a decision.

But we don't _have_ a pre-upload-pack hook, because it can be dangerous
in some situations. My point is to make it available, give it safe
semantics by default, and let people who are running daemon-like service
(i.e., where the admin controls the daemon and arbitrary users can't
write into the hooks directory) use it by setting an environment
variable, rather than patching git.

-Peff
