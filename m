From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 14/16] trailer: add tests for trailer command
Date: Sun, 19 Jan 2014 09:53:52 +0100
Message-ID: <20140119085355.2734.85504.chriscool@tuxfamily.org>
References: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 09:55:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4oAQ-0008R0-8m
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 09:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbaASIze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 03:55:34 -0500
Received: from [194.158.98.14] ([194.158.98.14]:46104 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752021AbaASIyy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 03:54:54 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id D56346E;
	Sun, 19 Jan 2014 09:54:33 +0100 (CET)
X-git-sha1: bc4e91473a31c5de758888c216038b3e95ce9e28 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240689>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7513-interpret-trailers.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index f5ef81f..2d50b7a 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -212,4 +212,31 @@ test_expect_success 'with input from stdin' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with simple command' '
+	git config trailer.sign.key "Signed-off-by: " &&
+	git config trailer.sign.where "after" &&
+	git config trailer.sign.ifExist "addIfDifferentNeighbor" &&
+	git config trailer.sign.command "echo \"A U Thor <author@example.com>\"" &&
+	cat complex_message_body >expected &&
+	printf "Fixes: \nAcked-by= \nReviewed-by: \nSigned-off-by: \nSigned-off-by: A U Thor <author@example.com>\n" >>expected &&
+	git interpret-trailers "review:" "fix=22" < complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'setup a commit' '
+	echo "Content of the first commit." > a.txt &&
+	git add a.txt &&
+	git commit -m "Add file a.txt"
+'
+
+test_expect_success 'with command using $ARG' '
+	git config trailer.fix.ifExist "overwrite" &&
+	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
+	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
+	cat complex_message_body >expected &&
+	printf "Fixes: $FIXED\nAcked-by= \nReviewed-by: \nSigned-off-by: \nSigned-off-by: A U Thor <author@example.com>\n" >>expected &&
+	git interpret-trailers "review:" "fix=HEAD" < complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.5.2.201.gacc5987
