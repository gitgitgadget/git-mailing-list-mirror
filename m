From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Wed, 28 Jan 2015 21:04:37 +0900
Message-ID: <1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
 <1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 02:07:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGdZk-0005st-Tm
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 02:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbbA2BHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 20:07:10 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:45586 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbA2BHE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:07:04 -0500
Received: by mail-pa0-f43.google.com with SMTP id eu11so31986927pac.2
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 17:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ucW6jD26w/J/KHc7fJcxPaHodh+W3EMBjdlIeLcsdhM=;
        b=ZGpIVOM4pER3bGmQ1tE1AKJqmJLvFdzmS7sjDof/To8A/uj/tWpP5tYARkmBaLIZRY
         6H4yBXsqh0svPJvijPMnaMRs8V8XPmynewV5AGrgStV0PD4v9EsBPAWjsk884rSoPpLw
         qZAg4NLSXOZgX13hwb2F12BGGPJsXTEd7Rrqnm1n1oWQW3GYB4RPKeJUikJaklCqmepz
         h9g7lqi0JTtWWZw818KReSQnve7mfqFnBm/Cz+Z/JnxGsZO1KuaJ87CCpIlT+BLrdxQQ
         SQauH06DHPJMZgohW968v5Q8vZb1Y2YyFpQi4nqy5lPqOVUVd87Ira3HDg7yBFbnbdLI
         fprQ==
X-Received: by 10.66.123.7 with SMTP id lw7mr5168817pab.103.1422446709428;
        Wed, 28 Jan 2015 04:05:09 -0800 (PST)
Received: from gmail.com ([111.91.137.67])
        by mx.google.com with ESMTPSA id fr11sm4614680pad.1.2015.01.28.04.05.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Jan 2015 04:05:08 -0800 (PST)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.3.0.rc1.32.g7a36c04
In-Reply-To: <1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263122>

From: Yi EungJun <eungjun.yi@navercorp.com>

Add an Accept-Language header which indicates the user's preferred
languages defined by $LANGUAGE, $LC_ALL, $LC_MESSAGES and $LANG.

Examples:
  LANGUAGE= -> ""
  LANGUAGE=ko:en -> "Accept-Language: ko, en;q=0.9, *;q=0.1"
  LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *;q=0.1"
  LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *;q=0.1"

This gives git servers a chance to display remote error messages in
the user's preferred language.

Limit the number of languages to 1,000 because q-value must not be
smaller than 0.001, and limit the length of Accept-Language header to
4,000 bytes for some HTTP servers which cannot accept such long header.

Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
---
 http.c                     | 147 +++++++++++++++++++++++++++++++++++++++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  42 +++++++++++++
 3 files changed, 191 insertions(+)

diff --git a/http.c b/http.c
index 040f362..b2ad2a8 100644
--- a/http.c
+++ b/http.c
@@ -68,6 +68,8 @@ static struct curl_slist *no_pragma_header;
 
 static struct active_request_slot *active_queue_head;
 
+static char *cached_accept_language;
+
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -515,6 +517,9 @@ void http_cleanup(void)
 		cert_auth.password = NULL;
 	}
 	ssl_cert_password_required = 0;
+
+	free(cached_accept_language);
+	cached_accept_language = NULL;
 }
 
 struct active_request_slot *get_active_slot(void)
@@ -986,6 +991,142 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
 		strbuf_addstr(charset, "ISO-8859-1");
 }
 
+/*
+ * Guess the user's preferred languages from the value in LANGUAGE environment
+ * variable and LC_MESSAGES locale category if NO_GETTEXT is not defined.
+ *
+ * The result can be a colon-separated list like "ko:ja:en".
+ */
+static const char *get_preferred_languages(void)
+{
+	const char *retval;
+
+	retval = getenv("LANGUAGE");
+	if (retval && *retval)
+		return retval;
+
+#ifndef NO_GETTEXT
+	retval = setlocale(LC_MESSAGES, NULL);
+	if (retval && *retval &&
+		strcmp(retval, "C") &&
+		strcmp(retval, "POSIX"))
+		return retval;
+#endif
+
+	return NULL;
+}
+
+static void write_accept_language(struct strbuf *buf)
+{
+	/*
+	 * MAX_DECIMAL_PLACES must not be larger than 3. If it is larger than
+	 * that, q-value will be smaller than 0.001, the minimum q-value the
+	 * HTTP specification allows. See
+	 * http://tools.ietf.org/html/rfc7231#section-5.3.1 for q-value.
+	 */
+	const int MAX_DECIMAL_PLACES = 3;
+	const int MAX_LANGUAGE_TAGS = 1000;
+	const int MAX_ACCEPT_LANGUAGE_HEADER_SIZE = 4000;
+	char **language_tags = NULL;
+	int num_langs = 0;
+	const char *s = get_preferred_languages();
+	int i;
+	struct strbuf tag = STRBUF_INIT;
+
+	/* Don't add Accept-Language header if no language is preferred. */
+	if (!s)
+		return;
+
+	/*
+	 * Split the colon-separated string of preferred languages into
+	 * language_tags array.
+	 */
+	do {
+		/* collect language tag */
+		for (; *s && (isalnum(*s) || *s == '_'); s++)
+			strbuf_addch(&tag, *s == '_' ? '-' : *s);
+
+		/* skip .codeset, @modifier and any other unnecessary parts */
+		while (*s && *s != ':')
+			s++;
+
+		if (tag.len) {
+			num_langs++;
+			REALLOC_ARRAY(language_tags, num_langs);
+			language_tags[num_langs - 1] = strbuf_detach(&tag, NULL);
+			if (num_langs >= MAX_LANGUAGE_TAGS - 1) /* -1 for '*' */
+				break;
+		}
+	} while (*s++);
+
+	/* write Accept-Language header into buf */
+	if (num_langs) {
+		int last_buf_len = 0;
+		int max_q;
+		int decimal_places;
+		char q_format[32];
+
+		/* add '*' */
+		REALLOC_ARRAY(language_tags, num_langs + 1);
+		language_tags[num_langs++] = "*"; /* it's OK; this won't be freed */
+
+		/* compute decimal_places */
+		for (max_q = 1, decimal_places = 0;
+		     max_q < num_langs && decimal_places <= MAX_DECIMAL_PLACES;
+		     decimal_places++, max_q *= 10)
+			;
+
+		sprintf(q_format, ";q=0.%%0%dd", decimal_places);
+
+		strbuf_addstr(buf, "Accept-Language: ");
+
+		for(i = 0; i < num_langs; i++) {
+			if (i > 0)
+				strbuf_addstr(buf, ", ");
+
+			strbuf_addstr(buf, language_tags[i]);
+
+			if (i > 0)
+				strbuf_addf(buf, q_format, max_q - i);
+
+			if (buf->len > MAX_ACCEPT_LANGUAGE_HEADER_SIZE) {
+				strbuf_remove(buf, last_buf_len, buf->len - last_buf_len);
+				break;
+			}
+
+			last_buf_len = buf->len;
+		}
+	}
+
+	/* free language tags -- last one is a static '*' */
+	for(i = 0; i < num_langs - 1; i++)
+		free(language_tags[i]);
+	free(language_tags);
+}
+
+/*
+ * Get an Accept-Language header which indicates user's preferred languages.
+ *
+ * Examples:
+ *   LANGUAGE= -> ""
+ *   LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
+ *   LANGUAGE=ko_KR.UTF-8:sr@latin -> "Accept-Language: ko-KR, sr; q=0.9, *; q=0.1"
+ *   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
+ *   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
+ *   LANGUAGE= LANG=C -> ""
+ */
+static const char *get_accept_language(void)
+{
+	if (!cached_accept_language) {
+		struct strbuf buf = STRBUF_INIT;
+		write_accept_language(&buf);
+		if (buf.len > 0)
+			cached_accept_language = strbuf_detach(&buf, NULL);
+	}
+
+	return cached_accept_language;
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -998,6 +1139,7 @@ static int http_request(const char *url,
 	struct slot_results results;
 	struct curl_slist *headers = NULL;
 	struct strbuf buf = STRBUF_INIT;
+	const char *accept_language;
 	int ret;
 
 	slot = get_active_slot();
@@ -1023,6 +1165,11 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
+	accept_language = get_accept_language();
+
+	if (accept_language)
+		headers = curl_slist_append(headers, accept_language);
+
 	strbuf_addstr(&buf, "Pragma:");
 	if (options && options->no_cache)
 		strbuf_addstr(&buf, " no-cache");
diff --git a/remote-curl.c b/remote-curl.c
index dd63bc2..04989e5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -962,6 +962,8 @@ int main(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 	int nongit;
 
+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index ac71418..e1e2938 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -196,5 +196,47 @@ test_expect_success 'reencoding is robust to whitespace oddities' '
 	grep "this is the error message" stderr
 '
 
+check_language () {
+	case "$2" in
+	'')
+		>expect
+		;;
+	?*)
+		echo "Accept-Language: $1" >expect
+		;;
+	esac &&
+	GIT_CURL_VERBOSE=1 \
+	LANGUAGE=$2 \
+	git ls-remote "$HTTPD_URL/dumb/repo.git" >output 2>&1 &&
+	tr -d '\015' <output |
+	sort -u |
+	sed -ne '/^Accept-Language:/ p' >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'git client sends Accept-Language based on LANGUAGE' '
+	check_language "ko-KR, *;q=0.9" ko_KR.UTF-8'
+
+test_expect_success 'git client sends Accept-Language correctly with unordinary LANGUAGE' '
+	check_language "ko-KR, *;q=0.9" "ko_KR:" &&
+	check_language "ko-KR, en-US;q=0.9, *;q=0.8" "ko_KR::en_US" &&
+	check_language "ko-KR, *;q=0.9" ":::ko_KR" &&
+	check_language "ko-KR, en-US;q=0.9, *;q=0.8" "ko_KR!!:en_US" &&
+	check_language "ko-KR, ja-JP;q=0.9, *;q=0.8" "ko_KR en_US:ja_JP"'
+
+test_expect_success 'git client sends Accept-Language with many preferred languages' '
+	check_language "ko-KR, en-US;q=0.9, fr-CA;q=0.8, de;q=0.7, sr;q=0.6, \
+ja;q=0.5, zh;q=0.4, sv;q=0.3, pt;q=0.2, *;q=0.1" \
+		ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt &&
+	check_language "ko-KR, en-US;q=0.99, fr-CA;q=0.98, de;q=0.97, sr;q=0.96, \
+ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.90" \
+		ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt:nb
+'
+
+test_expect_success 'git client does not send an empty Accept-Language' '
+	GIT_CURL_VERBOSE=1 LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
+	! grep "^Accept-Language:" stderr
+'
+
 stop_httpd
 test_done
-- 
2.3.0.rc1.32.g7a36c04
