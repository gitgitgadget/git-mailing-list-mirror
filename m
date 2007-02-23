From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: [PATCH] Support incremental pack files
Date: Fri, 23 Feb 2007 00:10:35 -0800
Message-ID: <7vfy8x9tvo.fsf@assigned-by-dhcp.cox.net>
References: <20070223071344.GA21107@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Fri Feb 23 09:10:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKVVn-0004gC-U0
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 09:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbXBWIKh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 03:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbXBWIKh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 03:10:37 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:55019 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbXBWIKg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 03:10:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223081036.UUPB3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Feb 2007 03:10:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SwAb1W0051kojtg0000000; Fri, 23 Feb 2007 03:10:36 -0500
In-Reply-To: <20070223071344.GA21107@auto.tuwien.ac.at> (Martin Koegler's
	message of "Fri, 23 Feb 2007 08:13:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40422>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> Commiting a new version in GIT increases the storage by the compressed
> size of each changed blob. Packing all unpacked objects decreases the
> required storage, but does not generate deltas against objects in
> packs. You need to repack all objects to get around this.
>
> For normal source code, this is not a problem.  But if you want to use
> git for big files, you waste storage (or CPU time for everything
> repacking).

Three points that might help you without any code change.

 - Have you run "git repack -a -d" without "-f"?  Reusing of
   existing delta is specifically designed to avoid the "CPU
   time for everything repacking" problem.

 - If you are dealing with something other than "normal source
   code", do you know if your objects delta against each other
   well?  If not, turning core.legacyheaders off might be a
   win.  It allows the objects that are recorded as non-delta in
   resulting pack to be copied straight from loose objects.

 - Once you accumulated large enough packs with existing
   objects, marking them with .keep would leave them untouched
   during subsequent repack.  When "git repack -a -d" repacks
   "everything", its definition of "everything" becomes "except
   things that are in packs marked with .keep files".

Side note: Is the .keep mechanism sufficiently documented?  I am
too lazy to check that right now, but here is a tip.  After
releasing the big one, line v1.5.0, I do:

  $ P=.git/objects/pack
  $ git rev-list --objects v1.5.0 |
    git pack-objects --delta-base-offset \
          --depth=30 --window=100 --no-reuse-delta pack
  ...
  6fba5cb8ed92dfef71ff47def9f95fa1e703ba59
  $ mv pack-6fba5cb8ed92dfef71ff47def9f95fa1e703ba59.* $P/
  $ echo 'Post 1.5.0' >$P/pack-6fba5cb8ed92dfef71ff47def9f95fa1e703ba59.keep
  $ git gc --prune

This does three things:

 - It packs everything reachable from v1.5.0 with delta chain
   that is deeper than the default.

 - The pack is installed in the object store; the presence of
   .keep file (the contents of it does not matter) tells
   subsequent repack not to touch it.

 - Then the remaining objects are packed into different pack.

With this, the repository uses two packs, one is what I'll keep
until it's time to do the big repack again, another is what's
constantly recreated by repacking but contains only "recent"
object.

> It only permits, that the base commit of a delta is located in a
> different pack or as unpacked object.

This "only" change needs to be done _very_ carefully, since
self-containedness of pack files is one of the important
elements of the stability of a git repository.

In effect, you are making the delta and its base object into a
new type of "reachability" for the purpose of fsck/prune by
allowing incremental pack to contain a delta against a loose
object.  I am not saying it is a bad idea, but making sure you
covered every case you could lose necessary objects will be a
lot of work.

For example, suppose a delta in your incremental pack is based
on a loose object.  That loose object can become unreachable
after rewinding or rebasing your refs.  You have to somehow
arrange that git-prune knows this situation and prevent it from
getting pruned -- otherwise your incremental pack becomes
corrupt.

And that is just one example I could come up with after seeing
your message in 3 minutes while watching TV ;-).  I would
usually say "I am sure there will be more...", but in this
particular case, I am inclined to say that I do not even want to
start thinking about possible fallout from this.  It's scary.
