From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v7 1/1] http: Add Accept-Language header if possible
Date: Sun, 18 Jan 2015 21:26:35 +0900
Message-ID: <1421583995-3663-1-git-send-email-eungjun.yi@navercorp.com>
References: <1421583806-3563-1-git-send-email-eungjun.yi@navercorp.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 13:26:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCowP-0000Ru-6b
	for gcvg-git-2@plane.gmane.org; Sun, 18 Jan 2015 13:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbbARM0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 07:26:49 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42587 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbbARM0s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 07:26:48 -0500
Received: by mail-pa0-f49.google.com with SMTP id hz1so2520813pad.8
        for <git@vger.kernel.org>; Sun, 18 Jan 2015 04:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M2TF4D6kR80HmWSgktLLU5V0wJBFHzjNDOMx3h6LPiw=;
        b=GWxOZQ6LVOy2p0l2kZuulDvvEKf9vJWjV8a3sXa0GMbbBVimeMUx34i8ecWRHqk8dl
         Mfrh7/QS8t42+oTUku4fJNpQFvT7niI7/9L+OAOa+LKaCRzBbP/phiGdq8KUjM8AL6Tq
         lBl1vhO7p92YYfreJf9sxczx2tF5wYmKp+UDFTuDSwc9Atw2gvsiv8NNNIQsD8Hss4M1
         gp2pkU2UAMJHQMY+goqNSXy9If/BppRCddXVXUjiHTyAfxaW4kWYrvywx5eTm/0v5FKG
         W7V2Fu9oD/zok9OjhdGgq4+OK7NdHZilqOvSpzEEP/qBsRXDeuowzh+UfCH2Hp9zKDz3
         w70g==
X-Received: by 10.66.184.206 with SMTP id ew14mr35651880pac.3.1421584007659;
        Sun, 18 Jan 2015 04:26:47 -0800 (PST)
Received: from gmail.com ([121.130.252.34])
        by mx.google.com with ESMTPSA id j8sm8899354pdo.79.2015.01.18.04.26.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Jan 2015 04:26:46 -0800 (PST)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.2.0.44.g37b3e56.dirty
In-Reply-To: <1421583806-3563-1-git-send-email-eungjun.yi@navercorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262599>

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
 http.c                     | 152 +++++++++++++++++++++++++++++++++++++++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  42 +++++++++++++
 3 files changed, 196 insertions(+)

diff --git a/http.c b/http.c
index 040f362..349b033 100644
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
@@ -986,6 +993,145 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
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
+	struct strbuf *language_tags = NULL;
+	int num_langs;
+	const char *s = get_preferred_languages();
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
+		/* increase language_tags array to add new language tag */
+		REALLOC_ARRAY(language_tags, num_langs + 1);
+		strbuf_init(&language_tags[num_langs], 0);
+
+		/* collect language tag */
+		for (; *s && (isalnum(*s) || *s == '_'); s++)
+			strbuf_addch(&language_tags[num_langs], *s == '_' ? '-' : *s);
+
+		/* skip .codeset, @modifier and any other unnecessary parts */
+		while (*s && *s != ':')
+			s++;
+
+		if (language_tags[num_langs].len > 0) {
+			num_langs++;
+			if (num_langs >= MAX_LANGUAGE_TAGS - 1) /* -1 for '*' */
+				break;
+		}
+	} while (*s++);
+
+	/* write Accept-Language header into buf */
+	if (num_langs >= 1) {
+		int i;
+		int last_buf_len;
+		int max_q;
+		int decimal_places;
+		char q_format[32];
+
+		/* add '*' */
+		REALLOC_ARRAY(language_tags, num_langs + 1);
+		strbuf_init(&language_tags[num_langs], 0);
+		strbuf_addstr(&language_tags[num_langs++], "*");
+
+		/* compute decimal_places */
+		for (max_q = 1, decimal_places = 0;
+				max_q < num_langs && decimal_places <= MAX_DECIMAL_PLACES;
+				decimal_places++, max_q *= 10)
+			;
+
+		sprintf(q_format, ";q=0.%%0%dd", decimal_places);
+
+		strbuf_addstr(buf, "Accept-Language: ");
+
+		for(i = 0; i < num_langs; i++) {
+			if (language_tags[i].len == 0)
+				continue;
+
+			if (i > 0)
+				strbuf_addstr(buf, ", ");
+
+			strbuf_addstr(buf, strbuf_detach(&language_tags[i], NULL));
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
+	free(language_tags);
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
+	}
+
+	return cached_accept_language;
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -998,6 +1144,7 @@ static int http_request(const char *url,
 	struct slot_results results;
 	struct curl_slist *headers = NULL;
 	struct strbuf buf = STRBUF_INIT;
+	const char *accept_language;
 	int ret;
 
 	slot = get_active_slot();
@@ -1023,6 +1170,11 @@ static int http_request(const char *url,
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
2.2.0.44.g37b3e56.dirty
