From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v6 2/4] config: improve support for http.<url>.* settings
Date: Fri, 19 Jul 2013 05:48:43 -0700
Message-ID: <2cca0770a1e8495ac1418834c57f23d@f74d39fa044aa309eaea14b9f57fe79>
References: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 14:49:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0A7P-00082r-G3
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 14:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760259Ab3GSMtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 08:49:02 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48056 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759989Ab3GSMs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 08:48:59 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so4256713pdj.10
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hq7+rwYkwL8MimFvTrq1SRSAc5XNxkFwSmn7ZcvSAzQ=;
        b=IOyLOxZVD8pye2od7wUY6v1mSF4piPcKV//sPp+ybPs8II+bBhAuUgEmC8XT1B/j3c
         dfYGnL0BfWKwm/iR7kyauTsMgv6eWktFc5l2cwq/7rPkGNzBdzJLyFRGF+L41d/Ns8hG
         N2Or9ZXmkmgIkjDGldjkaHCu/CWWECySVH2buSZmZ1OWL2ZVNOmOweo4I0Q5CY4Zey9X
         uVRHYT5vpzGVocHooIhCpzw/1vVJ2kTq6M3FxfpACHcC/bQ8kSueqF3uVQT/m2XGVNCg
         FUd628JpkZADDXyXYeV1ZrCQJ+TvbPCkz6peVQbx4ONZsSHhbpEne3mncG6MqHibseQw
         EnCw==
X-Received: by 10.68.217.7 with SMTP id ou7mr17189914pbc.8.1374238138994;
        Fri, 19 Jul 2013 05:48:58 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ry2sm19426942pbc.41.2013.07.19.05.48.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 05:48:58 -0700 (PDT)
In-Reply-To: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230801>

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
 Documentation/config.txt |  19 ++-
 http.c                   | 322 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 329 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 41cab91..e461f32 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1517,16 +1517,15 @@ http.<url>.*::
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
index f61a79c..3c5c2ef 100644
--- a/http.c
+++ b/http.c
@@ -169,6 +169,311 @@ static void process_curl_messages(void)
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
+	 * Append to strbuf 'buf' characters from string 'from' with length
+	 * 'from_len' while unescaping characters that do not need to be escaped
+	 * and escaping characters that do.  The set of characters to escape
+	 * (the complement of which is unescaped) starts out as the RFC 3986
+	 * unsafe characters (0x00-0x1F,0x7F-0xFF," <>\"#%{}|\\^`").  If
+	 * 'esc_extra' is not NULL, those additional characters will also always
+	 * be escaped.  If 'esc_ok' is not NULL, those characters will be left
+	 * escaped if found that way, but will not be unescaped otherwise (used
+	 * for delimiters).  If a %-escape sequence is encountered that is not
+	 * followed by 2 hexadecimal digits, the sequence is invalid and
+	 * false (0) will be returned.  Otherwise true (1) will be returned for
+	 * success.
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
+static char *http_options_url_normalize(const char *url)
+{
+	/*
+	 * Normalize NUL-terminated url using the following rules:
+	 *
+	 * 1. Case-insensitive parts of url will be converted to lower case
+	 * 2. %-encoded characters that do not need to be will be unencoded
+	 * 3. Characters that are not %-encoded and must be will be encoded
+	 * 4. All %-encodings will be converted to upper case hexadecimal
+	 * 5. Leading 0s are removed from port numbers
+	 * 6. If the default port for the scheme is given it will be removed
+	 * 7. A path part (including empty) not starting with '/' has one added
+	 * 8. Any dot segments (. or ..) in the path are resolved and removed
+	 * 9. IPv6 host literals are allowed (but not normalized or validated)
+	 *
+	 * The rules are based on information in RFC 3986.
+	 *
+	 * Please note this function requires a full URL including a scheme
+	 * and host part (except for file: URLs which may have an empty host).
+	 *
+	 * The return value is a newly allocated string that must be freed
+	 * or NULL if the url is not valid.
+	 *
+	 * This is NOT a URL validation function.  Full URL validation is NOT
+	 * performed.  Some invalid host names are passed through this function
+	 * undetected.  However, most all other problems that make a URL invalid
+	 * will be detected (including a missing host for non file: URLs).
+	 */
+
+	size_t url_len = strlen(url);
+	struct strbuf norm;
+	size_t spanned;
+	const char *slash_ptr, *at_ptr, *colon_ptr, *path_start;
+	int found_host = 0;
+
+
+	/*
+	 * Copy lowercased scheme and :// suffix, %-escapes are not allowed
+	 */
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
+
+	/*
+	 * Copy any username:password if present normalizing %-escapes
+	 */
+	at_ptr = strchr(url, '@');
+	slash_ptr = url + strcspn(url, "/?#");
+	if (at_ptr && at_ptr < slash_ptr) {
+		if (at_ptr > url) {
+			if (!append_normalized_escapes(&norm, url, at_ptr - url,
+						       "", URL_RESERVED)) {
+				strbuf_release(&norm);
+				return NULL;
+			}
+		}
+		strbuf_addch(&norm, '@');
+		url_len -= (++at_ptr - url);
+		url = at_ptr;
+	}
+
+
+	/*
+	 * Copy the host part excluding any port part, no %-escapes allowed
+	 */
+	if (!url_len || strchr(":/?#", *url)) {
+		/* Missing host invalid for all URL schemes except file */
+		if (strncmp(norm.buf, "file:", 5)) {
+			strbuf_release(&norm);
+			return NULL;
+		}
+	} else {
+		found_host = 1;
+	}
+	colon_ptr = slash_ptr - 1;
+	while (colon_ptr > url && *colon_ptr != ':' && *colon_ptr != ']')
+		colon_ptr--;
+	if (*colon_ptr != ':') {
+		colon_ptr = slash_ptr;
+	} else if (!found_host && colon_ptr < slash_ptr && colon_ptr + 1 != slash_ptr) {
+		/* file: URLs may not have a port number */
+		strbuf_release(&norm);
+		return NULL;
+	}
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
+
+	/*
+	 * Check the port part and copy if not the default (after removing any
+	 * leading 0s); no %-escapes allowed
+	 */
+	if (colon_ptr < slash_ptr) {
+		/* skip the ':' and leading 0s but not the last one if all 0s */
+		url++;
+		url += strspn(url, "0");
+		if (url == slash_ptr && url[-1] == '0')
+			url--;
+		if (url == slash_ptr) {
+			/* Skip ":" port with no number, it's same as default */
+		} else if (slash_ptr - url == 2 &&
+			   !strncmp(norm.buf, "http:", 5) &&
+			   !strncmp(url, "80", 2)) {
+			/* Skip http :80 as it's the default */
+		} else if (slash_ptr - url == 3 &&
+			   !strncmp(norm.buf, "https:", 6) &&
+			   !strncmp(url, "443", 3)) {
+			/* Skip https :443 as it's the default */
+		} else {
+			/*
+			 * Port number must be all digits with leading 0s removed
+			 * and since all the protocols we deal with have a 16-bit
+			 * port number it must also be in the range 1..65535
+			 * 0 is not allowed because that means "next available"
+			 * on just about every system and therefore cannot be used
+			 */
+			unsigned long pnum = 0;
+			spanned = strspn(url, URL_DIGIT);
+			if (spanned < slash_ptr - url) {
+				/* port number has invalid characters */
+				strbuf_release(&norm);
+				return NULL;
+			}
+			if (slash_ptr - url <= 5)
+				pnum = strtoul(url, NULL, 10);
+			if (pnum == 0 || pnum > 65535) {
+				/* port number not in range 1..65535 */
+				strbuf_release(&norm);
+				return NULL;
+			}
+			strbuf_addch(&norm, ':');
+			strbuf_add(&norm, url, slash_ptr - url);
+		}
+		url_len -= slash_ptr - colon_ptr;
+		url = slash_ptr;
+	}
+
+
+	/*
+	 * Now copy the path resolving any . and .. segments being careful not
+	 * to corrupt the URL by unescaping any delimiters, but do add an
+	 * initial '/' if it's missing and do normalize any %-escape sequences.
+	 */
+	path_start = norm.buf + norm.len;
+	strbuf_addch(&norm, '/');
+	if (*url == '/') {
+		url++;
+		url_len--;
+	}
+	for (;;) {
+		const char *seg_start = norm.buf + norm.len;
+		const char *next_slash = url + strcspn(url, "/?#");
+		int skip_add_slash = 0;
+		/*
+		 * RFC 3689 indicates that any . or .. segments should be
+		 * unescaped before being checked for.
+		 */
+		if (!append_normalized_escapes(&norm, url, next_slash - url, "",
+					       URL_RESERVED)) {
+			strbuf_release(&norm);
+			return NULL;
+		}
+		if (!strcmp(seg_start, ".")) {
+			/* ignore a . segment; be careful not to remove initial '/' */
+			if (seg_start == path_start + 1) {
+				strbuf_setlen(&norm, norm.len - 1);
+				skip_add_slash = 1;
+			} else {
+				strbuf_setlen(&norm, norm.len - 2);
+			}
+		} else if (!strcmp(seg_start, "..")) {
+			/*
+			 * ignore a .. segment and remove the previous segment;
+			 * be careful not to remove initial '/' from path
+			 */
+			const char *prev_slash = norm.buf + norm.len - 3;
+			if (prev_slash == path_start) {
+				/* invalid .. because no previous segment to remove */
+				strbuf_release(&norm);
+				return NULL;
+			}
+			while (*--prev_slash != '/') {}
+			if (prev_slash == path_start) {
+				strbuf_setlen(&norm, prev_slash - norm.buf + 1);
+				skip_add_slash = 1;
+			} else {
+				strbuf_setlen(&norm, prev_slash - norm.buf);
+			}
+		}
+		url_len -= next_slash - url;
+		url = next_slash;
+		/* if the next char is not '/' done with the path */
+		if (*url != '/')
+			break;
+		url++;
+		url_len--;
+		if (!skip_add_slash)
+			strbuf_addch(&norm, '/');
+	}
+
+
+	/*
+	 * Now simply copy the rest, if any, only normalizing %-escapes and
+	 * being careful not to corrupt the URL by unescaping any delimiters.
+	 */
+	if (*url) {
+		if (!append_normalized_escapes(&norm, url, url_len, "", URL_RESERVED)) {
+			strbuf_release(&norm);
+			return NULL;
+		}
+	}
+
+
+	return strbuf_detach(&norm, NULL);
+}
+
 static size_t http_options_url_match_prefix(const char *url,
 					    const char *url_prefix,
 					    size_t url_prefix_len)
@@ -185,8 +490,13 @@ static size_t http_options_url_match_prefix(const char *url,
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
@@ -233,7 +543,13 @@ static int http_options(const char *var, const char *value, void *cb)
 	 */
 	dot = strrchr(key, '.');
 	if (dot) {
-		matchlen = http_options_url_match_prefix(url, key, dot - key);
+		char *config_url = xmemdupz(key, dot - key);
+		char *norm_url = http_options_url_normalize(config_url);
+		free(config_url);
+		if (!norm_url)
+			return 0;
+		matchlen = http_options_url_match_prefix(url, norm_url, strlen(norm_url));
+		free(norm_url);
 		if (!matchlen)
 			return 0;
 		key = dot + 1;
@@ -469,10 +785,12 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
+	char *norm_url = http_options_url_normalize(url);
 
 	http_is_verbose = 0;
 
-	git_config(http_options, (void *)url);
+	git_config(http_options, norm_url);
+	free(norm_url);
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
-- 
1.8.3
