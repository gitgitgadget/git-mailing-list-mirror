From: Jeff King <peff@peff.net>
Subject: Re: Graph sloc tool for git repos
Date: Sun, 13 Mar 2016 22:35:45 -0400
Message-ID: <20160314023545.GA19753@sigill.intra.peff.net>
References: <1457780426.2632189.547083938.25305E83@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Kai Hendry <hendry@iki.fi>
X-From: git-owner@vger.kernel.org Mon Mar 14 03:35:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afIMN-0004co-EA
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 03:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050AbcCNCfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 22:35:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:59058 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932561AbcCNCft (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2016 22:35:49 -0400
Received: (qmail 2207 invoked by uid 102); 14 Mar 2016 02:35:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 13 Mar 2016 22:35:48 -0400
Received: (qmail 18895 invoked by uid 107); 14 Mar 2016 02:36:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 13 Mar 2016 22:36:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Mar 2016 22:35:45 -0400
Content-Disposition: inline
In-Reply-To: <1457780426.2632189.547083938.25305E83@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288763>

On Sat, Mar 12, 2016 at 07:00:26PM +0800, Kai Hendry wrote:

> I penned a script to plot SLOC of a git project using GNUplot & I
> thought the fastest way to count code fluctuations was via `git show
> --numstat`.
> 
> However that requires some awk counting of the lines:
> https://github.com/kaihendry/graphsloc/blob/5f31e388e9b655e1801f13885f4311d221663a19/collect-stats.sh#L32
> 
> Is there a better way I missed? I think there is bug since my graph was
> a factor of 10 out whilst graphing Linux:
> https://twitter.com/kaihendry/status/706627679924174848

I think you'll always need to post-process the --numstat output to count
up lines. But that's fairly minor.

The bigger problem, I think is in how you handle merges. Imagine I have
two branches, each of which touch the same code:

  git init
  echo base >file
  git add file
  git commit -m base

  echo master >>file
  git commit -am master

  git checkout -b side HEAD^
  echo side >>file
  git commit -am side

and now I merge them, resolving the conflict favor of one side:

  git merge master
  { echo base; echo master; } >file
  git commit -am resolved

What does --numstat say?

  $ git log --cc --oneline --numstat
  989c6f7 resolved
  1       1       file
  b9bbaf9 side
  1       0       file
  087b294 master
  1       0       file
  09037ef base
  1       0       file

If we add these up, it looks like 3 lines were added. But the end result
has only 2 lines! We double-counted the additions on the two branches,
even though one stomped on the other. And then the merge resolution
looks neutral (one line gone, one line added), even though it was where
we did the stomping.

To be honest, I am not sure _what_ the "--cc --numstat" is showing
there (I added --cc because that is used by "git show", which is what
your script uses). The actual "--cc" (and "-c") patches show nothing,
which is right. It kind of looks like we are just showing the diffstat
against the first parent. I'm not sure anyone ever designed what a
"combined" diffstat would look like.

Let's redo our merge and resolve in favor of "side":

  git reset --hard HEAD^
  git merge master
  { echo base; echo side; } >file
  git commit -am resolved

Now the numstat is blank. I think it _is_ just showing the first-parent
diffstat. So that means each merge is introducing errors into your
count, and you'll drift away from accurate.

Another, related problem, is that you are adding up numbers along
multiple simultaneous branches. So going back to my output above, at the
point we read the "master" commit, we might say that the total
sloc-count is 2.  That's correct. And then we read "side", and say there
are 3 lines. But that's not right. It doesn't build on master, so we
still have only 2 lines. So even _if_ we merged them and the end result
had 3 lines (or if we somehow accounted for the double-counting when
examining the merge), you'd have inaccuracies through your dataset.

Another way of thinking about it is that your graph wants to represent a
single linear history, with the sloc-count changing as time moves to the
right. But that's not what really happened; at any given time, there are
_several_ sloc-counts, depending on which branch you're following.

But that can also give us a clue about one solution[1].  For your
purposes, you don't care about hitting every commit. You just want a
bunch of linear samples of the form [timestamp, sloc] to feed to
gnuplot. We can use "--first-parent" to walk _a_ linear history and see
a strict progression. And then use "-m" to tell git to just show merges
as the diff against that first parent (i.e., summarizing everything that
happened along the side-branch we are not following).

Like (this is back on the "we resolved as master" version of my example,
to illustrate how the merge is shown):

  $ git log --first-parent -m --numstat --oneline
  4244c8a resolved
  1       1       file
  b9bbaf9 side
  1       0       file
  09037ef base
  1       0       file

And that count is right. We had one line in our base, one on the
"side" commit, and then the merge didn't change our sloc-count at all
(we dropped the "side" line in favor of "master").

Finally, I'll note one other thing in my examples above. Note that I
used a single "git log" invocation, whereas your script reads "rev-list"
output to start a series of N "git show" invocations. I'll bet that took
quite a long time to run on the kernel. :)  Doing it all in one git-log
means you avoid the process startup overhead, and I'd expect it to run
~50 times as fast (at least that was what I saw from a quick experiment
on a much smaller repo).

-Peff

[1] The other solution I thought of was to actually count the SLOC of
    each tree at each commit, rather than worrying about diffs. You can
    make it efficient by caching the SLOC of blob and tree sha1s, so
    you don't count the same files over and over. That gives you
    accurate SLOC-counts at any given point in time, but doesn't address
    the multiple-branches thing (so you'd see your SLOC bounce up and
    down in time as you saw commits for various branches).
