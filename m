From: linux@horizon.com
Subject: Feature request: thin checkout
Date: 15 Jun 2007 04:53:46 -0400
Message-ID: <20070615085346.8027.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 10:53:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz7Z9-0001v6-BX
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 10:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbXFOIxt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 04:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbXFOIxt
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 04:53:49 -0400
Received: from science.horizon.com ([192.35.100.1]:19196 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752484AbXFOIxr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 04:53:47 -0400
Received: (qmail 8028 invoked by uid 1000); 15 Jun 2007 04:53:46 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50255>

Git packs so well that it's very common for the unpacked source to be much
larger than the history in .git.  The linux-kernel archive is a prime example.

I've also started using git-svn (awesome tool, BTW) and have discovered
the impressive disk space costs associated with SVN's tags/ directories
if I actually want to download the full history.

If you have multiple cloned repositories on one system, git can share
the history, but the working directory problem is exacerbated.
(Disk is cheap, but the RAM to cache it is limited.)

This got me thinking...
Wouldn't it be nice if there were a way to tell git-update-index and
git-checkout index that certain directories are not in the working
directory, but don't worry.  Just pretend they exist and match the index.

Then I could mark much of arch/* as "don't bother" and save a pile of
disk space per working directory.

This would be a little bit annoying if I tried to merge two branches with
conflicts in a "masked" part of the tree (well, it would create the index
entries, but I'd have no way to resolve the conflict), but I think that's
a matter of Don't Do That.

A slightly more flexible (but confusing?) option would be to mark parts
of the tree as "don't commit deletion".  That is, within named sections
of the tree:
- Missing files in the working directory are assumed unchanged from
  the index.  (Perhaps unless you explicitly git-add them.)
- Files that don't already exist aren't checked out from the index.
  (Unless explicitly named in a git-checkout operation.)
... but you could have a "selective checkout" in some directories.
E.g. in the kernel, you could include a stub Makefile, but omit
the .c files for file systems you don't need.

(And if we're really sneaky, teach the linux kernel Makefile how to check
out code when features are enabled.  That would address a longstanding
complaint about the size of the linux kernel source tree.  It's a
bit trickier than default make rules for getting <foo> from RCS/foo,v
because got doesn't provide a signle file that make(1) can look for,
but something's probably possible.)

That could also handle merges... the "check out the file with conflict
markers" operation could be unconditional if there are conflicts.


The multiple-git-repositories issue could be handled by hard-linking
the working directory files together (assuming your editor knows how to
unlink when changing them) using information easily available in the
index files.  Git could even detect and complain if a two files that
mismatched their index entries were hard-linked together.

But for the git-svn case where you have a tags/ directory full of old
copies of files, hard-linking is of limited use if most files changed
between tags.  Here, just being able to say "don't bother populating
that part of the working directory" would be very nice.


Does this make sense to anyone else?
