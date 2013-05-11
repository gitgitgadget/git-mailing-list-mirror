From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] t5510: start tracking-ref tests from a known state
Date: Sat, 11 May 2013 18:14:03 +0200
Message-ID: <20130511161400.GA3270@sigill.intra.peff.net>
References: <20130511161320.GA14990@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCR2-0001jo-Ep
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864Ab3EKQOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:14:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:58743 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab3EKQOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:14:07 -0400
Received: (qmail 9182 invoked by uid 102); 11 May 2013 16:14:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 11 May 2013 11:14:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2013 18:14:03 +0200
Content-Disposition: inline
In-Reply-To: <20130511161320.GA14990@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223977>

We have three sequential tests for for whether tracking refs
are updated by various fetches and pulls; the first two
should not update the ref, and the third should. Each test
depends on the state left by the test before.

This is fragile (a failing early test will confuse later
tests), and means we cannot add more "should update" tests
after the third one.

Let's instead save the initial state before these tests, and
then reset to a known state before running each test.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5510-fetch.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index d7a19a1..789c228 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -370,12 +370,20 @@ test_expect_success 'explicit fetch should not update tracking' '
 
 '
 
+test_expect_success 'mark initial state of origin/master' '
+	(
+		cd three &&
+		git tag base-origin-master refs/remotes/origin/master
+	)
+'
+
 test_expect_success 'explicit fetch should not update tracking' '
 
 	cd "$D" &&
 	git branch -f side &&
 	(
 		cd three &&
+		git update-ref refs/remotes/origin/master base-origin-master &&
 		o=$(git rev-parse --verify refs/remotes/origin/master) &&
 		git fetch origin master &&
 		n=$(git rev-parse --verify refs/remotes/origin/master) &&
@@ -390,6 +398,7 @@ test_expect_success 'explicit pull should not update tracking' '
 	git branch -f side &&
 	(
 		cd three &&
+		git update-ref refs/remotes/origin/master base-origin-master &&
 		o=$(git rev-parse --verify refs/remotes/origin/master) &&
 		git pull origin master &&
 		n=$(git rev-parse --verify refs/remotes/origin/master) &&
@@ -404,6 +413,7 @@ test_expect_success 'configured fetch updates tracking' '
 	git branch -f side &&
 	(
 		cd three &&
+		git update-ref refs/remotes/origin/master base-origin-master &&
 		o=$(git rev-parse --verify refs/remotes/origin/master) &&
 		git fetch origin &&
 		n=$(git rev-parse --verify refs/remotes/origin/master) &&
-- 
1.8.3.rc1.2.g12db477
