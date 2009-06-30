From: Jeff King <peff@peff.net>
Subject: Re: RFH - git-log variant that _does_ search through diffs
Date: Tue, 30 Jun 2009 15:31:35 -0400
Message-ID: <20090630193135.GA4460@sigio.peff.net>
References: <279b37b20906291708g67da3a75p316ea4893f02666a@mail.gmail.com> <20090630040337.GA23741@sigio.peff.net> <279b37b20906301105tf92f471g6146a083ba2e2882@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 21:29:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLj1c-0007Lp-79
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 21:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbZF3T3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 15:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbZF3T3l
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 15:29:41 -0400
Received: from peff.net ([208.65.91.99]:50476 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbZF3T3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 15:29:41 -0400
Received: (qmail 4471 invoked by uid 1000); 30 Jun 2009 19:31:35 -0000
Content-Disposition: inline
In-Reply-To: <279b37b20906301105tf92f471g6146a083ba2e2882@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122529>

On Tue, Jun 30, 2009 at 11:05:08AM -0700, Eric Raible wrote:

> What I _really_ want is the subset of all commits containing foo
> who's oneline commit message doesn't match a given regexp.
> 
> So I'm used something like this to extract the commits of interest:
> 
> git log -z -p | perl -0ne 'print if /^[-+].*foo/m' | tr '\0' '\n' |
> grep "^commit [0-9a-f]" | awk '{print $2}' |
> xargs -n1 git log --pretty=oneline -1 |
> grep -v dont_want

I think you can do this a little more simply and efficiently as:

  git log -z -p --format='GREP: %s' |
    perl -0ne 'print if /^[-+].*foo/m && !/^GREP:.*dont_want/' |
    tr '\0' '\n'

(though note that --format is new as of 1.6.3, I think; before that you
have to use "--pretty=format:"). Many fewer process invocations, and
less typing, though still easy to mess up. At one point I had considered
writing small wrapper scripts that understood the log output so you
could say:

  git log -z -p | filter-author $A | filter-diff $D | filter-subject $S

which is nicely readable and Unix-y, but is really _slow_ compared to
git doing it all in a single process. I think a "--grep-subject" and a
"--grep-diff" (aka "--search") are the only things that are missing now,
and those would both be pretty easy to implement.

-Peff
