From: Jeff King <peff@peff.net>
Subject: Re: tr/pty-all (Re: What's cooking in git.git (Dec 2011, #04; Tue,
 13))
Date: Wed, 14 Dec 2011 18:21:51 -0500
Message-ID: <20111214232151.GB13128@sigill.intra.peff.net>
References: <7vobvcrlve.fsf@alter.siamese.dyndns.org>
 <20111214070916.GA14954@elie.hsd1.il.comcast.net>
 <201112141717.15021.trast@student.ethz.ch>
 <20111214230713.GA13128@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Dec 15 00:21:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ray98-000751-9F
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 00:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759Ab1LNXVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 18:21:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50249
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150Ab1LNXVx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 18:21:53 -0500
Received: (qmail 3510 invoked by uid 107); 14 Dec 2011 23:28:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Dec 2011 18:28:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2011 18:21:51 -0500
Content-Disposition: inline
In-Reply-To: <20111214230713.GA13128@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187175>

On Wed, Dec 14, 2011 at 06:07:13PM -0500, Jeff King wrote:

> On Wed, Dec 14, 2011 at 05:17:14PM +0100, Thomas Rast wrote:
> 
> > > I also find Jeff's patch [3] appealing.
> > 
> > Me too, though wonder whether feeding a file full of garbage wouldn't
> > be better, so as to trip up commands that try to read only from a
> > non-tty stdin.
> 
> Interesting idea. Instead of getting an immediate EOF from /dev/null,
> they'll get some junk which they may or may not complain about. I played
> around with this a bit, redirecting test stdin from a file with:

So here is what that patch looked like. As I mentioned, it doesn't
actually catch the shortlog problem, but it would fix
Michael's issue with an outer reading loop.

-- >8 --
Subject: [PATCH] test-lib: redirect stdin of tests

We want to run tests in a predictable, sterile environment
so we can get repeatable results.  They should take as
little input as possible from the environment outside the
test script. We already sanitize environment variables, but
leave stdin untouched. This means that scripts can
accidentally be impacted by content on stdin, or whether
stdin isatty().

Furthermore, scripts reading from stdin can be annoying to
outer loops which care about their stdin offset, like:

  while read sha1; do
      make test
  done

A test which accidentally reads stdin would soak up all of
the rest of the input intended for the outer shell loop.

Let's redirect stdin from a known source to eliminate
variation. We could just connect it to /dev/null. However,
tests which accidentally read stdin would then see immediate
EOF, which may or may not cause them to notice the errror.
Instead, let's connect it to a file with random garbage in
it, in the hope that it will be more likely to trigger an
error in the mis-written test.

We'll also leave file descriptor 6 as a link to the original
stdin. Tests shouldn't need to look at this, but it can be
convenient for inserting interactive commands while
debugging tests (e.g., you could insert "bash <&6 >&3 2>&4"
to run interactive commands in the environment of the test
script).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/stdin-garbage |    1 +
 t/test-lib.sh   |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)
 create mode 100644 t/stdin-garbage

diff --git a/t/stdin-garbage b/t/stdin-garbage
new file mode 100644
index 0000000..3a2ebc2
--- /dev/null
+++ b/t/stdin-garbage
@@ -0,0 +1 @@
+This is a garbage file that will be connected to the stdin of each test.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bdd9513..67eb078 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -198,6 +198,8 @@ else
 	exec 4>/dev/null 3>/dev/null
 fi
 
+exec 6<&0
+
 test_failure=0
 test_count=0
 test_fixed=0
@@ -469,7 +471,7 @@ test_debug () {
 test_eval_ () {
 	# This is a separate function because some tests use
 	# "return" to end a test_expect_success block early.
-	eval >&3 2>&4 "$*"
+	eval <"$TEST_DIRECTORY/stdin-garbage" >&3 2>&4 "$*"
 }
 
 test_run_ () {
-- 
1.7.8.rc2.30.g803b1a
