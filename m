From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH ALTERNATIVE v6 2/4] config: add helper to normalize and match URLs
Date: Wed, 31 Jul 2013 13:52:00 -0700
Message-ID: <00149fa65749f81830e791397e4f492@f74d39fa044aa309eaea14b9f57fe79>
References: <72dacc4d84caf9831f5e12ece7f38f2@f74d39fa044aa309eaea14b9f57fe79>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 22:52:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4dNg-0001nL-UN
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 22:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760783Ab3GaUwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 16:52:15 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:49252 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab3GaUwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 16:52:14 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so1182308pde.23
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j2RCSguEw2YerGvSpDpuZ9DZbVGG8BsyJn4cmVs2E5g=;
        b=0GzFCCk/3iU7oxwHG4lMejdO7tRZfhFRYa5e9xn3tWsAfBeZEBbsT5F2+o+xudILd+
         nHtFlzHx6Mp8aByu1lad94Ozqmpx+f2rLiOWYnoux6a9aSSfHsYako7swVXXGy3x0Xs5
         XXthkj0I3/R4kOrk9lyfykma5hQ6U1vhxwx5p1hWqIWI63X2635saIDXZ7FyKDviGXrX
         4pY4CykT78krcMbDhQporA6JzTIUPK6qGC+2/o5J+H2ZIOJ+uz4bqjmEY5kAOMdaF11x
         6zcK54Kcw1V9o4M4LRHK4EC1VFDK1MDzcDmi3ZEhniK6lEZPwE5MGMH0Vlu+6TGbF3cv
         tfWQ==
X-Received: by 10.68.221.138 with SMTP id qe10mr82208744pbc.103.1375303933330;
        Wed, 31 Jul 2013 13:52:13 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ys4sm92445pbb.9.2013.07.31.13.52.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 13:52:12 -0700 (PDT)
In-Reply-To: <72dacc4d84caf9831f5e12ece7f38f2@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231460>

Some http.* configuration variables need to take values customized
for the URL we are talking to.  We may want to set http.sslVerify to
true in general but to false only for a certain site, for example,
with a configuration file like this:

	[http]
		sslVerify = true
	[http "https://weak.example.com"]
		sslVerify = false

and let the configuration machinery pick up the latter only when
talking to "https://weak.example.com".  The latter needs to kick in
not only when the URL is exactly "https://weak.example.com", but
also is anything that "match" it, e.g.

	https://weak.example.com/test
	https://me@weak.example.com/test

The <url> in the configuration key consists of the following parts,
and is considered a match to the URL we are attempting to access
under certain conditions:

  . Scheme (e.g., `https` in `https://example.com/`). This field
    must match exactly between the config key and the URL.

  . Host/domain name (e.g., `example.com` in `https://example.com/`).
    This field must match exactly between the config key and the URL.

  . Port number (e.g., `8080` in `http://example.com:8080/`).  This
    field must match exactly between the config key and the URL.
    Omitted port numbers are automatically converted to the correct
    default for the scheme before matching.

  . Path (e.g., `repo.git` in `https://example.com/repo.git`). The
    path field of the config key must match the path field of the
    URL either exactly or as a prefix of slash-delimited path
    elements.  A config key with path `foo/` matches URL path
    `foo/bar`.  A prefix can only match on a slash (`/`) boundary.
    Longer matches take precedence (so a config key with path
    `foo/bar` is a better match to URL path `foo/bar` than a config
    key with just path `foo/`).

  . User name (e.g., `me` in `https://me@example.com/repo.git`). If
    the config key has a user name, it must match the user name in
    the URL exactly. If the config key does not have a user name,
    that config key will match a URL with any user name (including
    none), but at a lower precedence than a config key with a user
    name.

Longer matches take precedence over shorter matches.

This step adds two helper functions `url_normalize()` and
`match_urls()` to help implement the above semantics. The
normalization rules are based on RFC 3986 and should result in any
two equivalent urls being a match.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 urlmatch.c | 468 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 urlmatch.h |  36 +++++
 2 files changed, 504 insertions(+)
 create mode 100644 urlmatch.c
 create mode 100644 urlmatch.h

diff --git a/urlmatch.c b/urlmatch.c
new file mode 100644
index 00000000..4f38cc7b
--- /dev/null
+++ b/urlmatch.c
@@ -0,0 +1,468 @@
+#include "cache.h"
+#include "urlmatch.h"
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
+static size_t url_match_prefix(const char *url,
+			       const char *url_prefix,
+			       size_t url_prefix_len)
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
+	pathmatchlen = url_match_prefix(
+		url->url + url->path_off,
+		url_prefix->url + url_prefix->path_off,
+		url_prefix->url_len - url_prefix->path_off);
+
+	if (pathmatchlen && exactusermatch)
+		*exactusermatch = usermatched;
+	return pathmatchlen;
+}
diff --git a/urlmatch.h b/urlmatch.h
new file mode 100644
index 00000000..b67f57f8
--- /dev/null
+++ b/urlmatch.h
@@ -0,0 +1,36 @@
+#ifndef URL_MATCH_H
+#include "string-list.h"
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
1.8.3
