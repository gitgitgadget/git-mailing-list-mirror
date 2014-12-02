From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v5 1/1] http: Add Accept-Language header if possible
Date: Tue,  2 Dec 2014 21:12:36 +0900
Message-ID: <1417522356-24212-2-git-send-email-eungjun.yi@navercorp.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
 <1417522356-24212-1-git-send-email-eungjun.yi@navercorp.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 13:13:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvmKG-0004A3-1F
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 13:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933097AbaLBMM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 07:12:59 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:65082 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932837AbaLBMM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 07:12:58 -0500
Received: by mail-pd0-f180.google.com with SMTP id p10so13122552pdj.39
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 04:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UN4ieHbKo7V3k/U8reFCguhAW74EYVDCak9u71grp2Y=;
        b=MyKQ3U+NkbVUmf4Lf3fbj9ys3Suph+0fRkg3BYKYuW56Q7BZ2SKKQ3ix7kbYdmpIhC
         ecUoX8W8kdo8kG03gVHvp6KgZ8KQEQZ3jvxEw9/wbW/SZEyj8c6DMallG9/luiLbyDb+
         2RbRJE9/caowAD2gF2tmvfEH3Ju7MmfKvLattXsbad7sbOEGzQSvQNaqapvBwxD+gDcz
         aDzZvW78+Q9UQVwBwxRdJ7HqzklJ7uvH0ecpjJZzW5Ur4YtpGXHhBViz5JMETxf3tezA
         sCxGmTpgXAVsnIbs9q5xvEE8Fu1VO0VnubkwJ21AmVdf1hSNbH/LTTBIr4pfSIrE4ZVR
         CKKQ==
X-Received: by 10.70.100.170 with SMTP id ez10mr108864875pdb.73.1417522378054;
        Tue, 02 Dec 2014 04:12:58 -0800 (PST)
Received: from gmail.com ([111.91.137.66])
        by mx.google.com with ESMTPSA id f12sm17905394pat.43.2014.12.02.04.12.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Dec 2014 04:12:57 -0800 (PST)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417522356-24212-1-git-send-email-eungjun.yi@navercorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260560>

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
 http.c                     | 154 +++++++++++++++++++++++++++++++++++++++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  31 +++++++++
 3 files changed, 187 insertions(+)

diff --git a/http.c b/http.c
index 040f362..69624af 100644
--- a/http.c
+++ b/http.c
@@ -68,6 +68,8 @@ static struct curl_slist *no_pragma_header;
 
 static struct active_request_slot *active_queue_head;
 
+static struct strbuf *cached_accept_language;
+
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -515,6 +517,9 @@ void http_cleanup(void)
 		cert_auth.password = NULL;
 	}
 	ssl_cert_password_required = 0;
+
+	if (cached_accept_language)
+		strbuf_release(cached_accept_language);
 }
 
 struct active_request_slot *get_active_slot(void)
@@ -986,6 +991,149 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
 		strbuf_addstr(charset, "ISO-8859-1");
 }
 
+/*
+ * Guess the user's preferred languages from the value in LANGUAGE environment
+ * variable and LC_MESSAGES locale category.
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
+	retval = setlocale(LC_MESSAGES, NULL);
+	if (retval && *retval &&
+		strcmp(retval, "C") &&
+		strcmp(retval, "POSIX"))
+		return retval;
+
+	return NULL;
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
+static struct strbuf *get_accept_language(void)
+{
+	const char *lang_begin, *pos;
+	int q, max_q;
+	int num_langs;
+	int decimal_places;
+	int is_codeset_or_modifier = 0;
+	char q_format[32];
+	/*
+	 * MAX_LANGS must not be larger than 1,000. If it is larger than that,
+	 * q-value will be smaller than 0.001, the minimum q-value the HTTP
+	 * specification allows [1].
+	 *
+	 * [1]: http://tools.ietf.org/html/rfc7231#section-5.3.1
+	 */
+	const int MAX_LANGS = 1000;
+	const int MAX_SIZE_OF_HEADER = 4000;
+	int last_size = 0;
+
+	if (cached_accept_language)
+		return cached_accept_language;
+
+	cached_accept_language = xmalloc(sizeof(struct strbuf));
+	strbuf_init(cached_accept_language, 0);
+	lang_begin = get_preferred_languages();
+
+	/* Don't add Accept-Language header if no language is preferred. */
+	if (!lang_begin)
+		return cached_accept_language;
+
+	/* Count number of preferred lang_begin to decide precision of q-factor. */
+	for (num_langs = 1, pos = lang_begin; *pos; pos++)
+		if (*pos == ':')
+			num_langs++;
+
+	/* Decide the precision for q-factor on number of preferred lang_begin. */
+	num_langs += 1; /* for '*' */
+
+	if (MAX_LANGS < num_langs)
+		num_langs = MAX_LANGS;
+
+	for (max_q = 1, decimal_places = 0;
+		max_q < num_langs;
+		decimal_places++, max_q *= 10);
+
+	sprintf(q_format, ";q=0.%%0%dd", decimal_places);
+
+	q = max_q;
+
+	strbuf_addstr(cached_accept_language, "Accept-Language: ");
+
+	/*
+	 * Convert a list of colon-separated locale values [1][2] to a list of
+	 * comma-separated language tags [3] which can be used as a value of
+	 * Accept-Language header.
+	 *
+	 * [1]: http://pubs.opengroup.org/onlinepubs/007908799/xbd/envvar.html
+	 * [2]: http://www.gnu.org/software/libc/manual/html_node/Using-gettextized-software.html
+	 * [3]: http://tools.ietf.org/html/rfc7231#section-5.3.5
+	 */
+	for (pos = lang_begin; ; pos++) {
+		if (*pos == ':' || !*pos) {
+			/* Ignore if this character is the first one. */
+			if (pos == lang_begin)
+				continue;
+
+			is_codeset_or_modifier = 0;
+
+			/* Put a q-factor only if it is less than 1.0. */
+			if (q < max_q)
+				strbuf_addf(cached_accept_language, q_format, q);
+
+			if (q > 1)
+				q--;
+
+			last_size = cached_accept_language->len;
+
+			/* NULL pos means this is the last language. */
+			if (*pos)
+				strbuf_addstr(cached_accept_language, ", ");
+			else
+				break;
+
+		} else if (is_codeset_or_modifier)
+			continue;
+		else if (*pos == '.' || *pos == '@') /* Remove .codeset and @modifier. */
+			is_codeset_or_modifier = 1;
+		else
+			strbuf_addch(cached_accept_language, *pos == '_' ? '-' : *pos);
+
+		if (cached_accept_language->len > MAX_SIZE_OF_HEADER) {
+			strbuf_remove(cached_accept_language, last_size,
+					cached_accept_language->len - last_size);
+			break;
+		}
+	}
+
+	/* Don't add Accept-Language header if no language is preferred. */
+	if (q >= max_q) {
+		return cached_accept_language;
+	}
+
+	/* Add '*' with minimum q-factor greater than 0.0. */
+	strbuf_addstr(cached_accept_language, ", *");
+	strbuf_addf(cached_accept_language, q_format, 1);
+
+	return cached_accept_language;
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -998,6 +1146,7 @@ static int http_request(const char *url,
 	struct slot_results results;
 	struct curl_slist *headers = NULL;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf *accept_language;
 	int ret;
 
 	slot = get_active_slot();
@@ -1023,6 +1172,11 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
+	accept_language = get_accept_language();
+
+	if (accept_language && accept_language->len > 0)
+		headers = curl_slist_append(headers, accept_language->buf);
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
index ac71418..197c361 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -196,5 +196,36 @@ test_expect_success 'reencoding is robust to whitespace oddities' '
 	grep "this is the error message" stderr
 '
 
+check_language () {
+	echo "Accept-Language: $1\r" >expect &&
+	test_must_fail env \
+		GIT_CURL_VERBOSE=1 \
+		LANGUAGE=$2 \
+		LC_ALL=$3 \
+		LC_MESSAGES=$4 \
+		LANG=$5 \
+		git clone "$HTTPD_URL/accept/language" 2>stderr &&
+	grep -i ^Accept-Language: stderr >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'git client sends Accept-Language based on LANGUAGE, LC_ALL, LC_MESSAGES and LANG' '
+	check_language "ko-KR, *;q=0.1" ko_KR.UTF-8 de_DE.UTF-8 ja_JP.UTF-8 en_US.UTF-8 &&
+	check_language "de-DE, *;q=0.1" ""          de_DE.UTF-8 ja_JP.UTF-8 en_US.UTF-8 &&
+	check_language "ja-JP, *;q=0.1" ""          ""          ja_JP.UTF-8 en_US.UTF-8 &&
+	check_language "en-US, *;q=0.1" ""          ""          ""          en_US.UTF-8
+'
+
+test_expect_success 'git client sends Accept-Language with many preferred languages' '
+	check_language "ko-KR, en-US;q=0.99, fr-CA;q=0.98, de;q=0.97, sr;q=0.96, \
+ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.01" \
+		ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt:nb
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
2.2.0
