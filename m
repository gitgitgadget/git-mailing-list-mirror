From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v5 4/5] config: improve support for http.<url>.* settings
Date: Mon, 15 Jul 2013 02:51:01 -0700
Message-ID: <dcbaa11c8595f48814aa39a75ad18ea@f74d39fa044aa309eaea14b9f57fe79>
References: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 11:51:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyfRI-0006b8-9M
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab3GOJvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:51:21 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:47043 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab3GOJvU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:51:20 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so10548333pdi.35
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u0mb4suy1k61bxAf8NFXM7TcTFxL/ZMfYq+cmIgxC2Q=;
        b=w9HE69ARQP4+pZrXharE0MQR5o2Wwx+vgSUn/tT70MVf9fWZv3rcImoRNfkd/ts1HO
         NNXX8lQNtFJRwjfSNl+vniraENjU8rfbkt3fpBi4HZj3dEct4lP5jvcR42krAi/WYjc9
         RiCwBxSw2WeqyDvs2SNECtmn17OYOCSUSVcPOsltrG5LFiTByfnuOwtRe50My+zG3TIP
         vZdv57sLoIxNNFGqwxI+XpwD+G3zw1qGBHyK1uj91o66Eg9zrvVvdAXFwUuPxgFKAVud
         1OlEYPMIrjU+HS3UxUhqG2OJjcB9sR3q1Try2evALN/rqNgOuWfsf3BM76rzMH9cQaoO
         eV2Q==
X-Received: by 10.66.153.140 with SMTP id vg12mr54330859pab.170.1373881879615;
        Mon, 15 Jul 2013 02:51:19 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wr9sm60041274pbc.7.2013.07.15.02.51.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 02:51:18 -0700 (PDT)
In-Reply-To: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230452>

Improve on the http.<url>.* url matching behavior by first
normalizing the urls before they are compared.

With this change, for example, the following configuration
section:

[http "https://example.com/path"]
        useragent = example-agent
        sslVerify = false

will properly match a "HTTPS://example.COM/p%61th" url which
is equivalent.

The normalization rules are based on RFC 3986 and should
result in any two equivalent urls being a match.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 Documentation/config.txt |  19 ++--
 http.c                   | 222 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 229 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ceced99..98eee23 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1535,16 +1535,15 @@ http.<url>.*::
 	Any of the http.* options above can be applied selectively to some urls.
 	For example "http.https://example.com.useragent" would set the user
 	agent only for https connections to example.com.  The <url> value
-	matches a url if it is an exact match or a prefix of the url matching
-	at a "/" boundary.  Longer <url> matches take precedence over shorter
-	ones with the environment variable settings taking precedence over all.
-	Note that <url> must match the url passed to git exactly (other than
-	possibly being a prefix).  This means any user, password and/or port
-	setting that appears in a url as well as any %XX escapes that are
-	present must also appear in <url> to have a successful match.  The urls
-	that are matched against are those given directly to git commands.  In
-	other words, use exactly the same url that was passed to git (possibly
-	shortened) for the <url> value of the config setting.
+	matches a url if it is an exact match or if it is a prefix of the url
+	matching at a "/" boundary.  Longer <url> matches take precedence over
+	shorter ones with the environment variable settings taking precedence
+	over all.  The urls are normalized before testing for a match.  Note,
+	however, that any user, password and/or port setting that appears in a
+	url must also match that part of <url> to have a successful match.  The
+	urls that are matched against are those given directly to git commands.
+	This means any urls visited as a result of a redirection do not
+	participate in matching.
 
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
diff --git a/http.c b/http.c
index 758e5b1..d04386e 100644
--- a/http.c
+++ b/http.c
@@ -169,6 +169,210 @@ static void process_curl_messages(void)
 }
 #endif
 
+#define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
+#define URL_DIGIT "0123456789"
+#define URL_HEXDIGIT URL_DIGIT "ABCDEFabcdef"
+#define URL_ALPHADIGIT URL_ALPHA URL_DIGIT
+#define URL_SCHEME_CHARS URL_ALPHADIGIT "+.-"
+#define URL_HOST_CHARS URL_ALPHADIGIT ".-[:]" /* IPv6 literals need [:] */
+#define URL_UNSAFE_CHARS " <>\"%{}|\\^`" /* plus 0x00-0x1F,0x7F-0xFF */
+#define URL_GEN_RESERVED ":/?#[]@"
+#define URL_SUB_RESERVED "!$&'()*+,;="
+#define URL_RESERVED URL_GEN_RESERVED URL_SUB_RESERVED /* only allowed delims */
+
+static int hex_digit_value(int ch)
+{
+	/*
+	 * Returns the hexadecimal digit value (0x00..0x0F) of character ch.
+	 * If ch is not a hexadecimal digit, the return value is undefined.
+	 */
+
+	if ('0' <= ch && ch <= '9')
+		return ch - '0';
+	return toupper(ch) - 'A' + 10;
+}
+
+static int append_normalized_escapes(struct strbuf *buf,
+				     const char *from,
+				     size_t from_len,
+				     const char *esc_extra,
+				     const char *esc_ok)
+{
+	/*
+	 * Append to strbuf buf characters from string from with length from_len
+	 * while unescaping characters that do not need to be escaped and
+	 * escaping characters that do.  The set of characters to escape (the
+	 * complement of which is unescaped) starts out as the RFC 3986 unsafe
+	 * characters (0x00-0x1F,0x7F-0xFF," <>\"#%{}|\\^`").  If esc_extra
+	 * is not NULL, those additional characters will also always be escaped.
+	 * If esc_ok is not NULL, those characters will be left escaped if found
+	 * that way, but will not be unescaped otherwise (used for delimiters).
+	 * If a %-escape sequence is encountered that is not followed by 2
+	 * hexadecimal digits, the sequence is invalid and false (0) will be
+	 * returned.  Otherwise true (1) will be returned for success.
+	 *
+	 * Note that all %-escape sequences will be normalized to UPPERCASE
+	 * as indicated in RFC 3986.  Unless included in esc_extra or esc_ok
+	 * alphanumerics and "-._~" will always be unescaped as per RFC 3986.
+	 */
+
+	while (from_len) {
+		int ch = *from++;
+		int was_esc = 0;
+
+		from_len--;
+		if (ch == '%') {
+			if (from_len < 2 ||
+			    !strchr(URL_HEXDIGIT, from[0]) ||
+			    !strchr(URL_HEXDIGIT, from[1]))
+				return 0;
+			ch = hex_digit_value(*from++) << 4;
+			ch |= hex_digit_value(*from++);
+			from_len -= 2;
+			was_esc = 1;
+		}
+		if (ch <= 0x1F || ch >= 0x7F || strchr(URL_UNSAFE_CHARS, ch) ||
+		    (esc_extra && strchr(esc_extra, ch)) ||
+		    (was_esc && strchr(esc_ok, ch)))
+			strbuf_addf(buf, "%%%02X", ch);
+		else
+			strbuf_addch(buf, ch);
+	}
+
+	return 1;
+}
+
+static char *http_options_url_normalize(const char *url, size_t *out_len)
+{
+	/*
+	 * Normalize NUL-terminated url using the following rules:
+	 *
+	 * 1. Case-insensitive parts of url will be converted to lower case
+	 * 2. %-encoded characters that do not need to be will be unencoded
+	 * 3. Characters that are not %-encoded and must be will be encoded
+	 * 4. All %-encodings will be converted to upper case hexadecimal
+	 * 5. If the default port for the scheme is given it will be removed
+	 * 6. If the user:password part is given and empty it will be removed
+	 * 7. A path part (including empty) not starting with '/' has one added
+	 * 8. IPv6 host literals are allowed (but not normalized or validated)
+	 *
+	 * The rules are based on information in RFC 3986.
+	 *
+	 * Please note this function requires a full URL including a scheme
+	 * and host part (except for file: URLs which may have an empty host).
+	 *
+	 * The return value is a newly allocated string that must be freed
+	 * or NULL if the url is not valid.
+	 *
+	 * If a non-NULL value is returned and out_len is not NULL then the
+	 * length of the result will be stored in *out_len.
+	 *
+	 * This is NOT a URL validation function.  Full URL validation is NOT
+	 * performed.  Some invalid host names are passed through this function
+	 * undetected.  Invalid port numbers may also be passed through
+	 * undetected.  However, most all other problems that make a URL invalid
+	 * will be detected (including a missing host for non file: URLs).
+	 */
+
+	size_t url_len = strlen(url);
+	struct strbuf norm;
+	size_t spanned;
+	const char *slash_ptr, *at_ptr, *colon_ptr;
+
+	/* Copy lowercased scheme and :// suffix, %-escapes are not allowed */
+	spanned = strspn(url, URL_SCHEME_CHARS);
+	if (!spanned || spanned + 3 > url_len || url[spanned] != ':' ||
+	    url[spanned+1] != '/' || url[spanned+2] != '/')
+		return NULL; /* Bad scheme and/or missing "://" part */
+	strbuf_init(&norm, url_len);
+	spanned += 3;
+	url_len -= spanned;
+	while (spanned--)
+		strbuf_addch(&norm, tolower(*url++));
+
+	/* Copy any username:password if present normalizing %-escapes */
+	at_ptr = strchr(url, '@');
+	slash_ptr = url + strcspn(url, "/?#");
+	if (at_ptr && at_ptr < slash_ptr) {
+		if (at_ptr > url) {
+			if (!append_normalized_escapes(&norm, url, at_ptr - url,
+						       "", URL_RESERVED)) {
+				strbuf_release(&norm);
+				return NULL;
+			}
+			strbuf_addch(&norm, '@');
+		}
+		url_len -= (++at_ptr - url);
+		url = at_ptr;
+	}
+
+	/* Copy the host part excluding any port part, no %-escapes allowed */
+	if (!url_len || strchr(":/?#", *url)) {
+		/* Missing host invalid for all URL schemes except file */
+		if (strncmp(norm.buf, "file:", 5)) {
+			strbuf_release(&norm);
+			return NULL;
+		}
+	}
+	colon_ptr = slash_ptr - 1;
+	while (colon_ptr > url && *colon_ptr != ':' && *colon_ptr != ']')
+		colon_ptr--;
+	if (*colon_ptr != ':')
+		colon_ptr = slash_ptr;
+	spanned = strspn(url, URL_HOST_CHARS);
+	if (spanned < colon_ptr - url) {
+		/* Host name has invalid characters */
+		strbuf_release(&norm);
+		return NULL;
+	}
+	while (url < colon_ptr) {
+		strbuf_addch(&norm, tolower(*url++));
+		url_len--;
+	}
+
+	/* Check the port part and copy if not the default, no %-escapes */
+	if (colon_ptr < slash_ptr) {
+		if (colon_ptr + 1 == slash_ptr) {
+			/* Skip ":" port with no number, it's same as default */
+		} else if (slash_ptr - colon_ptr == 3 &&
+			   !strncmp(norm.buf, "http:", 5) &&
+			   !strncmp(url, ":80", 3)) {
+			/* Skip http :80 as it's the default */
+		} else if (slash_ptr - colon_ptr == 4 &&
+			   !strncmp(norm.buf, "https:", 6) &&
+			   !strncmp(url, ":443", 4)) {
+			/* Skip https :443 as it's the default */
+		} else {
+			/* Port number must be all digits */
+			spanned = strspn(url + 1, URL_DIGIT);
+			if (spanned + 1 < slash_ptr - colon_ptr) {
+				/* port number has invalid characters */
+				strbuf_release(&norm);
+				return NULL;
+			}
+			strbuf_add(&norm, url, slash_ptr - colon_ptr);
+		}
+		url_len -= slash_ptr - colon_ptr;
+		url = slash_ptr;
+	}
+
+	/*
+	 * Now simply copy the rest, if any, only normalizing %-escapes and
+	 * being careful to not corrupt the URL by unescaping any delimiters,
+	 * but do add an initial '/' if it's missing
+	 */
+	if (*url != '/')
+		strbuf_addch(&norm, '/');
+	if (*url) {
+		if (!append_normalized_escapes(&norm, url, url_len, "", URL_RESERVED)) {
+			strbuf_release(&norm);
+			return NULL;
+		}
+	}
+
+	return strbuf_detach(&norm, out_len);
+}
+
 static size_t http_options_url_match_prefix(const char *url,
 					    const char *url_prefix,
 					    size_t url_prefix_len)
@@ -185,8 +389,13 @@ static size_t http_options_url_match_prefix(const char *url,
 	 * The return value is the length of the match in characters (excluding
 	 * any final '/') or 0 for no match.  Passing "/" as url_prefix will
 	 * always cause 0 to be returned.
+	 *
+	 * Passing NULL as url and/or url_prefix will always cause 0 to be
+	 * returned without causing any faults.
 	 */
 	size_t url_len;
+	if (!url || !url_prefix)
+		return 0;
 	if (url_prefix_len && url_prefix[url_prefix_len - 1] == '/')
 		url_prefix_len--;
 	if (!url_prefix_len || strncmp(url, url_prefix, url_prefix_len))
@@ -233,7 +442,14 @@ static int http_options(const char *var, const char *value, void *cb)
 	 */
 	dot = strrchr(key, '.');
 	if (dot) {
-		matchlen = http_options_url_match_prefix(url, key, dot - key);
+		char *config_url = xmemdupz(key, dot - key);
+		size_t norm_url_len;
+		char *norm_url = http_options_url_normalize(config_url, &norm_url_len);
+		free(config_url);
+		if (!norm_url)
+			return 0;
+		matchlen = http_options_url_match_prefix(url, norm_url, norm_url_len);
+		free(norm_url);
 		if (!matchlen)
 			return 0;
 		key = dot + 1;
@@ -475,10 +691,12 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
+	char *norm_url = http_options_url_normalize(url, NULL);
 
 	http_is_verbose = 0;
 
-	git_config(http_options, (void *)url);
+	git_config(http_options, norm_url);
+	free(norm_url);
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
-- 
1.8.3
