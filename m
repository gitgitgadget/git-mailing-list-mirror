From: Jeff King <peff@peff.net>
Subject: Re: gitk "find commit adding/removing string"/possible pickaxe bug?
Date: Tue, 18 Jan 2011 13:50:28 -0500
Message-ID: <20110118185027.GA10562@sigill.intra.peff.net>
References: <514EB3AA-CD31-4BDB-B777-B7AAEEDF5663@sebastianhahn.net>
 <201101181744.18139.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sebastian Hahn <mail@sebastianhahn.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 18 19:50:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfGdc-0001d9-Ds
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 19:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab1ARSuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 13:50:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54674 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab1ARSue (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 13:50:34 -0500
Received: (qmail 31190 invoked by uid 111); 18 Jan 2011 18:50:32 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 18 Jan 2011 18:50:32 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jan 2011 13:50:28 -0500
Content-Disposition: inline
In-Reply-To: <201101181744.18139.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165211>

On Tue, Jan 18, 2011 at 05:44:17PM +0100, Thomas Rast wrote:

> In particular, in a history where
> 
>   $ git show HEAD:foo
>   quux
>   $ git show HEAD^:foo
>   bar
>   $ git show HEAD^2:foo
>   baz

I created a similar repo with:

commit() {
  echo $1 >file && git add file && git commit -m $1
}
mkdir repo && cd repo && git init
commit base
commit master
git checkout -b other HEAD^
commit other
git merge master
commit resolved

which should be identical. But I get different results (see near the
end):

> the behaviour is:
> 
>   git log -Squux                  # empty
>   git log -Squux -p               # empty

All of which make sense to me. Pickaxe operates on diff filepairs, and
git by default doesn't seem to do merge diffing at all (but see below).
So those filepairs don't exist to consider.

>   git log -Squux --pickaxe-all    # empty

This doesn't help. It just loosens the actual diff shown from "just the
things that matched -S" to "everything in that commit". It doesn't
add to the filepairs that make it to pickaxe.

>   git log -Squux -c      	  # shows merge, but no diff

This "-c" does what you want, because we start looking at merge
filepairs. Although one thing leaves me confused. If I do:

  git log -p

I get no diff for the merge commit. But in git-diff(1), it says:

  COMBINED DIFF FORMAT
    "git-diff-tree", "git-diff-files" and "git-diff" can take -c or --cc
    option to produce combined diff. For showing a merge commit with
    "git log -p", this is the default format; you can force showing full
    diff with the -m option.

which implies to me that "-c" should be on by default if we selected
"-p" (or presumably -S).

I didn't bisect, but I wonder if the doc is wrong, or if we accidentally
lost this default at some point.

>   git log -Squux --cc    	  # shows merge, but no diff

Makes sense again, since you didn't ask for a patch, no patch.

>   git log -Squux -c -p   	  # shows merge, but no diff

Weird.  Here I get a nice combined diff, which is what I expect.

>   git log -Squux -c --pickaxe-all # shows merge, but no diff

Yep, no "-p" again.

>   git log -Squux --pickaxe-all -c -p  # shows merge & combined diff

The pickaxe-all shouldn't impact anything, at least not in my test repo,
as there is only one file. But of course I do get the diff, as I did
above. Can you show the steps to create your repo? I'm wondering what is
different.

-Peff
