From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/5] trailer: add test with an old style conflict block
Date: Fri, 07 Nov 2014 19:50:52 +0100
Message-ID: <20141107185053.16854.69782.chriscool@tuxfamily.org>
References: <20141107184148.16854.63825.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Nov 07 19:51:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmodK-0006PK-D2
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 19:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbaKGSvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 13:51:32 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:49699 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156AbaKGSva (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 13:51:30 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 10B5C52;
	Fri,  7 Nov 2014 19:51:29 +0100 (CET)
X-git-sha1: a197cda31590b648253967657168bf4c295202b9 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20141107184148.16854.63825.chriscool@tuxfamily.org>
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
