From: Jeff King <peff@peff.net>
Subject: Re: Re-Transmission of blobs?
Date: Mon, 16 Sep 2013 17:55:36 -0400
Message-ID: <20130916215536.GB5477@sigill.intra.peff.net>
References: <20130910130837.GA14259@raven.wolf.lan>
 <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
 <20130911112758.GB14259@raven.wolf.lan>
 <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
 <20130912074241.GC14259@raven.wolf.lan>
 <20130912092339.GA30702@sigill.intra.peff.net>
 <20130912103531.GD14259@raven.wolf.lan>
 <20130912194453.GD32069@sigill.intra.peff.net>
 <20130913100934.GE14259@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 16 23:55:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLgln-0007rE-CE
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 23:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352Ab3IPVzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 17:55:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:38867 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab3IPVzm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 17:55:42 -0400
Received: (qmail 22763 invoked by uid 102); 16 Sep 2013 21:55:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Sep 2013 16:55:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Sep 2013 17:55:36 -0400
Content-Disposition: inline
In-Reply-To: <20130913100934.GE14259@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234846>

On Fri, Sep 13, 2013 at 12:09:35PM +0200, Josef Wolf wrote:

> > > I'm not sure I understand correctly. I see that bitmaps can be used to
> > > implement set operations. But how comes that walking the graph requires a lot
> > > of CPU? Isn't it O(n)?
> > 
> > Yes and no. Your "n" there is the entirety of history.
> 
> Is this really true?

Yes. If you know that the receiver has commit X, and you want to know if
it has some blob Y, the only way to know for sure is to look at every
tree of every commit reachable from X, and see whether any of them
references Y. You might get lucky and see that one of the first commits
you looked at mentions Y, but in the negative case, you have to go all
the way down to the roots.

> > (and each one needs to be pulled off of the disk,
> > decompressed, and reconstructed from deltas).
> 
> While you need to unpack commits/trees to traverse further down, I can't see
> any reason to unpack/reconstruct blobs just to see whether you need to send
> it. The SHA is all you need to know, isn't it?

Correct. The full sentence that you partially quoted above was:

   So even though you are looking at each commit and tree only once,
   it's still a large number of them (and each one needs to be pulled
   off of the disk, decompressed, and reconstructed from deltas).

I.e., the "each one" is "commits and trees".  Even reading just them
takes a fair bit of time. Pulling each blob off of disk, too, takes even
longer. You can try it yourself like this:

  git rev-list --objects --all |
    cut -d' ' -f1 |
    git cat-file --batch-check >all-objects
  for i in commit tree blob; do
    grep $i all-objects | cut -d' ' -f1 >$i-objects
    echo >&2 "==> $i"
    time git cat-file --batch <$i-objects >/dev/null
  done

For git.git, commits take about 0.5 seconds on my machine, trees 1
second, and blobs 13 seconds. For the kernel, it's 5, 22, and 210
seconds, respectively.

Now those are times to actually cat the content to /dev/null. Just
looking at it internally is cheaper, but it gives you a ballpark figure
(and most of that time goes to zlib inflation, which is the same either
way).

> > Secondly, the graph traversal ends up seeing the same sha1s over and
> > over again in tree entries (because most entries in the tree don't
> > change from commit to commit).
> 
> Whenever you see an object (whether commit or tree) that you already have
> seen, you can stop traversing further down this part of the graph/tree, as
> everything you will see on this part has already be seen before.
> 
> Why would you see the same commits/trees over and over again? You'd stop
> traversing on the boundary of the already-seen-territory, leaving the vast
> majority of the "duplicated" structure under the carpet. Somehow I fail to see
> the problem here.

Yes, you do not have to recurse into sub-trees (or commits) you have
already seen. And we already do that optimization.  So you do not see
the whole recursive tree over and over, but you see "almost same"
single-level trees repeatedly.

Let me try to give an example.  Here's the root tree of git.git's v1.8.4
release:

  $ git ls-tree v1.8.4 | wc -l
  361

So we have to do 361 lookups, one per entry, to find that we haven't
yet processed each one.

Now what happens when we look at the next commit?

  $ git ls-tree v1.8.4^ | wc -l
  361
  $ git diff-tree --abbrev v1.8.4 v1.8.4^
  :040000 040000 f3aec4c... a6e780e... M  Documentation
  :100755 100755 06026ea... 572dfeb... M  GIT-VERSION-GEN

Still 361 entries, but only two are changed. Yet we still have
to go through all 361 to figure out _which_ were changed.

We can do that by going linearly through the tree and checking each sha1
against a "have we seen this?" data structure. Or we could diff
on-the-fly between adjacent trees, and only process those that we know
we didn't just see.

The current code uses the "seen this" strategy with a hash table. I've
tried the diff strategy, but I couldn't make it any faster than using
the hash table. If we had a tree storage format that made diffs cheap
(like packv4), then traversing via diffs would probably be a win.

Note also that the cost of traversing is dependent on the shape of the
tree. Putting all of your files in the root directory does not perform
as well as having a nicely balanced tree structure, because we can't
weed out as many entries by noticing the whole sub-tree is unchanged.

-Peff
