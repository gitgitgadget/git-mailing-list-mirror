From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v6 1/1] http: Add Accept-Language header if possible
Date: Tue, 23 Dec 2014 01:44:18 +0900
Message-ID: <1419266658-1180-2-git-send-email-eungjun.yi@navercorp.com>
References: <CAO2U3QjG2rUgUrM5odX0UOnHsENnYTfwaRLhHv8gka7qj4XWdw@mail.gmail.com>
 <1419266658-1180-1-git-send-email-eungjun.yi@navercorp.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 17:44:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3664-0003Jg-0B
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 17:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbaLVQog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 11:44:36 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:47430 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868AbaLVQoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 11:44:34 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so6168186pde.29
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 08:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o/Pkfu/UOYK23IhL6ZNK24kiQG+lChg5pvuKyD8g+6Y=;
        b=qOR//XmTmE1Khd/oHcDSDbjDxjZOVMPk0r9zJvU4JuU222xVoiOIaIhJT8UDm9RKDL
         ERNdZlyc0HFAoiV/9tBFKEavoXeV3njJ2FptEUsfxE5s/icpoAIdEH2yQw4h7X1lI/GT
         PLxnAa8fQgYcpRbfbU97/250n8JMolClw1PB9kztAOMeu5fONn/ZUxzYPawBcK6ok5Oe
         i5Ofuap8Ta+opZXEgHgV7Xi7JE2Eux47MZJTLaWTcC5xh7IivbR49bUUg0X2TRQj6Mp+
         cqbUp9c6H6jecABpdq/FW/tMchjOXj3xGyWGQ79hskYTLEEubpPk4T4HVjhgozuJohBe
         L5gw==
X-Received: by 10.66.147.102 with SMTP id tj6mr36175872pab.95.1419266674154;
        Mon, 22 Dec 2014 08:44:34 -0800 (PST)
Received: from gmail.com ([222.234.94.10])
        by mx.google.com with ESMTPSA id bx13sm17732247pdb.19.2014.12.22.08.44.31
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Dec 2014 08:44:33 -0800 (PST)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.2.0.375.gcd18ce6.dirty
In-Reply-To: <1419266658-1180-1-git-send-email-eungjun.yi@navercorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261649>

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
 http.c                     | 173 +++++++++++++++++++++++++++++++++++++++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  32 +++++++++
 3 files changed, 207 insertions(+)

diff --git a/http.c b/http.c
index 040f362..7a77708 100644
--- a/http.c
+++ b/http.c
@@ -68,6 +68,8 @@ static struct curl_slist *no_pragma_header;
 
 static struct active_request_slot *active_queue_head;
 
+static char *cached_accept_language;
+
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -515,6 +517,11 @@ void http_cleanup(void)
 		cert_auth.password = NULL;
 	}
 	ssl_cert_password_required = 0;
+
+	if (cached_accept_language) {
+		free(cached_accept_language);
+		cached_accept_language = NULL;
+	}
 }
 
 struct active_request_slot *get_active_slot(void)
@@ -986,6 +993,166 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
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
+	const char *lang_begin, *pos;
+	int q, max_q;
+	int num_langs;
+	int decimal_places;
+	const int CODESET_OR_MODIFIER = 1;
+	const int LANGUAGE_TAG = 2;
+	const int SEPARATOR = 3;
+	int is_q_factor_required = 0;
+	int parse_state = 0;
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
+	const int MAX_SIZE_OF_ASTERISK_ELEMENT = 11; /* for ", *;q=0.001" */
+	int last_size = 0;
+
+	lang_begin = get_preferred_languages();
+
+	/* Don't add Accept-Language header if no language is preferred. */
+	if (!lang_begin)
+		return;
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
+		decimal_places++, max_q *= 10)
+		;
+
+	sprintf(q_format, ";q=0.%%0%dd", decimal_places);
+
+	q = max_q;
+
+	strbuf_addstr(buf, "Accept-Language: ");
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
+		if (!*pos || *pos == ':') {
+			if (is_q_factor_required) {
+				/* Put a q-factor only if it is less than 1.0. */
+				if (q < max_q)
+					strbuf_addf(buf, q_format, q);
+
+				if (q > 1)
+					q--;
+
+				last_size = buf->len;
+
+				is_q_factor_required = 0;
+			}
+			parse_state = SEPARATOR;
+		} else if (parse_state == CODESET_OR_MODIFIER)
+			continue;
+		else if (*pos == ' ') /* Ignore whitespace character */
+			continue;
+		else if (*pos == '.' || *pos == '@') /* Remove .codeset and @modifier. */
+			parse_state = CODESET_OR_MODIFIER;
+		else {
+			if (parse_state != LANGUAGE_TAG && q < max_q)
+				strbuf_addstr(buf, ", ");
+			strbuf_addch(buf, *pos == '_' ? '-' : *pos);
+			is_q_factor_required = 1;
+			parse_state = LANGUAGE_TAG;
+		}
+
+		if (buf->len > MAX_SIZE_OF_HEADER - MAX_SIZE_OF_ASTERISK_ELEMENT) {
+			strbuf_remove(buf, last_size, buf->len - last_size);
+			break;
+		}
+
+		if (!*pos)
+			break;
+	}
+
+	/* Don't add Accept-Language header if no language is preferred. */
+	if (q >= max_q) {
+		strbuf_reset(buf);
+		return;
+	}
+
+	/* Add '*' with minimum q-factor greater than 0.0. */
+	strbuf_addstr(buf, ", *");
+	strbuf_addf(buf, q_format, 1);
+}
+
+/*
+ * Get an Accept-Language header which indicates user's preferred languages.
+ *
+ * This function always return non-NULL string as strbuf_detach() does.
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
+		cached_accept_language = strbuf_detach(&buf, NULL);
+		strbuf_release(&buf);
+	}
+
+	return cached_accept_language;
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -998,6 +1165,7 @@ static int http_request(const char *url,
 	struct slot_results results;
 	struct curl_slist *headers = NULL;
 	struct strbuf buf = STRBUF_INIT;
+	const char *accept_language;
 	int ret;
 
 	slot = get_active_slot();
@@ -1023,6 +1191,11 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
+	accept_language = get_accept_language();
+
+	if (strlen(accept_language) > 0)
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
index ac71418..1a58b97 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -196,5 +196,37 @@ test_expect_success 'reencoding is robust to whitespace oddities' '
 	grep "this is the error message" stderr
 '
 
+check_language () {
+	echo "Accept-Language: $1" >expect &&
+	GIT_CURL_VERBOSE=1 \
+	LANGUAGE=$2 \
+	git ls-remote "$HTTPD_URL/dumb/repo.git" 2>&1 |
+	tr -d '\015' |
+	sort -u >stderr &&
+	grep -i ^Accept-Language: stderr >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'git client sends Accept-Language based on LANGUAGE' '
+	check_language "ko-KR, *;q=0.1" ko_KR.UTF-8'
+
+test_expect_success 'git client sends Accept-Language correctly with unordinary LANGUAGE' '
+	check_language "ko-KR, *;q=0.1" "ko_KR:" &&
+	check_language "ko-KR, *;q=0.1" " ko_KR" &&
+	check_language "ko-KR, en-US;q=0.9, *;q=0.1" "ko_KR: en_US" &&
+	check_language "ko-KR, en-US;q=0.9, *;q=0.1" "ko_KR::en_US" &&
+	check_language "ko-KR, *;q=0.1" ":::ko_KR"'
+
+test_expect_success 'git client sends Accept-Language with many preferred languages' '
+	check_language "ko-KR, en-US;q=0.99, fr-CA;q=0.98, de;q=0.97, sr;q=0.96, \
+ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.01" \
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
2.2.0.375.gcd18ce6.dirty
