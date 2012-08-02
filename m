From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Thu, 2 Aug 2012 18:14:04 -0400
Message-ID: <20120802221404.GA1682@sigill.intra.peff.net>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
 <20120802213346.GA575@sigill.intra.peff.net>
 <7vipd1c66f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Butcher <dev.lists@jessamine.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:14:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx3er-0007hP-Sh
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065Ab2HBWON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:14:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49155 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277Ab2HBWOM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:14:12 -0400
Received: (qmail 18994 invoked by uid 107); 2 Aug 2012 22:14:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Aug 2012 18:14:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2012 18:14:04 -0400
Content-Disposition: inline
In-Reply-To: <7vipd1c66f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202804>

On Thu, Aug 02, 2012 at 02:52:56PM -0700, Junio C Hamano wrote:

> > Seq is (unfortunately) not portable. I usually use a perl snippet
> > instead, like:
> >
> >   perl -le 'print for (1..10)'
> >
> > Though I think we are adjusting that to use $PERL_PATH these days.
> 
> t/perf/perf-lib.sh and t/t5551-http-fetch.sh seem to use "seq";
> perhaps we should replace them, then.

Traditionally, BSD did not have seq (they have "jot" instead). However,
my OS X 10.7 box does have seq, and its manpage claims that it appeared
in FreeBSD 9.0. But we should be able to run the test suite on older
versions of both (9.0 is barely 6 months old).

I suspect people on those platforms did not notice because t5551 does
not run by default (not only due to the apache requirement, but you have
to set GIT_TEST_LONG to trigger the particular test that uses it), and
people don't typically run the perf code regularly to look for
regressions.

-- >8 --
Subject: [PATCH] stop using 'seq' in test scripts

The seq command is GNU-ism, and is missing at least in older
BSD releases and their derivatives, not to mention antique
commercial Unixes.

We already purged it in b3431bc (Don't use seq in tests, not
everyone has it, 2007-05-02), but a few new instances have
crept in. They went unnoticed because they are in scripts
that are not run by default.

Let's replace them with a perl snippet (which we already
assume to be everywhere elsewhere in the test suite).
---
b3431bc used a while loop with increment to replace it, which we could
also do. I think the perl script is a little easier to read. If we
ever want to drop the perl dependency for the test suite, we could write
a 5-liner test-seq.c replacement.

 t/perf/perf-lib.sh    | 2 +-
 t/t5551-http-fetch.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 5580c22..8bf8d69 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -163,7 +163,7 @@ test_perf () {
 		else
 			echo "perf $test_count - $1:"
 		fi
-		for i in $(seq 1 $GIT_PERF_REPEAT_COUNT); do
+		for i in $("$PERL_PATH" -le "print for 1..$GIT_PERF_REPEAT_COUNT"); do
 			say >&3 "running: $2"
 			if test_run_perf_ "$2"
 			then
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index fadf2f2..e858a31 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -114,7 +114,7 @@ test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
 	(
 	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	for i in `seq 50000`
+	for i in `"$PERL_PATH" -le "print for (1..50000)"`
 	do
 		echo "commit refs/heads/too-many-refs"
 		echo "mark :$i"
