From: David Kastrup <dak@gnu.org>
Subject: A simpler approach to tracking directories (was: The philosophy behind my directory proposal in a nutshell)
Date: Sun, 22 Jul 2007 17:39:06 +0200
Message-ID: <85abtola79.fsf@lola.goethe.zz>
References: <85fy3hqtwl.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 17:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICdWe-0008MO-9L
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 17:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbXGVPjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 11:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbXGVPjM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 11:39:12 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:52953 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876AbXGVPjL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 11:39:11 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 9316327BC2C
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 17:39:09 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 79F9C2DAB40
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 17:39:09 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-022-107.pools.arcor-ip.net [84.61.22.107])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 44D5936E86B
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 17:39:09 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3C8211D1E182; Sun, 22 Jul 2007 17:39:06 +0200 (CEST)
In-Reply-To: <85fy3hqtwl.fsf@lola.goethe.zz> (David Kastrup's message of "Sun\, 22 Jul 2007 00\:22\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53274>


Ok, I've gotten enough flak for my first proposal that it is clear
that it is rather irrelevant whether it would work (of which I remain
convinced) or not.  Now I also have been of the opinion that it was
perfectly easy to understand and embrace, and the amount, content and
tone of responses have made very obvious that I have been quite wrong
about _that_ at least.

The good thing is that among all the flamage there have been actually
some people who went to the pain of actually reviewing the proposed
changes and give feedback about their relative feasibility in the
current code base.  This has helped more than the reflections on my
sanity, I am glad to say.

So here we go:

I think there has been some vague consensus with the notion that it
does not make sense to track whether or not a directory _is_ empty at
the time of checkin (when checking in files below it, it _can't_ be),
but rather whether it should be automatically added and removed by git
based on the files in it alone.

The current state of affairs with git is that directories are
exclusively a mechanism for accommodating hierarchical filenames.
Consequently, the index does not need to know about them.

Anyway, here is the basic idea: git is already capable of tracking
file permissions (though at the current point of time, this is
somewhat artificially limited to the u+x bit), so there are basic
mechanisms in place for passing the respective bits through.

Now my proposal basically boils down to using the u+x bit on
directory/tree entries for tracking "keep around when empty".

I think we are on the safe side to assume a directory with access
permissions zero (a-rwx) is something we never want to be able to
track with git.  So this special value, which I think is the current
default, can express "delete when empty".  Personally I believe that
git can be made without problems to track more permissions (possibly
by configuring an appropriate mask for the project) than it currently
does, but that's not relevant for now: it is sufficient to use
permissions a-rwx for an automatically managed (=evaporate when empty)
tree/directory, and 755 for a manually managed (=stay around)
tree/directory without actually calling lstat for now.

Apart from needing to accommodate directories in the index (since they
are now associated with 1 instead of 0 bits of information), this will
work with the current data structures and protocols.  Patches and
diffs can encode the change between tracked and untracked directories
as a change in the permissions of the directory.

So this obliterates the need to distinguish trees from directories
using actually separate and separately listed repository entries,
hopefully removing the main stumbling block.

It also addresses the concern of a tree's SHA1 changing when its
evaporate-when-empty-ness changes.  It also will not lead to dangerous
situations on systems attempting to replace or delete "." as a regular
file.

So it has several technical advantages over my previous proposal, and
I _think_ it may be easier to understand and lead to less
contraintuitive behavior.

Now for deciding about _when_ to track a directory or not, I think
that the following part of the previous proposal was workable:

A directory's permission should be tracked in the same situations that
a file's permissions get tracked: that is if either the directory has
_explicitly_ been added to a commit, or it is _implicitly_ part of a
complete tree added into a commit.  For implicitly indicated _files_,
whether or not they become tracked depends on the gitignore mechanism.
I think asking the gitignore mechanism whether the pattern "." in a
given directory is worth tracking is a good way of deciding implicit
inclusion, falling back onto a "core.dirtrack" or similar variable
that has some vague analogy to the "core.filemode" variable.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
