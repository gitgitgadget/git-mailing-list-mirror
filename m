From: Jeff King <peff@peff.net>
Subject: Re: Using Filemerge.app as a git-diff viewer
Date: Wed, 21 Nov 2007 09:36:58 -0500
Message-ID: <20071121143658.GA24108@sigill.intra.peff.net>
References: <47440912.8010800@cam.ac.uk> <20071121112757.GA17231@sigill.intra.peff.net> <47442E57.8010004@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>
To: Toby White <tow21@cam.ac.uk>
X-From: git-owner@vger.kernel.org Wed Nov 21 15:37:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuqhc-0008Q5-Rz
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 15:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbXKUOhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 09:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754404AbXKUOhD
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 09:37:03 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2797 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbXKUOhB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 09:37:01 -0500
Received: (qmail 7983 invoked by uid 111); 21 Nov 2007 14:36:59 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 Nov 2007 09:36:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2007 09:36:58 -0500
Content-Disposition: inline
In-Reply-To: <47442E57.8010004@cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65655>

On Wed, Nov 21, 2007 at 01:10:47PM +0000, Toby White wrote:

> And in any case, that launches Filemerge repeatedly
> on every file separately, which makes reviewing a large diff
> time-consuming and not very helpful.

I think that particular complaint of GIT_EXTERNAL_DIFF has come up
before. It probably wouldn't be too hard to support a separate
environment variable to mean "diff these two trees" (or tree/cache, or
cache/working tree, etc) rather than "diff these two files".

> Am I misunderstanding the documentation? From man git-write-tree
>
> "Conceptually, git-write-tree sync()s the current index contents into a
>  set of tree files. In order to have that match what is actually in your
>  directory right now, you need to have done a git-update-index phase
>  before you did the git-write-tree."
>
> So git-write-tree precisely does give you the index not the working tree,
> by my reading.

What you are doing isn't _wrong_, but it is not the most efficient way
of doing it, and it is a little bit awkward, I think.

There are basically three conceptual "spots" for files in git:

  - in the object database (i.e., tree objects pointing to blobs)
  - in the index (the blobs are actually in the object db)
  - in the working tree (i.e., actual files)

git-write-tree moves data from the index into the object database
(git-commit is more or less git-write-tree followed by git-commit-tree).
git-archive (piped to tar) moves data from the object database (because
it takes a tree object name) into the working tree.

So you are basically moving data into the object db, and then out to the
working tree. But there is a command that moves data directly from the
index to the working tree: git-checkout-index.

Now, what you are doing is not terribly inefficient in that sense, since
creating a tree object is usually pretty inexpensive. But it does
involve writing to the object db for a diff, which is conceptually a
read-only operation.

However, git-checkout-index also avoids piping through tar, which is
likely to be faster for a large data set.

> Erm, ok, this is rapidly approaching the limit of my git knowledge,

BTW, I don't mean to nitpick your script, which obviously works for you.
I'm just trying to increase your git knowledge. :)

> but while I can see git-read-tree will write a tree-ish into a temp
> index,
>
> (so presumably
> git-read-tree --index-output=$TMPFILE <commit>
> ought to work. Except it doesn't, I get the error message
> fatal: unable to write new index file
> ),

Are you perhaps running against the rename(2)-ability boundaries
mentioned in the man page? --index-output is relatively new, and I'm not
sure of the reasons surrounding it. I think what you really want to work
with a temp index is to set GIT_INDEX_FILE.

> I can't see how to make git-checkout-index read from a temp index.

It should read from GIT_INDEX_FILE. So the correct incantation for
checking out a tree should be:

GIT_INDEX_FILE=$TMPFILE git-read-tree <commit>
GIT_INDEX_FILE=$TMPFILE git-checkout-index -a --prefix=$TMPDIR/

and of course, for the --cached case, you can just use the existing
index:

git-checkout-index -a --prefix=$TMPDIR/

(btw, I have no idea if creating a temp index is actually faster than
piping through tar. I suspect it is, but haven't tested. So it may be
sane to use checkout-index for the --cached case, which is what I was
originally suggesting, and simply use git-archive for the tree case).

> And I'm assuming I don't want to go stomping all over the current
> index just in order to do a diff, which shouldn't change the state
> of my repository.

Correct.

> Is there a canonical way to checkout a given commit object into
> a fresh directory?

git-archive piped to tar is the canonical porcelain way (again, I was
suggesting checkout-index mainly for the --cached case). The way I
showed above is the "plumbing" way (and is what underlies git-checkout,
for example, though of course a temp index is not needed in that case).

Hope that make sense.

-Peff
