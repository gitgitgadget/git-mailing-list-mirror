From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Wed, 20 Apr 2016 00:18:27 -0400
Message-ID: <20160420041827.GA7627@sigill.intra.peff.net>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
 <1461079290-6523-3-git-send-email-sbeller@google.com>
 <CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 06:18:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asjb1-0007in-3h
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 06:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbcDTESb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 00:18:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:52615 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753953AbcDTESb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 00:18:31 -0400
Received: (qmail 16108 invoked by uid 102); 20 Apr 2016 04:18:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 00:18:30 -0400
Received: (qmail 23426 invoked by uid 107); 20 Apr 2016 04:18:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 00:18:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2016 00:18:27 -0400
Content-Disposition: inline
In-Reply-To: <CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291979>

[your original probably didn't make it to the list because of its 5MB
 attachment; the list has a 100K limit; I'll try to quote liberally]

On Tue, Apr 19, 2016 at 04:17:50PM -0700, Jacob Keller wrote:

> I ran this version of the patch against the entire Linux kernel
> history, as I figured this has a large batch of C code to try and spot
> any issues.
> 
> I ran something like the following command in bash
> 
> $git rev-list HEAD | while read -r rev; do diff -F ^commit -u <(git
> show --format="commit %H" --no-compaction-heuristic $rev) <(git show
> --format="commit %H" --compaction-heuristic $rev); done >
> heuristic.patch

My earlier tests with the perl script were all done with "git log -p",
which will not show anything at all for merges (and my script wouldn't
know how to deal with combined diffs anyway). But I think this new patch
_will_ kick in for combined diffs (because it is built on individual
diffs). It will be interesting to see if this has any effect there, and
what it looks like.

We should be able to see it (on a small enough repository) with:

  git log --format='commit %H' --cc --merges

and comparing the before/after.

> I've attached the file that I generated for the Linux history, it's
> rather large so hopefully I can get some help to spot any differences.
> The above approach will work for pretty much any repository, and works
> better than trying to generate the entire thing first and then diff
> (since that runs out of memory pretty fast).

I don't think there is much point in generating a complete diff between
the patches for every commit, when nobody can look at the whole thing.
Unless we have automated tooling to find "interesting" bits (and
certainly a tool to remove the boring "a comment got shifted by one"
lines would help; those are all known improvements, but it's the _other_
stuff we want to look).

But if we are not using automated tooling to find the needle in the
haystack, we might as well using sampling to make the dataset more
manageable. Adding "--since=1.year.ago" is one way, though we may want
to sample more randomly across time.

> So far, I haven't spotted anything that would want me to disable it,
> while I've spotted several cases where I felt that readability was
> improved. It's somewhat difficult to spot though.

I did find one case that I think is worse. Look at 857942fd1a in the
kernel. It has a pattern like this:

  ... surrounding code ...

  function_one();
  ... more surrounding code ...

which becomes:

  ... surrounding code ...

  function_two();

  ... more surrounding code

Without the new heuristic, that looks like:

  -function_one();
  +function_two();
  +

but with it, it becomes:

  +
  +function_two();

  -function_one();

which is kind of weird. Having the two directly next to each other reads
better to me. This is a pretty unusual diff, though, in that it did
change the surrounding whitespace (and if you look further in the diff,
the identical change is made elsewhere _without_ touching the
whitespace). So this is kind of an anomaly. And IMHO the weirdness here
is outweighed by the vast number of improvements elsewhere.

-Peff
