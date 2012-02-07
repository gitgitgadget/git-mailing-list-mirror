From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] config: add include directive
Date: Tue, 7 Feb 2012 13:36:44 -0500
Message-ID: <20120207183644.GB32367@sigill.intra.peff.net>
References: <20120206095306.GA2404@sigill.intra.peff.net>
 <20120206095404.GB4300@sigill.intra.peff.net>
 <7v62fj60ya.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 19:36:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RupuN-0000yK-If
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 19:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188Ab2BGSgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 13:36:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59352
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755808Ab2BGSgq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 13:36:46 -0500
Received: (qmail 9893 invoked by uid 107); 7 Feb 2012 18:43:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 13:43:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 13:36:44 -0500
Content-Disposition: inline
In-Reply-To: <7v62fj60ya.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190196>

On Mon, Feb 06, 2012 at 02:39:41PM -0800, Junio C Hamano wrote:

> > +Includes
> > +~~~~~~~~
> > +
> > +You can include one config file from another by setting the special
> > +`include.path` variable to the name of the file to be included. The
> > +included file is expanded immediately, as if its contents had been
> > +found at the location of the include directive. If the value of the
> > +`include.path` variable is a relative path, the path is considered to be
> > +relative to the configuration file in which the include directive was
> > +found. See below for examples.
> 
> If the file referenced by this directive does not exist, what should
> happen?  Should it be signalled as an error?  Should it stop the whole
> calling process with die()?

I silently ignore it. My thinking was that you might want to have
something like:

  [include]
          path = .gitconfig-local

in a stock .gitconfig that you ship to all of your machines[1]. Then
machines that need it can put things in .gitconfig-local, and those that
don't can just ignore it.

It is a tradeoff, of course, in that typos will be silently ignored. For
this use case, you could also just create an empty .gitconfig-local on
machines that don't have anything to put there.

[1] Actually, a similar use might be a ~/.gitconfig that is shared by a
    mounted home directory (e.g., via NFS) NFS, and a ~/.gitconfig-$HOST
    that is specific to each machine. The current code doesn't expand
    environment variables (nor tildes), but perhaps it should.

> I think "die() when we are honoring the include, ignore when we are not"
> would be a good way to handle this, as it allows us to catch mistakes
> while allowing the user to fix broken configuration files using "git
> config --unset include.path", but I may be overlooking something.

The writing path does not use the include callback wrapper at all; so
include.path can be manipulated just as any other variable, and the
value is not treated specially.

-Peff
