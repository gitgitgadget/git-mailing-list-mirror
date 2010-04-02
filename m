From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] textconv caching
Date: Fri, 2 Apr 2010 02:14:21 -0400
Message-ID: <20100402061420.GA5551@coredump.intra.peff.net>
References: <20100402000159.GA15101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 08:14:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxa9P-0000wv-W2
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 08:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189Ab0DBGOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 02:14:35 -0400
Received: from peff.net ([208.65.91.99]:32816 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758028Ab0DBGOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 02:14:34 -0400
Received: (qmail 8554 invoked by uid 107); 2 Apr 2010 06:15:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 02 Apr 2010 02:15:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Apr 2010 02:14:21 -0400
Content-Disposition: inline
In-Reply-To: <20100402000159.GA15101@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143778>

On Thu, Apr 01, 2010 at 08:01:59PM -0400, Jeff King wrote:

>   [before]
>   $ time git show >/dev/null
>   real    0m13.724s
>   user    0m12.057s
>   sys     0m1.624s
> 
>   [after (with cache primed)]
>   $ time git show >/dev/null
>   real    0m0.009s
>   user    0m0.004s
>   sys     0m0.004s

Since this is a space-time tradeoff, I thought it would make sense to
show some size numbers as a followup.

To get a sense of the size of the repo (it's almost all photos and
videos):

  [size of the repo, already fully packed]
  $ du -sh .git/objects
  4.0G    .git/objects

  [the number of unique blobs through all history; most are binary media]
  $ git log --raw --no-abbrev | awk '/^:/ {print $3 "\n" $4}' | sort -u | wc -l
  10605

In comparison, the metadata for a given file (produced by the textconv)
is about 200 bytes of text.

So I did a big cache priming:

  $ time git log -p >/dev/null
  real    39m29.748s
  user    23m1.090s
  sys     3m46.642s

Slow, and unsurprisingly spends quite a bit of time waiting on I/O. The
result is a notes tree with almost one textconv per blob:

  $ git ls-tree -r notes/textconv/mfo | wc -l
  10317

We're now using almost 200M:

  $ git count-objects
  39513 objects, 198604 kilobytes

But wait. Many of those objects are trees for stale versions of the
cache.

  $ git repack -d
  $ (cd .git/objects/pack && du -k *.pack)
  2056    pack-34170e72ec40a07e98aae044479abccc9e02751b.pack
  4089224 pack-81797628f3aebf6a0bdc082fa05ec14932910534.pack
  $ git count-objects
  30685 objects, 163288 kilobytes

In actuality, a fully packed cache is only about 2M (from 35M of
loose objects; it deltas quite well because there is a lot of overlap
in my metadata). And we can prune away the other 160M of cruft:

  $ git prune
  $ git count-objects
  0 objects, 0 kilobytes

And of course, the final speed result:

  $ time git log -p >/dev/null
  real    0m7.606s
  user    0m6.084s
  sys     0m0.788s

So what I take away from this is two things:

  1. The size tradeoff is definitely worthwhile for some workloads. In
     this case, the textconv version is orders of magnitude smaller than
     the original. I'd be interested to see numbers for something like a
     repository of documents that get textconv'd to pure ascii.

  2. We had 460% loose object overhead just from tree objects in
     intermediate versions of the cache. While it was not too hard to
     get rid of with a repack and a prune, we are probably better off
     not generating it in the first place. In theory we could have
     written only one notes tree, and kept the intermediate state in
     memory. In practice, flushing once per commit-diff (instead of once
     per file) would probably be fine, and would be simpler to
     implement.

And of course, now that I have a completely primed cache, I can push it
around with "git push $dest notes/textconv/mfo". Yay for storing notes
as git objects.

-Peff
