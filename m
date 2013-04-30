From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/6] sha1_name: refactor reinterpret()
Date: Tue, 30 Apr 2013 16:49:12 -0500
Message-ID: <1367358554-4257-5-git-send-email-felipe.contreras@gmail.com>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, "Duy Nguyen\"" <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 23:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIRt-0003XS-2D
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 23:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933838Ab3D3Vuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 17:50:46 -0400
Received: from mail-ye0-f170.google.com ([209.85.213.170]:41292 "EHLO
	mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933760Ab3D3Vup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 17:50:45 -0400
Received: by mail-ye0-f170.google.com with SMTP id m4so164844yen.29
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1pvB1vEuK9wZDhkIXWcuzIBQxel06wxe6PdxfzegeHc=;
        b=Rqr6Q5ulSfAgFtgxGcBD5FO3tTSubsUIYfAPMRdX6NVqI6OtkjBAnsv5teS3742FLq
         XlpJCIcZgwUTCJEr3yOgz328UzT8mKYm6NvSG6i4LLoNbRoscs35+nAMDCM0EIy1wnEE
         btO1g7WnaS7cO0SLBG1LmdQ474bvRGLgY+Uno660Os3jEsxUoSgWfaEZOx9Lbsv3oCAF
         Y/zHDhIE5O3w/Nmzzk9OjysSmRiQT8o58mMQLLMZHQHgyy6ImNZavtmMP8F5MfJHg0ys
         kZ07RTm0Ydul9AY891lh6JFg3zf1uvGGletKj7AA3RTFN/poTt+E47B4OXgCK6omLCqn
         XzzA==
X-Received: by 10.236.129.235 with SMTP id h71mr183757yhi.72.1367358645273;
        Tue, 30 Apr 2013 14:50:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id t27sm316316yhm.20.2013.04.30.14.50.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 14:50:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.395.gfe9a10d
In-Reply-To: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223018>

This code essentially replaces part of ref with another ref, for example
'@{-1}@{u}' is replaced with 'master@{u}', but this can be reused for
other purposes other than nth prior checkouts.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 93c4e8c..76e3219 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -965,6 +965,27 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
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
@@ -998,25 +1019,8 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 		return len; /* syntax Ok, not enough switches */
 	if (len > 0 && len == namelen)
 		return len; /* consumed all */
-	else if (len > 0) {
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
+	else if (len > 0)
+		return reinterpret(name, namelen, len, buf);
 
 	cp = strchr(name, '@');
 	if (!cp)
-- 
1.8.3.rc0.395.gfe9a10d
