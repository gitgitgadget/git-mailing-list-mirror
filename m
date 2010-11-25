From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 3/9] shift end_url_with_slash() from http.[ch] to url.[ch]
Date: Thu, 25 Nov 2010 16:21:04 +0800
Message-ID: <1290673270-4284-4-git-send-email-rctay89@gmail.com>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-2-git-send-email-rctay89@gmail.com>
 <1290673270-4284-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:22:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLX6P-0008Mi-0x
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596Ab0KYIWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:22:43 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34173 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab0KYIWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 03:22:42 -0500
Received: by mail-iw0-f174.google.com with SMTP id 5so389iwn.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 00:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hnz2PviPNtXrjtuwc25TUsw6ZBiiGToJqp+8LFOeV38=;
        b=fyGC+FPoCYEnTPoYExrp9s8bZKggcOXxdS5facACcRgacNiperABtsM9iQHXqfW9M3
         zkGDfHTGXgNRRcctB023PyvGf05kdypuDD0I3+fFtDwveYdxcIu347dXt9yY4R8sh0R1
         qmI0W6v9sY4q5ds5/ElaxKUqJNdbpPudjQAk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EF93+ckmYKJDO36Q7pUZALAtNSwpX8PnoBRi/R0n++Vn6bZL8xEuxJKRx2sEGFCHLK
         AX7D8R9yPV/ybVgYLl2sinRQ3PfLGhO04J0woKH8GW4XfyeC5KVXunRsX1X7kwhlDyXS
         aYRRPkD3K+XAzTHFmbT8grZ+P1Kt3pCNT/3Ko=
Received: by 10.42.132.135 with SMTP id d7mr171190ict.240.1290673362687;
        Thu, 25 Nov 2010 00:22:42 -0800 (PST)
Received: from localhost.localdomain (cm60.zeta152.maxonline.com.sg [116.87.152.60])
        by mx.google.com with ESMTPS id i16sm513271ibl.12.2010.11.25.00.22.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 00:22:41 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290673270-4284-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162108>

This allows non-http/curl users to access it too (eg. http-backend.c).

Update include headers in end_url_with_slash() users too.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Makefile |    2 +-
 http.c   |    8 +-------
 http.h   |    2 +-
 url.c    |    7 +++++++
 url.h    |    2 ++
 5 files changed, 12 insertions(+), 9 deletions(-)

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
index 173f74c..5c6e243 100644
--- a/http.h
+++ b/http.h
@@ -8,6 +8,7 @@
 
 #include "strbuf.h"
 #include "remote.h"
+#include "url.h"
 
 /*
  * We detect based on the cURL version if multi-transfer is
@@ -117,7 +118,6 @@ extern void append_remote_object_url(struct strbuf *buf, const char *url,
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
1.7.3.2.495.gc7b3f
