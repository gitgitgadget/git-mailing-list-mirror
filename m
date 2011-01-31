From: Jeff King <peff@peff.net>
Subject: Re: gitk "find commit adding/removing string"/possible pickaxe bug?
Date: Mon, 31 Jan 2011 15:00:03 -0500
Message-ID: <20110131200002.GA7859@sigill.intra.peff.net>
References: <514EB3AA-CD31-4BDB-B777-B7AAEEDF5663@sebastianhahn.net>
 <201101181744.18139.trast@student.ethz.ch>
 <20110118185027.GA10562@sigill.intra.peff.net>
 <201101182139.28808.trast@student.ethz.ch>
 <20110118205040.GA20970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sebastian Hahn <mail@sebastianhahn.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 31 21:00:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjzv7-0003DD-BW
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 21:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab1AaUAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 15:00:10 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46757 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253Ab1AaUAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 15:00:09 -0500
Received: (qmail 12378 invoked by uid 111); 31 Jan 2011 20:00:07 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 Jan 2011 20:00:07 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Jan 2011 15:00:03 -0500
Content-Disposition: inline
In-Reply-To: <20110118205040.GA20970@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165743>

On Tue, Jan 18, 2011 at 03:50:40PM -0500, Jeff King wrote:

> > doesn't; it only gives a diff for the commit that introduced 'bar'.  I
> > guess this makes sense: -S notices that the number of 'bar's is
> > actually the same as in *one* merge parent, hence the merge cannot be
> > all that interesting.  OTOH it still shows the merge commit in the
> > history, which is a bit strange.  --pickaxe-all does not make a
> > difference either;
> 
> Hrm. What I expected[1] to happen would be for the diff machinery to
> look at each filepair individually, one of them to trigger -S, which
> shows the commit, and then to fail to produce a combined diff because we
> threw away the other uninteresting filepair. But in that case,
> --pickaxe-all _should_ show something, as its point is to keep all of
> the filepairs.  And that's clearly not happening.
> 
> So now I don't know what's going on. I'll try to trace through the diff
> machinery and see if that gives a clue.
> 
> -Peff
> 
> [1] That's what I expect, but not necessarily what I want. I think what
> I would want is for it to do a token count of the merge commit, and if
> it fails to match _every_ parent, then it it interesting. Otherwise, the
> content presumably came from that parent.

I looked into this, and sadly the "wanted" behavior I described above is
not easy to do. It turns out that we never actually see the whole 3-way
diff as a single unit in diffcore-pickaxe. Instead, log-tree calls into
diff_tree_combined, which diffs each parent _individually_, including
running diffcore magic on it. And then if one of those appears
interesting, we show the merge.

So diffcore-pickaxe never even knows that we are doing a combined diff.
It just sees the difference between M and M^, and then separately the
difference between M and M^2. This works OK in my example:

  commit() {
    echo $1 >file && git add file && git commit -m $1
  }
  commit base
  commit master
  git checkout -b other HEAD^
  commit other
  git merge master
  commit resolved

as doing "git log -Sother -c" will show both the commit "other" _and_
the merge commit (since it removed "other" in favor of "resolved"). But
you could also construct a case where it isn't true. For example,
consider a case where two sides add the same token, and the resolution
is to keep both. E.g.:

  echo base >file && git add file && git commit -m base
  echo foo bar >file && git commit -a -m master
  git checkout -b other HEAD^
  echo foo baz >file && git commit -a -m other
  git merge master
  (echo foo bar; echo foo baz) >file && git commit -a -m resolved

That shows the merge commit, even though it didn't actually introduce or
delete that token at all. OTOH, it is part of a conflict region, so it
is really difficult to say whether it is interesting or not. I dunno
what the right semantics are (and note that the definition I gave in the
above email would also trigger on this case).

I have the nagging feeling there is another less ambiguous corner case
that is wrong, but I'm having trouble constructing one.


Anyway, the real point is that we can't do anything special to pickaxe
merge commits at the diffcore level without some pretty major diff
surgery. So where does that leave us? You can still get pretty
reasonable results from turning on "-c". I was curious what the CPU cost
was of turning "-c" on by default, and was very surprised by the
results (in git.git):

  $ time git log -Sfoo >/dev/null
  real    0m11.532s
  user    0m11.273s
  sys     0m0.116s

  $ time git log -c -Sfoo >/dev/null
  real    3m7.530s
  user    3m3.991s
  sys     0m2.948s

A 1700% slowdown? Wow. There are ~20000 non-merge commits in git.git and
~4500 merge commits. Each merge commit has two parents (since we don't
tend to octopus merge), each of which is diffed individually. So I'd
expect it to add about 9000 diffs, or roughly 50% on top of the
11-second case.

My guess is that the subtree merges from gitk and git-gui are very
expensive to look at, since from one parent's perspective we will have
created the entire git project from scratch. On every merge. Yikes.

-Peff
