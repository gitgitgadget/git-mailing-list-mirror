From: Jeff King <peff@peff.net>
Subject: Re: Questions about git-push for huge repositories
Date: Tue, 8 Sep 2015 01:44:33 -0400
Message-ID: <20150908054432.GC26331@sigill.intra.peff.net>
References: <CAN6cQGPcGpaXUGu_7aaeJtMbruMocte-5po97vG5r39f=YdTZQ@mail.gmail.com>
 <xmqq4mj7bfsf.fsf@gitster.mtv.corp.google.com>
 <CAN6cQGMf089ERn2kZbFpHJ6vyJ4BnjCm-m-E+hQsduH55XFvKw@mail.gmail.com>
 <CAN6cQGNGP+n3L=tuRCymOTWFCnFNsq-tFHkaNm+W=o726mjmmw@mail.gmail.com>
 <CAN6cQGOO540FV9bTQPks+1nHS1xO10Rv8iNzAj8-cBihQ4_kEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Levin Du <zslevin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 07:44:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZBhw-0002O9-6X
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 07:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbbIHFoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 01:44:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:56112 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752778AbbIHFof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 01:44:35 -0400
Received: (qmail 14817 invoked by uid 102); 8 Sep 2015 05:44:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 00:44:35 -0500
Received: (qmail 19267 invoked by uid 107); 8 Sep 2015 05:44:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 01:44:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 01:44:33 -0400
Content-Disposition: inline
In-Reply-To: <CAN6cQGOO540FV9bTQPks+1nHS1xO10Rv8iNzAj8-cBihQ4_kEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277488>

On Tue, Sep 08, 2015 at 09:30:09AM +0800, Levin Du wrote:

> Take kernel source code for example:
> 
> # Clone the kernel to A and B
> $ git --version
> git version 2.3.2
> $ git clone --bare  ../kernel/ A
> $ git clone --bare  ../kernel/ B

OK, two repos with the same source.

> # Create the orphan commit and check
> $ cd A
> $ git branch test
> Switched to a new branch 'test'
> $ git replace --graft test
> $ git rev-parse test
> cbbae6741c60c9e09f87521e3a79810abd6a2fda
> $ git rev-parse test^{tree}
> 929bdce0b48ca6079ad281a9d8ba24de3e49881a
> $ git rev-parse replace/cbbae6741c60c9e09f87521e3a79810abd6a2fda
> 82d3e9ce1ca062c219f1209c5291ccd5603e5302
> $ git rev-parse 82d3e9ce1ca062c219f1209c5291ccd5603e5302^{tree}
> 929bdce0b48ca6079ad281a9d8ba24de3e49881a
> $ git log --pretty=oneline 82d3e9ce1ca062c219f1209c5291ccd5603e5302 | wc -l
> 1

So you've created a new commit object, 82d3e9ce1, which has the same
tree as the original branch, but no parents.

Note that fetch and push do not respect the "replace" mechanism. They
can't, because we have no idea if the other side of the connection
shares our "replace" view of the world. So if I use "replace" to say
that commit X has parent Y, I cannot assume that pushing to some _other_
repository with X means that they also have all of Y.

But it should be OK, of course, to push the new orphan commit. I.e., if
we are pushing the object itself, not caring that it is part of a
"replace" mechanism, that should be no different than pushing any other
commit.

> $ du -hs ../B
> 1.6G ../B
> $ git push ../B 'refs/replace/*'
> Counting objects: 51216, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (48963/48963), done.
> Writing objects: 100% (51216/51216), 139.61 MiB | 17.88 MiB/s, done.
> Total 51216 (delta 3647), reused 34580 (delta 1641)
> To ../B
> * [new branch]
> refs/replace/cbbae6741c60c9e09f87521e3a79810abd6a2fda ->
> refs/replace/cbbae6741c60c9e09f87521e3a79810abd6a2fda
> $ du -hs ../B
> 1.7G ../B
> 
> It takes some time for 'git push' to compress the objects and B has
> finally increased 0.1G,
> which is for the newly commit whose tree is already in the repository.

Right, this is due to the commit-walking that Junio explained earlier.
We walk the commits only, and then expand the positive side (things the
other side wants) into trees and blobs. Even though we know about a
commit that the other side has that points to the tree, we don't make
the connection.

You can get a more thorough answer by expanding and marking all trees
and blobs, taking the set difference between all of the objects you want
to send, and all of the objects you know the other side has. I.e.,
basically:

  # what we want to send
  git rev-list --objects 82d3e9ce1ca062c219f1209c5291ccd5603e5302 | sort >want

  # what we know the other side has; turn off replacements, since we
  # want the real value, not with our fake replace overlaid
  git --no-replace-objects rev-list --objects refs/heads/master | sort >have

  # set difference
  comm -23 want have

which should consist of only the one commit. But if you actually ran
that, you may notice that the second rev-list takes a long time to run.
In your exact case, one can get lucky by progressively drilling down
into commits and their trees (since the tip commit of "master" happens
to share the identical tree with our new fake commit). But that is
rather an uncommon example, and in more normal cases of fetching from
somebody, building on top, and then pushing back up, it is much more
expensive. In those cases it is much more efficient to walk the small
number of new commits and then expand only their newly-added objects.

If you turn on reachability bitmaps, git _will_ do the thorough set
difference, because it becomes much cheaper to do so. E.g., try:

    git repack -adb

in repo A to build a single pack with bitmaps enabled. Then a subsequent
push should send only a single object (the new commit).

Of course the time spent building the bitmaps is larger than a single
push, so this is not a good strategy if you are just trying to send one
tree.

-Peff
