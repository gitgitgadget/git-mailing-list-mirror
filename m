From: Jeff King <peff@peff.net>
Subject: Re: git status / git diff -C not detecting file copy
Date: Tue, 2 Dec 2014 01:55:50 -0500
Message-ID: <20141202065550.GB1948@peff.net>
References: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
 <CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
 <CAJxwDJzxUEd3czHpwDtKaERKDhvyCGOzGbKO4X9z44ugTJ2q4w@mail.gmail.com>
 <CAGyf7-F9twCEUY-LN=xEf4=gfNW8oLEHJmTjHRQ2MncHZ2emZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pol Online <info@pol-online.net>, Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 07:55:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvhNL-0003Dx-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 07:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbaLBGzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 01:55:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:46988 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752342AbaLBGzt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 01:55:49 -0500
Received: (qmail 25663 invoked by uid 102); 2 Dec 2014 06:55:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 00:55:49 -0600
Received: (qmail 13384 invoked by uid 107); 2 Dec 2014 06:55:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 01:55:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 01:55:50 -0500
Content-Disposition: inline
In-Reply-To: <CAGyf7-F9twCEUY-LN=xEf4=gfNW8oLEHJmTjHRQ2MncHZ2emZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260542>

On Sun, Nov 30, 2014 at 12:54:53PM +1100, Bryan Turner wrote:

> I'll let someone a little more intimately familiar with the internals
> of git status comment on why the documentation for that mentions
> copies.

I don't think there is a good reason. git-status has used renames since
mid-2005. The documentation mentioning copies was added much later,
along with the short and porcelain formats. That code handles whatever
the diff engine throws at it.  I don't think anybody considered at that
time the fact that you cannot actually provoke status to look for
copies.

Interestingly, the rename behavior dates all the way back to:

  commit 753fd78458b6d7d0e65ce0ebe7b62e1bc55f3992
  Author: Linus Torvalds <torvalds@ppc970.osdl.org>
  Date:   Fri Jun 17 15:34:19 2005 -0700

  Use "-M" instead of "-C" for "git diff" and "git status"
  
  The "C" in "-C" may stand for "Cool", but it's also pretty slow, since
  right now it leaves all unmodified files to be tested even if there are
  no new files at all.  That just ends up being unacceptably slow for big
  projects, especially if it's not all in the cache.

I suspect that the copy code may be much faster these days (it sounds
like we did not even have the find-copies-harder distinction then, and
these days we certainly take the quick return if there are no copy
destination candidates).

To get a rough sense of how much effort is entailed in the various
options, here are "git log --raw" timings for git.git (all timings are
warm cache, best-of-five, wall clock time):

  log --raw:       0m2.311s
  log --raw -M:    0m2.362s
  log --raw -C:    0m2.576s
  log --raw -C -C: 1m4.462s

You can see that rename detection adds a little, and copy detections
adds a little more.  That makes sense; it's rare for new files to appear
at the same that old files are going away (renames), so most of the time
it does nothing. Copies introduce a bit more work; we have to compare
against any changed files, and there are typically several in each
commit. find-copies-harder is...well, very expensive.

These timings are of diffs between commits and their parents, of course.
But if we assume that "git status" will show diffs roughly similar to
what gets committed, then this should be comparable. There are about 30K
non-merge commits we traversed there, so adding 200ms is an average of
not very much per commit. Of course the cost is disproportionately borne
by diffs which have an actual file come into being. There are ~2000
commits that introduce a file, so it's probably accurate to say that it
either adds nothing in most cases, or ~1/10th of a millisecond in
others.

Note this is also doing inexact detection, which involves actually
looking at the contents of candidate blobs (whereas exact detection can
be done by comparing sha1s, which is very fast). If you set
diff.renamelimit to "1", then we do only exact detections. Here are
timings there:

  log --raw:       0m02.311s    (for reference)
  log --raw -M:    0m02.337s
  log --raw -C:    0m02.347s
  log --raw -C -C: 0m24.419s

That speeds things up a fair bit, even for "-C" (we don't have to access
the blobs anymore, so I suspect the time is going to just accessing all
of the trees; normally diff does not descend into subtrees that have the
same sha1). Of course, you probably wouldn't want to turn off inexact
renames completely. I suspect what you'd want is a --find-copies-moderately
where we look for cheap copies using "-C", and then follow up with "-C
-C" only using exact renames.

So from these timings, I'd conclude that:

  1. It's probably fine to turn on copies for "git status".

  2. It's probably even OK to use "-C -C" for some projects. Even though
     22s looks scary there, that's only 11ms for git.git (remember,
     spread across 2000 commits). For linux.git, it's much, much worse.
     I killed my "-C -C" run after 10 minutes, and it had only gone
     through 1/20th of the commits. Extrapolating, you're looking at
     500ms or so added to a "git status" run.

     So you'd almost certainly want this to be configurable.

Does either of you want to try your hand at a patch? Just enabling
copies should be a one-liner. Making it configurable is more involved,
but should also be pretty straightforward.

-Peff
