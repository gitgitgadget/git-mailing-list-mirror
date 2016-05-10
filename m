From: Jeff King <peff@peff.net>
Subject: [PATCH] test-lib: set BASH_XTRACEFD automatically
Date: Tue, 10 May 2016 17:32:18 -0400
Message-ID: <20160510213218.GA27028@sigill.intra.peff.net>
References: <cover.1462888768.git.johannes.schindelin@gmx.de>
 <alpine.DEB.2.20.1605101607180.4092@virtualbox>
 <xmqqshxpofqh.fsf@gitster.mtv.corp.google.com>
 <20160510205800.GC19958@sigill.intra.peff.net>
 <xmqqpostmxah.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 23:32:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0FGU-0004gh-U0
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 23:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbcEJVcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 17:32:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:37312 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751410AbcEJVcW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 17:32:22 -0400
Received: (qmail 30708 invoked by uid 102); 10 May 2016 21:32:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 17:32:21 -0400
Received: (qmail 2033 invoked by uid 107); 10 May 2016 21:32:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 17:32:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2016 17:32:18 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpostmxah.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294197>

On Tue, May 10, 2016 at 02:13:26PM -0700, Junio C Hamano wrote:

> > I don't think there is a scalable, portable way to do so. "-x" output is
> > going to stderr, and is inherited by any functions or subshells. So
> > either we have to ask "-x" output to go somewhere else, or we have to
> > turn it off inside the functions and subshells. The latter requires
> > tweaking each site, which isn't scalable. And there is no way to do the
> > former in a portable way (AFAIK).
> 
> Yeah, that was the conclusion I was coming to; the same "unscalable"
> argument applies to the patch under discussion, too.

I think munging the tests themselves is even more horrible than tweaking
test_must_fail, but even the latter is not very scalable (test_must_fail
is undoubtedly the most common function, but it's not the only one; and
one may actually want to see its trace output anyway).

> > +BASH_XTRACEFD=4
> [...]
> 
> Yeah, something like that I would greatly appreciate.

Here it is in patch form. It's sad that we can't automatically help
people using dash (which includes myself). I suppose we could
auto-reinvoke ourselves using bash if it is available, but that feels a
bit too magical. I'm content to let "try running with bash" be a tool in
our toolbox.

-- >8 --
Subject: [PATCH] test-lib: set BASH_XTRACEFD automatically

Passing "-x" to a test script enables the shell's "set -x"
tracing, which can help with tracking down the command that
is causing a failure. Unfortunately, it can also _cause_
failures in some tests that redirect the stderr of a shell
function.  Inside the function the shell continues to
respect "set -x", and the trace output is collected along
with whatever stderr is generated normally by the function.

You can see an example of this by running:

  ./t0040-parse-options.sh -x -i

which will fail immediately in the first test, as it
expects:

  test_must_fail some-cmd 2>output.err

to leave output.err empty (but with "-x" it has our trace
output).

Unfortunately there isn't a portable or scalable solution to
this. We could teach test_must_fail to disable "set -x", but
that doesn't help any of the other functions or subshells.

However, we can work around it by pointing the "set -x"
output to our descriptor 4, which always points to the
original stderr of the test script. Unfortunately this only
works for bash, but it's better than nothing (and other
shells will just ignore the BASH_XTRACEFD variable).

The patch itself is a trivial-looking one-liner, but there
are a few subtleties worth mentioning:

  - the variable is _not_ exported; the "set -x" is local to
    our process, and so the tracefd should match

  - this line has to come after we do the redirection for fd
    4, as bash will otherwise complain during the variable
    assignment

  - likewise, we cannot ever unset this variable, as it
    would close descriptor 4

  - setting it once here is sufficient to cover both the
    regular "-x" case (which implies "--verbose"), as well
    as "--verbose-only=1". This works because the latter
    flips "set -x" off and on for particular tests (if it
    didn't, we would get tracing for all tests, as going to
    descriptor 4 effectively circumvents the verbose flag).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/README      | 6 +++---
 t/test-lib.sh | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index 1dc908e..76a0daa 100644
--- a/t/README
+++ b/t/README
@@ -84,9 +84,9 @@ appropriately before running "make".
 
 -x::
 	Turn on shell tracing (i.e., `set -x`) during the tests
-	themselves. Implies `--verbose`. Note that this can cause
-	failures in some tests which redirect and test the
-	output of shell functions. Use with caution.
+	themselves. Implies `--verbose`. Note that in non-bash shells,
+	this can cause failures in some tests which redirect and test
+	the output of shell functions. Use with caution.
 
 -d::
 --debug::
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 286c5f3..482ec11 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -321,6 +321,7 @@ then
 else
 	exec 4>/dev/null 3>/dev/null
 fi
+BASH_XTRACEFD=4
 
 test_failure=0
 test_count=0
-- 
2.8.2.660.ge43c418
