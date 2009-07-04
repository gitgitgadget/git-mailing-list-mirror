From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 2/2] git apply: preserve original whitespace with --ignore-whitespace
Date: Sat,  4 Jul 2009 13:53:49 +0200
Message-ID: <1246708429-21823-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246708429-21823-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 13:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MN3p2-0004Sc-BR
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 13:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbZGDLyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 07:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbZGDLyB
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 07:54:01 -0400
Received: from mail-bw0-f207.google.com ([209.85.218.207]:43626 "EHLO
	mail-bw0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbZGDLx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 07:53:58 -0400
Received: by bwz3 with SMTP id 3so827198bwz.37
        for <git@vger.kernel.org>; Sat, 04 Jul 2009 04:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=biJykrO5z3eSZx+zfAimehjxPhDI44Yn8DCvEgIcKIs=;
        b=osqRjdZ6+ZWuTkZ5H/7/111hgsCzQsC+qoj7UiktKA4bnNcUe0l1x4TevtG/hbINEk
         RwDWKukdP7KpFLK8iFlOTpjSP2K054oY+WOrTAQu/HmFv6CVvfN2jwTfjBv+HlgryB9k
         6q8Cf/rI+W6c99dyE0OxTw8di9ESbq3V2EFh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lrnkmrmq2mQbyt74C/R4/Fuodxw/cRILhpFFCSjLX7I8+JxWfAlD4MFoJtAWXhtj0G
         vKX0CUlyKA1/VTk1nQCEHB70jv+mJOgL/fT02AZlRvZ+n614QXrTTIYbqhhLHm/6AI/P
         UjiVJO/GjzFXhB8KoG95YT95znatHdvjVK8GM=
Received: by 10.103.246.1 with SMTP id y1mr1374740mur.120.1246708439823;
        Sat, 04 Jul 2009 04:53:59 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-32-98.clienti.tiscali.it [94.37.32.98])
        by mx.google.com with ESMTPS id j6sm22507316mue.31.2009.07.04.04.53.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Jul 2009 04:53:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.512.g4fff
In-Reply-To: <1246708429-21823-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122719>

---
 builtin-apply.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 01230f1..6c6ccbd 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1639,10 +1639,17 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	}
 }
 
+/*
+ * Update the preimage, and the common lines in postimage,
+ * from buffer buf of length len. If postlen is 0 the postimage
+ * is updated in place, otherwise it's updated on a new buffer
+ * of length postlen
+ */
+
 static void update_pre_post_images(struct image *preimage,
 				   struct image *postimage,
 				   char *buf,
-				   size_t len)
+				   size_t len, size_t postlen)
 {
 	int i, ctx;
 	char *new, *old, *fixed;
@@ -1661,11 +1668,19 @@ static void update_pre_post_images(struct image *preimage,
 	*preimage = fixed_preimage;
 
 	/*
-	 * Adjust the common context lines in postimage, in place.
-	 * This is possible because whitespace fixing does not make
-	 * the string grow.
+	 * Adjust the common context lines in postimage. This can be
+	 * done in-place when we are just doing whitespace fixing,
+	 * which does not make the string grow, but needs a new buffer
+	 * when ignore_whitespace causes the update, since in this case
+	 * we could have e.g. tabs converted to multiple spaces.
+	 * We trust the caller to tell us if the update can be done
+	 * in place (postlen==0) or not.
 	 */
-	new = old = postimage->buf;
+	old = postimage->buf;
+	if (postlen)
+		new = postimage->buf = xmalloc(postlen);
+	else
+		new = old;
 	fixed = preimage->buf;
 	for (i = ctx = 0; i < postimage->nr; i++) {
 		size_t len = postimage->line[i].len;
@@ -1737,8 +1752,34 @@ static int match_fragment(struct image *img,
 	if ((match_end
 	     ? (try + preimage->len == img->len)
 	     : (try + preimage->len <= img->len)) &&
-	    lines_match(img->buf + try, preimage->buf, preimage->len))
+	    lines_match(img->buf + try, preimage->buf, preimage->len)) {
+		/*
+		 * When ignoring whitespace, we want to preserve the
+		 * target image whitespace in lines that are not modified,
+		 * so we update the preimage and the common lines in
+		 * the postimage to the target whitespace.
+		 */
+		if (ignore_whitespace) {
+			/*
+			 * New length for the updated pre and postimages
+			 */
+			size_t prelen = 0;
+			size_t postlen = postimage->len;
+			for (i = 0; i < preimage->nr; i++) {
+				size_t len = img->line[try_lno + i].len;
+				if (preimage->line[i].flag & LINE_COMMON)
+					postlen += len - preimage->line[i].len;
+				prelen += preimage->line[i].len = len;
+			}
+			fixed_buf = xmalloc(prelen);
+			memcpy(fixed_buf, img->buf + try, prelen);
+
+			update_pre_post_images(
+				preimage, postimage,
+				fixed_buf, prelen, postlen);
+		}
 		return 1;
+	}
 
 	if (ws_error_action != correct_ws_error)
 		return 0;
@@ -1799,7 +1840,7 @@ static int match_fragment(struct image *img,
 	 * hunk match.  Update the context lines in the postimage.
 	 */
 	update_pre_post_images(preimage, postimage,
-			       fixed_buf, buf - fixed_buf);
+			       fixed_buf, buf - fixed_buf, 0);
 	return 1;
 
  unmatch_exit:
-- 
1.6.3.3.512.g4fff
