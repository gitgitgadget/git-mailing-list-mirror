From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv2] ident.c: add support for IPv6
Date: Thu, 19 Nov 2015 14:54:20 +0100
Message-ID: <1447941260-5395-1-git-send-email-gitter.spiros@gmail.com>
Cc: peff@peff.net, sunshine@sunshineco.com,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 14:54:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzPfV-0006Ij-4I
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 14:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934043AbbKSNy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 08:54:28 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33673 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932882AbbKSNy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 08:54:27 -0500
Received: by pabfh17 with SMTP id fh17so84717998pab.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2015 05:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1XjBDaVfu7uqJ20dqVZSdbOWmltaUljhQDUnyi8ByLc=;
        b=OnCpXKrmyob5oP1vANyWtpvksr1K95TlvxybShcNmznWXQdOCXSkNCGswoQHpMQfTP
         udu2f7uRsUdhaqX5/Ls75MNTBVQNlsoqTNT1xprC6MmJP2sAI+MVvy0X+OxWqZHgQEQm
         hiSZvh1xmHt96w7eegqwBf+vNhh2SzdQpWpA5L5/gYU8KnZDqE/80Zjswtv965S2pn9z
         6lLIMyPIsnoBQBkYOsQRrcaetABOUJS4QI7YClsYJ6Lyj1310Ja8MyhMV8uKKblY99zK
         jOzRaf1yuGzjbkeff0rdxZ3GgA3N6ispnYLbJmFMMgks/yVnsaEtAvS4mmrMUBLTh3nk
         HjVQ==
X-Received: by 10.66.122.105 with SMTP id lr9mr10858192pab.8.1447941267278;
        Thu, 19 Nov 2015 05:54:27 -0800 (PST)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id cc16sm11048102pac.44.2015.11.19.05.54.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Nov 2015 05:54:26 -0800 (PST)
X-Mailer: git-send-email 2.3.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281475>

Add IPv6 support by implementing name resolution with the
protocol agnostic getaddrinfo(3) API. The old gethostbyname(3)
code is still available when git is compiled with NO_IPV6.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
Helped-by: Jeff King <peff@peff.net> 
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
---
This is the second version of the patch ($gmane/280488)
Changes from previous:

- Simplified the implementation, avoiding the duplication of 
the function add_domainname (Jeff King) ($gmane/280512)

- Fixed a possible memory leak with getaddrinfo (Eric Sunshine)
  ($gmane/280507)


 ident.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/ident.c b/ident.c
index 5ff1aad..283e83f 100644
--- a/ident.c
+++ b/ident.c
@@ -73,7 +73,12 @@ static int add_mailname_host(struct strbuf *buf)
 static void add_domainname(struct strbuf *out)
 {
 	char buf[1024];
+#ifndef NO_IPV6
+	struct addrinfo hints, *ai;
+	int gai;
+#else
 	struct hostent *he;
+#endif /* NO_IPV6 */
 
 	if (gethostname(buf, sizeof(buf))) {
 		warning("cannot get host name: %s", strerror(errno));
@@ -82,10 +87,23 @@ static void add_domainname(struct strbuf *out)
 	}
 	if (strchr(buf, '.'))
 		strbuf_addstr(out, buf);
-	else if ((he = gethostbyname(buf)) && strchr(he->h_name, '.'))
-		strbuf_addstr(out, he->h_name);
-	else
-		strbuf_addf(out, "%s.(none)", buf);
+	else	{
+#ifndef NO_IPV6
+		memset (&hints, '\0', sizeof (hints));
+		hints.ai_flags = AI_CANONNAME;
+		if (!(gai = getaddrinfo(buf, NULL, &hints, &ai)) && ai && strchr(ai->ai_canonname, '.')) 
+			strbuf_addstr(out, ai->ai_canonname);
+#else
+		if ((he = gethostbyname(buf)) && strchr(he->h_name, '.'))
+			strbuf_addstr(out, he->h_name);
+#endif /* NO_IPV6 */
+		else
+			strbuf_addf(out, "%s.(none)", buf);
+
+#ifndef NO_IPV6
+		if (gai) freeaddrinfo(ai);
+#endif /* NO_IPV6 */
+	}
 }
 
 static void copy_email(const struct passwd *pw, struct strbuf *email)
-- 
2.5.0
