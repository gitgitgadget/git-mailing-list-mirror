From: Jeff King <peff@peff.net>
Subject: duplicate objects in packfile
Date: Wed, 14 Aug 2013 14:17:18 -0400
Message-ID: <20130814181718.GA7911@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 14 20:17:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9fdO-0004mR-Hg
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 20:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758413Ab3HNSRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 14:17:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:39717 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038Ab3HNSRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 14:17:21 -0400
Received: (qmail 3831 invoked by uid 102); 14 Aug 2013 18:17:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Aug 2013 13:17:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Aug 2013 14:17:18 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232305>

I'm tracking down a rather odd problem in a packfile I found on GitHub.
This particular packfile contains the same object at various offsets
within the file. In fact there are several packfiles that exhibit this
behavior, all in the same repository, and in each one there are several
duplicated objects (some of which are present 3 or even 4 times).

index-pack is happy to index these packfiles, and just creates multiple
entries for the object. The usual binary search in find_pack_entry_one
will find one of them (though of course which depends on the exact
layout of the index). But curiously, the experimental sha1_entry_pos
lookup does not.  It hits an assert() that can only be triggered in the
face of duplicate objects. For example:

  $ git cat-file -t 4ea4acbcb0930ac42acc87a0d203864dec1a9697
  commit

  $ GIT_USE_LOOKUP=1 git cat-file -t 4ea4acbcb0930ac42acc87a0d203864dec1a9697
  git: sha1-lookup.c:222: sha1_entry_pos: Assertion `lov < hiv' failed.
  Aborted

It's easy enough to fix with a repack, but I am curious:

  1. Is sha1_entry_pos wrong to barf on duplicate items in the index? If
     so, do we want to fix it, or simply retire GIT_USE_LOOKUP?

     Related, should we consider duplicate items in a packfile to be a
     bogus packfile (and consequently notice and complain during
     indexing)? I don't think it _hurts_ anything (aside from the assert
     above), though it is of course wasteful.

     I didn't go into detail on how the assertion above is triggered,
     but I can break it down line by line if anybody cares; the short of
     it is that it can only be caused by an unsorted index or a
     duplicate entry.

  2. How can duplicate entries get into a packfile?

     Git itself should not generate duplicate entries (pack-objects is
     careful to remove duplicates). Since these packs almost certainly
     were pushed by a client, I wondered if "index-pack --fix-thin"
     might accidentally add multiple copies of an object when it is the
     preferred base for multiple objects, but it specifically avoids
     doing so.

     The packs in question were received by us in 2010. Did we ever have
     bugs in this area? I don't recall any, nor could I find any in the
     history.

     That makes me suspect the user may have been using an alternate git
     implementation. libgit2 did not know how to pack in 2010, and Grit
     still doesn't.  JGit did, and I don't know offhand about Dulwich.
     Does anyone know of bugs in those implementations that might have
     caused this?

The packs in question are public, so I can share them if anybody is
curious to look (but the whole repository is on the order of 700M).

Given the dates on the packs and how rare this is, I'm pretty much
willing to chalk it up to a random bug (in git or otherwise) that does
not any longer exist. But I was curious if anybody else knew anything,
and we may want to fix sha1_entry_pos to behave more like the regular
binary search.

-Peff
