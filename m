From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/2] git apply: preserve original whitespace with --ignore-whitespace
Date: Thu,  2 Jul 2009 14:52:17 +0200
Message-ID: <1246539137-24754-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246539137-24754-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246539137-24754-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Robert Fitzsimons <robfitz@273k.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 14:52:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMLmG-00056H-BU
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 14:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbZGBMwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 08:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZGBMw2
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 08:52:28 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58783 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZGBMwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 08:52:25 -0400
Received: by fxm18 with SMTP id 18so1464679fxm.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8RIiEOcIY3xOBRxioDGEdLhpUEEsqSXP2GOeVxGrBJQ=;
        b=FkwB0gTyrMBvB0IuO2NW+XKXr5IWyl+WDpcVdMGwbBc+8tzM0rpyEOfd82Bz3A4rx9
         LL6oVKvVYw22ldSVV6DFbgbYijCWjfjSQEh+SaBtoGept4fSjkji/hdH67WyD8JvbM/3
         A7S3ePLrZ9SXfdavw74AUvX4SsXsddtkjzvc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kDNZRKHoNtMO9Bv1ORIUDBrheTJuyjP5oGCmiaQhckArtWzU7+o3rPpJqMYtlvSn1d
         A5MKAzJxYMMVfFzYo8XA2MJ4IUUqkROdkEWx5L5N0riOMz2PpTk3QIWKp7MnMer7lk/3
         HYZrblf5+DK8xsYXd/AHp+aLvw5/H5ernMXYY=
Received: by 10.86.53.11 with SMTP id b11mr166520fga.12.1246539147698;
        Thu, 02 Jul 2009 05:52:27 -0700 (PDT)
Received: from localhost (host-78-15-5-16.cust-adsl.tiscali.it [78.15.5.16])
        by mx.google.com with ESMTPS id 4sm3888759fgg.12.2009.07.02.05.52.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 05:52:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.512.g1f6a.dirty
In-Reply-To: <1246539137-24754-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122643>

---
 builtin-apply.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 86860d6..d213cce 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1640,6 +1640,10 @@ static void update_pre_post_images(struct image *preimage,
 	int i, ctx;
 	char *new, *old, *fixed;
 	struct image fixed_preimage;
+	/* Do we need more space for the postimage? */
+	size_t newlen = postimage->len;
+	if (len > preimage->len)
+		newlen += len - preimage->len;
 
 	/*
 	 * Update the preimage with whitespace fixes.  Note that we
@@ -1654,11 +1658,16 @@ static void update_pre_post_images(struct image *preimage,
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
@@ -1730,8 +1739,25 @@ static int match_fragment(struct image *img,
 	if ((match_end
 	     ? (try + preimage->len == img->len)
 	     : (try + preimage->len <= img->len)) &&
-	    !memcmp_switch(img->buf + try, preimage->buf, preimage->len))
+	    !memcmp_switch(img->buf + try, preimage->buf, preimage->len)) {
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
1.6.3.3.512.g1f6a.dirty
