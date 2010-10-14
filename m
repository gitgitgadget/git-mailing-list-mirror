From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] t5523: test push progress output to tty
Date: Wed, 13 Oct 2010 23:05:05 -0400
Message-ID: <20101014030505.GC5626@sigill.intra.peff.net>
References: <20101014030220.GB20685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 05:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6E7c-0006GC-Dx
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 05:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab0JNDEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 23:04:42 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44616 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258Ab0JNDEm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 23:04:42 -0400
Received: (qmail 4691 invoked by uid 111); 14 Oct 2010 03:04:41 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 14 Oct 2010 03:04:41 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 23:05:05 -0400
Content-Disposition: inline
In-Reply-To: <20101014030220.GB20685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159018>

We already test the non-tty cases, but until recent changes
made lib-terminal.sh available, we couldn't test the case
with a tty. These tests reveal a bug: --no-progress is
silently ignored.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5523-push-upstream.sh |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 113626b..78c5978 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -2,6 +2,7 @@
 
 test_description='push with --set-upstream'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 ensure_fresh_upstream() {
 	test -d parent &&
@@ -72,7 +73,14 @@ test_expect_success 'push -u HEAD' '
 	check_config headbranch upstream refs/heads/headbranch
 '
 
-test_expect_success 'progress messages to non-tty' '
+test_expect_success 'progress messages go to tty' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u upstream master >out 2>err &&
+	grep "Writing objects" err
+'
+
+test_expect_success 'progress messages do not go to non-tty' '
 	ensure_fresh_upstream &&
 
 	# skip progress messages, since stderr is non-tty
@@ -80,7 +88,7 @@ test_expect_success 'progress messages to non-tty' '
 	! grep "Writing objects" err
 '
 
-test_expect_success 'progress messages to non-tty (forced)' '
+test_expect_success 'progress messages go to non-tty (forced)' '
 	ensure_fresh_upstream &&
 
 	# force progress messages to stderr, even though it is non-tty
@@ -88,4 +96,18 @@ test_expect_success 'progress messages to non-tty (forced)' '
 	grep "Writing objects" err
 '
 
+test_expect_success 'push -q suppresses progress' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u -q upstream master >out 2>err &&
+	! grep "Writing objects" err
+'
+
+test_expect_failure 'push --no-progress suppresses progress' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u --no-progress upstream master >out 2>err &&
+	! grep "Writing objects" err
+'
+
 test_done
-- 
1.7.3.1.204.g337d6.dirty
