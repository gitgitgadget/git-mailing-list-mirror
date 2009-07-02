From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv1bis 2/2] git apply: preserve original whitespace with --ignore-whitespace
Date: Thu,  2 Jul 2009 19:48:41 +0200
Message-ID: <1246556921-5819-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Robert Fitzsimons <robfitz@273k.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 19:49:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMQPI-0004JX-UM
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 19:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbZGBRsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 13:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbZGBRsv
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 13:48:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:51466 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbZGBRss (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 13:48:48 -0400
Received: by fg-out-1718.google.com with SMTP id e21so540871fga.17
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BN+pkJilGerkTiGckkGAK7BI4F73Fii9cJkNLcgJ7gM=;
        b=SPJAfV8m5oZYCMdErfK5l1RKPpn6NxCBn6AFpDvftfjhJzEYNAvG0FYaWQW7BUfvty
         tz0LPGCd4dpvUAOuCsLjbBOcg9sI9Lx/P1KQLiUAE85a6Y8hpFxj9tyEl7HA5slcXPCM
         XMvM/gPPenEqlsBbNuoO79k5T5xP08cbvHvB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rC8O3bVEuVnfULw2eojx5+ezw8pYPoxCU5I5IVrQFQkLnNsewUWAb/wPQHmlMT/Xp3
         Udm/XdNkQ8Yjv9afi9GOIu9BzQpPQ1iaHPjR1jsONdo/xzhDib6knJ/ftmTCfFQdvuWX
         ZHqHbjD2XmxfC13XshULXNOgNr7GIQgdguDqk=
Received: by 10.86.27.17 with SMTP id a17mr508909fga.17.1246556931704;
        Thu, 02 Jul 2009 10:48:51 -0700 (PDT)
Received: from localhost (host-78-15-5-16.cust-adsl.tiscali.it [78.15.5.16])
        by mx.google.com with ESMTPS id l12sm6068483fgb.24.2009.07.02.10.48.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 10:48:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.512.g509a
In-Reply-To: <1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122660>

---
 builtin-apply.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 70cc985..24ab286 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1644,6 +1644,10 @@ static void update_pre_post_images(struct image *preimage,
 	int i, ctx;
 	char *new, *old, *fixed;
 	struct image fixed_preimage;
+	/* Do we need more space for the postimage? */
+	size_t newlen = postimage->len;
+	if (len > preimage->len)
+		newlen += len - preimage->len;
 
 	/*
 	 * Update the preimage with whitespace fixes.  Note that we
@@ -1658,11 +1662,16 @@ static void update_pre_post_images(struct image *preimage,
 	*preimage = fixed_preimage;
 
 	/*
-	 * Adjust the common context lines in postimage, in place.
+	 * Adjust the common context lines in postimage, in place
+	 * if we are not ignoring whitespace differences.
 	 * This is possible because whitespace fixing does not make
 	 * the string grow.
 	 */
-	new = old = postimage->buf;
+	old = postimage->buf;
+	if (ignore_whitespace)
+		new = postimage->buf = xmalloc(newlen);
+	else
+		new = old;
 	fixed = preimage->buf;
 	for (i = ctx = 0; i < postimage->nr; i++) {
 		size_t len = postimage->line[i].len;
@@ -1738,8 +1747,25 @@ static int match_fragment(struct image *img,
 	     ? (try + preimage->len == img->len)
 	     : (try + preimage->len <= img->len)) &&
 	    lines_match(img->buf + try, img_len,
-	                preimage->buf, preimage->len))
+	                preimage->buf, preimage->len)) {
+		if (ignore_whitespace) {
+			/*
+			 * Replace the preimage whitespace with the original one
+			 */
+			size_t newlen = 0;
+			for (i = 0; i < preimage->nr; i++) {
+				newlen += preimage->line[i].len =
+				          img->line[try_lno + i].len;
+			}
+			fixed_buf = xmalloc(newlen);
+			memcpy(fixed_buf, img->buf + try, newlen);
+
+			update_pre_post_images(
+				preimage, postimage,
+				fixed_buf, newlen);
+		}
 		return 1;
+	}
 
 	if (!ignore_whitespace && (ws_error_action != correct_ws_error))
 		return 0;
-- 
1.6.3.3.511.g0ded0.dirty
