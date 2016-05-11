From: Jeff King <peff@peff.net>
Subject: [PATCH v2] test-lib: set BASH_XTRACEFD automatically
Date: Wed, 11 May 2016 09:44:04 -0400
Message-ID: <20160511134404.GB19356@sigill.intra.peff.net>
References: <cover.1462888768.git.johannes.schindelin@gmx.de>
 <alpine.DEB.2.20.1605101607180.4092@virtualbox>
 <xmqqshxpofqh.fsf@gitster.mtv.corp.google.com>
 <20160510205800.GC19958@sigill.intra.peff.net>
 <xmqqpostmxah.fsf@gitster.mtv.corp.google.com>
 <20160510213218.GA27028@sigill.intra.peff.net>
 <xmqqd1otmut8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 15:44:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0UQx-0005Kl-Gj
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbcEKNoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:44:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:38017 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932755AbcEKNoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:44:07 -0400
Received: (qmail 14115 invoked by uid 102); 11 May 2016 13:44:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 May 2016 09:44:06 -0400
Received: (qmail 11581 invoked by uid 107); 11 May 2016 13:44:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 May 2016 09:44:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 May 2016 09:44:04 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd1otmut8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294344>

On Tue, May 10, 2016 at 03:06:59PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The patch itself is a trivial-looking one-liner, but there
> > are a few subtleties worth mentioning:
> >
> >   - the variable is _not_ exported; the "set -x" is local to
> >     our process, and so the tracefd should match
> >
> >   - this line has to come after we do the redirection for fd
> >     4, as bash will otherwise complain during the variable
> >     assignment
> >
> >   - likewise, we cannot ever unset this variable, as it
> >     would close descriptor 4
> >
> >   - setting it once here is sufficient to cover both the
> >     regular "-x" case (which implies "--verbose"), as well
> >     as "--verbose-only=1". This works because the latter
> >     flips "set -x" off and on for particular tests (if it
> >     didn't, we would get tracing for all tests, as going to
> >     descriptor 4 effectively circumvents the verbose flag).
> 
> Thanks.  Some of them may deserve to be next to the one-liner to
> prevent people from making changes that tickle them?

Good idea. Here's a v2 that moves most of that text into a comment.

-- >8 --
Subject: test-lib: set BASH_XTRACEFD automatically

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

The patch itself is a simple one-liner, but note the caveats
in the accompanying comments.

Automatic tests for our "-x" option may be a bit too meta
(and a pain, because they are bash-specific), but I did
confirm that it works correctly both with regular "-x" and
with "--verbose-only=1". This works because the latter flips
"set -x" off and on for particular tests (if it didn't, we
would get tracing for all tests, as going to descriptor 4
effectively circumvents the verbose flag).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/README      |  6 +++---
 t/test-lib.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

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
index 286c5f3..0055ebb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -322,6 +322,19 @@ else
 	exec 4>/dev/null 3>/dev/null
 fi
 
+# Send any "-x" output directly to stderr to avoid polluting tests
+# which capture stderr. We can do this unconditionally since it
+# has no effect if tracing isn't turned on.
+#
+# Note that this sets up the trace fd as soon as we assign the variable, so it
+# must come after the creation of descriptor 4 above. Likewise, we must never
+# unset this, as it has the side effect of closing descriptor 4, which we
+# use to show verbose tests to the user.
+#
+# Note also that we don't need or want to export it. The tracing is local to
+# this shell, and we would not want to influence any shells we exec.
+BASH_XTRACEFD=4
+
 test_failure=0
 test_count=0
 test_fixed=0
-- 
2.8.2.812.gd91b08f
