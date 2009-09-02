From: Jeff King <peff@peff.net>
Subject: Re: `Git Status`-like output for two local branches
Date: Wed, 2 Sep 2009 03:57:13 -0400
Message-ID: <20090902075713.GA1832@coredump.intra.peff.net>
References: <c115fd3c0908311320q46d585d2v457ccd0f411a6404@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 09:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MikiZ-0005RJ-Us
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 09:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZIBH5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 03:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbZIBH5O
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 03:57:14 -0400
Received: from peff.net ([208.65.91.99]:44931 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033AbZIBH5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 03:57:14 -0400
Received: (qmail 5636 invoked by uid 107); 2 Sep 2009 07:57:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Sep 2009 03:57:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2009 03:57:13 -0400
Content-Disposition: inline
In-Reply-To: <c115fd3c0908311320q46d585d2v457ccd0f411a6404@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127592>

On Mon, Aug 31, 2009 at 04:20:47PM -0400, Tim Visher wrote:

> I'm interested in being able to get a message such as 'dev and master
> have diverged, having 1 and 2 commits different respectively' or 'dev
> is behind master by 3 commits and can be fast-forwarded', etc.  I'm
> sure this is simple, but I can't figure out how to do it in the docs.
> Sorry for the noobness of the question.

No, there isn't a simple command to say "show me this status text for
these two arbitrary branches".

However, the process is relatively simple to implement in a shell
script:

  1. Pick your two branches. I'm not clear on whether you want to
     compare two arbitrary branches, or what.

     For the regular "status", one is the current branch, and the other
     is the "upstream" branch (as configured by your
     branch.$current.merge variables). Calculating "upstream" can
     actually be a bit tricky because it involves looking at several
     configuraiton variables. However, recent versions of git allow this
     shell snippet (the 'upstream' formatter was added in v1.6.3):

       current=`git symbolic-ref HEAD`
       upstream=`git for-each-ref --format='%(upstream)' $current`

  2. Count the commits on each side that are not in the other. The
     simplest way to do this is:

       in_a=`git rev-list $b..$a -- | wc -l`
       in_b=`git rev-list $a..$b -- | wc -l`

     but the internal code actually does both traversals simultaneously,
     which is slightly more efficient.  You can also do that by parsing
     the output of:

       git rev-list --left-right $a...$b --

      which will mark commits in "a" with a '<' and commits in "b" with
      a '>'. I don't know whether the extra complexity is worth the
      efficiency gain (in the internal code it is easier, since we
      aren't actually generating output and parsing it; we just keep a
      count).

  3. Compare the counts. If:

       a=0, b=0: they are the same commit
       a=0, b>0: a is behind b by $b commits, and can be fast-forwarded
       a>0, b=0: a is ahead of b by $a commits (and can be pushed, or b
                 can be fast-forwarded to a)
       a>0, b>0: branches have diverged and have $a and $b commits
                 respectively

So it's easy to script, but not exactly a one-liner. We might be able to
do better if you reduce the problem space. What exactly are you trying
to accomplish?

-Peff
