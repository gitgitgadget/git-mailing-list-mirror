From: Jeff King <peff@peff.net>
Subject: Re: git log with ordering option and --first-parent is unnecessarily
 slow
Date: Sat, 9 Apr 2016 01:01:16 -0400
Message-ID: <20160409050116.GB25151@sigill.intra.peff.net>
References: <CAKdicq8MnZMBV97K5O8Oa1T=PT9DsutmBS+P-bFYitATHH3s+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Josiah Boning <jboning@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 07:01:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aol1S-0007iz-Tn
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 07:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbcDIFBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 01:01:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:46782 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750988AbcDIFBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 01:01:20 -0400
Received: (qmail 25693 invoked by uid 102); 9 Apr 2016 05:01:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 01:01:20 -0400
Received: (qmail 9614 invoked by uid 107); 9 Apr 2016 05:01:23 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 01:01:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Apr 2016 01:01:16 -0400
Content-Disposition: inline
In-Reply-To: <CAKdicq8MnZMBV97K5O8Oa1T=PT9DsutmBS+P-bFYitATHH3s+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291081>

On Fri, Apr 08, 2016 at 08:55:54PM -0700, Josiah Boning wrote:

> As measured on linux.git, adding --date-order to a log command can
> result in a significant slowdown (~25x here; I've seen ~100x on other
> repositories):
> 
>     $ time git log --first-parent --max-count=51 master > /dev/null
>     real    0m0.024s
>     user    0m0.006s
>     sys    0m0.016s
>     $ time git log --date-order --first-parent --max-count=51 master > /dev/null
>     real    0m0.652s
>     user    0m0.570s
>     sys    0m0.074s

Try timing "git log --first-parent master >/dev/null". It should be
about the same as the latter, which gives a hint about what is going on.

It's the "--max-count" which is interesting here. It is applied _after_
the sorting. So in the non-sorted case, git can stream out commits and
stop after printing 51. In the sorted case, we have to access every
commit to get its date (well, every commit on the first-parent path),
then sort them, and then return the first 51.

> In combination with --first-parent, --date-order (or any other
> ordering option) should be a no-op, since --first-parent selects a
> linear history. So it seems like there's a significant performance win
> available by ignoring ordering options when --first-parent is present.
> Would this change be desirable? If so, I'll see about submitting a
> patch.

I do agree that --date-order on a linear parent walk cannot change the
ordering (which guarantees child-before-parent), and is a noop.  But
note that not all first-parent invocations are strictly linear. For
example:

  git log --first-parent --date-order master next

which starts from two tips. We'd still want to order commits from the
two lists according to --date-order.

I suppose we could catch the single-tip, first-parent case and ignore
any ordering options which imply child-before-parent (which is currently
all of them). But I did not think too hard if there are any other corner
cases. This sounds like a case of "doctor, it hurts when I do this". Why
do you want to add --date-order in such a case, when it is a noop?

> More generally, it seems like it might be possible to identify when
> the selected commits are linear and avoid the cost of sorting.

It's not the cost of sorting. It's the cost of accessing the commits (if
you profile, you should see most time spent in zlib). So figuring out
that the case is linear will require roughly the same expense.

-Peff
