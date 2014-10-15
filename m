From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/25] prune-safety
Date: Wed, 15 Oct 2014 18:32:44 -0400
Message-ID: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:32:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeX7n-000306-1l
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbaJOWcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:32:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:58907 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751287AbaJOWcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:32:50 -0400
Received: (qmail 1961 invoked by uid 102); 15 Oct 2014 22:32:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:32:47 -0500
Received: (qmail 27804 invoked by uid 107); 15 Oct 2014 22:32:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:32:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:32:44 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a re-roll of the patch series I posted earlier to make "git
prune" keep more contiguous chunks of the object graph. The cleanups to
t5304 were spun off into their own series, and are dropped here.
However, the other patches seem to have multiplied in number (I must
have fed them after midnight).

Here are the changes since the first round (thanks everybody for your
comments):

  - fix bogus return values from freshen_file, foreach_alt_odb, and
    for_each_packed_object

  - make for_each_object_in_pack static

  - clarify commit message for "keep objects reachable from recent
    objects" patch (this was the one that confused Junio, and I
    elaborated based on our discussion)

  - clarify the definition of "loose object dirs" in the comment above
    for_each_loose_file_in_object_dir

  - in for_each_loose_file, traverse hashed loose object directories in
    numeric order, and pass the number to the subdir callback (this is
    used by prune-packed for its progress updates); as a side effect,
    this fixes the bugs Michael noticed with the subdir callback.

  - prune-packed now reuses the for_each_loose_file interface

  - use revs->ignore_missing_links so we don't barf on already-missing
    unreferenced objects

  - convert reachable.c to use traverse_commit_list instead of its own
    custom walk; this gives support for ignore_missing_links above, and
    saves us a fair bit of code.

  - while in the area, I noticed that reachable.c's reflog handling is
    the same as rev-list's --reflog option; it now builds on what's in
    revision.c.

That takes us up to patch 17. While working in reachable.c, I noticed an
oddity: we consider objects in the index to be reachable during prune
(which is good), but we do not when dropping them during a repack that
uses --unpack-unreachable=<expiration>. The remaining patches fix that,
which needed a fair bit of preparatory cleanup.

I'm really beginning to question whether the "just drop objects that are
about to be pruned" optimization done in 7e52f56 (gc: do not explode
objects which will be immediately pruned, 2012-04-07). It really
complicates things as pack-objects and prune need to have the exact same
rules (and implementing it naively, by having pack-objects run the same
code as prune, is not desirable because pack-objects has _already_ done
a complete expensive traversal to generate the packing list). And I fear
it will get even worse if we implement some of the race-condition fixes
that Michael suggested earlier.

On the other hand, the loosening behavior without 7e52f56 has some
severe pathological cases. A repository which has had a chunk of history
deleted can easily increase in size several orders of magnitude due to
loosening (since we lose the benefit of all deltas in the loosened
objects).

Finally, there are a few things that were discussed that I didn't
address/fix. I don't think any of them is a critical blocker, but I
did want to summarize the state:

  - when refreshing, we may update a pack's mtime multiple times. It
    probably wouldn't be too hard to cache this and only update once per
    program run, but I also don't think it's that big a deal in
    practice.

  - We will munge mtimes of objects found in alternates. If we don't
    have write access to the alternate, we'll create a local duplicate
    of the object. This is the safer thing, but I'm not sure if there
    are cases where we might try to write out a large number of objects
    which exist in an alternate (OTOH, we will eventually drop them at
    the next repack).

  - I didn't implement the "sort by inode" trick that fsck does when
    traversing the loose objects. It wouldn't be too hard, but I'm not
    convinced it's actually important.

  - I didn't convert fsck to the for_each_loose_file interface (mostly
    because I didn't do the inode-sorting trick, and while I don't think
    it matters, I didn't go to the work to show that it _doesn't_).

Here are the patches:

  [01/25]: foreach_alt_odb: propagate return value from callback
  [02/25]: isxdigit: cast input to unsigned char
  [03/25]: object_array: factor out slopbuf-freeing logic
  [04/25]: object_array: add a "clear" function
  [05/25]: clean up name allocation in prepare_revision_walk
  [06/25]: reachable: use traverse_commit_list instead of custom walk
  [07/25]: reachable: reuse revision.c "add all reflogs" code
  [08/25]: prune: factor out loose-object directory traversal
  [09/25]: reachable: mark index blobs as SEEN
  [10/25]: prune-packed: use for_each_loose_file_in_objdir
  [11/25]: count-objects: do not use xsize_t when counting object size
  [12/25]: count-objects: use for_each_loose_file_in_objdir
  [13/25]: sha1_file: add for_each iterators for loose and packed objects
  [14/25]: prune: keep objects reachable from recent objects
  [15/25]: pack-objects: refactor unpack-unreachable expiration check
  [16/25]: pack-objects: match prune logic for discarding objects
  [17/25]: write_sha1_file: freshen existing objects
  [18/25]: make add_object_array_with_context interface more sane
  [19/25]: traverse_commit_list: support pending blobs/trees with paths
  [20/25]: rev-list: document --reflog option
  [21/25]: rev-list: add --index-objects option
  [22/25]: reachable: use revision machinery's --index-objects code
  [23/25]: pack-objects: use argv_array
  [24/25]: repack: pack objects mentioned by the index
  [25/25]: pack-objects: double-check options before discarding objects
