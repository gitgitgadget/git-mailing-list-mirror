From: Jeff King <peff@peff.net>
Subject: Re: tr/pty-all (Re: What's cooking in git.git (Dec 2011, #04; Tue,
 13))
Date: Wed, 14 Dec 2011 19:50:57 -0500
Message-ID: <20111215005057.GB2566@sigill.intra.peff.net>
References: <7vobvcrlve.fsf@alter.siamese.dyndns.org>
 <20111214070916.GA14954@elie.hsd1.il.comcast.net>
 <201112141717.15021.trast@student.ethz.ch>
 <20111214230713.GA13128@sigill.intra.peff.net>
 <20111214232151.GB13128@sigill.intra.peff.net>
 <20111214233119.GA2354@elie>
 <20111215002530.GA2566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 01:51:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RazXN-0003X4-Eg
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 01:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758414Ab1LOAvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 19:51:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50279
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758371Ab1LOAu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 19:50:59 -0500
Received: (qmail 4495 invoked by uid 107); 15 Dec 2011 00:57:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Dec 2011 19:57:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2011 19:50:57 -0500
Content-Disposition: inline
In-Reply-To: <20111215002530.GA2566@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187179>

On Wed, Dec 14, 2011 at 07:25:30PM -0500, Jeff King wrote:

> [1] Actually, you could abandon the idea of feeding garbage altogether,
> and instead open the descriptor outside the test, then check that its
> offset is still 0 after the test. You'd have to use a helper program to
> do the ftell(), but it should work as the descriptor position will be
> shared.

And here's what that patch would look like. You still want to feed a
garbage file, because you want to make sure that there is something for
it to actually read. And then either it can choke on the garbage and
fail, or if not, you can detect afterwards that it was read.

This correctly detects the bug in t7006. I can't decide if it's clever
or ugly.

---
 t/stdin-garbage |    1 +
 t/test-lib.sh   |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 t/stdin-garbage

diff --git a/t/stdin-garbage b/t/stdin-garbage
new file mode 100644
index 0000000..3a2ebc2
--- /dev/null
+++ b/t/stdin-garbage
@@ -0,0 +1 @@
+This is a garbage file that will be connected to the stdin of each test.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bdd9513..9b4692b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -466,6 +466,10 @@ test_debug () {
 	test "$debug" = "" || eval "$1"
 }
 
+test_stdin_unread_ () {
+	test "`perl -e 'print tell(STDIN)'`" = 0
+}
+
 test_eval_ () {
 	# This is a separate function because some tests use
 	# "return" to end a test_expect_success block early.
@@ -475,9 +479,21 @@ test_eval_ () {
 test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
+	# feed the test a bogus stdin, but keep a spare descriptor open in case
+	# the test redirects stdin, which affects us since it is an eval
+	exec 6<&0
+	exec 7<"$TEST_DIRECTORY/stdin-garbage"
+	exec 0<&7
 	test_eval_ "$1"
 	eval_ret=$?
 
+	# check that nobody read from our bogus descriptor
+	if test $eval_ret = 0 && ! test_stdin_unread_ <&7; then
+		echo >&4 "bug in the test script: somebody read from stdin"
+		eval_ret=1
+	fi
+	exec 0<&6
+
 	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
 	then
 		test_eval_ "$test_cleanup"
-- 
1.7.8.rc2.30.g803b1a
