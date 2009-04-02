From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git remote update: New option --prune (-p)
Date: Thu, 2 Apr 2009 10:31:12 -0400
Message-ID: <20090402143112.GA26974@coredump.intra.peff.net>
References: <20090402123823.GA1756@pvv.org> <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com> <20090402134414.GB26699@coredump.intra.peff.net> <9b18b3110904020717h3a0d4b34h7f4b2b83527e6743@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	gitster@pobox.com
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 16:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpNyY-0004aF-JH
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 16:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759555AbZDBOb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 10:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759375AbZDBOb2
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 10:31:28 -0400
Received: from peff.net ([208.65.91.99]:39491 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759250AbZDBOb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 10:31:27 -0400
Received: (qmail 26509 invoked by uid 107); 2 Apr 2009 14:31:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 02 Apr 2009 10:31:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2009 10:31:12 -0400
Content-Disposition: inline
In-Reply-To: <9b18b3110904020717h3a0d4b34h7f4b2b83527e6743@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115470>

On Thu, Apr 02, 2009 at 04:17:35PM +0200, demerphq wrote:

> > But "git remote update" actually respects "remote groups", so it is not
> > just "--all". I think what you want is "git remote prune <group>".
> 
> Are there any implicit groups defined, like "all-remotes" or
> something? It seems less than desirable to have to define such a group
> for an operation that IMO is pretty reasonable to expect to happen
> regularly.

Yes. From "git help remote":

       update
           Fetch updates for a named set of remotes in the repository as
           defined by remotes.<group>. If a named group is not specified on
           the command line, the configuration parameter remotes.default will
           get used; if remotes.default is not defined, all remotes which do
           not have the configuration parameter
           remote.<name>.skipDefaultUpdate set to true will be updated. (See
           git-config(1)).

So without defining any other config, "git remote update" will by
default update everything

> I personally haven't found any use for defining  remote groups yet to
> be honest. Its a granularity of operation that hasnt served much
> purpose for me yet. Although i could see it being useful in the
> future.

I haven't either. I suspect it would be useful if you had a complex set
of repo relationships, like an integration manager pulling from an
upstream but also from other developers.

> Generally tho I either want to update and prune one remote only, with
> 
>    git fetch $remote; git prune $remote,

It might be useful if "remote update" treated an unconfigured group as a
simple remote. So that "git remote update --prune $remote" would do what
you wanted here.

I could even see "remote.*.autoprune" config being useful so you could
avoid --prune. It is living dangerously, I suppose, for some workflows;
but I generally consider whatever is in my remote tracking branches to
be throwaway, and automatically pruning is not really dangerous.

> or i want to update and prune all with something like:
> 
>   git remote update; for r in $(git remote); do git remote prune $r; done;
> 
> This patch makes the latter better huffman encoded, but I'd kind of
> expect both to be doable as single commands in terms of how often I
> want to do them.
> 
> Maybe git fetch --prune would be a nice complement to this patch.

I think we have tried to keep pruning out of fetch, as fetch does not
necessarily use or know about tracking branches. But the "git remote
update $remote" proposal I gave above would do basically the same thing
(except you would call it "remote update" instead of "fetch").

-Peff
