From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v8 2/4] config: improve support for http.<url>.* settings
Date: Mon, 22 Jul 2013 05:56:42 -0700
Message-ID: <5c7eeb6b52a5468aeca40cf2e6ae579@f74d39fa044aa309eaea14b9f57fe79>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
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
X-From: git-owner@vger.kernel.org Mon Jul 22 14:57:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Ffp-0001iC-7H
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 14:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920Ab3GVM5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 08:57:00 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36558 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab3GVM46 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 08:56:58 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so6989440pbb.36
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=juwuae6ESTm2l6qkT3DL9A7u/KhNmM9gsRjb3+hSd+4=;
        b=Hirjl1mOFJizQ3hCyAvww1Rap0Xq1dN0wGDSgekVVUMdQ4NzM4Hs/jAj57AL0/Zy0p
         ID//tERidLEZwchy9pHJKX/m3cWHQ8m22LODz5HVG8gFYDCwQ04yjqnwVJdh/v+cb+48
         Ye+8a1uNAJV2Jno9SOpRl6c1lA65v5q/2O57S7DunTRhfWUbvsTHT/xK9whSiOx55Zgf
         JIUSrFLQ6JsmCXemJuexXihe3kfkzwrCR1NQbPRfvC26D7Mc+8m6p7BGFb7BptI14UsR
         fyT9S6PUJtISmBR3E2w43GEM3pakb6BtEbr4JRIrd2bGWp/Kf5MVwwkY5X3dQVC0fsLs
         StJQ==
X-Received: by 10.68.220.1 with SMTP id ps1mr25419435pbc.30.1374497817656;
        Mon, 22 Jul 2013 05:56:57 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id x8sm35698437pbb.39.2013.07.22.05.56.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 05:56:56 -0700 (PDT)
In-Reply-To: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230978>

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
 http.c                   | 311 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 318 insertions(+), 12 deletions(-)

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
index 1531ffa..29e119c 100644
--- a/http.c
+++ b/http.c
@@ -169,6 +169,300 @@ static void process_curl_messages(void)
 }
 #endif
 
+#define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
+#define URL_DIGIT "0123456789"
+#define URL_ALPHADIGIT URL_ALPHA URL_DIGIT
+#define URL_SCHEME_CHARS URL_ALPHADIGIT "+.-"
+#define URL_HOST_CHARS URL_ALPHADIGIT ".-[:]" /* IPv6 literals need [:] */
+#define URL_UNSAFE_CHARS " <>\"%{}|\\^`" /* plus 0x00-0x1F,0x7F-0xFF */
+#define URL_GEN_RESERVED ":/?#[]@"
+#define URL_SUB_RESERVED "!$&'()*+,;="
+#define URL_RESERVED URL_GEN_RESERVED URL_SUB_RESERVED /* only allowed delims */
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
+			    !isxdigit((unsigned char)from[0]) ||
+			    !isxdigit((unsigned char)from[1]))
+				return 0;
+			ch = hexval_table[(unsigned char)*from++] << 4;
+			ch |= hexval_table[(unsigned char)*from++];
+			from_len -= 2;
+			was_esc = 1;
+		}
+		if ((unsigned char)ch <= 0x1F || (unsigned char)ch >= 0x7F ||
+		    strchr(URL_UNSAFE_CHARS, ch) ||
+		    (esc_extra && strchr(esc_extra, ch)) ||
+		    (was_esc && strchr(esc_ok, ch)))
+			strbuf_addf(buf, "%%%02X", (unsigned char)ch);
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
+	 * First character of scheme must be URL_ALPHA
+	 */
+	spanned = strspn(url, URL_SCHEME_CHARS);
+	if (!spanned || !isalpha(url[0]) || spanned + 3 > url_len ||
+	    url[spanned] != ':' || url[spanned+1] != '/' || url[spanned+2] != '/')
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
@@ -185,8 +479,13 @@ static size_t http_options_url_match_prefix(const char *url,
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
@@ -233,7 +532,13 @@ static int http_options(const char *var, const char *value, void *cb)
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
@@ -469,11 +774,13 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
+	char *norm_url = http_options_url_normalize(url);
 
 	http_is_verbose = 0;
 
 	memset(http_option_max_matched_len, 0, sizeof(http_option_max_matched_len));
-	git_config(http_options, (void *)url);
+	git_config(http_options, norm_url);
+	free(norm_url);
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
-- 
1.8.3
