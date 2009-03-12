From: Jeff King <peff@peff.net>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 12:35:33 -0400
Message-ID: <20090312163533.GA28205@coredump.intra.peff.net>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com> <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de> <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com> <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302> <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com> <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com> <B9479687-D936-4EE1-A5A4-663968B76EBF@ai.rug.nl> <20090312153738.GA24690@coredump.intra.peff.net> <43d8ce650903120916yb91113fy5485813c512c8108@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 17:46:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhnuF-0004TH-K1
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 17:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292AbZCLQfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 12:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756147AbZCLQfn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 12:35:43 -0400
Received: from peff.net ([208.65.91.99]:48117 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756145AbZCLQfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 12:35:42 -0400
Received: (qmail 2843 invoked by uid 107); 12 Mar 2009 16:35:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 12 Mar 2009 12:35:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Mar 2009 12:35:33 -0400
Content-Disposition: inline
In-Reply-To: <43d8ce650903120916yb91113fy5485813c512c8108@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113084>

On Thu, Mar 12, 2009 at 04:16:09PM +0000, John Tapsell wrote:

> I was thinking more along the lines of checking if it begins with
> remotes/, origin/, tags/, stash/, bisect/    and blacklisting these.
> 
> Can anyone suggest a reason that you really might want to create a
> branch called  origin/something ?

The name "origin" is simply convention. So if you are thinking about
blacklisting "origin/*", then it is certainly possible to have a false
positive (although as you note, it is unlikely). But what is worse is
that it is very likely for you to have a false negative if you use a
different remote name (and people often do if they have multiple
remotes).

For example, in one of my projects where I do integration, "origin" is
my own public repo, and I have a remote pointing to the public repo of a
number of other developers from whom I pull. So I would encounter the
same error by doing:

  git checkout -b mike/master mike/master

but it would not be caught by your rule.

One area where your rule _is_ nicer than mine is that mine only looks at
what exists _now_ and doesn't future-proof you at all. So I could say

  git checkout -b origin/newtopic

which might not be ambiguous. But if the remote adds a "newtopic"
branch, then the next time I fetch it will _become_ ambiguous.

Potentially you could blacklist "X/*" for every remote.X.* that
exists in your config. Even that, of course, isn't future-proof against
you creating a new remote. :)

I think the future-proofing is probably not worth the effort. Catching
things that are ambiguous _now_ will cover the "oops, I typed the wrong
thing" case, which I think is really the issue.

-Peff
