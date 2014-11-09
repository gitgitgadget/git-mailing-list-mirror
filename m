From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 5/5] trailer: add test with an old style conflict block
Date: Sun, 09 Nov 2014 10:23:43 +0100
Message-ID: <20141109092344.4864.23949.chriscool@tuxfamily.org>
References: <20141109092313.4864.54933.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 10:27:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnOml-0006Of-Il
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 10:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbaKIJ1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 04:27:42 -0500
Received: from [194.158.98.15] ([194.158.98.15]:60681 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751588AbaKIJ1k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 04:27:40 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 78B61A3;
	Sun,  9 Nov 2014 10:27:18 +0100 (CET)
X-git-sha1: 21a8e4102395af9657b87b1d9676b52704c0ea02 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20141109092313.4864.54933.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7513-interpret-trailers.sh | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index fed053a..bd0ab46 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -213,7 +213,7 @@ test_expect_success 'with 2 files arguments' '
 '
 
 test_expect_success 'with message that has comments' '
-	cat basic_message >>message_with_comments &&
+	cat basic_message >message_with_comments &&
 	sed -e "s/ Z\$/ /" >>message_with_comments <<-\EOF &&
 		# comment
 
@@ -240,6 +240,36 @@ test_expect_success 'with message that has comments' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with message that has an old style conflict block' '
+	cat basic_message >message_with_comments &&
+	sed -e "s/ Z\$/ /" >>message_with_comments <<-\EOF &&
+		# comment
+
+		# other comment
+		Cc: Z
+		# yet another comment
+		Reviewed-by: Johan
+		Reviewed-by: Z
+		# last comment
+
+		Conflicts:
+
+	EOF
+	cat basic_message >expected &&
+	cat >>expected <<-\EOF &&
+		# comment
+
+		Reviewed-by: Johan
+		Cc: Peff
+		# last comment
+
+		Conflicts:
+
+	EOF
+	git interpret-trailers --trim-empty --trailer "Cc: Peff" message_with_comments >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with commit complex message and trailer args' '
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
-- 
2.1.2.555.gfbecd99
