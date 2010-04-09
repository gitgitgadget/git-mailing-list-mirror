From: Jeff King <peff@peff.net>
Subject: Re: git pull suggestion
Date: Thu, 8 Apr 2010 23:49:11 -0400
Message-ID: <20100409034911.GA4020@coredump.intra.peff.net>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com>
 <201004081754.24954.trast@student.ethz.ch>
 <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com>
 <20100408231154.GB13704@vidovic>
 <v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 05:49:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O05E3-00067N-Fd
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 05:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab0DIDte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 23:49:34 -0400
Received: from peff.net ([208.65.91.99]:40852 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342Ab0DIDtd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 23:49:33 -0400
Received: (qmail 29820 invoked by uid 107); 9 Apr 2010 03:49:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 23:49:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 23:49:11 -0400
Content-Disposition: inline
In-Reply-To: <v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144393>

On Thu, Apr 08, 2010 at 11:06:42PM -0400, Aghiles wrote:

> Kind of ! 'git status' will effectively tell you what files are
> modified but not in the index. The problem is that there is no way to
> know what files are in potential conflict with what is coming from
> 'git pull'. So basically, you can have as many dirty files as you want
> in your working directory as long as they are not conflicting with
> what's coming.
> If dirty files are in conflict, then 'git pull' will complain, but
> slowly ... :)

I think I get what you are talking about now. Consider the following
example script, and let me know if it illustrates your problem:

  # define some handy functions
  content() {
    echo 1 $1 >file1
    echo 2 $1 >file2
  }
  commit() {
    git add file1 file2
    git commit -m "$1"
  }

  # make a new repo
  mkdir repo && cd repo && git init

  # make two diverged branches
  content one; commit one
  git checkout -b other
  content two; commit two
  git checkout master
  content three; commit three

  # now give us dirty working tree state on both files
  content four

  # and try to merge
  git merge other

I get:

  $ git merge other
  error: Your local changes to 'file1' would be overwritten by merge. Aborting.
  Please, commit your changes or stash them before you can merge.

But that's not the whole story. Once you fix that, you will see that
your local changes to 'file2' would be overwritten by the merge:

  $ git commit -m "commit file1" file1
  $ git merge other
  error: Your local changes to 'file2' would be overwritten by merge. Aborting.
  Please, commit your changes or stash them before you can merge.

And so on.

Notice that I didn't use "pull", but pull should invoke git-merge after
fetching from the remote. I assume this is the same message you are
talking about?

I agree it would be nicer if, on the error case, we kept going through
the index to find all of the other error cases, and printed them all.
The code for that is a bit tricky, though, as the unpack-trees merging
code which produces that message is a callback, and only sees one cache
entry at a time.

It is possible to manually get the answer you want, or close to it. You
are looking for the intersection of files modified by you and files
modified by the upstream. So:

  # unique list of modified working tree files and index entries
  $ (git diff-files --name-only;
     git diff-index --name-only HEAD
    ) | sort -u >us
  # files that will be changing as part of merge
  $ git diff-tree --name-only $HEAD_TO_MERGE_FROM | sort >them
  $ comm -12 us them

where $HEAD_TO_MERGE_FROM in my example would be "other", but in the
case of a pull, would probably be FETCH_HEAD.

It isn't 100% accurate, as there are some special cases that the merging
code handles (e.g., I think if the remote changed a file and we have the
same uncommitted change in our working tree, we may still allow that.
There are probably others, too). But it should give a general idea of
what is in conflict.

In practice, I have never actually wanted to this. The workflow goes
something like:

  (1) Run git merge foo (or git pull)

  (2) Oops, I have cruft in my working tree. What was it? Run git
      status.

  (3a) Oh, that cruft should have been committed. Make a commit (or
       commits). Go to (1), possibly still with some changes in
       the working tree.

       or

  (3b) Oh, that cruft is some change I want to carry forward in the
       working directory. Run git stash, repeat the pull, fix any
       merge conflicts, and then git stash apply.

So it doesn't really matter to me if there is 1 conflicting file or 100.
In most cases, the commits in (3a) will clean up all of it in one go.
Otherwise, I'll just stash it all and come back to it.

-Peff
