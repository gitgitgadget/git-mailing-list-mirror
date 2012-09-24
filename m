From: Jeff King <peff@peff.net>
Subject: Re: git pull transfers useless files
Date: Mon, 24 Sep 2012 15:17:31 -0400
Message-ID: <20120924191731.GB15858@sigill.intra.peff.net>
References: <CAB9Jk9BcusbERNW0ZTsuq6xd7onOuggfTxJnf7D_USNv-uhC1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 21:17:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGEA5-0000Ir-VG
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 21:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757861Ab2IXTRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 15:17:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57206 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757844Ab2IXTRg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 15:17:36 -0400
Received: (qmail 2899 invoked by uid 107); 24 Sep 2012 19:18:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 15:18:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 15:17:31 -0400
Content-Disposition: inline
In-Reply-To: <CAB9Jk9BcusbERNW0ZTsuq6xd7onOuggfTxJnf7D_USNv-uhC1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206315>

On Mon, Sep 24, 2012 at 07:51:20PM +0200, Angelo Borsotti wrote:

> #!/bin/bash
> 
> set -v
> cd remote
> rm -rf * .git/
> git init
> echo '*.pdf -crlf -diff merge=binary' >.git/info/attributes
> 
> touch f1
> git add f1
> echo "aaa" >f1.pdf
> git add f1.pdf
> cp <very large pdf file, some 100 Mbytes>.pdf f2.pdf
> git add f2.pdf
> git commit -m A
> cd ..
> 
> cd local
> rm -rf * .git/
> git init
> echo '*.pdf -crlf -diff merge=binary' >.git/info/attributes
> git remote add remote ../remote
> 
> touch f3
> git add f3
> git commit -m B
> git checkout -b develop
> 
> echo "bbb" >f2.pdf
> git add f2.pdf
> git commit -m C
> git pull -v --squash remote master
> 
> ls
> cat <f2.pdf
> 
> set +v
> 
> Replace <very large pdf file, some 100 Mbytes>.pdf with the path of a pdf file
> that is really large and run it.
> When it executes the git pull it spends on my computer some 30 seconds,
> obviously transferring the pdf file, that then it disregards because of the
> merge=binary attribute.

It does not disregard the file. The working tree is left with your
existing version of f2, but note that the index still marks the
conflict. Your next step would be to resolve the conflict in some way.
Towards that end, you can now inspect both sides:

  git show :2:f2.pdf  ;# our side
  git show :3:f2.pdf  ;# their side

Or you can invoke a mergetool to start a third-party merge helper on the
binary files:

  git mergetool

Or you can just resolve in favor of "their" side:

  git checkout --theirs f2.pdf

>From your description, I imagine your intent is to simply resolve in
favor of the "ours", and never look at the other side. However, git does
not have enough information to know that.

There is no "merge=ours" attribute (and indeed, it would be kind of
crazy, since your result would depend on which direction you were
merging, which is something you only know at the time of merge. Hence it
makes sense as a command-line option for a strategy, but not something
that is an attribute as a file).

All that being said, we can construct a case where the contents of the
PDF really _don't_ matter at all to the result. Like this:

  # new repo
  git init parent
  cd parent

  # make a commit with a giant file
  echo small >foo.txt
  cp <your-giant-file>.pdf big.pdf
  git add .
  git commit -m one

  # now get rid of the giant file
  git rm big.pdf
  git commit -m two

  # now merge it into another history
  git init ../child
  cd ../child
  echo unrelated >file.txt
  git add .
  git commit -m three
  git pull -v --squash ../parent master

Because we are doing a squash merge, we will throw away most of the
history we fetch, and only ever look at the tip of parent/master (which
in this case does not contain the PDF), and the shared ancestor (which
in this case is empty, since there is no shared history).

So in theory we could get by with fetching all the commits (to do the
history traversal), and the trees and blobs only from the tip commit.
But that is not a good idea in general for two reasons:

  1. Even if that PDF is not used in the actual merge algorithm, the
     contents of the earlier commits are useful for figuring out what
     happened (e.g., when resolving another conflict, you might want to
     refer back via "git log").

  2. It breaks git's reachability assumptions. Git always makes sure
     that if you have object X, you have all of the objects it refers
     to, the ones they refer to, and so on. This assumption underlies
     many of git's operations (e.g., what we need to send to a remote
     who claims to have commit X).

     In this case, since you are using --squash, you could presumably
     throw away the original history after doing the squash merge. But
     it would be quite complex to special-case this in the protocol, and
     almost certainly not worth it for this corner case.

-Peff
