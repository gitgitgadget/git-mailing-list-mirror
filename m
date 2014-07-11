From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v2] http: Add Accept-Language header if possible
Date: Fri, 11 Jul 2014 18:46:29 +0900
Message-ID: <1405071989-7682-1-git-send-email-eungjun.yi@navercorp.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 11:48:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5XRY-0007m9-VO
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 11:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbaGKJsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 05:48:37 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36749 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbaGKJsg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 05:48:36 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so1186797pab.32
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=03mdub87R7UC207KFz6sHTVEymhBR2FkSVg6hVP303c=;
        b=c6U5uQA4Rn7YHMM41BRQtUD8qyolTKU/ULuvFOxlYTiYwz2aE33TsKw2M3HFqsx1DD
         sKM+39nS2DtrKHRqSjF9f4G9xLX4V4JvqcBuPDensmGW2cXXjUZBhaJUqZIhqD9jKQi+
         bqpS0RB8Yod6DJZIDMfgvd+yzCC8k5KWSEp95AykwNl3CTaW8MpRqv0I9b9bMiIJyJyi
         mKSzc7+SaoalAKmKY0Uo2E+piewXZYGLrN7gqfiKd5j4QfxXSLSOlYdQZdjXyq7P/VPv
         yeRsJSU5EXTKsm2upPHAuyNovLJlMoG3qbmYC4gqNMvO/PWWkps49xu2hDnvgdL6RyID
         uT2g==
X-Received: by 10.70.0.48 with SMTP id 16mr23113293pdb.8.1405072111792;
        Fri, 11 Jul 2014 02:48:31 -0700 (PDT)
Received: from gmail.com ([111.91.137.67])
        by mx.google.com with ESMTPSA id qn13sm2343820pdb.69.2014.07.11.02.48.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jul 2014 02:48:31 -0700 (PDT)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.0.1.473.g4b69a73.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253268>

From: Yi EungJun <eungjun.yi@navercorp.com>

Add an Accept-Language header which indicates the user's preferred
languages defined by $LANGUAGE, $LC_ALL, $LC_MESSAGES and $LANG.

Examples:
  LANGUAGE= -> ""
  LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
  LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
  LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"

This gives git servers a chance to display remote error messages in
the user's preferred language.

Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
---
 http.c                     | 125 +++++++++++++++++++++++++++++++++++++++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  21 ++++++++
 3 files changed, 148 insertions(+)

diff --git a/http.c b/http.c
index 3a28b21..a20f3e2 100644
--- a/http.c
+++ b/http.c
@@ -983,6 +983,129 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
 		strbuf_addstr(charset, "ISO-8859-1");
 }
 
+/*
+ * Guess the user's preferred languages from the value in LANGUAGE environment
+ * variable and LC_MESSAGES locale category.
+ *
+ * The result can be a colon-separated list like "ko:ja:en".
+ */
+static const char* get_preferred_languages() {
+    const char* retval;
+
+	retval = getenv("LANGUAGE");
+	if (retval != NULL && retval[0] != '\0')
+		return retval;
+
+	retval = setlocale(LC_MESSAGES, NULL);
+	if (retval != NULL && retval[0] != '\0'
+		&& strcmp(retval, "C") != 0
+		&& strcmp(retval, "POSIX") != 0)
+		return retval;
+
+	return NULL;
+}
+
+/*
+ * Add an Accept-Language header which indicates user's preferred languages.
+ *
+ * Examples:
+ *   LANGUAGE= -> ""
+ *   LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
+ *   LANGUAGE=ko_KR.UTF-8:sr@latin -> "Accept-Language: ko-KR, sr; q=0.9, *; q=0.1"
+ *   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
+ *   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
+ *   LANGUAGE= LANG=C -> ""
+ */
+static struct curl_slist* add_accept_language(struct curl_slist *headers)
+{
+	const char *p1, *p2, *p3;
+	struct strbuf buf = STRBUF_INIT;
+	float q = 1.0;
+	float q_precision = 0.1;
+	int num_langs = 1;
+	char* q_format = "; q=%.1f";
+
+	p1 = get_preferred_languages();
+
+	/* Don't add Accept-Language header if no language is preferred. */
+	if (p1 == NULL || p1[0] == '\0') {
+		strbuf_release(&buf);
+		return headers;
+	}
+
+	/* Count number of preferred languages to decide precision of q-factor */
+	for (p3 = p1; *p3 != '\0'; p3++) {
+		if (*p3 == ':') {
+			num_langs++;
+		}
+	}
+
+	/* Decide the precision for q-factor on number of preferred languages. */
+	if (num_langs + 1 > 100) { /* +1 is for '*' */
+		q_precision = 0.001;
+		q_format = "; q=%.3f";
+	} else if (num_langs + 1 > 10) { /* +1 is for '*' */
+		q_precision = 0.01;
+		q_format = "; q=%.2f";
+	}
+
+	strbuf_addstr(&buf, "Accept-Language: ");
+
+	for (p2 = p1; q > q_precision; p2++) {
+		if ((*p2 == ':' || *p2 == '\0') && p1 != p2) {
+			if (q < 1.0) {
+				strbuf_addstr(&buf, ", ");
+			}
+
+			for (p3 = p1; p3 < p2; p3++) {
+				/* Replace '_' with '-'. */
+				if (*p3 == '_') {
+					strbuf_add(&buf, p1, p3 - p1);
+					strbuf_addstr(&buf, "-");
+					p1 = p3 + 1;
+				}
+
+				/* Chop off anything after '.' or '@'. */
+				if ((*p3 == '.' || *p3 == '@')) {
+					break;
+				}
+			}
+
+			if (p3 > p1) {
+				strbuf_add(&buf, p1, p3 - p1);
+			}
+
+			/* Put the q factor if only it is less than 1.0. */
+			if (q < 1.0) {
+				strbuf_addf(&buf, q_format, q);
+			}
+
+			q -= q_precision;
+			p1 = p2 + 1;
+
+			if (*p2 == '\0') {
+				break;
+			}
+		}
+	}
+
+	/* Don't add Accept-Language header if no language is preferred. */
+	if (q >= 1.0) {
+		strbuf_release(&buf);
+		return headers;
+	}
+
+	/* Add '*' with minimum q-factor greater than 0.0. */
+	strbuf_addstr(&buf, ", *");
+	strbuf_addf(&buf, q_format, q_precision);
+
+	headers = curl_slist_append(headers, buf.buf);
+
+	strbuf_release(&buf);
+
+	return headers;
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -1020,6 +1143,8 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
+	headers = add_accept_language(headers);
+
 	strbuf_addstr(&buf, "Pragma:");
 	if (options && options->no_cache)
 		strbuf_addstr(&buf, " no-cache");
diff --git a/remote-curl.c b/remote-curl.c
index 4493b38..07f2a5d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -946,6 +946,8 @@ int main(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 	int nongit;
 
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index ac71418..687baf9 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -196,5 +196,26 @@ test_expect_success 'reencoding is robust to whitespace oddities' '
 	grep "this is the error message" stderr
 '
 
+test_expect_success 'git client sends Accept-Language based on LANGUAGE, LC_ALL, LC_MESSAGES and LANG' '
+	test_must_fail env GIT_CURL_VERBOSE=1 LANGUAGE=ko_KR.UTF-8 LC_ALL=de_DE.UTF-8 LC_MESSAGES=ja_JP.UTF-8 LANG=en_US.UTF-8 git clone "$HTTPD_URL/accept/language" 2>stderr &&
+	grep "^Accept-Language: ko-KR, \*; q=0.1" stderr &&
+	test_must_fail env GIT_CURL_VERBOSE=1 LANGUAGE= LC_ALL=de_DE.UTF-8 LC_MESSAGES=ja_JP.UTF-8 LANG=en_US.UTF-8 git clone "$HTTPD_URL/accept/language" 2>stderr &&
+	grep "^Accept-Language: de-DE, \*; q=0.1" stderr &&
+	test_must_fail env GIT_CURL_VERBOSE=1 LANGUAGE= LC_ALL= LC_MESSAGES=ja_JP.UTF-8 LANG=en_US.UTF-8 git clone "$HTTPD_URL/accept/language" 2>stderr &&
+	grep "^Accept-Language: ja-JP, \*; q=0.1" stderr &&
+	test_must_fail env GIT_CURL_VERBOSE=1 LANGUAGE= LC_ALL= LC_MESSAGES= LANG=en_US.UTF-8 git clone "$HTTPD_URL/accept/language" 2>stderr &&
+	grep "^Accept-Language: en-US, \*; q=0.1" stderr
+'
+
+test_expect_success 'git client sends Accept-Language with many preferred languages' '
+	test_must_fail env GIT_CURL_VERBOSE=1 LANGUAGE=ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt:nb git clone "$HTTPD_URL/accept/language" 2>stderr &&
+	grep "^Accept-Language: ko-KR, en-US; q=0.99, fr-CA; q=0.98, de; q=0.97, sr; q=0.96, ja; q=0.95, zh; q=0.94, sv; q=0.93, pt; q=0.92, nb; q=0.91, \*; q=0.01" stderr
+'
+
+test_expect_success 'git client does not send Accept-Language' '
+	test_must_fail env GIT_CURL_VERBOSE=1 LANGUAGE= git clone "$HTTPD_URL/accept/language" 2>stderr &&
+	! grep "^Accept-Language:" stderr
+'
+
 stop_httpd
 test_done
-- 
2.0.1.473.g4b69a73.dirty
