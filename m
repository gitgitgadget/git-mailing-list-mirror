From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Fri, 17 Feb 2012 15:37:55 -0500
Message-ID: <20120217203755.GA30114@sigill.intra.peff.net>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
 <CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
 <8762f9k5sg.fsf@thomas.inf.ethz.ch>
 <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
 <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 21:38:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyUZ9-0005D8-91
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 21:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab2BQUh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 15:37:58 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41182
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322Ab2BQUh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 15:37:57 -0500
Received: (qmail 12188 invoked by uid 107); 17 Feb 2012 20:37:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Feb 2012 15:37:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2012 15:37:55 -0500
Content-Disposition: inline
In-Reply-To: <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190979>

On Fri, Feb 17, 2012 at 06:19:06PM +0100, Piotr Krukowiecki wrote:

> "git update-index --refresh" with dropped cache took
> real	0m3.726s
> user	0m0.024s
> sys	0m0.404s
> [...]
> The diff-index after dropping cache takes
> real	0m14.095s
> user	0m0.268s
> sys	0m0.564s

OK, that suggests to me that the real culprit is the I/O we spend in
accessing the object db, since that is the main I/O that happens in the
second command but not the first.

> > Mostly reading (we keep a sorted index and access the packfiles via
> > mmap, so we only touch the pages we need). But you're also paying to
> > lstat() the directory tree, too. And you're paying to load (probably)
> > the whole index into memory, although it's relatively compact compared
> > to the actual file data.
> 
> If the index is the objects/pack/*.idx files than it's 21MB

Yes, that's it. Though we don't necessarily read the whole thing. The
sorted list of sha1s is only a part of that. And we mmap and
binary-search that, so we only have to fault in pages that are actually
used in our binary search.

However, we're faulting in random pages of the index in series, so it
may actually have a lot of latency. You can see how expensive the I/O on
the index is with something like this:

  [whole operation, for reference]
  $ sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'
  $ time git diff-index HEAD
  real    0m2.636s
  user    0m0.248s
  sys     0m0.392s

  [prime the cache with just the index]
  $ sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'
  $ time cat .git/objects/pack/*.idx >/dev/null
  real    0m0.288s
  user    0m0.000s
  sys     0m0.028s
  $ time git diff-index HEAD
  real    0m2.175s
  user    0m0.272s
  sys     0m0.320s

So roughly 20% of the I/O time in my case went to faulting in the index.
You could pre-fault in the index, which would give the OS a chance to do
read-ahead caching. You can see that the combined cat and diff-index
times are still lower than the raw diff-index time. You could also do
them in parallel, but that will create some additional seeks as the
threads fight for the disk, but may be a win in the long run because we
can read bigger chunks. You can roughly simulate it by running the "cat"
and the "diff-index" above in parallel.  I get:

  real    0m2.464s
  user    0m0.284s
  sys     0m0.372s

which is almost exactly the same as doing them separately (though note
that this is on an SSD, so seeking is very cheap).

But the bulk of the time still goes to actually retrieving the object
data, so that's probably a more interesting area to focus, anyway (and
if we can reduce object accesses, we reduce their lookup, too :) ).

> If I understand correctly, you only need to compute sha1 on the
> workdir files and compare it with sha1 files recorded in index/gitdir.
> It seems that to get the sha1 from index/gitdir I need to read the
> packfiles? Maybe it'd be possible to cache/index it somehow, for
> example in separate and smaller file?

There are two diffs going on in "git status". One is a comparison
between index and worktree. In that one, you need to lstat each file to
make sure the cached sha1 we have in the index is up to date. Assuming
it is, you don't need to touch the file data at all. Then you compare
that sha1 to the stage 0 sha1 (i.e., what we typically think of as
"staged for commit"). If they match, you don't need to do more work.

But the expensive diff-index we've been doing above is comparing the
index to the HEAD tree. And doing that is a little trickier. The index
is a flat list of files with their sha1s. But the HEAD tree is stored
hierarchically. So to get the sha1 of foo/bar/baz, we have to access the
root tree object, find the "foo" entry, access its tree object, find the
"bar" entry, access its tree object, and then find the "baz" entry. Then
we compare the sha1 of the "baz" entry to what's in the index.

So what's where your I/O comes from: accessing each of the tree objects.
And that fact that it isn't just "compare the HEAD and index sha1s" is
that the index is stored as a list of flat files.

That being said, we do have an index extension to store the tree sha1 of
whole directories (i.e., we populate it when we write a whole tree or
subtree into the index from the object db, and it becomes invalidated
when a file becomes modified). This optimization is used by things like
"git commit" to avoid having to recreate the same sub-trees over and
over when creating tree objects from the index. But we could also use it
here to avoid having to even read the sub-tree objects from the object
db.

> No, it's ext4 and the disk Seagate Barracuda 7200.12 500GB, as it
> reads on the cover :)
> 
> But IMO faster disk won't help with this - times will be smaller, but
> you'll still have to read the same data, so the subdir times will be
> just 2x faster than whole repo, won't it? So maybe in my case it will
> go down to e.g. 2s on subdir, but for someone with larger repository
> it will still be 10s...

Sure. But a certain amount of I/O is going to be unavoidable to get the
answer to your question. So you will never be able to achieve the
warm-cache case. I'm not saying we can't improve (e.g., I think the
index extension thing I mentioned above is a promising approach). But we
have to be realistic about what will make things faster; if I/O is your
problem, faster disk is one possible solution (especially because some
of this is related to seeking and latency, an SSD is a nice improvement
for cold-cache times).

-Peff
