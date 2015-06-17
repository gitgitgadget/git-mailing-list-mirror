From: Jeff King <peff@peff.net>
Subject: Re: slash in branch name
Date: Wed, 17 Jun 2015 15:24:45 -0400
Message-ID: <20150617192444.GD25304@peff.net>
References: <5581C77A.3040703@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: KK <horizn@wp.pl>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:24:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Ix9-0003zk-Ms
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512AbbFQTYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:24:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:47599 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757309AbbFQTYr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:24:47 -0400
Received: (qmail 31090 invoked by uid 102); 17 Jun 2015 19:24:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 14:24:47 -0500
Received: (qmail 28400 invoked by uid 107); 17 Jun 2015 19:24:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 15:24:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 15:24:45 -0400
Content-Disposition: inline
In-Reply-To: <5581C77A.3040703@wp.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271887>

On Wed, Jun 17, 2015 at 08:16:10PM +0100, KK wrote:

> remote: error: invalid key: hooks.denypush.branch.versions/4.3.2
> remote: error: invalid key: hooks.allowmerge.versions/4.3.2
> [...]

Those are syntactically bogus config keys. Keys should be of the form

  section.subsection.key

and only "subsection" can contain arbitrary bytes (and of course the
value can, too). The hooks running on the server are using git's config
system in ways that were not intended.  It should rearrange its
organization of the data (I cannot comment much further without seeing
the hooks themselves).

> My colleague did some research about that and it seems that this commit has
> stopped update hook working:
> 
> commit b09c53a3e331211fc0154de8ebb271e48f8c7ee5
> Author: Libor Pechacek <lpechacek@suse.cz>
> Date:   Sun Jan 30 20:40:41 2011 +0100
> 
>     Sanity-check config variable names
> [...]
> 
> Could you please advise how to fix/revert this?

I guess we could add a "--no-really-i-am-abusing-git-config" option to
git-config to let these pass, at least for lookups. I am not sure that
is a good idea, though. I think your hooks are fundamentally broken for
branches with odd characters (right now you are seeing complaints on the
lookup side, but I suspect that you could not write a
"hooks.denypush.branch.versions/4.3.2" entry if you wanted to, as git
would choke on reading the config file).

-Peff
