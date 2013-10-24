From: Jeff King <peff@peff.net>
Subject: [PATCH 0/19] pack bitmaps
Date: Thu, 24 Oct 2013 13:59:15 -0400
Message-ID: <20131024175915.GA23398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 19:59:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZPBq-0002Ih-7I
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 19:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815Ab3JXR7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 13:59:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:54855 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752724Ab3JXR7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 13:59:17 -0400
Received: (qmail 331 invoked by uid 102); 24 Oct 2013 17:59:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 12:59:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 13:59:15 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236587>

This series implements JGit-style pack bitmaps to speed up fetching and
cloning. For example, here is a simulation of the server side of a clone
of a fully-packed kernel repo (measuring actual clones is harder,
because the client does a lot of work on resolving deltas):

   [before]
   $ time git pack-objects --all --stdout </dev/null >/dev/null
   Counting objects: 3237103, done.
   Compressing objects: 100% (508752/508752), done.
   Total 3237103 (delta 2699584), reused 3237103 (delta 2699584)

   real    0m44.111s
   user    0m42.396s
   sys     0m3.544s


   [after]
   $ time git pack-objects --all --stdout </dev/null >/dev/null
   Reusing existing pack: 3237103, done.
   Total 3237103 (delta 0), reused 0 (delta 0)

   real    0m1.636s
   user    0m1.460s
   sys     0m0.172s


This helps eliminate load on the server side, but it also means that we
actually start transferring objects way faster, which means the clones
finish faster. If you look at current clones of torvalds/linux from
kernel.org, it's almost two minutes before they actually start sending
you any data, during which time the client is twiddling its thumbs.

The bitmaps implemented here are compatible with those produced by JGit.
We can read JGit-produced bitmaps, and JGit can read ours. The one
exception is the final patch, which adds an optional name-hash cache.
It's added in such a way that existing implementations can ignore it,
and is marked with a flag in the header. However, JGit is very picky
about the "flags" field; it will reject any bitmap index with a flag it
does not know about.

The patches are:

  [01/19]: sha1write: make buffer const-correct
  [02/19]: revindex: Export new APIs
  [03/19]: pack-objects: Refactor the packing list
  [04/19]: pack-objects: factor out name_hash
  [05/19]: revision: allow setting custom limiter function
  [06/19]: sha1_file: export `git_open_noatime`
  [07/19]: compat: add endianness helpers
  [08/19]: ewah: compressed bitmap implementation

    Refactoring and support for the rest of the series.

  [09/19]: documentation: add documentation for the bitmap format
  [10/19]: pack-bitmap: add support for bitmap indexes
  [11/19]: pack-objects: use bitmaps when packing objects
  [12/19]: rev-list: add bitmap mode to speed up object lists

    Bitmap reading (you can test it against JGit at this point by
    running "jgit debug-gc", and then cloning or running rev-list).

  [13/19]: pack-objects: implement bitmap writing
  [14/19]: repack: stop using magic number for ARRAY_SIZE(exts)
  [15/19]: repack: turn exts array into array-of-struct
  [16/19]: repack: handle optional files created by pack-objects
  [17/19]: repack: consider bitmaps when performing repacks

    Bitmap writing (you can test against JGit by running
    "git repack -adb", and then running "jgit daemon" to
    serve the result).

  [18/19]: t: add basic bitmap functionality tests

    With reading and writing, we can do our own tests.

  [19/19]: pack-bitmap: implement optional name_hash cache

    And this is our extension.

A similar series has been running on github.com for the past couple of
months, though not every repository has had bitmaps turned on (but some
very busy ones have).  We've hopefully squeezed out all of the bugs and
corner cases over that time. However, I did rebase this on a more modern
version of "master"; among other conflicts, this required porting the
git-repack changes from shell to C. So it's entirely possible I've
introduced new bugs. :)

The idea and original implementation for bitmaps comes from Shawn and
Colby, of course. The hard work in this series was done by Vicent Marti,
and he is credited as the author in most of the patches. I've added some
window dressing and helped a little with debugging and review. But along
with Vicent, I should be able to help with answering questions for
review, and as time goes on, I'm familiar enough with the code to deal
with bugs and reviewing future changes.

-Peff
