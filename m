From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v4 1/1] http: Add Accept-Language header if possible
Date: Sun, 20 Jul 2014 02:58:50 +0900
Message-ID: <1405792730-13539-2-git-send-email-eungjun.yi@navercorp.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 19 20:01:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8YwP-0007hm-Fz
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 20:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbaGSSA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 14:00:56 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:38570 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbaGSSAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 14:00:55 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so6836300pde.9
        for <git@vger.kernel.org>; Sat, 19 Jul 2014 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xGlpqmE+7FXyPpEvpNwnOi/8rXFlJVdWiAQRkANgnWI=;
        b=wE08UP2GaCDhpUpR1+Tesx3ODX3tEDQGyUrEKDrmnNDXhvcabzV3UdMaVwwuPcRYmg
         LfiIU28MzLeMyNy49Ebc5CjO4+kI6bVFKytD8jrhs/wdSQjlaY4q4ixkJIh8wMObQTq2
         3XinstC/wH5sQE6hTJJ4f2ELyXSBeIU9lvn7DW5qvXvW26E/YxB+Wp8l/jYRrswYqRUO
         2VXRrDo6GFNdfw/YapkIUZ6NHE/TOR0+OZ4uNP42Re2f08WadPPKlLL4TjSBzSPnpaaN
         P5P9DqmyDrwom1et8Nh1y5EHsmrHfkO9to9gF5v1VVPTIPpp9pXCvbZ974ReZog6T0WS
         vXKA==
X-Received: by 10.70.39.66 with SMTP id n2mr13816634pdk.131.1405792853654;
        Sat, 19 Jul 2014 11:00:53 -0700 (PDT)
Received: from gmail.com ([222.234.94.10])
        by mx.google.com with ESMTPSA id oa17sm12257241pdb.46.2014.07.19.11.00.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Jul 2014 11:00:53 -0700 (PDT)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.0.1.473.g731ddce.dirty
In-Reply-To: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253902>

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
 http.c                     | 134 +++++++++++++++++++++++++++++++++++++++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  31 +++++++++++
 3 files changed, 167 insertions(+)

diff --git a/http.c b/http.c
index 3a28b21..ed4e8e1 100644
--- a/http.c
+++ b/http.c
@@ -67,6 +67,8 @@ static struct curl_slist *no_pragma_header;
 
 static struct active_request_slot *active_queue_head;
 
+static struct strbuf *cached_accept_language = NULL;
+
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -512,6 +514,9 @@ void http_cleanup(void)
 		cert_auth.password = NULL;
 	}
 	ssl_cert_password_required = 0;
+
+	if (cached_accept_language)
+		strbuf_release(cached_accept_language);
 }
 
 struct active_request_slot *get_active_slot(void)
@@ -983,6 +988,129 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
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
+	static struct strbuf buf = STRBUF_INIT;
+	struct strbuf q_format_buf = STRBUF_INIT;
+	char *q_format;
+
+	if (cached_accept_language)
+		return cached_accept_language;
+
+	lang_begin = get_preferred_languages();
+
+	/* Don't add Accept-Language header if no language is preferred. */
+	if (!(lang_begin && *lang_begin)) {
+		cached_accept_language = &buf;
+		return cached_accept_language;
+	}
+
+	/* Count number of preferred lang_begin to decide precision of q-factor */
+	for (num_langs = 1, pos = lang_begin; *pos; pos++)
+		if (*pos == ':')
+			num_langs++;
+
+	/* Decide the precision for q-factor on number of preferred lang_begin. */
+	num_langs += 1; /* for '*' */
+	decimal_places = 1 + (num_langs > 10) + (num_langs > 100);
+	strbuf_addf(&q_format_buf, "; q=0.%%0%dd", decimal_places);
+	q_format = strbuf_detach(&q_format_buf, NULL);
+	for (max_q = 1; decimal_places-- > 0;) max_q *= 10;
+	q = max_q;
+
+	strbuf_addstr(&buf, "Accept-Language: ");
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
+				strbuf_addf(&buf, q_format, q);
+
+			if (q > 1)
+				q--;
+
+			/* NULL pos means this is the last language. */
+			if (*pos)
+				strbuf_addstr(&buf, ", ");
+			else
+				break;
+
+		} else if (is_codeset_or_modifier)
+			continue;
+		else if (*pos == '.' || *pos == '@') /* Remove .codeset and @modifier. */
+			is_codeset_or_modifier = 1;
+		else
+			strbuf_addch(&buf, *pos == '_' ? '-' : *pos);
+	}
+
+	/* Don't add Accept-Language header if no language is preferred. */
+	if (q >= max_q) {
+		cached_accept_language = &buf;
+		return cached_accept_language;
+	}
+
+	/* Add '*' with minimum q-factor greater than 0.0. */
+	strbuf_addstr(&buf, ", *");
+	strbuf_addf(&buf, q_format, 1);
+
+	cached_accept_language = &buf;
+	return cached_accept_language;
+}
+
 /* http_request() targets */
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
@@ -995,6 +1123,7 @@ static int http_request(const char *url,
 	struct slot_results results;
 	struct curl_slist *headers = NULL;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf* accept_language;
 	int ret;
 
 	slot = get_active_slot();
@@ -1020,6 +1149,11 @@ static int http_request(const char *url,
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
index ac71418..d2dac44 100755
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
+	check_language "ko-KR, *; q=0.1" ko_KR.UTF-8 de_DE.UTF-8 ja_JP.UTF-8 en_US.UTF-8 &&
+	check_language "de-DE, *; q=0.1" ""          de_DE.UTF-8 ja_JP.UTF-8 en_US.UTF-8 &&
+	check_language "ja-JP, *; q=0.1" ""          ""          ja_JP.UTF-8 en_US.UTF-8 &&
+	check_language "en-US, *; q=0.1" ""          ""          ""          en_US.UTF-8
+'
+
+test_expect_success 'git client sends Accept-Language with many preferred languages' '
+	check_language "ko-KR, en-US; q=0.99, fr-CA; q=0.98, de; q=0.97, sr; q=0.96, \
+ja; q=0.95, zh; q=0.94, sv; q=0.93, pt; q=0.92, nb; q=0.91, *; q=0.01" \
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
2.0.1.473.g731ddce.dirty
