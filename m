From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 1/2] sha1_name: refactor reinterpret()
Date: Tue,  7 May 2013 17:04:30 -0500
Message-ID: <1367964271-11422-2-git-send-email-felipe.contreras@gmail.com>
References: <1367964271-11422-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, "Duy Nguyen\"" <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 00:06:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZq1Q-0007uI-8s
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 00:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab3EGWGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 18:06:02 -0400
Received: from mail-ye0-f169.google.com ([209.85.213.169]:54193 "EHLO
	mail-ye0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab3EGWGB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 18:06:01 -0400
Received: by mail-ye0-f169.google.com with SMTP id m3so252905yen.0
        for <git@vger.kernel.org>; Tue, 07 May 2013 15:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=H2JAm3jUg0N3TyHG/fofHsyX4JCoqZh8+zQshhERvb4=;
        b=Cu6h4nhyy3zOYWjy49VyMCF8WBNXwWm3aVy+SMc/38Tsu7CEWxwA0/uC05A/HAkZo/
         1eBsz6+mYNvMzWczZHepK3GPKsAfOqeKYbxNbEzkV69PkG3TqzVnSb49v9nqrbDiSF60
         A+P1FTCEW3VD6qlf8TshdC2ovo2P5HQAlVveue4/vhsIOnkYKYtAONbJjxelESHquF7o
         AOAhuhn9TMpmA2Qacn/wntYCJKRAW4x1Gg7+6tMhpdzVBaVwg8Z0NM5fcH3oLecBPwW3
         Gu/YJjHBwC5KlEXssIYOfv2Iz9a+V1mXObGVXrOLNXgS4tX9nGeEqluxt4oyOTtui6H7
         WdXQ==
X-Received: by 10.236.110.69 with SMTP id t45mr3844187yhg.50.1367964360365;
        Tue, 07 May 2013 15:06:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i21sm58448128yhl.15.2013.05.07.15.05.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 15:05:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367964271-11422-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223619>

This code essentially replaces part of ref with another ref, for example
'@{-1}@{u}' is replaced with 'master@{u}', but this can be reused for
other purposes other than nth prior checkouts.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..fd2a95a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -966,6 +966,27 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 	return st;
 }
 
+static int reinterpret(const char *name, int namelen, int len, struct strbuf *buf)
+{
+	/* we have extra data, which might need further processing */
+	struct strbuf tmp = STRBUF_INIT;
+	int used = buf->len;
+	int ret;
+
+	strbuf_add(buf, name + len, namelen - len);
+	ret = interpret_branch_name(buf->buf, &tmp);
+	/* that data was not interpreted, remove our cruft */
+	if (ret < 0) {
+		strbuf_setlen(buf, used);
+		return len;
+	}
+	strbuf_reset(buf);
+	strbuf_addbuf(buf, &tmp);
+	strbuf_release(&tmp);
+	/* tweak for size of {-N} versus expanded ref name */
+	return ret - used + len;
+}
+
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
@@ -999,25 +1020,8 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 		return len; /* syntax Ok, not enough switches */
 	if (0 < len && len == namelen)
 		return len; /* consumed all */
-	else if (0 < len) {
-		/* we have extra data, which might need further processing */
-		struct strbuf tmp = STRBUF_INIT;
-		int used = buf->len;
-		int ret;
-
-		strbuf_add(buf, name + len, namelen - len);
-		ret = interpret_branch_name(buf->buf, &tmp);
-		/* that data was not interpreted, remove our cruft */
-		if (ret < 0) {
-			strbuf_setlen(buf, used);
-			return len;
-		}
-		strbuf_reset(buf);
-		strbuf_addbuf(buf, &tmp);
-		strbuf_release(&tmp);
-		/* tweak for size of {-N} versus expanded ref name */
-		return ret - used + len;
-	}
+	else if (0 < len)
+		return reinterpret(name, namelen, len, buf);
 
 	cp = strchr(name, '@');
 	if (!cp)
-- 
1.8.3.rc0.401.g45bba44
