From: Jeff King <peff@peff.net>
Subject: [PATCH 7/9] add tests for cloning corrupted repositories
Date: Mon, 25 Mar 2013 16:22:29 -0400
Message-ID: <20130325202229.GG16019@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 21:23:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDv6-0007l6-7d
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758911Ab3CYUWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:22:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39351 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab3CYUWd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:22:33 -0400
Received: (qmail 27937 invoked by uid 107); 25 Mar 2013 20:24:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:24:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:22:29 -0400
Content-Disposition: inline
In-Reply-To: <20130325201427.GA15798@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219085>

We try not to let corruption pass unnoticed over fetches and
clones. For the most part, this works, but there are some
broken corner cases, including:

  1. We do not detect missing objects over git-aware
     transports. This is a little hard to test, because the
     sending side will actually complain about the missing
     object.

     To fool it, we corrupt a repository such that we have a
     "misnamed" object: it claims to be sha1 X, but is
     really Y. This lets the sender blindly transmit it, but
     it is the receiver's responsibility to verify that what
     it got is sane (and it does not).

  2. We do not detect missing or misnamed blobs during the
     checkout phase of clone.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1060-object-corruption.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 0792132..eb285c0 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -33,6 +33,19 @@ test_expect_success 'setup repo with missing object' '
 	)
 '
 
+test_expect_success 'setup repo with misnamed object' '
+	git init misnamed &&
+	(
+		cd misnamed &&
+		test_commit content &&
+		good=$(obj_to_file HEAD:content.t) &&
+		blob=$(echo corrupt | git hash-object -w --stdin) &&
+		bad=$(obj_to_file $blob) &&
+		rm -f "$good" &&
+		mv "$bad" "$good"
+	)
+'
+
 test_expect_success 'streaming a corrupt blob fails' '
 	(
 		cd bit-error &&
@@ -56,4 +69,32 @@ test_expect_success 'read-tree -u detects missing objects' '
 	)
 '
 
+# We use --bare to make sure that the transport detects it, not the checkout
+# phase.
+test_expect_success 'clone --no-local --bare detects corruption' '
+	test_must_fail git clone --no-local --bare bit-error corrupt-transport
+'
+
+test_expect_success 'clone --no-local --bare detects missing object' '
+	test_must_fail git clone --no-local --bare missing missing-transport
+'
+
+test_expect_failure 'clone --no-local --bare detects misnamed object' '
+	test_must_fail git clone --no-local --bare misnamed misnamed-transport
+'
+
+# We do not expect --local to detect corruption at the transport layer,
+# so we are really checking the checkout() code path.
+test_expect_success 'clone --local detects corruption' '
+	test_must_fail git clone --local bit-error corrupt-checkout
+'
+
+test_expect_failure 'clone --local detects missing objects' '
+	test_must_fail git clone --local missing missing-checkout
+'
+
+test_expect_failure 'clone --local detects misnamed objects' '
+	test_must_fail git clone --local misnamed misnamed-checkout
+'
+
 test_done
-- 
1.8.2.13.g0f18d3c
