From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Thu, 19 Jun 2008 12:35:21 +0200
Message-ID: <20080619103521.GC14415@diana.vm.bytemark.co.uk>
References: <20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu> <m33anao11u.fsf@localhost.localdomain> <20080618223821.GJ29404@genesis.frugalware.org> <20080619072308.GA12727@diana.vm.bytemark.co.uk> <7v7iclx4nw.fsf@gitster.siamese.dyndns.org> <20080619082156.GB12727@diana.vm.bytemark.co.uk> <20080619083356.GN29404@genesis.frugalware.org> <20080619091903.GA14415@diana.vm.bytemark.co.uk> <20080619100637.GO29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 12:42:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Hb7-0007Iv-M0
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 12:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504AbYFSKlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 06:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755460AbYFSKlh
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 06:41:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2770 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbYFSKlg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 06:41:36 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K9HU9-00043j-00; Thu, 19 Jun 2008 11:35:21 +0100
Content-Disposition: inline
In-Reply-To: <20080619100637.GO29404@genesis.frugalware.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85468>

On 2008-06-19 12:06:37 +0200, Miklos Vajna wrote:

> You can store them as a blob, make a tree of them and make a commit
> in the log branch point to the tree. This one has the advantage of
> being able to do a 'git log' on a particular patch of the patch set.

If I don't store the pre or post tree in its entirety, I lose the
ability to do patch application by three-way merge. (The current StGit
design assumes that we can always make a three-way merge as a last
resort when applying patches. Basically, StGit is just a fancy way to
rebase.)

But yes, this is a viable idea. (Though once I have to store one of
the trees, I believe it's actually simpler and cheaper to just store
the other tree as well, instead of having to compute the diff and
store that in a blob.)

> The other one is to create n+1 trees (and commits, where the first
> commit has no parent) for n patches, and point to the last commit
> from the log branch.

There's actually no point in making more than one commit. A tree can
easily hold a lot of sub-trees.

I have an existing implementation that stores the pre and post tree
for each patch, plus some metadata (message, author). The issue with
this format is that every time we write a new log entry (that is, for
every StGit command), we have to call git multiple times in order to
write several new trees and blobs.

StGit normally represents each patch by a commit object, so it should
be faster to simply write a single new commit to the log that has some
metadata in its commit message and just refers to all the patches'
commit objects (by having them as parents). Which is why I was
inquiring about the maximum number of parents of a commit object.

( Some background: At a given point in time, your StGit stack consists
  of a few applied patches, and a few unapplied patches. The applied
  patches are just a linear sequence of commits at the top of your
  current branch, so we can trivially save them all from the garbage
  collector by making the stack top a parent of our log commit. The
  unapplied patches, however, are commits that are not reachable from
  the stack top -- they can be "pushed" onto the stack by rebasing, at
  which point they become applied, but until then we can't make any
  assumptions about them being ancestors of anything. So a log commit
  potentially has to have _every_ unapplied patch as a parent. (If we
  know that the commit of an unapplied patch used to be applied, we
  know that it's reachable from previous log commits, but we don't
  always know that.) )

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
