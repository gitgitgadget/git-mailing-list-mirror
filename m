From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 13:31:50 +0200
Message-ID: <86zm1sbpeh.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 13:32:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBUF4-0007Xx-Io
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 13:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbXGSLcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 07:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbXGSLcT
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 07:32:19 -0400
Received: from main.gmane.org ([80.91.229.2]:45112 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbXGSLcS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 07:32:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBUEj-00074g-6b
	for git@vger.kernel.org; Thu, 19 Jul 2007 13:32:01 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 13:32:01 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 13:32:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:5Pbxk0sxMPZqXBNbmkOCnlId2Ss=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52971>

Tomash Brechko <tomash.brechko@gmail.com> writes:

> Dear Git fellows,
>
> A year or so ago I too would strongly advocate the need of tracking
> empty directories, permissions et al., it seemed so "natural" and
> "plain obvious" to me back then.  But since that time I learned to
> appreciate the "contents tracking" approach, and now view
> directories (paths in general) only as the means for Git to know
> where to put the contents on checkout.  This, BTW, is consistent
> with how Git figures container copies/renames.

I'll answer to this based on my proposal of adding "A/B/. [dir]" as a
separate entity to index and repository, keeping "[tree]" out of
indices, and don't allow an empty "[tree]" into repositories.

This is a very natural abstraction.

> But there's no end to how much information one may want to store in
> Git to make it "_file system_ contents tracking software".  Starting
> with empty directories, one may argue then that certain installation
> trees also need particular file ownership, so lets store user/group
> names like tar does.  It was mentioned already in this thread that
> in addition to 'rwx' we also would have to store ACLs (some OSes
> have only one of these concepts, some both), SELinux security
> contexts, perhaps other arbitrary file attributes that may be part
> of file system state.

A [dir] entry may be eventually be made to track any of this, like a
[file] entry could.  If one wished to do this.

> Wouldn't it be better to preserve Git as a contents tracking system,
> and add some tools on top of it that can translate file system state
> into textual (or binary) form, so it can be stored in current Git?
> And then use this textual representation to restore actual file
> system attributes/layout on checkout?  And the only change in Git
> itself would be some more hooks, for instance one hook before
> checking out over the old work tree, and one after the checkout.  Or
> one can simply wrap certain Git commands to implement such hooks.

This is not good since "tracking" means "tracking".  With your model,
the metainformation would be dissociated from the information.
Renames and moves would make ground beef of the metadata.

> In any case, no one is going to be against the new feature if it
> won't break anything for those of us who find the pure contents
> tracking the right thing.

My proposal would allow setting an option to track or not track
directories implicitly by default.

> And storing empty directories by default may not be natural for
> everyone.  So before going into technical details of how this can
> possibly be implemented, could someone answer the following:

I'll answer assuming the proposed model.

> 1 Is Git going to track directories _always_?  Looks like not, because
>   in this thread there seems to be a distinction between 'git add DIR'
>   and 'git add DIR/FILE', i.e. not everyone is sure if in the last
>   case Git should track DIR or not.

Let's have a variable

core.adddirs

If you set core.adddirs to false, git will not enter directories into
the index for addition.  Consequently, they will not end up in the
repository.  If you git-rm a directory, the index will contain a
notice to delete the directory along with deletion notices for all
registered other elements of the directory.  Committing this means
that the directory will no longer be separately controlled by git,
even if for some reason the repository has other files remaining in
the tree.

Something like the Linux kernel repository which may be accessed by
ancient git versions would naturally contain "core.adddirs: false" in
its default configuration file, and this would be passed around when
cloning.  So directory elements would stay out of it.

> 2 If Git will track only explicitly mentioned directories, then what
>   about recursive operations?  Will it add only files by default, or
>   directories too?  Perhaps there will be some --add-dirs option to
>   'git add'.

There could be a commandline override for "core.adddirs".

> 3 Since in certain recursive operations one will want to affect
>   directories too, how .gitignore will look?  Most files have a notion
>   of extension, so me may say '*.o', but with directories things a bit
>   more complicated.  One would want to say "exclude DIR2 only if under
>   DIR1 at any hierarchy depth", i.e. exclude paths matching
>   qr%DIR1/(.+/)?DIR1/%, and shell wildcards aren't that expressive,
>   '*' doesn't cross hierarchy.  Note that we live without this now,
>   but this will be the next "natural" demand once directories become
>   first class citizens.

Huh?  I don't get this.  It's like "we can't allow people to buy
chocolate, or they'll demand next to have nuclear weapons delivered at
their house".  Deal with the demands as they come up.  If a directory
has a tree-local name ".", it can be dealt with in patterns if really
needed.  I don't see much of a necessity however.

Although it would be natural to have
core.adddirs: false
be equivalent to
core.excludefile: .

And so it might be possible to actually not need a separate
core.adddirs option at all, technically.

-- 
David Kastrup
