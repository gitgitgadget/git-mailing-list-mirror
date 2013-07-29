From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] url-match: split out URL matching logic out of http.c
Date: Mon, 29 Jul 2013 15:49:08 -0700
Message-ID: <1375138150-19520-2-git-send-email-gitster@pobox.com>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
 <1375138150-19520-1-git-send-email-gitster@pobox.com>
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 30 00:49:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3wGF-0008Bj-HT
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 00:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab3G2WtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 18:49:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756240Ab3G2WtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 18:49:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A0FC340F0;
	Mon, 29 Jul 2013 22:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ZDUR
	j639fSuFoFidG6PTDo416P0=; b=wMNeY9XdOJns+hPvQ9nHcmtAeyluWGN+bBVU
	whitQ65JmXJkP5SvPMmOHhQ2HmNtGYAzcq8n+4Hrh9JW5F7j928BWnRoVsUJLqgT
	BeMDYTDeQ+MsIa50jis6YjsDDce+qocHI6RGfVFXd30gm+xymXf4dTyb8EzFHQfr
	CZExONM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	prJNq1UzRaEQByzjJkhDJ3o2Ok1JB/d/xmM/OKRFE44tZ62szKLH8658l36HwefG
	s/TvCr2fTljWpP8JIW/kvgMgEselK1szMxGlOrf/xgRkQTteYPbSiBiyujWNwKya
	E5qSQaV55NqZ56nu3XExzF7FXQEFk5rASrfZiO7zHLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EDEA340EF;
	Mon, 29 Jul 2013 22:49:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C2BF340E9;
	Mon, 29 Jul 2013 22:49:14 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc0-137-g17832d4
In-Reply-To: <1375138150-19520-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 179902C4-F8A1-11E2-928A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231335>

Move reusable URL matching code out of http.c, because it is not
limited to http, and we do not necessarily want to link its users
with the cURL library.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile             |   2 +
 http.c               | 500 +--------------------------------------------------
 test-url-normalize.c |   2 -
 url-match.c          | 468 +++++++++++++++++++++++++++++++++++++++++++++++
 url-match.h          |  35 ++++
 5 files changed, 509 insertions(+), 498 deletions(-)
 create mode 100644 url-match.c
 create mode 100644 url-match.h

diff --git a/Makefile b/Makefile
index f83879c..92ccfb3 100644
--- a/Makefile
+++ b/Makefile
@@ -722,6 +722,7 @@ LIB_H += tree-walk.h
 LIB_H += tree.h
 LIB_H += unpack-trees.h
 LIB_H += url.h
+LIB_H += url-match.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
 LIB_H += varint.h
@@ -869,6 +870,7 @@ LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
 LIB_OBJS += unpack-trees.o
 LIB_OBJS += url.o
+LIB_OBJS += url-match.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
diff --git a/http.c b/http.c
index c636d3c..a91a00b 100644
--- a/http.c
+++ b/http.c
@@ -3,6 +3,7 @@
 #include "sideband.h"
 #include "run-command.h"
 #include "url.h"
+#include "url-match.h"
 #include "credential.h"
 #include "version.h"
 #include "pkt-line.h"
@@ -56,33 +57,6 @@ enum http_option_type {
 	OPT_MAX
 };
 
-struct url_info {
-	char *url;		/* normalized url on success, must be freed, otherwise NULL */
-	const char *err;	/* if !url, a brief reason for the failure, otherwise NULL */
-
-	/* the rest of the fields are only set if url != NULL */
-
-	size_t url_len;		/* total length of url (which is now normalized) */
-	size_t scheme_len;	/* length of scheme name (excluding final :) */
-	size_t user_off;	/* offset into url to start of user name (0 => none) */
-	size_t user_len;	/* length of user name; if user_off != 0 but
-				   user_len == 0, an empty user name was given */
-	size_t passwd_off;	/* offset into url to start of passwd (0 => none) */
-	size_t passwd_len;	/* length of passwd; if passwd_off != 0 but
-				   passwd_len == 0, an empty passwd was given */
-	size_t host_off;	/* offset into url to start of host name (0 => none) */
-	size_t host_len;	/* length of host name; this INCLUDES any ':portnum';
-				 * file urls may have host_len == 0 */
-	size_t port_len;	/* if a portnum is present (port_len != 0), it has
-				 * this length (excluding the leading ':') at the
-				 * end of the host name (always 0 for file urls) */
-	size_t path_off;	/* offset into url to the start of the url path;
-				 * this will always point to a '/' character
-				 * after the url has been normalized */
-	size_t path_len;	/* length of path portion excluding any trailing
-				 * '?...' and '#...' portion; will always be >= 1 */
-};
-
 static size_t http_option_max_matched_len[OPT_MAX];
 static int http_option_user_matched[OPT_MAX];
 
@@ -197,472 +171,6 @@ static void process_curl_messages(void)
 }
 #endif
 
-#define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
-#define URL_DIGIT "0123456789"
-#define URL_ALPHADIGIT URL_ALPHA URL_DIGIT
-#define URL_SCHEME_CHARS URL_ALPHADIGIT "+.-"
-#define URL_HOST_CHARS URL_ALPHADIGIT ".-[:]" /* IPv6 literals need [:] */
-#define URL_UNSAFE_CHARS " <>\"%{}|\\^`" /* plus 0x00-0x1F,0x7F-0xFF */
-#define URL_GEN_RESERVED ":/?#[]@"
-#define URL_SUB_RESERVED "!$&'()*+,;="
-#define URL_RESERVED URL_GEN_RESERVED URL_SUB_RESERVED /* only allowed delims */
-
-static int append_normalized_escapes(struct strbuf *buf,
-				     const char *from,
-				     size_t from_len,
-				     const char *esc_extra,
-				     const char *esc_ok)
-{
-	/*
-	 * Append to strbuf 'buf' characters from string 'from' with length
-	 * 'from_len' while unescaping characters that do not need to be escaped
-	 * and escaping characters that do.  The set of characters to escape
-	 * (the complement of which is unescaped) starts out as the RFC 3986
-	 * unsafe characters (0x00-0x1F,0x7F-0xFF," <>\"#%{}|\\^`").  If
-	 * 'esc_extra' is not NULL, those additional characters will also always
-	 * be escaped.  If 'esc_ok' is not NULL, those characters will be left
-	 * escaped if found that way, but will not be unescaped otherwise (used
-	 * for delimiters).  If a %-escape sequence is encountered that is not
-	 * followed by 2 hexadecimal digits, the sequence is invalid and
-	 * false (0) will be returned.  Otherwise true (1) will be returned for
-	 * success.
-	 *
-	 * Note that all %-escape sequences will be normalized to UPPERCASE
-	 * as indicated in RFC 3986.  Unless included in esc_extra or esc_ok
-	 * alphanumerics and "-._~" will always be unescaped as per RFC 3986.
-	 */
-
-	while (from_len) {
-		int ch = *from++;
-		int was_esc = 0;
-
-		from_len--;
-		if (ch == '%') {
-			if (from_len < 2 ||
-			    !isxdigit((unsigned char)from[0]) ||
-			    !isxdigit((unsigned char)from[1]))
-				return 0;
-			ch = hexval_table[(unsigned char)*from++] << 4;
-			ch |= hexval_table[(unsigned char)*from++];
-			from_len -= 2;
-			was_esc = 1;
-		}
-		if ((unsigned char)ch <= 0x1F || (unsigned char)ch >= 0x7F ||
-		    strchr(URL_UNSAFE_CHARS, ch) ||
-		    (esc_extra && strchr(esc_extra, ch)) ||
-		    (was_esc && strchr(esc_ok, ch)))
-			strbuf_addf(buf, "%%%02X", (unsigned char)ch);
-		else
-			strbuf_addch(buf, ch);
-	}
-
-	return 1;
-}
-
-static char *http_options_url_normalize(const char *url, struct url_info *out_info)
-{
-	/*
-	 * Normalize NUL-terminated url using the following rules:
-	 *
-	 * 1. Case-insensitive parts of url will be converted to lower case
-	 * 2. %-encoded characters that do not need to be will be unencoded
-	 * 3. Characters that are not %-encoded and must be will be encoded
-	 * 4. All %-encodings will be converted to upper case hexadecimal
-	 * 5. Leading 0s are removed from port numbers
-	 * 6. If the default port for the scheme is given it will be removed
-	 * 7. A path part (including empty) not starting with '/' has one added
-	 * 8. Any dot segments (. or ..) in the path are resolved and removed
-	 * 9. IPv6 host literals are allowed (but not normalized or validated)
-	 *
-	 * The rules are based on information in RFC 3986.
-	 *
-	 * Please note this function requires a full URL including a scheme
-	 * and host part (except for file: URLs which may have an empty host).
-	 *
-	 * The return value is a newly allocated string that must be freed
-	 * or NULL if the url is not valid.
-	 *
-	 * If out_info is non-NULL, the url and err fields therein will always
-	 * be set.  If a non-NULL value is returned, it will be stored in
-	 * out_info->url as well, out_info->err will be set to NULL and the
-	 * other fields of *out_info will also be filled in.  If a NULL value
-	 * is returned, NULL will be stored in out_info->url and out_info->err
-	 * will be set to a brief, translated, error message, but no other
-	 * fields will be filled in.
-	 *
-	 * This is NOT a URL validation function.  Full URL validation is NOT
-	 * performed.  Some invalid host names are passed through this function
-	 * undetected.  However, most all other problems that make a URL invalid
-	 * will be detected (including a missing host for non file: URLs).
-	 */
-
-	size_t url_len = strlen(url);
-	struct strbuf norm;
-	size_t spanned;
-	size_t scheme_len, user_off=0, user_len=0, passwd_off=0, passwd_len=0;
-	size_t host_off=0, host_len=0, port_len=0, path_off, path_len, result_len;
-	const char *slash_ptr, *at_ptr, *colon_ptr, *path_start;
-	char *result;
-
-	/*
-	 * Copy lowercased scheme and :// suffix, %-escapes are not allowed
-	 * First character of scheme must be URL_ALPHA
-	 */
-	spanned = strspn(url, URL_SCHEME_CHARS);
-	if (!spanned || !isalpha(url[0]) || spanned + 3 > url_len ||
-	    url[spanned] != ':' || url[spanned+1] != '/' || url[spanned+2] != '/') {
-		if (out_info) {
-			out_info->url = NULL;
-			out_info->err = _("invalid URL scheme name or missing '://' suffix");
-		}
-		return NULL; /* Bad scheme and/or missing "://" part */
-	}
-	strbuf_init(&norm, url_len);
-	scheme_len = spanned;
-	spanned += 3;
-	url_len -= spanned;
-	while (spanned--)
-		strbuf_addch(&norm, tolower(*url++));
-
-
-	/*
-	 * Copy any username:password if present normalizing %-escapes
-	 */
-	at_ptr = strchr(url, '@');
-	slash_ptr = url + strcspn(url, "/?#");
-	if (at_ptr && at_ptr < slash_ptr) {
-		user_off = norm.len;
-		if (at_ptr > url) {
-			if (!append_normalized_escapes(&norm, url, at_ptr - url,
-						       "", URL_RESERVED)) {
-				if (out_info) {
-					out_info->url = NULL;
-					out_info->err = _("invalid %XX escape sequence");
-				}
-				strbuf_release(&norm);
-				return NULL;
-			}
-			colon_ptr = strchr(norm.buf + scheme_len + 3, ':');
-			if (colon_ptr) {
-				passwd_off = (colon_ptr + 1) - norm.buf;
-				passwd_len = norm.len - passwd_off;
-				user_len = (passwd_off - 1) - (scheme_len + 3);
-			} else {
-				user_len = norm.len - (scheme_len + 3);
-			}
-		}
-		strbuf_addch(&norm, '@');
-		url_len -= (++at_ptr - url);
-		url = at_ptr;
-	}
-
-
-	/*
-	 * Copy the host part excluding any port part, no %-escapes allowed
-	 */
-	if (!url_len || strchr(":/?#", *url)) {
-		/* Missing host invalid for all URL schemes except file */
-		if (strncmp(norm.buf, "file:", 5)) {
-			if (out_info) {
-				out_info->url = NULL;
-				out_info->err = _("missing host and scheme is not 'file:'");
-			}
-			strbuf_release(&norm);
-			return NULL;
-		}
-	} else {
-		host_off = norm.len;
-	}
-	colon_ptr = slash_ptr - 1;
-	while (colon_ptr > url && *colon_ptr != ':' && *colon_ptr != ']')
-		colon_ptr--;
-	if (*colon_ptr != ':') {
-		colon_ptr = slash_ptr;
-	} else if (!host_off && colon_ptr < slash_ptr && colon_ptr + 1 != slash_ptr) {
-		/* file: URLs may not have a port number */
-		if (out_info) {
-			out_info->url = NULL;
-			out_info->err = _("a 'file:' URL may not have a port number");
-		}
-		strbuf_release(&norm);
-		return NULL;
-	}
-	spanned = strspn(url, URL_HOST_CHARS);
-	if (spanned < colon_ptr - url) {
-		/* Host name has invalid characters */
-		if (out_info) {
-			out_info->url = NULL;
-			out_info->err = _("invalid characters in host name");
-		}
-		strbuf_release(&norm);
-		return NULL;
-	}
-	while (url < colon_ptr) {
-		strbuf_addch(&norm, tolower(*url++));
-		url_len--;
-	}
-
-
-	/*
-	 * Check the port part and copy if not the default (after removing any
-	 * leading 0s); no %-escapes allowed
-	 */
-	if (colon_ptr < slash_ptr) {
-		/* skip the ':' and leading 0s but not the last one if all 0s */
-		url++;
-		url += strspn(url, "0");
-		if (url == slash_ptr && url[-1] == '0')
-			url--;
-		if (url == slash_ptr) {
-			/* Skip ":" port with no number, it's same as default */
-		} else if (slash_ptr - url == 2 &&
-			   !strncmp(norm.buf, "http:", 5) &&
-			   !strncmp(url, "80", 2)) {
-			/* Skip http :80 as it's the default */
-		} else if (slash_ptr - url == 3 &&
-			   !strncmp(norm.buf, "https:", 6) &&
-			   !strncmp(url, "443", 3)) {
-			/* Skip https :443 as it's the default */
-		} else {
-			/*
-			 * Port number must be all digits with leading 0s removed
-			 * and since all the protocols we deal with have a 16-bit
-			 * port number it must also be in the range 1..65535
-			 * 0 is not allowed because that means "next available"
-			 * on just about every system and therefore cannot be used
-			 */
-			unsigned long pnum = 0;
-			spanned = strspn(url, URL_DIGIT);
-			if (spanned < slash_ptr - url) {
-				/* port number has invalid characters */
-				if (out_info) {
-					out_info->url = NULL;
-					out_info->err = _("invalid port number");
-				}
-				strbuf_release(&norm);
-				return NULL;
-			}
-			if (slash_ptr - url <= 5)
-				pnum = strtoul(url, NULL, 10);
-			if (pnum == 0 || pnum > 65535) {
-				/* port number not in range 1..65535 */
-				if (out_info) {
-					out_info->url = NULL;
-					out_info->err = _("invalid port number");
-				}
-				strbuf_release(&norm);
-				return NULL;
-			}
-			strbuf_addch(&norm, ':');
-			strbuf_add(&norm, url, slash_ptr - url);
-			port_len = slash_ptr - url;
-		}
-		url_len -= slash_ptr - colon_ptr;
-		url = slash_ptr;
-	}
-	if (host_off)
-		host_len = norm.len - host_off;
-
-
-	/*
-	 * Now copy the path resolving any . and .. segments being careful not
-	 * to corrupt the URL by unescaping any delimiters, but do add an
-	 * initial '/' if it's missing and do normalize any %-escape sequences.
-	 */
-	path_off = norm.len;
-	path_start = norm.buf + path_off;
-	strbuf_addch(&norm, '/');
-	if (*url == '/') {
-		url++;
-		url_len--;
-	}
-	for (;;) {
-		const char *seg_start = norm.buf + norm.len;
-		const char *next_slash = url + strcspn(url, "/?#");
-		int skip_add_slash = 0;
-		/*
-		 * RFC 3689 indicates that any . or .. segments should be
-		 * unescaped before being checked for.
-		 */
-		if (!append_normalized_escapes(&norm, url, next_slash - url, "",
-					       URL_RESERVED)) {
-			if (out_info) {
-				out_info->url = NULL;
-				out_info->err = _("invalid %XX escape sequence");
-			}
-			strbuf_release(&norm);
-			return NULL;
-		}
-		if (!strcmp(seg_start, ".")) {
-			/* ignore a . segment; be careful not to remove initial '/' */
-			if (seg_start == path_start + 1) {
-				strbuf_setlen(&norm, norm.len - 1);
-				skip_add_slash = 1;
-			} else {
-				strbuf_setlen(&norm, norm.len - 2);
-			}
-		} else if (!strcmp(seg_start, "..")) {
-			/*
-			 * ignore a .. segment and remove the previous segment;
-			 * be careful not to remove initial '/' from path
-			 */
-			const char *prev_slash = norm.buf + norm.len - 3;
-			if (prev_slash == path_start) {
-				/* invalid .. because no previous segment to remove */
-				if (out_info) {
-					out_info->url = NULL;
-					out_info->err = _("invalid '..' path segment");
-				}
-				strbuf_release(&norm);
-				return NULL;
-			}
-			while (*--prev_slash != '/') {}
-			if (prev_slash == path_start) {
-				strbuf_setlen(&norm, prev_slash - norm.buf + 1);
-				skip_add_slash = 1;
-			} else {
-				strbuf_setlen(&norm, prev_slash - norm.buf);
-			}
-		}
-		url_len -= next_slash - url;
-		url = next_slash;
-		/* if the next char is not '/' done with the path */
-		if (*url != '/')
-			break;
-		url++;
-		url_len--;
-		if (!skip_add_slash)
-			strbuf_addch(&norm, '/');
-	}
-	path_len = norm.len - path_off;
-
-
-	/*
-	 * Now simply copy the rest, if any, only normalizing %-escapes and
-	 * being careful not to corrupt the URL by unescaping any delimiters.
-	 */
-	if (*url) {
-		if (!append_normalized_escapes(&norm, url, url_len, "", URL_RESERVED)) {
-			if (out_info) {
-				out_info->url = NULL;
-				out_info->err = _("invalid %XX escape sequence");
-			}
-			strbuf_release(&norm);
-			return NULL;
-		}
-	}
-
-
-	result = strbuf_detach(&norm, &result_len);
-	if (out_info) {
-		out_info->url = result;
-		out_info->err = NULL;
-		out_info->url_len = result_len;
-		out_info->scheme_len = scheme_len;
-		out_info->user_off = user_off;
-		out_info->user_len = user_len;
-		out_info->passwd_off = passwd_off;
-		out_info->passwd_len = passwd_len;
-		out_info->host_off = host_off;
-		out_info->host_len = host_len;
-		out_info->port_len = port_len;
-		out_info->path_off = path_off;
-		out_info->path_len = path_len;
-	}
-	return result;
-}
-
-static size_t http_options_url_match_prefix(const char *url,
-					    const char *url_prefix,
-					    size_t url_prefix_len)
-{
-	/*
-	 * url_prefix matches url if url_prefix is an exact match for url or it
-	 * is a prefix of url and the match ends on a path component boundary.
-	 * Both url and url_prefix are considered to have an implicit '/' on the
-	 * end for matching purposes if they do not already.
-	 *
-	 * url must be NUL terminated.  url_prefix_len is the length of
-	 * url_prefix which need not be NUL terminated.
-	 *
-	 * The return value is the length of the match in characters (including
-	 * the final '/' even if it's implicit) or 0 for no match.
-	 *
-	 * Passing NULL as url and/or url_prefix will always cause 0 to be
-	 * returned without causing any faults.
-	 */
-	if (!url || !url_prefix)
-		return 0;
-	if (!url_prefix_len || (url_prefix_len == 1 && *url_prefix == '/'))
-		return (!*url || *url == '/') ? 1 : 0;
-	if (url_prefix[url_prefix_len - 1] == '/')
-		url_prefix_len--;
-	if (strncmp(url, url_prefix, url_prefix_len))
-		return 0;
-	if ((strlen(url) == url_prefix_len) || (url[url_prefix_len] == '/'))
-		return url_prefix_len + 1;
-	return 0;
-}
-
-static int http_options_match_urls(const struct url_info *url,
-				   const struct url_info *url_prefix,
-				   int *exactusermatch)
-{
-	/*
-	 * url_prefix matches url if the scheme, host and port of url_prefix
-	 * are the same as those of url and the path portion of url_prefix
-	 * is the same as the path portion of url or it is a prefix that
-	 * matches at a '/' boundary.  If url_prefix contains a user name,
-	 * that must also exactly match the user name in url.
-	 *
-	 * If the user, host, port and path match in this fashion, the returned
-	 * value is the length of the path match including any implicit
-	 * final '/'.  For example, "http://me@example.com/path" is matched by
-	 * "http://example.com" with a path length of 1.
-	 *
-	 * If there is a match and exactusermatch is not NULL, then
-	 * *exactusermatch will be set to true if both url and url_prefix
-	 * contained a user name or false if url_prefix did not have a
-	 * user name.  If there is no match *exactusermatch is left untouched.
-	 */
-	int usermatched = 0;
-	int pathmatchlen;
-
-	if (!url || !url_prefix || !url->url || !url_prefix->url)
-		return 0;
-
-	/* check the scheme */
-	if (url_prefix->scheme_len != url->scheme_len ||
-	    strncmp(url->url, url_prefix->url, url->scheme_len))
-		return 0; /* schemes do not match */
-
-	/* check the user name if url_prefix has one */
-	if (url_prefix->user_off) {
-		if (!url->user_off || url->user_len != url_prefix->user_len ||
-		    strncmp(url->url + url->user_off,
-			    url_prefix->url + url_prefix->user_off,
-			    url->user_len))
-			return 0; /* url_prefix has a user but it's not a match */
-		usermatched = 1;
-	}
-
-	/* check the host and port */
-	if (url_prefix->host_len != url->host_len ||
-	    strncmp(url->url + url->host_off,
-		    url_prefix->url + url_prefix->host_off, url->host_len))
-		return 0; /* host names and/or ports do not match */
-
-	/* check the path */
-	pathmatchlen = http_options_url_match_prefix(
-		url->url + url->path_off,
-		url_prefix->url + url_prefix->path_off,
-		url_prefix->url_len - url_prefix->path_off);
-
-	if (pathmatchlen && exactusermatch)
-		*exactusermatch = usermatched;
-	return pathmatchlen;
-}
-
 static int match_is_ignored(size_t matchlen, int usermatch, enum http_option_type opt)
 {
 	/*
@@ -720,11 +228,11 @@ static int http_options(const char *var, const char *value, void *cb)
 		if (!info || !info->url)
 			return 0;
 		config_url = xmemdupz(key, dot - key);
-		norm_url = http_options_url_normalize(config_url, &norm_info);
+		norm_url = url_normalize(config_url, &norm_info);
 		free(config_url);
 		if (!norm_url)
 			return 0;
-		matchlen = http_options_match_urls(info, &norm_info, &usermatch);
+		matchlen = match_urls(info, &norm_info, &usermatch);
 		free(norm_url);
 		if (!matchlen)
 			return 0;
@@ -967,7 +475,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
 	memset(http_option_max_matched_len, 0, sizeof(http_option_max_matched_len));
 	memset(http_option_user_matched, 0, sizeof(http_option_user_matched));
-	http_options_url_normalize(url, &info);
+	url_normalize(url, &info);
 	git_config(http_options, &info);
 	free(info.url);
 
diff --git a/test-url-normalize.c b/test-url-normalize.c
index 4f870dc..0b809eb 100644
--- a/test-url-normalize.c
+++ b/test-url-normalize.c
@@ -65,8 +65,6 @@ static int run_http_options(const char *file,
 	return 0;
 }
 
-#define url_normalize(u,i) http_options_url_normalize(u,i)
-
 int main(int argc, char **argv)
 {
 	const char *usage = "test-url-normalize [-p | -l] <url1> | <url1> <url2>"
diff --git a/url-match.c b/url-match.c
new file mode 100644
index 0000000..424a0a0
--- /dev/null
+++ b/url-match.c
@@ -0,0 +1,468 @@
+#include "cache.h"
+#include "url-match.h"
+
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
+char *url_normalize(const char *url, struct url_info *out_info)
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
+	 * If out_info is non-NULL, the url and err fields therein will always
+	 * be set.  If a non-NULL value is returned, it will be stored in
+	 * out_info->url as well, out_info->err will be set to NULL and the
+	 * other fields of *out_info will also be filled in.  If a NULL value
+	 * is returned, NULL will be stored in out_info->url and out_info->err
+	 * will be set to a brief, translated, error message, but no other
+	 * fields will be filled in.
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
+	size_t scheme_len, user_off=0, user_len=0, passwd_off=0, passwd_len=0;
+	size_t host_off=0, host_len=0, port_len=0, path_off, path_len, result_len;
+	const char *slash_ptr, *at_ptr, *colon_ptr, *path_start;
+	char *result;
+
+	/*
+	 * Copy lowercased scheme and :// suffix, %-escapes are not allowed
+	 * First character of scheme must be URL_ALPHA
+	 */
+	spanned = strspn(url, URL_SCHEME_CHARS);
+	if (!spanned || !isalpha(url[0]) || spanned + 3 > url_len ||
+	    url[spanned] != ':' || url[spanned+1] != '/' || url[spanned+2] != '/') {
+		if (out_info) {
+			out_info->url = NULL;
+			out_info->err = _("invalid URL scheme name or missing '://' suffix");
+		}
+		return NULL; /* Bad scheme and/or missing "://" part */
+	}
+	strbuf_init(&norm, url_len);
+	scheme_len = spanned;
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
+		user_off = norm.len;
+		if (at_ptr > url) {
+			if (!append_normalized_escapes(&norm, url, at_ptr - url,
+						       "", URL_RESERVED)) {
+				if (out_info) {
+					out_info->url = NULL;
+					out_info->err = _("invalid %XX escape sequence");
+				}
+				strbuf_release(&norm);
+				return NULL;
+			}
+			colon_ptr = strchr(norm.buf + scheme_len + 3, ':');
+			if (colon_ptr) {
+				passwd_off = (colon_ptr + 1) - norm.buf;
+				passwd_len = norm.len - passwd_off;
+				user_len = (passwd_off - 1) - (scheme_len + 3);
+			} else {
+				user_len = norm.len - (scheme_len + 3);
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
+			if (out_info) {
+				out_info->url = NULL;
+				out_info->err = _("missing host and scheme is not 'file:'");
+			}
+			strbuf_release(&norm);
+			return NULL;
+		}
+	} else {
+		host_off = norm.len;
+	}
+	colon_ptr = slash_ptr - 1;
+	while (colon_ptr > url && *colon_ptr != ':' && *colon_ptr != ']')
+		colon_ptr--;
+	if (*colon_ptr != ':') {
+		colon_ptr = slash_ptr;
+	} else if (!host_off && colon_ptr < slash_ptr && colon_ptr + 1 != slash_ptr) {
+		/* file: URLs may not have a port number */
+		if (out_info) {
+			out_info->url = NULL;
+			out_info->err = _("a 'file:' URL may not have a port number");
+		}
+		strbuf_release(&norm);
+		return NULL;
+	}
+	spanned = strspn(url, URL_HOST_CHARS);
+	if (spanned < colon_ptr - url) {
+		/* Host name has invalid characters */
+		if (out_info) {
+			out_info->url = NULL;
+			out_info->err = _("invalid characters in host name");
+		}
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
+				if (out_info) {
+					out_info->url = NULL;
+					out_info->err = _("invalid port number");
+				}
+				strbuf_release(&norm);
+				return NULL;
+			}
+			if (slash_ptr - url <= 5)
+				pnum = strtoul(url, NULL, 10);
+			if (pnum == 0 || pnum > 65535) {
+				/* port number not in range 1..65535 */
+				if (out_info) {
+					out_info->url = NULL;
+					out_info->err = _("invalid port number");
+				}
+				strbuf_release(&norm);
+				return NULL;
+			}
+			strbuf_addch(&norm, ':');
+			strbuf_add(&norm, url, slash_ptr - url);
+			port_len = slash_ptr - url;
+		}
+		url_len -= slash_ptr - colon_ptr;
+		url = slash_ptr;
+	}
+	if (host_off)
+		host_len = norm.len - host_off;
+
+
+	/*
+	 * Now copy the path resolving any . and .. segments being careful not
+	 * to corrupt the URL by unescaping any delimiters, but do add an
+	 * initial '/' if it's missing and do normalize any %-escape sequences.
+	 */
+	path_off = norm.len;
+	path_start = norm.buf + path_off;
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
+			if (out_info) {
+				out_info->url = NULL;
+				out_info->err = _("invalid %XX escape sequence");
+			}
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
+				if (out_info) {
+					out_info->url = NULL;
+					out_info->err = _("invalid '..' path segment");
+				}
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
+	path_len = norm.len - path_off;
+
+
+	/*
+	 * Now simply copy the rest, if any, only normalizing %-escapes and
+	 * being careful not to corrupt the URL by unescaping any delimiters.
+	 */
+	if (*url) {
+		if (!append_normalized_escapes(&norm, url, url_len, "", URL_RESERVED)) {
+			if (out_info) {
+				out_info->url = NULL;
+				out_info->err = _("invalid %XX escape sequence");
+			}
+			strbuf_release(&norm);
+			return NULL;
+		}
+	}
+
+
+	result = strbuf_detach(&norm, &result_len);
+	if (out_info) {
+		out_info->url = result;
+		out_info->err = NULL;
+		out_info->url_len = result_len;
+		out_info->scheme_len = scheme_len;
+		out_info->user_off = user_off;
+		out_info->user_len = user_len;
+		out_info->passwd_off = passwd_off;
+		out_info->passwd_len = passwd_len;
+		out_info->host_off = host_off;
+		out_info->host_len = host_len;
+		out_info->port_len = port_len;
+		out_info->path_off = path_off;
+		out_info->path_len = path_len;
+	}
+	return result;
+}
+
+static size_t http_options_url_match_prefix(const char *url,
+					    const char *url_prefix,
+					    size_t url_prefix_len)
+{
+	/*
+	 * url_prefix matches url if url_prefix is an exact match for url or it
+	 * is a prefix of url and the match ends on a path component boundary.
+	 * Both url and url_prefix are considered to have an implicit '/' on the
+	 * end for matching purposes if they do not already.
+	 *
+	 * url must be NUL terminated.  url_prefix_len is the length of
+	 * url_prefix which need not be NUL terminated.
+	 *
+	 * The return value is the length of the match in characters (including
+	 * the final '/' even if it's implicit) or 0 for no match.
+	 *
+	 * Passing NULL as url and/or url_prefix will always cause 0 to be
+	 * returned without causing any faults.
+	 */
+	if (!url || !url_prefix)
+		return 0;
+	if (!url_prefix_len || (url_prefix_len == 1 && *url_prefix == '/'))
+		return (!*url || *url == '/') ? 1 : 0;
+	if (url_prefix[url_prefix_len - 1] == '/')
+		url_prefix_len--;
+	if (strncmp(url, url_prefix, url_prefix_len))
+		return 0;
+	if ((strlen(url) == url_prefix_len) || (url[url_prefix_len] == '/'))
+		return url_prefix_len + 1;
+	return 0;
+}
+
+int match_urls(const struct url_info *url,
+	       const struct url_info *url_prefix,
+	       int *exactusermatch)
+{
+	/*
+	 * url_prefix matches url if the scheme, host and port of url_prefix
+	 * are the same as those of url and the path portion of url_prefix
+	 * is the same as the path portion of url or it is a prefix that
+	 * matches at a '/' boundary.  If url_prefix contains a user name,
+	 * that must also exactly match the user name in url.
+	 *
+	 * If the user, host, port and path match in this fashion, the returned
+	 * value is the length of the path match including any implicit
+	 * final '/'.  For example, "http://me@example.com/path" is matched by
+	 * "http://example.com" with a path length of 1.
+	 *
+	 * If there is a match and exactusermatch is not NULL, then
+	 * *exactusermatch will be set to true if both url and url_prefix
+	 * contained a user name or false if url_prefix did not have a
+	 * user name.  If there is no match *exactusermatch is left untouched.
+	 */
+	int usermatched = 0;
+	int pathmatchlen;
+
+	if (!url || !url_prefix || !url->url || !url_prefix->url)
+		return 0;
+
+	/* check the scheme */
+	if (url_prefix->scheme_len != url->scheme_len ||
+	    strncmp(url->url, url_prefix->url, url->scheme_len))
+		return 0; /* schemes do not match */
+
+	/* check the user name if url_prefix has one */
+	if (url_prefix->user_off) {
+		if (!url->user_off || url->user_len != url_prefix->user_len ||
+		    strncmp(url->url + url->user_off,
+			    url_prefix->url + url_prefix->user_off,
+			    url->user_len))
+			return 0; /* url_prefix has a user but it's not a match */
+		usermatched = 1;
+	}
+
+	/* check the host and port */
+	if (url_prefix->host_len != url->host_len ||
+	    strncmp(url->url + url->host_off,
+		    url_prefix->url + url_prefix->host_off, url->host_len))
+		return 0; /* host names and/or ports do not match */
+
+	/* check the path */
+	pathmatchlen = http_options_url_match_prefix(
+		url->url + url->path_off,
+		url_prefix->url + url_prefix->path_off,
+		url_prefix->url_len - url_prefix->path_off);
+
+	if (pathmatchlen && exactusermatch)
+		*exactusermatch = usermatched;
+	return pathmatchlen;
+}
diff --git a/url-match.h b/url-match.h
new file mode 100644
index 0000000..e9cecd3
--- /dev/null
+++ b/url-match.h
@@ -0,0 +1,35 @@
+#ifndef URL_MATCH_H
+
+struct url_info {
+	/* normalized url on success, must be freed, otherwise NULL */
+	char *url;
+	/* if !url, a brief reason for the failure, otherwise NULL */
+	const char *err;
+
+	/* the rest of the fields are only set if url != NULL */
+
+	size_t url_len;		/* total length of url (which is now normalized) */
+	size_t scheme_len;	/* length of scheme name (excluding final :) */
+	size_t user_off;	/* offset into url to start of user name (0 => none) */
+	size_t user_len;	/* length of user name; if user_off != 0 but
+				   user_len == 0, an empty user name was given */
+	size_t passwd_off;	/* offset into url to start of passwd (0 => none) */
+	size_t passwd_len;	/* length of passwd; if passwd_off != 0 but
+				   passwd_len == 0, an empty passwd was given */
+	size_t host_off;	/* offset into url to start of host name (0 => none) */
+	size_t host_len;	/* length of host name; this INCLUDES any ':portnum';
+				 * file urls may have host_len == 0 */
+	size_t port_len;	/* if a portnum is present (port_len != 0), it has
+				 * this length (excluding the leading ':') at the
+				 * end of the host name (always 0 for file urls) */
+	size_t path_off;	/* offset into url to the start of the url path;
+				 * this will always point to a '/' character
+				 * after the url has been normalized */
+	size_t path_len;	/* length of path portion excluding any trailing
+				 * '?...' and '#...' portion; will always be >= 1 */
+};
+
+extern char *url_normalize(const char *, struct url_info *);
+extern int match_urls(const struct url_info *url, const struct url_info *url_prefix, int *exactusermatch);
+
+#endif /* URL_MATCH_H */
-- 
1.8.4-rc0-137-g17832d4
