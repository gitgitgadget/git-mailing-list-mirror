From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] archimport improvements
Date: Tue, 15 Nov 2005 00:03:52 -0800
Message-ID: <20051115080352.GG7484@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <46a038f90511120354n4584aedfhb1f2928ac41478ab@mail.gmail.com> <20051112202150.GA2037@Muzzle> <46a038f90511141438q1d85d429vedcf2a3b54d761e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 09:05:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbvnH-0004g1-U4
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 09:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVKOIDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 03:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVKOIDx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 03:03:53 -0500
Received: from hand.yhbt.net ([66.150.188.102]:28834 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1751367AbVKOIDx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 03:03:53 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 3F1112DC033; Tue, 15 Nov 2005 00:03:52 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511141438q1d85d429vedcf2a3b54d761e1@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11882>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Eric,
> 
> thanks for resending those so quickly. I think I'm going to sit on the
> 'overhaul of changeset application' patch a bit -- I'll test & ack
> your other patches for merge soonish but I want to review and test
> this one carefully.
> 
> My main concern is that it seems to be calling tla get for each
> revision that it imports. For large trees, this is slow. I would be
> much happier with a fast Perl-based approach. Have you got a public
> repo with directory renames?

Please read my sync_to_ps() function very carefully.  Next is a patch
that helps you track which Arch command (get/replay/apply-delta) is used
for each changeset.

tla replay is the most common for any halfway normal (changeset-based)
tree by far.

tla get is not called any more often than before.

apply-delta is hardly, if ever called.  It may not even be reachable
unless somebody commits revisions to the same tree with clocks out of
order from patchlevel order.  Heck, if it's ever called, it's most
likely faster just to rmtree and tla get again.

Unfortunately, my heavily used and abused trees are private.

> Additional comments follow...
> 
> On 11/13/05, Eric Wong <normalperson@yhbt.net> wrote:
> > > > * Identify git branches as an Arch "archive,category<--branch>--version"
> > > >   Anything less than that is ambiguous as far as history and patch
> > > >   relationships go.
> > >
> > > These bug/sanity fixes are _good_. As you mention, I wasn't aware that
> > > patchnames could show up not having a --branch part. Tricky...
> >
> > Thanks.  I got lazy one day and started ignoring --branch on some of my
> > personal projects to save my fingers :)
> 
> Yup, makes sense. My concern now is that existing imports will change
> the name of branches and tags going forward. Can I ask you to resend
> that patch with the new branchname mangling as default, and the old
> one as optional?

Ok, good idea.  My previous patch already automatically converted the
private tags, which we actually need to parse, and I see no reason to
change that, but branch names and public tags which affect
non-gitarchimport users can be preserved with the -o flag.

> I know it'll force us to go back to using shellquote, but I am not too
> worried by that dependency at the moment.
 
Actually, usage of shell_quote() in git-archimport was always
unnecessary.  Passing arguments to external programs as an array,
using the 3-argument version of open() for files, and using -z in
git-commands with pipes are better ways to go.

> > > > Current weaknesses:
> > > >
> > > > * (Present in the original code as well).
> > > >   The code still assumes that dates in commit logs can be trusted, which is
> > > >   fine in most cases, but a wayward branch can screw up git-archimport and
> > > >   cause parents to be missed.
> > >
> > > Fair enough. You mention an alternative strategy (tla ancestry) --
> > > have you tried it at all?
> >
> > No, not yet.
> 
> Also interested in this if you get around to it.

It's not a high priority for me and I probably don't have time to do
this.

-- 
Eric Wong
