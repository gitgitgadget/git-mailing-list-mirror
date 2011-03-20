From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] checkout: add basic tests for detached-orphan warning
Date: Sun, 20 Mar 2011 05:04:16 -0400
Message-ID: <20110320090416.GA15948@sigill.intra.peff.net>
References: <20110320090111.GA15641@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 10:04:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1EYh-0003t6-Rc
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 10:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab1CTJET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 05:04:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59863
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab1CTJES (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 05:04:18 -0400
Received: (qmail 24560 invoked by uid 107); 20 Mar 2011 09:04:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 20 Mar 2011 05:04:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2011 05:04:16 -0400
Content-Disposition: inline
In-Reply-To: <20110320090111.GA15641@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169493>

Commit 8e2dc6ac added a warning when we leave a detached
HEAD whose commit is not reachable from any ref tip. Let's
add a few basic tests to make sure it works.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t2020-checkout-detach.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 0042145..bfeb2a6 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -11,6 +11,14 @@ check_not_detached () {
 	git symbolic-ref -q HEAD >/dev/null
 }
 
+ORPHAN_WARNING='you are leaving .* commit.*behind'
+check_orphan_warning() {
+	grep "$ORPHAN_WARNING" "$1"
+}
+check_no_orphan_warning() {
+	! grep "$ORPHAN_WARNING" "$1"
+}
+
 reset () {
 	git checkout master &&
 	check_not_detached
@@ -19,6 +27,8 @@ reset () {
 test_expect_success 'setup' '
 	test_commit one &&
 	test_commit two &&
+	test_commit three && git tag -d three &&
+	test_commit four && git tag -d four &&
 	git branch branch &&
 	git tag tag
 '
@@ -92,4 +102,28 @@ test_expect_success 'checkout --detach moves HEAD' '
 	git diff --exit-code two
 '
 
+test_expect_success 'checkout warns on orphan commits' '
+	reset &&
+	git checkout --detach two &&
+	echo content >orphan &&
+	git add orphan &&
+	git commit -a -m orphan &&
+	git checkout master 2>stderr &&
+	check_orphan_warning stderr
+'
+
+test_expect_success 'checkout does not warn leaving ref tip' '
+	reset &&
+	git checkout --detach two &&
+	git checkout master 2>stderr &&
+	check_no_orphan_warning stderr
+'
+
+test_expect_success 'checkout does not warn leaving reachable commit' '
+	reset &&
+	git checkout --detach HEAD^ &&
+	git checkout master 2>stderr &&
+	check_no_orphan_warning stderr
+'
+
 test_done
-- 
1.7.2.5.10.g62fe7
