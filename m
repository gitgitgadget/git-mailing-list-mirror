From: Jeff King <peff@peff.net>
Subject: Re: git status / git diff -C not detecting file copy
Date: Tue, 2 Dec 2014 15:09:11 -0500
Message-ID: <20141202200910.GB23461@peff.net>
References: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
 <CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
 <CAJxwDJzxUEd3czHpwDtKaERKDhvyCGOzGbKO4X9z44ugTJ2q4w@mail.gmail.com>
 <CAGyf7-F9twCEUY-LN=xEf4=gfNW8oLEHJmTjHRQ2MncHZ2emZQ@mail.gmail.com>
 <20141202065550.GB1948@peff.net>
 <xmqqvblukk98.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bryan Turner <bturner@atlassian.com>,
	Pol Online <info@pol-online.net>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 21:10:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvtlu-00074n-P9
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 21:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbaLBUJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 15:09:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:47366 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751396AbaLBUJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 15:09:10 -0500
Received: (qmail 27960 invoked by uid 102); 2 Dec 2014 20:09:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 14:09:10 -0600
Received: (qmail 18393 invoked by uid 107); 2 Dec 2014 20:09:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 15:09:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 15:09:11 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvblukk98.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260591>

On Tue, Dec 02, 2014 at 09:57:07AM -0800, Junio C Hamano wrote:

> > To get a rough sense of how much effort is entailed in the various
> > options, here are "git log --raw" timings for git.git (all timings are
> > warm cache, best-of-five, wall clock time):
> 
> The rationale of the change talks about "big projects" and your
> analysis and argument to advocate reversion of that change is based
> on "git.git"?  What is going on here?

I find that git.git is often a useful and easy thing to time to
extrapolate to other projects. It's 1/10th-1/20th the size of the kernel
(both in tree size and commit depth), which I do consider a "big
project" (and I have a feeling is what Linus was talking about).

Of course, performance numbers do not always scale linearly with repo
size. I didn't show the full numbers for the kernel, but they are:

  log --raw:       0m53.587s
  log --raw -M:    0m55.424s
  log --raw -C:    1m02.733s
  log --raw -C -C: <killed after 10 minutes>

There are ~20K commits that introduce files in the kernel (about 10x
what git.git had). So renames add well under a millisecond to each of
those diffs, and a single "-C" adds a third of a millisecond.

Which is pretty in-line with the git.git findings (it is not linear
here, but actually fairly constant. This makes sense, as it scales with
the size of the commit, not the size of the tree).

And as I noted, "-C -C" is rather expensive (I gave some estimated
timings earlier; you could probably come up with something more accurate
by doing smarter sampling).

> Also our history is fairly unusual in that we do not have a lot of
> renames (there was one large "s|builtin-|builtin/|" rename event,
> but that is about it), which may not be a good example to base such
> a design decision on.

I think the work scales not with the number of actual renames, but with
the number of commits where we even bother to look at renames at all
(i.e., ones with an 'A' diff-status). And my estimates assume that we
pay zero cost for other diffs, and attribute all of the extra time to
those diffs. So I think frequency of rename (or 'A') events does not
impact the estimate of the impact on a single "git status" run.

What does impact it is the _size_ of each commit. If you quite
frequently add a new file while touching tens of thousands of other
files, then the performance will be a lot more noticeable. And both
git.git and linux.git are probably better than some other projects about
having small commits.

Still, though. I stand by my earlier conclusions. Even with commits ten
times as large as the kernel's, you are talking about 3ms added to a
"status" run (and again, only when you hit such a gigantic commit _and_
it has an 'A' file).

> It is a fine idea to make this configurable ("status.renames = -C"
> or something, perhaps?), though.

I think it would be OK to move to "-C" as a default, but I agree it is
nicer if it is configurable, as it gives a safety hatch for people in
pathological repos to drop back to the old behavior (or even turn off
renames altogether).

-Peff
