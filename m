From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t9902: add a few basic completion tests
Date: Wed, 26 Sep 2012 17:47:51 -0400
Message-ID: <20120926214750.GA18653@sigill.intra.peff.net>
References: <20120926214653.GA18628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 23:48:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGzSc-0004sP-4Y
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 23:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab2IZVrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 17:47:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59353 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116Ab2IZVrx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 17:47:53 -0400
Received: (qmail 28005 invoked by uid 107); 26 Sep 2012 21:48:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Sep 2012 17:48:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2012 17:47:51 -0400
Content-Disposition: inline
In-Reply-To: <20120926214653.GA18628@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206449>

We were not testing ref or tree completion at all. Let's
give them even basic sanity checks to avoid regressions.

Signed-off-by: Jeff King <peff@peff.net>
---
This would have caught the recent breakage, and also paves the way for
testing the new fix.

 t/t9902-completion.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 92d7eb4..2fc833a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -61,6 +61,15 @@ test_completion ()
 	test_cmp expected out
 }
 
+# Like test_completion, but reads expectation from stdin,
+# which is convenient when it is multiline. We also process "_" into
+# spaces to make test vectors more readable.
+test_completion_long ()
+{
+	tr _ " " >expected &&
+	test_completion "$1"
+}
+
 newline=$'\n'
 
 test_expect_success '__gitcomp - trailing space - options' '
@@ -228,4 +237,36 @@ test_expect_success 'general options plus command' '
 	test_completion "git --no-replace-objects check" "checkout "
 '
 
+test_expect_success 'setup for ref completion' '
+	echo content >file1 &&
+	echo more >file2 &&
+	git add . &&
+	git commit -m one &&
+	git branch mybranch &&
+	git tag mytag
+'
+
+test_expect_success 'checkout completes ref names' '
+	test_completion_long "git checkout m" <<-\EOF
+	master_
+	mybranch_
+	mytag_
+	EOF
+'
+
+test_expect_success 'show completes all refs' '
+	test_completion_long "git show m" <<-\EOF
+	master_
+	mybranch_
+	mytag_
+	EOF
+'
+
+test_expect_success '<ref>: completes paths' '
+	test_completion_long "git show mytag:f" <<-\EOF
+	file1_
+	file2_
+	EOF
+'
+
 test_done
-- 
1.7.12.10.g31da6dd
