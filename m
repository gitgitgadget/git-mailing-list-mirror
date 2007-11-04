From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Fix an infinite loop in sq_quote_buf().
Date: Sun, 4 Nov 2007 21:26:22 +0100
Message-ID: <200711042126.22512.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 21:26:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iom3L-0007LY-Tz
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 21:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbXKDU0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 15:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbXKDU0Z
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 15:26:25 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:35303 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbXKDU0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 15:26:25 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 8565134487;
	Sun,  4 Nov 2007 21:26:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id BA7DA58C46;
	Sun,  4 Nov 2007 21:26:22 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63439>

sq_quote_buf() treats single-quotes and exclamation marks specially, but
it incorrectly parsed the input for single-quotes and backslashes.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 quote.c          |    2 +-
 t/t5510-fetch.sh |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/quote.c b/quote.c
index 482be05..919d092 100644
--- a/quote.c
+++ b/quote.c
@@ -26,7 +26,7 @@ void sq_quote_buf(struct strbuf *dst, const char *src)
 
 	strbuf_addch(dst, '\'');
 	while (*src) {
-		size_t len = strcspn(src, "'\\");
+		size_t len = strcspn(src, "'!");
 		strbuf_add(dst, src, len);
 		src += len;
 		while (need_bs_quote(*src)) {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index d217657..aad863d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -208,4 +208,11 @@ test_expect_success 'fetch with a non-applying branch.<name>.merge' '
 	git fetch blub
 '
 
+# the strange name is: a\!'b
+test_expect_success 'quoting of a strangely named repo' '
+	! git fetch "a\\!'\''b" > result 2>&1 &&
+	cat result &&
+	grep "fatal: '\''a\\\\!'\''b'\''" result
+'
+
 test_done
-- 
1.5.3.4.315.g2ce38
