From: mdw@distorted.org.uk (Mark Wooding)
Subject: git-http-fetch failure/segfault -- alas no patch
Date: Mon, 30 Jan 2006 20:34:16 +0000
Message-ID: <17374.30792.548889.344768@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 30 21:35:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3fjt-0000wh-Bh
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 21:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWA3UeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 15:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWA3UeU
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 15:34:20 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:7590 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S964962AbWA3UeT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 15:34:19 -0500
Received: (qmail 4691 invoked by uid 1000); 30 Jan 2006 20:34:18 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15297>

[This is a repost -- sorry!  I fouled up the last one by missing the
subject off, which makes me look like a prize pillock.  I also failed to
mention the relevant versions, so let me try again.  I do actually have
a brain, honest; it's just not working at the moment for some reason.]

git-http-fetch seems buggy.  (This is in both 1.1.5 and 1506fc34... on
the git.kernel.org master -- same symptoms.)

I /think/ it's getting confused by a combination of a large top-level
tree (lots of blobs directly attached) attached to the top commit,
together with most of the things being packed.

To illustrate the bug, create a repository with the following shell
script.  (It will create a working tree called `funt' with a little GIT
history inside.)

----
#! /bin/sh

set -e
mkdir funt
cd funt
git-init-db 
yes | nl | head -200 | while read n hunoz; do echo file $n >foo.$n; done
git-add *
echo Boo. | git-commit -F - -a
git-repack
git-prune-packed 
echo Censored >foo.197
echo Ouch. | git-commit -F - -a
git-update-server-info
----

Then put the repository somewhere your web server will let you get to
it, and try to clone it, say using

  git-clone http://boyle.nsict.org/~mdw/funt.git

(Yes, that repository exists and is live; the server is fairly
well-connected.  FWIW, I've put up a tarball of the repository called
.../funt.git.tar.gz too.)  You ought to be greeted with text like this:

  error: Unable to find b4f495485ca9ae825ec8c504cdcf24652342f43c under
  http://boyle.nsict.org/~mdw/funt/.git/

  Cannot obtain needed commit b4f495485ca9ae825ec8c504cdcf24652342f43c
  while processing commit 351c72525b9ee5b2321c65598ce82a4e79015012.

If you're very lucky, git-http-fetch will segfault.

What's going on here?

Think about the repository layout for a bit.  There's a `big' pack file,
and a little commit.  The commit has an unpacked tree attached, but
almost all of its leaves are in the pack.  The commit's parent is
packed.

So git-http-fetch starts by filling its queue with prefetches for blob
objects which are packed (and so it gets 404s for them).  This is fine.
However! when it comes to collect the parent commit, it realises it
needs to fetch the pack list.  Unfortunately, something goes wrong in
run_active_slot.  As far as I can make out, the slot used to collect
.../info/packs is being /reused/ by fill_active_slots (called by
step_active_slots) before fetch_indices is returned to.  Since the
prefetch which got the new slot is for an object which got packed, it
fails with a 404, which is written back to the slot.  The result is that
fetch_indices thinks that the pack list doesn't exist (even though it
actually does, and libcurl fetched it just fine, thanks).  This is
marked as a permanent error, and that parent commit can't be found.

The segfault is I think due to this reuse too, but it only happens
sometimes and I'm not entirely clear on why.

I'm afraid I don't have a patch.  I've spent a little while trying to
fix this bug myself, but my changes just seem to cause wedging, or fd
leaks, or segfaults, or all three, so it's obvious I don't understand
the code well enough.

-- [mdw]
