From: Jeff King <peff@peff.net>
Subject: [PATCH 0/16] make prune mtime-checking more careful
Date: Fri, 3 Oct 2014 16:20:46 -0400
Message-ID: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:21:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9La-0006L2-7r
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbaJCUU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:20:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:54800 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753823AbaJCUUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:20:48 -0400
Received: (qmail 2646 invoked by uid 102); 3 Oct 2014 20:20:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:20:48 -0500
Received: (qmail 14876 invoked by uid 107); 3 Oct 2014 20:20:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:20:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:20:46 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257850>

At GitHub we've occasionally run across repos getting corrupted by trees
and blobs near the tip going missing. We do a lot of "test merges"
between branches and HEAD (this is what feeds the "OK to merge" button
on the web interface), and the objects are almost always related to
these merges. The objects are removed by prune, which doesn't realize
that they are part of an ongoing operation. Prune uses the filesystem
mtime to determine this, but we are not very thorough in making sure
that is kept up to date.

This series tries to fix that with two techniques:

  1. When we try to write an object to disk, we optimize out the write
     if we already have the object. Instead, we should still update the
     mtime of the object in this case.

  2. Treat objects reachable from "recent" objects as recent themselves.

     When we check that we have an object, we do not check whether we
     have all of the objects it can reach. If you have some new objects
     that refer to some old objects (e.g., you create and delete a tree
     on day 1, and then create a new tree referring to the blob on day
     2), then prune may delete the old object but not the new (in this
     case, we delete the blob but not the tree).

     Any subsequent use of the new object will check that we have it
     (e.g., commit-tree makes sure we have the tree we feed it), but not
     other objects it can reach. This can lead to referencing a
     half-formed part of the graph.

Note that this does not make prune race-free. For example, you could
check for and update the mtime of an object just as prune is deleting
it, and think that it is written when it is not. Fixing that would
require some atomic mechanism for prune to check the mtime and delete.
But I do think this series cuts us down to "real" race conditions, with
millisecond-ish timing. The problems we're fixing here are much worse
than that. The distance between an object being written and being
referred may operate on human timescales (e.g., writing a commit
message). Or the time distance between two objects that refer to each
other may be days or weeks; a prune where one falls in the "recent"
boundary and another does not can be disastrous.

There's quite a lot of patches here, but most of them are preparatory
cleanups. The meat is in patches 13, 15, and 16.

  [01/16]: foreach_alt_odb: propagate return value from callback
  [02/16]: isxdigit: cast input to unsigned char
  [03/16]: object_array: factor out slopbuf-freeing logic
  [04/16]: object_array: add a "clear" function
  [05/16]: clean up name allocation in prepare_revision_walk
  [06/16]: reachable: clear pending array after walking it
  [07/16]: t5304: use test_path_is_* instead of "test -f"
  [08/16]: t5304: use helper to report failure of "test foo = bar"
  [09/16]: prune: factor out loose-object directory traversal
  [10/16]: count-objects: do not use xsize_t when counting object size
  [11/16]: count-objects: use for_each_loose_file_in_objdir
  [12/16]: sha1_file: add for_each iterators for loose and packed objects
  [13/16]: prune: keep objects reachable from recent objects
  [14/16]: pack-objects: refactor unpack-unreachable expiration check
  [15/16]: pack-objects: match prune logic for discarding objects
  [16/16]: write_sha1_file: freshen existing objects

Note that these aren't yet running on GitHub servers. I know that they
fix real potential problems (see the new t6501 for examples), but I
don't know for sure if they will catch the problems we have seen. The
frequency of these issues is relatively rare, so even once deployed, we
won't know for sure until a few weeks or months have passed.

-Peff
