From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 03:39:27 +0200
Message-ID: <85myxpp67k.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
	<858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr> <85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<851wf2bcqy.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
	<85odi69vgt.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org>
	<85tzrxslms.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
	<85644dqoig.fsf@lola.goethe.zz> <f7uap7$eo1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 03:39:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICQQ3-0003Th-Q1
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 03:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbXGVBjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 21:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbXGVBjb
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 21:39:31 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:56936 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750715AbXGVBja (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 21:39:30 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 6CF0C2CB668;
	Sun, 22 Jul 2007 03:39:29 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 564D0ABCFF;
	Sun, 22 Jul 2007 03:39:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-231.pools.arcor-ip.net [84.61.10.231])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 353F036E868;
	Sun, 22 Jul 2007 03:39:29 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9B61A1D1E182; Sun, 22 Jul 2007 03:39:27 +0200 (CEST)
In-Reply-To: <f7uap7$eo1$1@sea.gmane.org> (Jakub Narebski's message of "Sun\, 22 Jul 2007 03\:16\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53211>

Jakub Narebski <jnareb@gmail.com> writes:

> David Kastrup wrote:
>
>> I must be really bad at explaining things, or I am losing a fight
>> against preconceptions fixed beyond my imagination.
>
> I don't understand you, or you don't understand git. "Tree" object
> in object database (in repository) represents a directory in the
> working area. There was never any problem with having empty trees in
> object database, or having links to empty directory in the superdir.
> We don't have to change anything about object database.

I disagree here.  The object database _can_ represent an _empty_
directory that has been added explicitly, because up to now no
operations existed that actually left an empty tree.  But it can't
distinguish a _non_-empty directory that has been added explicitly
from non-empty directory that has not been added explicitly.

To wit: after the sequence

mkdir a
touch a/b
git-add a
git-commit -m x
git-rm a/b
git-commit -m x

I expect git to retain an empty directory a.  But the _tree_ now can't
be different from the tree in the situation

mkdir a
touch a/b
git-add a/b
git-commit -m x
git-rm a/b
git-commit -m x

because after step 1, the trees have identical contents, and so there
is nothing at the _identical_ step 2 that could cause different
behavior.

But in the second case, git must _not_ retain a.  So we need to record
the information that in the first case, a was added explicitly.  And
this can't be done with the current repository layout.  It doesn't buy
us anything that we _have_ a representation available for an _empty_
tree added explicitly.  We need this "added explicitly" information
for _every_ tree, not just empty ones.

And a perfectly consistent way is to make those trees with an
explicitly added directory _non-empty_, by virtue of putting a file
"." in them.  This file, of course, exists in every physical
directory, but we may or may not decide to let it be tracked by git,
using the gitignore mechanism on the pattern ".".  Perfectly
expedient.

> The problems with git problems with empty directories stems from the
> fact that index didn't have directories.

That basically implies that no information about directories could be
tracked in the repository.  And yes, we need appropriate information
in the index.  Again, the information whether a directory was added
explicitly.

> Index is flattened version of root tree, and before subproject
> support it contained _only_ info about blobs (file contents).

And the repository is a versioned and hierarchically hashed version of
the index, but its trees contain _no_ information that is not already
inherently represented by the files alone.  Permitting empty trees
would change that fundamental property, and it would not buy us the
ability to actually track directories: see above.  So it is not worth
the trouble to assign any meaningful concept to persisting empty trees
rather than make them a case for git-fsck.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
