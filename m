From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/6] shift end_url_with_slash() from http.[ch] to url.[ch]
Date: Fri, 19 Nov 2010 20:46:25 +0800
Message-ID: <1290170790-2200-2-git-send-email-rctay89@gmail.com>
References: <1290170790-2200-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 13:47:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJQN3-0001C8-9E
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 13:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999Ab0KSMqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 07:46:55 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47695 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab0KSMqy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 07:46:54 -0500
Received: by mail-pv0-f174.google.com with SMTP id 1so687011pvh.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 04:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=h45CKql/aEJsIHsL43ieezZhEMKtchDI3SWPr5BNakI=;
        b=tWRngqLr31NfYBu6X2MWWNBnnLkuNx5YeZJ3TwFP73OTCrM29Sibw8VAU8UTwivQ41
         2GIOPf3KGgGUkixyDZvUlM4PcBhnYDh7mL08cEHxKTPnh7IRUyy7kBdL++0G3fBkAXJB
         ubV4qa1chCmeYglR4/cgrmKvL1v4Y0CD47USI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=q9hJu9o9QbBT5kU+93I2XdwmyqXsCzz+oSf/FFueJUDWiw5fv9t+vKhihMsKZ24bN6
         Pkd49MrRxeEuVeGvDK+lLVZNcQr3+GQzv0CV8qxbk1c88eJnY6fzoqxQG3xuVsN7ifQ5
         ZluQg2cSQ+AV98FzqzHQ5WBQbvEdfQvGsZLE4=
Received: by 10.142.233.4 with SMTP id f4mr1666859wfh.60.1290170813985;
        Fri, 19 Nov 2010 04:46:53 -0800 (PST)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id q13sm1852420wfc.5.2010.11.19.04.46.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 04:46:52 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290170790-2200-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161746>

This allows non-http/curl users to access it too (eg. http-backend.c).

Update include headers in end_url_with_slash() users too.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Makefile |    2 +-
 http.c   |    8 +-------
 http.h   |    1 -
 url.c    |    7 +++++++
 url.h    |    2 ++
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index ca1d1fe..e02b0f4 100644
--- a/Makefile
+++ b/Makefile
@@ -1922,7 +1922,7 @@ builtin/tar-tree.o archive-tar.o: tar.h
 builtin/pack-objects.o: thread-utils.h
 connect.o transport.o http-backend.o: url.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
-http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h
+http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h url.h
 
 xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
diff --git a/http.c b/http.c
index 17bcf19..310dd86 100644
--- a/http.c
+++ b/http.c
@@ -2,6 +2,7 @@
 #include "pack.h"
 #include "sideband.h"
 #include "run-command.h"
+#include "url.h"
 
 int data_received;
 int active_requests;
@@ -733,13 +734,6 @@ static inline int hex(int v)
 		return 'A' + v - 10;
 }
 
-void end_url_with_slash(struct strbuf *buf, const char *url)
-{
-	strbuf_addstr(buf, url);
-	if (buf->len && buf->buf[buf->len - 1] != '/')
-		strbuf_addstr(buf, "/");
-}
-
 static char *quote_ref_url(const char *base, const char *ref)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/http.h b/http.h
index 173f74c..10de0a5 100644
--- a/http.h
+++ b/http.h
@@ -117,7 +117,6 @@ extern void append_remote_object_url(struct strbuf *buf, const char *url,
 				     int only_two_digit_prefix);
 extern char *get_remote_object_url(const char *url, const char *hex,
 				   int only_two_digit_prefix);
-extern void end_url_with_slash(struct strbuf *buf, const char *url);
 
 /* Options for http_request_*() */
 #define HTTP_NO_CACHE		1
diff --git a/url.c b/url.c
index cd8f74f..7cebc64 100644
--- a/url.c
+++ b/url.c
@@ -125,3 +125,10 @@ char *url_decode_parameter_value(const char **query)
 	struct strbuf out = STRBUF_INIT;
 	return url_decode_internal(query, "&", &out, 1);
 }
+
+void end_url_with_slash(struct strbuf *buf, const char *url)
+{
+	strbuf_addstr(buf, url);
+	if (buf->len && buf->buf[buf->len - 1] != '/')
+		strbuf_addstr(buf, "/");
+}
diff --git a/url.h b/url.h
index 15817f8..8cb74d4 100644
--- a/url.h
+++ b/url.h
@@ -7,4 +7,6 @@ extern char *url_decode(const char *url);
 extern char *url_decode_parameter_name(const char **query);
 extern char *url_decode_parameter_value(const char **query);
 
+extern void end_url_with_slash(struct strbuf *buf, const char *url);
+
 #endif /* URL_H */
-- 
1.7.3.67.g2a10b
