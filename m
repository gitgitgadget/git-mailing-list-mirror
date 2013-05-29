From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] test-lib: verbose mode for only tests matching a
 pattern
Date: Wed, 29 May 2013 01:07:32 -0400
Message-ID: <20130529050732.GC31762@sigill.intra.peff.net>
References: <cover.1368736093.git.trast@inf.ethz.ch>
 <10e5eacece7fc9657c312b5c51747d23ae9ef40b.1368736093.git.trast@inf.ethz.ch>
 <20130529050000.GB31762@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 29 07:07:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhYbs-0000cv-Pu
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302Ab3E2FHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:07:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:35693 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073Ab3E2FHg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:07:36 -0400
Received: (qmail 10221 invoked by uid 102); 29 May 2013 05:08:16 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 00:08:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 01:07:32 -0400
Content-Disposition: inline
In-Reply-To: <20130529050000.GB31762@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225736>

On Wed, May 29, 2013 at 01:00:00AM -0400, Jeff King wrote:

> So we see 83 and 84 non-verbose, which is good. And we see the actual
> output from 85 (the output from a "git checkout"). But we do not see the
> "expecting success" for it. We see it for the _next_ test, which we
> should not see at all. So I think your toggling is happening in the
> wrong spot, but I haven't looked further than that.

I think you want something more like:

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5251009..75351f5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -349,6 +349,7 @@ test_expect_failure () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
+		toggle_verbose
 		say >&3 "checking known breakage: $2"
 		if test_run_ "$2" expecting_failure
 		then
@@ -367,6 +368,7 @@ test_expect_success () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
+		toggle_verbose
 		say >&3 "expecting success: $2"
 		if test_run_ "$2"
 		then
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b4e81bc..165e84e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -400,7 +400,6 @@ setup_test_eval () {
 setup_test_eval () {
 	setup_malloc_check
 	toggle_valgrind
-	toggle_verbose
 }
 teardown_test_eval () {
 	teardown_malloc_check

However, I'm not sure the toggle is the right thing. However, the whole
toggle thing seems weird to me, as there is a big "gap" between
finishing test X and starting test X+1 where we inherit the verbosity
(and valgrind) settings from X. In general we frown upon doing much at
all outside of test_expect_*, but I would think that:

  test_expect_success 'one' '...'
  git foo
  test_expect_success 'two' '...'

when run with "--valgrind-only=1" would not run the intermediate "git
foo" with valgrind. I would have expected the implementation to be more
like:

  maybe_turn_on_valgrind
  maybe_turn_on_verbose
  run_the_actual_test
  maybe_turn_off_verbose
  maybe_turn_off_valgrind

rather than relying on the next test to return to normal. I doubt that
it matters too much in practice, though.

-Peff
