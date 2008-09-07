From: Jeff King <peff@peff.net>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 7 Sep 2008 13:28:07 -0400
Message-ID: <20080907172807.GA25233@coredump.intra.peff.net>
References: <20080907103415.GA3139@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Sep 07 19:29:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcO4b-0002Yo-W2
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 19:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbYIGR2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 13:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754108AbYIGR2K
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 13:28:10 -0400
Received: from peff.net ([208.65.91.99]:2583 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029AbYIGR2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 13:28:09 -0400
Received: (qmail 12509 invoked by uid 111); 7 Sep 2008 17:28:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Sep 2008 13:28:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Sep 2008 13:28:07 -0400
Content-Disposition: inline
In-Reply-To: <20080907103415.GA3139@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95153>

On Sun, Sep 07, 2008 at 12:34:15PM +0200, Stephen R. van den Berg wrote:

> The questions now are:
> - Would there be good reason not to record the backport/forwardport
>   relationship in the additional parents of a commit?

Parents mean something different than just a link. If A is a parent of
B, then that implies that at point B, we considered all of the history
leading up to B (including A), and arrived at a certain tree state.

But cherry-picking means we looked at just A and used it to find a
certain tree-state. It says nothing about anything that came _before_ A.

So imagine this history:

A--B--C <-- master
 \
  D--E--F <-- side branch

Now let's say we want to cherry-pick E. If we mark the cherry-picked
commit as a parent, we get:

A--B--C--E' <-- master
 \      /
  D----E--F <-- side branch

Now let's say we want to merge the branches. What's our merge base?
Without your proposal, it is A, but now it is actually E. So doing a
three-way merge between E' and F with base E, it will look like our
master branch _removed_ the change from D which is still present in F.
And in a 3-way merge if one side removes something but the other side
leaves it untouched, then the result removes it.

So the merge result is bogus, as it is missing D.

I'm including a quick script below which creates this situation (it may
need tweaking to run on your system, but hopefully you get the point).

-Peff

-- >8 --
#!/bin/sh -ex

rm -rf repo

change() {
  perl -pi -e '/^'$1'$/ and $_ .= "changed $_"' words &&
  git commit -a -m $1 &&
  git tag $1
}

mkdir repo && cd repo && git init
cp /usr/share/dict/words . && git add words && git commit -m initial
change A
change B
change C
git checkout -b other A
change D
change E
change F
git checkout master
git cherry-pick -n E
tree=`git write-tree`
commit=`echo cherry pick | git commit-tree $tree -p HEAD^ -p E`
git update-ref HEAD $commit
