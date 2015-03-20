From: Jeff King <peff@peff.net>
Subject: test &&-chain lint (was: [PATCH 1/5] t5312: test object deletion
 code paths in a corrupted repository)
Date: Thu, 19 Mar 2015 22:08:51 -0400
Message-ID: <20150320020851.GC15302@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317072844.GA25191@peff.net>
 <CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
 <20150320013217.GA15302@peff.net>
 <CAPig+cQKhBw8air5y3NJaP5Rx9pXVaz9Lmvhe20AimW7pCsWBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 03:09:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYmMu-0001Zf-1R
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 03:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbbCTCIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 22:08:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:35583 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750734AbbCTCIy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 22:08:54 -0400
Received: (qmail 17328 invoked by uid 102); 20 Mar 2015 02:08:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 21:08:53 -0500
Received: (qmail 19245 invoked by uid 107); 20 Mar 2015 02:09:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 22:09:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 22:08:51 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQKhBw8air5y3NJaP5Rx9pXVaz9Lmvhe20AimW7pCsWBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265859>

On Thu, Mar 19, 2015 at 09:37:12PM -0400, Eric Sunshine wrote:

> > Thanks. I notice that a large number of broken &&-chains are on
> > here-docs. I really wish you could put the && on the "EOF" line at the
> > end of the here-doc. I understand _why_ that this not the case, but
> > mentally it is where I want to type it, and I obviously sometimes fail
> > to go back and fix it. I don't think there's a better solution in POSIX
> > sh, though.
> 
> I wonder if test-lint could be enhanced to detect this sort of problem?

That would be nice, but it's complicated. A naive:

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b170cbc..3a6d8d8 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -22,6 +22,7 @@ while (<>) {
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
+	/ <<-?.?EOF(.*)/ && $1 !~ /&&/ and err 'here-doc with broken &&-chain';
 	# this resets our $. for each file
 	close ARGV if eof;
 }

yields quite a few false positives, because of course we don't know
which are meant to be at the end of the chain and which are not. And
finding that out is tough. We'd have to actually parse to the end of
the here-doc ourselves, then see if it was the end of the test_expect
block.

I think it would be simpler to ask the shell to check this for us, like:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c096778..02a03d5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -524,6 +524,21 @@ test_eval_ () {
 test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
+
+	if test -n "$GIT_TEST_CHAIN_LINT"; then
+		# 117 is unlikely to match the exit code of
+		# another part of the chain
+		test_eval_ "(exit 117) && $1"
+		if test "$?" != 117; then
+			# all bets are off for continuing with other tests;
+			# we expected none of the rest of the test commands to
+			# run, but at least some did. Who knows what weird
+			# state we're in? Just bail, and the user can diagnose
+			# by running in --verbose mode
+			error "bug in the test script: broken &&-chain"
+		fi
+	fi
+
 	setup_malloc_check
 	test_eval_ "$1"
 	eval_ret=$?

This turns up an appalling number of failures, but AFAICT they are all
"real" in the sense that the &&-chains are broken. In some cases these
are real, but in others the tests are of an older style where they did
not expect some early commands to fail (and we would catch their bogus
output if they did). E.g., in the patch below, I think the first one is
a real potential bug, and the other two are mostly noise. I do not mind
setting a rule and fixing all of them, though.

I seem to recall people looked at doing this sort of lint a while ago,
but we never ended up committing anything. I wonder if it was because of
all of these "false positives".

diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 6d3b828..62fce10 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -62,7 +62,7 @@ test_expect_success 'git update-index --add to add various paths.' '
 			cd submod$i && git commit --allow-empty -m "empty $i"
 		) || break
 	done &&
-	git update-index --add submod[12]
+	git update-index --add submod[12] &&
 	(
 		cd submod1 &&
 		git commit --allow-empty -m "empty 1 (updated)"
@@ -99,12 +99,12 @@ test_expect_success 'git ls-files -k to show killed files.' '
 '
 
 test_expect_success 'git ls-files -k output (w/o icase)' '
-	git ls-files -k >.output
+	git ls-files -k >.output &&
 	test_cmp .expected .output
 '
 
 test_expect_success 'git ls-files -k output (w/ icase)' '
-	git -c core.ignorecase=true ls-files -k >.output
+	git -c core.ignorecase=true ls-files -k >.output &&
 	test_cmp .expected .output
 '
 

-Peff
