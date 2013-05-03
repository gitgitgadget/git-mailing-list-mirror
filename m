From: Jeff King <peff@peff.net>
Subject: another packed-refs race
Date: Fri, 3 May 2013 04:38:48 -0400
Message-ID: <20130503083847.GA16542@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 03 10:38:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYBW5-0006R7-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 10:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762783Ab3ECIiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 04:38:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:36704 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab3ECIiu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 04:38:50 -0400
Received: (qmail 12878 invoked by uid 102); 3 May 2013 08:39:07 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 May 2013 03:39:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 May 2013 04:38:48 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223299>

I found another race related to the packed-refs code. Consider for a
moment what happens when we are looking at refs and another process does
a simultaneous "git pack-refs --all --prune", updating packed-refs and
deleting the loose refs.

If we are resolving a single ref, then we will either find its loose
form or not. If we do, we're done. If not, we can fall back on what was
in the packed-refs file. If we read the packed-refs file at that point,
we're OK. If the loose ref existed before but was pruned before we could
read it, then we know the packed-refs file is already in place, because
pack-refs would not have deleted the loose ref until it had finished
writing the new file. But imagine that we already loaded the packed-refs
file into memory earlier. We may be looking at an _old_ version of it
that has an irrelevant sha1 from the older packed-refs file. Or it might
not even exist in the packed-refs file at all, and we think the ref does
not resolve.

We could fix this by making sure our packed-refs file is up to date
before using it. E.g., resolving a ref with the following sequence:

  1. Look for loose ref. If found, OK.

  2. Compare inode/size/mtime/etc of on-disk packed-refs to their values
     from the last time we loaded it. If they're not the same, reload
     packed-refs from disk. Otherwise, continue.

  3. Look for ref in in-memory packed-refs.

Not too bad. We introduce one extra stat() for a ref that has been
packed, and the scheme isn't very complicated.

But what about enumerating refs via for_each_ref? It's possible to have
the same problem there, and the packed-refs file may be moved into place
midway through the process of enumerating the loose refs. So we may see
refs/heads/master, but when we get to refs/remotes/origin/master, it has
now been packed and pruned. I _think_ we can get by with:

  1. Generate the complete sorted list of loose refs.

  2. Check that packed-refs is stat-clean, and reload if necessary, as
     above.

  3. Merge the sorted loose and packed lists, letting loose override
     packed (so even if we get repacked halfway through our loose
     traversal and get half of the refs there, it's OK to see duplicates
     in packed-refs, which we will ignore).

This is not very far off of what we do now. Obviously we don't do the
stat-clean check in step 2. But we also don't generate the complete list
of loose refs before hitting the packed-refs file. Instead we lazily
load the loose directories as needed. And of course we cache that
information in memory, even though it may go out of date. I think the
best we could do is keep a stat() for each individual directory we see,
and check it before using the in-memory contents. That may be a lot of
stats, but it's still better than actually opening each loose ref
separately.

So I think it's possible to fix, but I thought you might have some
insight on the simplest way to fit it into the current ref code.

Did I explain the problem well enough to understand? Can you think of
any simpler or better solutions (or is there a case where my proposed
solutions don't work?).

For reference, here's a script that demonstrates the problem during
enumeration (sometimes for-each-ref fails to realize that
refs/heads/master exists at all):

  # run this in one terminal
  git init repo &&
  cd repo &&
  git commit --allow-empty -m foo &&
  base=`git rev-parse HEAD` &&
  while true; do
    # this re-creates the loose ref in .git/refs/heads/master
    git update-ref refs/heads/master $base &&

    # we can remove packed-refs safely, as we know that
    # its only value is now stale. Real git would not do
    # this, but we are simulating the case that "master"
    # simply wasn't included in the last packed-refs file.
    rm -f .git/packed-refs &&

    # and now we repack, which will create an up-to-date
    # packed-refs file, and then delete the loose ref
    git pack-refs --all --prune
  done

  # then simultaneously run this in another
  cd repo &&
  while true; do
    refs=`git for-each-ref`
    echo "==> $refs"
    test -z "$refs" && break
  done

Obviously the "rm -f packed-refs" above is contrived, but it does
simulate a real possible state. You could also do it with a packed-refs
file that has an outdated value for refs/heads/master, and demonstrate
that for-each-ref sees the outdated value.

-Peff
