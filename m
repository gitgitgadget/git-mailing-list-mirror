From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn test suite failures due to Subversion race
Date: Mon, 12 Feb 2007 02:38:22 -0800
Message-ID: <20070212103822.GA21413@localdomain>
References: <45CFDFDE.8080907@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Spang <mspang@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Mon Feb 12 11:38:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGYa0-00062P-RJ
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 11:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbXBLKi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 05:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbXBLKi0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 05:38:26 -0500
Received: from hand.yhbt.net ([66.150.188.102]:56378 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964852AbXBLKiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 05:38:25 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1DC927DC094;
	Mon, 12 Feb 2007 02:38:23 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 12 Feb 2007 02:38:22 -0800
Content-Disposition: inline
In-Reply-To: <45CFDFDE.8080907@uwaterloo.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39390>

Michael Spang <mspang@uwaterloo.ca> wrote:
> Some of the git-svn tests can fail on fast machines due to a race in
> Subversion: if a file is modified in the same second it was checked out
> (or in for that matter), Subversion will not consider it modified.
> Apparently there is also a "racy Subversion" problem parallel to the
> "racy-git" problem. The machine is an Athlon 64 X2 3800+.

I don't think any of my machines are even half as fast.  The git-svn
tests take a long time on my dev machine, so we have entirely different
issues.

> For example, test #3 of t9106-git-svn-commit-diff-clobber.sh will fail
> if Subversion happens to fail to make any commit in test #2 of the same
> file. Test #2 will silently pass if no commit was made, as it is not an
> error to commit nothing. The commit in #3 is supposed to conflict with
> the one from #2, but obviously won't if that commit wasn't made. So in
> this case test #3's commit succeeds when failure is expected, and the
> test fails. The [annotated] output of a test run where this happens is
> attached. A couple of other tests have the same problem.
> 
> This may be a known issue, but my search of the archives was fruitless
> and it doesn't appear to be documented anywhere. It's obviously one that
> would need to ultimately be fixed in Subversion, although a workaround
> in the test suite might help those whose builds depend on a passing test
> suite. It's problematic for me to have the git test suite fail because
> the git package for Debian runs the test suite while building, and will
> abort the build if there are failures.

Not known to me.  This is the first time I've heard of this issue; but
I'm not at all surprised that this is happening, though.

> Until this race is fixed in Subversion I guess I'm stuck either skipping
> the git-svn tests or inserting `sleep 1` in a few places to work around
> it. A patch that works around this problem in all of the tests that
> failed for me is attached in case its useful to someone. Even faster
> machines may reveal more instances of the problem. I did not attempt to
> "fix" any tests that will still pass if commits are lost.

This is disconcerting.  Given that hardware is still getting faster, I
suspect there will be many more problems with the svn tests in the
future.  I have no plans for upgrading hardware in the near future; so I
won't be hitting these problems myself.

I'm alright with adding the `sleep 1` in several more places where this
can be an issue.  If it gets bad enough for people with slower
computers, I'll probably just create a function that sleeps only if a
variable is not set (TOO_SLOW_TO_RACE=1 :)

I've been considering rewriting the tests to use the Perl SVN::
libraries exclusively; but that runs the risk of introducing new bugs.

> From 97e90fcd7cf600726ec468016eb37d1e1de38dde Mon Sep 17 00:00:00 2001
> From: Michael Spang <mspang@uwaterloo.ca>
> Date: Sun, 11 Feb 2007 20:56:22 -0500
> Subject: [PATCH] Work around Subversion race in git-svn tests.
> 
> Signed-off-by: Michael Spang <mspang@uwaterloo.ca>

It would've been good to have the above email explanation above in the
commit message below so we know why the patch was needed (when it gets
applied).

-- 
Eric Wong
