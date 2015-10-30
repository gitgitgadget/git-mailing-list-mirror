From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] ident.c: add support for IPv6
Date: Fri, 30 Oct 2015 15:48:07 +0100
Message-ID: <1446216487-11503-1-git-send-email-gitter.spiros@gmail.com>
Cc: peff@peff.net, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 30 15:48:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsAyg-0003Xm-Uw
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 15:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbbJ3OsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 10:48:23 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33265 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbbJ3OsW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 10:48:22 -0400
Received: by padhy1 with SMTP id hy1so70558289pad.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bJUHibVurax74uxVlMm0Z1LDls4UaULDjtFzFcLe25Y=;
        b=sjTltTP1oxfH+5ShS5ze1SQeU0rdsYaBkvq72LKfHiePGvgkfQIBDRsv2src+LN8wu
         qR+m74r/Av3A4y+qf7+xI7RbImr2aiaZxpBym8eyTsnzjIb85hRO5D4PNZ35JA2xXnCt
         caB+lj80W00F2FI/kRahw0FfsOlKxASTGuJ7rc5ljHHrcgxGQk15q4psAW9ckOcazSVj
         9824RAAJ2GnGos7AZSfzaFU/OBtyJZg1NecXIMbYuDNOtyIUmCPLEv6KCw8MeHZcIbVa
         Sqs+g4/AraG898QnW0clMetI9Q156KsufQAyAR69nF91930s7+i//DNtwPNSR4qd+/k9
         7Npw==
X-Received: by 10.66.141.42 with SMTP id rl10mr9351792pab.18.1446216501543;
        Fri, 30 Oct 2015 07:48:21 -0700 (PDT)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id tj2sm8717011pab.4.2015.10.30.07.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 07:48:20 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280488>

Add IPv6 support by implementing name resolution with the
protocol agnostic getaddrinfo(3) API. The old gethostbyname(3)
code is still available when git is compiled with NO_IPV6.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 ident.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/ident.c b/ident.c
index 5ff1aad..86b62be 100644
--- a/ident.c
+++ b/ident.c
@@ -69,6 +69,34 @@ static int add_mailname_host(struct strbuf *buf)
 	fclose(mailname);
 	return 0;
 }
+#ifndef NO_IPV6
+
+static void add_domainname(struct strbuf *out)
+{
+	char buf[1024];
+	struct addrinfo hints, *ai;
+	int gai;
+
+	if (gethostname(buf, sizeof(buf))) {
+		warning("cannot get host name: %s", strerror(errno));
+		strbuf_addstr(out, "(none)");
+		return;
+	}
+	if (strchr(buf, '.'))
+		strbuf_addstr(out, buf);
+	else	{
+		memset (&hints, '\0', sizeof (hints));
+		hints.ai_flags = AI_CANONNAME;
+		if (!(gai = getaddrinfo(buf, NULL, &hints, &ai)) && ai && strchr(ai->ai_canonname, '.')) {
+			strbuf_addstr(out, ai->ai_canonname);
+			freeaddrinfo(ai);
+		}
+		else
+			strbuf_addf(out, "%s.(none)", buf);
+	}
+}
+#else /* NO_IPV6 */
+
 
 static void add_domainname(struct strbuf *out)
 {
@@ -88,6 +116,8 @@ static void add_domainname(struct strbuf *out)
 		strbuf_addf(out, "%s.(none)", buf);
 }
 
+#endif /* NO_IPV6 */
+
 static void copy_email(const struct passwd *pw, struct strbuf *email)
 {
 	/*
-- 
2.3.3.GIT
