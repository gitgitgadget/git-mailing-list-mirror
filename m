From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH] http: Add Accept-Language header if possible
Date: Wed,  9 Jul 2014 00:54:06 +0900
Message-ID: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 17:54:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4XjA-00011p-I2
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 17:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbaGHPyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 11:54:22 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:58535 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbaGHPyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 11:54:21 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so7576624pab.30
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Khm2hw2nnYXB5o5EnqmitkhDbXGdYRfA+g/mnj9H2o0=;
        b=J6r29PuW7SmoYYgTKDhpjLF+UT/rbIsSl1kFjvhXsuScwPbpavfzd7Vcn+Vh6GrOV+
         9RhkjwyAhLgUQbDxvRsvv1fbmZ6jgld4z42VeZ54Y2KJe9lm5KoerIm3JMu6CFPWf0N9
         oBQ+WgsJNHQubQ3OAQoc/eWcZ/R3V86b4nCNevZBv6u1bAFaLMSHf6Y1v+RpcFXxRmWf
         ryJx34HzJ1BVezBamuzZqfRZg6IP3d16LvrwfVfneB474VQ+6dCznxmmgaNu6cvuAh/6
         vs0287mxlsWhE+2ysHSCB9nAgjAI546PBoyRcZr8e75fDEsgVjS9enZWL49P9b72bZ0I
         punw==
X-Received: by 10.70.138.45 with SMTP id qn13mr5961850pdb.20.1404834860678;
        Tue, 08 Jul 2014 08:54:20 -0700 (PDT)
Received: from gmail.com ([222.234.94.10])
        by mx.google.com with ESMTPSA id gx10sm54352009pbd.81.2014.07.08.08.54.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Jul 2014 08:54:20 -0700 (PDT)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.0.1.473.gafdefd9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253030>

From: Yi EungJun <eungjun.yi@navercorp.com>

Add an Accept-Language header which indicates the user's preferred
languages defined by 'LANGUAGE' environment variable if the variable is
not empty.

Example:
  LANGUAGE= -> ""
  LANGUAGE=ko -> "Accept-Language: ko; q=1.000, *; q=0.001"
  LANGUAGE=ko:en -> "Accept-Language: ko; q=1.000, en; q=0.999, *; q=0.001"

This gives git servers a chance to display remote error messages in
the user's preferred language.
---
 http.c                     | 43 +++++++++++++++++++++++++++++++++++++++++++
 t/t5550-http-fetch-dumb.sh | 10 ++++++++++
 2 files changed, 53 insertions(+)

diff --git a/http.c b/http.c
index 3a28b21..c345616 100644
--- a/http.c
+++ b/http.c
@@ -983,6 +983,47 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
 		strbuf_addstr(charset, "ISO-8859-1");
 }
 
+/*
+ * Add an Accept-Language header which indicates user's preferred languages
+ * defined by 'LANGUAGE' environment variable if the variable is not empty.
+ *
+ * Example:
+ *   LANGUAGE= -> ""
+ *   LANGUAGE=ko -> "Accept-Language: ko; q=1.000, *; q=0.001"
+ *   LANGUAGE=ko:en -> "Accept-Language: ko; q=1.000, en; q=0.999, *; q=0.001"
+ */
+static void add_accept_language(struct strbuf *buf)
+{
+	const char *p1, *p2;
+	float q = 1.000;
+
+	p1 = getenv("LANGUAGE");
+
+	if (p1 != NULL && p1[0] != '\0') {
+		strbuf_reset(buf);
+		strbuf_addstr(buf, "Accept-Language: ");
+		for (p2 = p1; q > 0.001; p2++) {
+			if ((*p2 == ':' || *p2 == '\0') && p1 != p2) {
+				if (q < 1.0) {
+					strbuf_addstr(buf, ", ");
+				}
+				strbuf_add(buf, p1, p2 - p1);
+				strbuf_addf(buf, "; q=%.3f", q);
+				q -= 0.001;
+				p1 = p2 + 1;
+
+				if (*p2 == '\0') {
+					break;
+				}
+			}
+		}
+		if (q < 1.0) {
+			strbuf_addstr(buf, ", ");
+		}
+		strbuf_addstr(buf, "*; q=0.001\r\n");
+	}
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -1020,6 +1061,8 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
+	add_accept_language(&buf);
+
 	strbuf_addstr(&buf, "Pragma:");
 	if (options && options->no_cache)
 		strbuf_addstr(&buf, " no-cache");
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index ac71418..ea15158 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -196,5 +196,15 @@ test_expect_success 'reencoding is robust to whitespace oddities' '
 	grep "this is the error message" stderr
 '
 
+test_expect_success 'git client sends Accept-Language' '
+	GIT_CURL_VERBOSE=1 LANGUAGE=ko:en git clone "$HTTPD_URL/accept/language" 2>actual
+	grep "^Accept-Language: ko; q=1.000, en; q=0.999, \*; q=0.001" actual
+'
+
+test_expect_success 'git client does not send Accept-Language' '
+	GIT_CURL_VERBOSE=1 LANGUAGE= git clone "$HTTPD_URL/accept/language" 2>actual
+	test_must_fail grep "^Accept-Language:" actual
+'
+
 stop_httpd
 test_done
-- 
2.0.1.473.gafdefd9.dirty
