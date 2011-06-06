From: Jeff King <peff@peff.net>
Subject: Re: diff'ing files ...
Date: Mon, 6 Jun 2011 18:43:56 -0400
Message-ID: <20110606224356.GC13697@sigill.intra.peff.net>
References: <BANLkTi=1vaoLVmhyahDttmUmqw7RTp=8-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Albretch Mueller <lbrtchx@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 00:44:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTiWv-0006c1-Mo
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 00:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758498Ab1FFWoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 18:44:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40178
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758363Ab1FFWoA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 18:44:00 -0400
Received: (qmail 9734 invoked by uid 107); 6 Jun 2011 22:44:06 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jun 2011 18:44:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jun 2011 18:43:56 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=1vaoLVmhyahDttmUmqw7RTp=8-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175178>

On Mon, Jun 06, 2011 at 06:49:04PM +0000, Albretch Mueller wrote:

>  I could not find specific information on what diff'ing algorithm does
> git use. Any white papers about git internals, mostly about its
> diff'ing and synching algorithm? (and I am not scared at all of
> "Directed Acyclic Graph" or any kind of Math terminology; in fact, I
> love it ;-))

It depends on what level you want to talk about. Each commit has a tree
state represented by a single "tree object". Each tree object is a list
of paths mapping to more objects, each of which may be a binary stream
of data ("blob") or another tree object (i.e., a subtree).

Diffing commits means diffing their trees. Diffing trees means looking
for blobs at the same path in each commit and diffing them[1]. How we
diff the content in the blobs depends on:

  1. any external diff configuration (e.g., GIT_EXTERNAL_DIFF in the
     environment, or a per-file diff driver; see "git help attributes").
     In that case, we just show whatever output the external diff
     produces.

  2. We use xdiff by default, which does a line-oriented diff using the
     Myers algorithm (just like most "diff" implementations). See
     xdiff/xdiffi.c in the git source, or Myers "An O(ND) Difference
     Algorith and its Variations".

  3. If you give the --patience option, we use the patience algorithm
     instead:

       http://bramcohen.livejournal.com/73318.html

     That's the inventor's original description, but you can find other
     discussion by googling for "patience diff".

  4. If you use --word-diff (or --color-words), we find differences by
     line, and then break lines down by configurable delimiters into
     words, and then do a Myers diff on the resulting list of words.

  5. If files are not text, we usually just say "Binary files differ"
     (like most diff implementations). We can also generate binary
     diffs, though I don't know offhand the details of the algorithm.

I think that more or less covers 2-way diffing. There's also a 3-way
comparison when merging, both at the tree level and at the blob level.
Syncing actually has very little to do with our regular diffing. We
generate compact binary deltas (just like in (5) above) between objects,
regardless of their path, and send the other side a set of needed
objects. This is the same format used for compact "packfile" storage.
If the last bit of that paragraph didn't make any sense, then read up on
git's object model in something like "Pro Git":

  http://progit.org/book/ch9-0.html

-Peff

[1] Actually, tree comparisons are a little more complex than I made
them out to be. For instance, a path might exist on only one side (which
we usually show as a comparison to an empty blob), or might exist as a
tree on one side and a blob on the other. We also look for renames of
paths at the blob level by looking for similar blobs.
