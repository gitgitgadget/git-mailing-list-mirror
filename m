From: Jeff King <peff@peff.net>
Subject: [RFH] bug in unpack_trees
Date: Tue, 4 Mar 2008 06:59:41 -0500
Message-ID: <20080304115940.GA5260@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Goerzen <jgoerzen@complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 13:00:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVp7-0002Vx-Uh
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 13:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbYCDL7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 06:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756000AbYCDL7o
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:59:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3746 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754395AbYCDL7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 06:59:44 -0500
Received: (qmail 4953 invoked by uid 111); 4 Mar 2008 11:59:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 04 Mar 2008 06:59:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Mar 2008 06:59:41 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76073>

I am tracking down a bug in unpack_trees, but I can't seem to find the
exact problem; I'm hoping to get help from people who have touched this
code a bit more than I have.

You can see the problem with this script:

  # make a repo
  mkdir repo && cd repo && git init

  # make a directory which will become a df conflict
  mkdir df
  echo content >df/file
  git add df/file
  git commit -m one

  # and save a copy of the index
  git ls-files >index1

  # now make a new commit that has the df conflict and
  # a newly added file
  rm -rf df
  echo content >df
  git add df
  echo content >new
  git add new
  git commit -m two

  # now this should put our index exactly back to 'one'
  git reset --hard HEAD^

  # but it doesn't
  git ls-files >index2
  diff -u index1 index2

The 'new' file is still in the index, and it shouldn't be. It's actually
not git-reset to blame, but the "git read-tree -u --reset HEAD^" that it
calls. The problem reproduces with every version of git I tried, so I
suspect it is as old as unpack_trees.

As far as I can tell, the D/F conflict somehow gets the list merge out
of sync. In unpack_trees_rec, every cache entry we look up gets compared
to the first tree entry, but because we are out of sync, the tree entry
will always become the new "first" (it looks like this test is supposed
to be for processing foo/ before foo/bar, and shouldn't otherwise
trigger). Because "first" and "cache_name" don't match, we don't realize
we haven't found an entry missing from the tree, and we don't trigger
the removal code.

So where I need help is figuring out how the traversal is _supposed_ to
work. I.e., why does it get out of sync on the D/F case? I'm sure it's
probably a one-liner fix, but I just don't see it.

-Peff
