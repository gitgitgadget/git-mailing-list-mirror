From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv3] ident.c: add support for IPv6
Date: Fri, 27 Nov 2015 14:08:27 +0000
Message-ID: <1448633307-43339-1-git-send-email-gitter.spiros@gmail.com>
Cc: peff@peff.net, sunshine@sunshineco.com,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 15:08:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2JhT-0005GM-VO
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 15:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbbK0OIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 09:08:34 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33759 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbK0OIe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 09:08:34 -0500
Received: by wmec201 with SMTP id c201so72007649wme.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2015 06:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FQB4tlksVopabEvv86FDLSfpjt/TxoZIj/n8InNHhLw=;
        b=uVkU2s7jzfgyIeasfFqXETppPKj5Mqmt7bjPaeWNdUJb9fK5WuZNbtE9KUq6rLtRrL
         7rLcjNJmHpGT89LQfZT8VSd1n4Bpu/IRrl0jKkjunN824UCQZ4Nf7XT4OrtwzpTmk2G1
         JmHxY3DPUazHUcAE3d0zXzQJBlCFF9fUrfLSXi+7RakNIIzXCy1r3xGjxagYOgDaVNQB
         OJUWQBGrW8BbozndMAX6XLJ9TnYHxy5tBEdw33O2QmaFeEHoMh/x4T/0k/x1O5iEgNzB
         13Wnbg2GwBkewjOLWiwKMyNf3WwUXhVr9V1SeYjOZS/zbUHyF75gcSvh2/RmkWxzbRr4
         PUWA==
X-Received: by 10.194.188.49 with SMTP id fx17mr32055865wjc.47.1448633313059;
        Fri, 27 Nov 2015 06:08:33 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id cl5sm32997377wjc.29.2015.11.27.06.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Nov 2015 06:08:32 -0800 (PST)
X-Mailer: git-send-email 2.6.3.368.gf34be46.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281774>

Add IPv6 support by implementing name resolution with the
protocol agnostic getaddrinfo(3) API. The old gethostbyname(3)
code is still available when git is compiled with NO_IPV6.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
---
This is the third version of the patch ($gmane/280488)
Changes from previous:

- Simplified the implementation, adding the new
function canonical_name (Jeff King) ($gmane/281479).
Fixed a new typo introduced in the second version.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 ident.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/ident.c b/ident.c
index 5ff1aad..6695537 100644
--- a/ident.c
+++ b/ident.c
@@ -70,10 +70,33 @@ static int add_mailname_host(struct strbuf *buf)
 	return 0;
 }
 
+static int canonical_name(const char *host, struct strbuf *out)
+{
+       int status=-1;
+#ifndef NO_IPV6
+       struct addrinfo hints, *ai;
+       memset (&hints, '\0', sizeof (hints));
+       hints.ai_flags = AI_CANONNAME;
+       int gai = getaddrinfo(host, NULL, &hints, &ai);
+       if (!gai) {
+               if (ai && strchr(ai->ai_canonname, '.')) {
+                       strbuf_addstr(out, ai->ai_canonname);
+                       status=0;
+               }
+               freeaddrinfo(ai);
+       }
+#else
+       struct hostent *he = gethostbyname(buf);
+       if (he && strchr(he->h_name, '.')) {
+                       strbuf_addstr(out, he->h_name);
+                       status=0;
+       }
+#endif /* NO_IPV6 */
+}
+
 static void add_domainname(struct strbuf *out)
 {
 	char buf[1024];
-	struct hostent *he;
 
 	if (gethostname(buf, sizeof(buf))) {
 		warning("cannot get host name: %s", strerror(errno));
@@ -82,10 +105,9 @@ static void add_domainname(struct strbuf *out)
 	}
 	if (strchr(buf, '.'))
 		strbuf_addstr(out, buf);
-	else if ((he = gethostbyname(buf)) && strchr(he->h_name, '.'))
-		strbuf_addstr(out, he->h_name);
-	else
-		strbuf_addf(out, "%s.(none)", buf);
+	else {
+		 if (canonical_name(buf,out) != 0) strbuf_addf(out, "%s.(none)", buf);
+	}
 }
 
 static void copy_email(const struct passwd *pw, struct strbuf *email)
-- 
2.5.0
