From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v8 4/4] config: allow http.<url>.* any user matching
Date: Mon, 22 Jul 2013 05:56:44 -0700
Message-ID: <7dfaadb69accede33b88ae2d9e47a48@f74d39fa044aa309eaea14b9f57fe79>
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
X-From: git-owner@vger.kernel.org Mon Jul 22 14:57:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Ffy-0001uU-R7
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 14:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275Ab3GVM5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 08:57:08 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:56644 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab3GVM5D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 08:57:03 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so6791129pdd.6
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iLSGUt/ZadJogmolZPRNNEm3V7nGiF6z+wkXW1EeRYk=;
        b=xJ8F8jtCh+/CXowUNV+6kd049Lpdosw0q8tEx3OnB0Xb6BQSoz98Z51xC2jhg+ct2t
         DHDW2g7YHK6v1bcTcpHbWjwYuy1GbwP9qKXZx/fn6Ijk5e5l7UZjXkpyC2N54jI6zMrR
         pycgo5UBwXQKbXE7sk7ZlHvcQbkPH53VGZV5008I5YCZPYp5ClV6XnxSd57MzxCmswdN
         kmEGCHasw1ql7RnGwC1vd3JtaGwMTaQ83grv1D3M6fdIDIr/VAY5sSbX1LF0L7apvGG0
         O+7E++Vgm4BgwNrnjsBXkusxSG6S0cYzosfTrhhFwBLNrBgHUgooUlrG/Nu7agsl1ovD
         8XEg==
X-Received: by 10.66.2.164 with SMTP id 4mr32085053pav.55.1374497822621;
        Mon, 22 Jul 2013 05:57:02 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id x8sm35698437pbb.39.2013.07.22.05.57.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 05:57:01 -0700 (PDT)
In-Reply-To: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230981>

Previously the <url> had to specify an exactly matching user name
and password if those were present in the url being matched against.

Now the password portion is always ignored and omitting the user
name from <url> allows it to match against any user name.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 Documentation/config.txt |  29 +++--
 http.c                   | 281 +++++++++++++++++++++++++++++++++++++++--------
 t/t5200-url-normalize.sh |   3 +-
 t/t5200/config-3         |   4 +
 test-url-normalize.c     |  17 +--
 5 files changed, 270 insertions(+), 64 deletions(-)
 create mode 100644 t/t5200/config-3

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e461f32..c418adf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1517,15 +1517,26 @@ http.<url>.*::
 	Any of the http.* options above can be applied selectively to some urls.
 	For example "http.https://example.com.useragent" would set the user
 	agent only for https connections to example.com.  The <url> value
-	matches a url if it is an exact match or if it is a prefix of the url
-	matching at a "/" boundary.  Longer <url> matches take precedence over
-	shorter ones with the environment variable settings taking precedence
-	over all.  The urls are normalized before testing for a match.  Note,
-	however, that any user, password and/or port setting that appears in a
-	url must also match that part of <url> to have a successful match.  The
-	urls that are matched against are those given directly to git commands.
-	This means any urls visited as a result of a redirection do not
-	participate in matching.
+	matches a url if it refers to the same scheme, host and port and the
+	path portion is an exact match or a prefix that matches at a "/"
+	boundary.  If <url> does not include a user name, it will match a url
+	with any username otherwise the user name must match as well (the
+	password part, if present in the url, is always ignored).  Longer <url>
+	path matches take precedence over shorter matches no matter what order
+	they occur in.  For example, if both "https://user@example.com/path" and
+	"https://example.com/path/name" are used as a config <url> value and
+	then "https://user@example.com/path/name/here" is passed to a git
+	command, the settings in the "https://example.com/path/name" section
+	will be preferred because that <url> has a longer path length match than
+	"https://user@example.com/path" even though the latter did match the
+	user.  For same length matches, the last one wins except that a same
+	length <url> match that includes a user name will be preferred over a
+	same length <url> match that does not.  The urls are normalized before
+	matching so that equivalent urls that are simply spelled differently
+	will match properly.  Environment variable settings always override any
+	matches.  The urls that are matched against are those given directly to
+	git commands.  This means any urls visited as a result of a redirection
+	do not participate in matching.
 
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
diff --git a/http.c b/http.c
index 29e119c..c636d3c 100644
--- a/http.c
+++ b/http.c
@@ -56,7 +56,35 @@ enum http_option_type {
 	OPT_MAX
 };
 
+struct url_info {
+	char *url;		/* normalized url on success, must be freed, otherwise NULL */
+	const char *err;	/* if !url, a brief reason for the failure, otherwise NULL */
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
 static size_t http_option_max_matched_len[OPT_MAX];
+static int http_option_user_matched[OPT_MAX];
 
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
@@ -231,7 +259,7 @@ static int append_normalized_escapes(struct strbuf *buf,
 	return 1;
 }
 
-static char *http_options_url_normalize(const char *url)
+static char *http_options_url_normalize(const char *url, struct url_info *out_info)
 {
 	/*
 	 * Normalize NUL-terminated url using the following rules:
@@ -254,6 +282,14 @@ static char *http_options_url_normalize(const char *url)
 	 * The return value is a newly allocated string that must be freed
 	 * or NULL if the url is not valid.
 	 *
+	 * If out_info is non-NULL, the url and err fields therein will always
+	 * be set.  If a non-NULL value is returned, it will be stored in
+	 * out_info->url as well, out_info->err will be set to NULL and the
+	 * other fields of *out_info will also be filled in.  If a NULL value
+	 * is returned, NULL will be stored in out_info->url and out_info->err
+	 * will be set to a brief, translated, error message, but no other
+	 * fields will be filled in.
+	 *
 	 * This is NOT a URL validation function.  Full URL validation is NOT
 	 * performed.  Some invalid host names are passed through this function
 	 * undetected.  However, most all other problems that make a URL invalid
@@ -263,9 +299,10 @@ static char *http_options_url_normalize(const char *url)
 	size_t url_len = strlen(url);
 	struct strbuf norm;
 	size_t spanned;
+	size_t scheme_len, user_off=0, user_len=0, passwd_off=0, passwd_len=0;
+	size_t host_off=0, host_len=0, port_len=0, path_off, path_len, result_len;
 	const char *slash_ptr, *at_ptr, *colon_ptr, *path_start;
-	int found_host = 0;
-
+	char *result;
 
 	/*
 	 * Copy lowercased scheme and :// suffix, %-escapes are not allowed
@@ -273,9 +310,15 @@ static char *http_options_url_normalize(const char *url)
 	 */
 	spanned = strspn(url, URL_SCHEME_CHARS);
 	if (!spanned || !isalpha(url[0]) || spanned + 3 > url_len ||
-	    url[spanned] != ':' || url[spanned+1] != '/' || url[spanned+2] != '/')
+	    url[spanned] != ':' || url[spanned+1] != '/' || url[spanned+2] != '/') {
+		if (out_info) {
+			out_info->url = NULL;
+			out_info->err = _("invalid URL scheme name or missing '://' suffix");
+		}
 		return NULL; /* Bad scheme and/or missing "://" part */
+	}
 	strbuf_init(&norm, url_len);
+	scheme_len = spanned;
 	spanned += 3;
 	url_len -= spanned;
 	while (spanned--)
@@ -288,12 +331,25 @@ static char *http_options_url_normalize(const char *url)
 	at_ptr = strchr(url, '@');
 	slash_ptr = url + strcspn(url, "/?#");
 	if (at_ptr && at_ptr < slash_ptr) {
+		user_off = norm.len;
 		if (at_ptr > url) {
 			if (!append_normalized_escapes(&norm, url, at_ptr - url,
 						       "", URL_RESERVED)) {
+				if (out_info) {
+					out_info->url = NULL;
+					out_info->err = _("invalid %XX escape sequence");
+				}
 				strbuf_release(&norm);
 				return NULL;
 			}
+			colon_ptr = strchr(norm.buf + scheme_len + 3, ':');
+			if (colon_ptr) {
+				passwd_off = (colon_ptr + 1) - norm.buf;
+				passwd_len = norm.len - passwd_off;
+				user_len = (passwd_off - 1) - (scheme_len + 3);
+			} else {
+				user_len = norm.len - (scheme_len + 3);
+			}
 		}
 		strbuf_addch(&norm, '@');
 		url_len -= (++at_ptr - url);
@@ -307,25 +363,37 @@ static char *http_options_url_normalize(const char *url)
 	if (!url_len || strchr(":/?#", *url)) {
 		/* Missing host invalid for all URL schemes except file */
 		if (strncmp(norm.buf, "file:", 5)) {
+			if (out_info) {
+				out_info->url = NULL;
+				out_info->err = _("missing host and scheme is not 'file:'");
+			}
 			strbuf_release(&norm);
 			return NULL;
 		}
 	} else {
-		found_host = 1;
+		host_off = norm.len;
 	}
 	colon_ptr = slash_ptr - 1;
 	while (colon_ptr > url && *colon_ptr != ':' && *colon_ptr != ']')
 		colon_ptr--;
 	if (*colon_ptr != ':') {
 		colon_ptr = slash_ptr;
-	} else if (!found_host && colon_ptr < slash_ptr && colon_ptr + 1 != slash_ptr) {
+	} else if (!host_off && colon_ptr < slash_ptr && colon_ptr + 1 != slash_ptr) {
 		/* file: URLs may not have a port number */
+		if (out_info) {
+			out_info->url = NULL;
+			out_info->err = _("a 'file:' URL may not have a port number");
+		}
 		strbuf_release(&norm);
 		return NULL;
 	}
 	spanned = strspn(url, URL_HOST_CHARS);
 	if (spanned < colon_ptr - url) {
 		/* Host name has invalid characters */
+		if (out_info) {
+			out_info->url = NULL;
+			out_info->err = _("invalid characters in host name");
+		}
 		strbuf_release(&norm);
 		return NULL;
 	}
@@ -367,6 +435,10 @@ static char *http_options_url_normalize(const char *url)
 			spanned = strspn(url, URL_DIGIT);
 			if (spanned < slash_ptr - url) {
 				/* port number has invalid characters */
+				if (out_info) {
+					out_info->url = NULL;
+					out_info->err = _("invalid port number");
+				}
 				strbuf_release(&norm);
 				return NULL;
 			}
@@ -374,15 +446,22 @@ static char *http_options_url_normalize(const char *url)
 				pnum = strtoul(url, NULL, 10);
 			if (pnum == 0 || pnum > 65535) {
 				/* port number not in range 1..65535 */
+				if (out_info) {
+					out_info->url = NULL;
+					out_info->err = _("invalid port number");
+				}
 				strbuf_release(&norm);
 				return NULL;
 			}
 			strbuf_addch(&norm, ':');
 			strbuf_add(&norm, url, slash_ptr - url);
+			port_len = slash_ptr - url;
 		}
 		url_len -= slash_ptr - colon_ptr;
 		url = slash_ptr;
 	}
+	if (host_off)
+		host_len = norm.len - host_off;
 
 
 	/*
@@ -390,7 +469,8 @@ static char *http_options_url_normalize(const char *url)
 	 * to corrupt the URL by unescaping any delimiters, but do add an
 	 * initial '/' if it's missing and do normalize any %-escape sequences.
 	 */
-	path_start = norm.buf + norm.len;
+	path_off = norm.len;
+	path_start = norm.buf + path_off;
 	strbuf_addch(&norm, '/');
 	if (*url == '/') {
 		url++;
@@ -406,6 +486,10 @@ static char *http_options_url_normalize(const char *url)
 		 */
 		if (!append_normalized_escapes(&norm, url, next_slash - url, "",
 					       URL_RESERVED)) {
+			if (out_info) {
+				out_info->url = NULL;
+				out_info->err = _("invalid %XX escape sequence");
+			}
 			strbuf_release(&norm);
 			return NULL;
 		}
@@ -425,6 +509,10 @@ static char *http_options_url_normalize(const char *url)
 			const char *prev_slash = norm.buf + norm.len - 3;
 			if (prev_slash == path_start) {
 				/* invalid .. because no previous segment to remove */
+				if (out_info) {
+					out_info->url = NULL;
+					out_info->err = _("invalid '..' path segment");
+				}
 				strbuf_release(&norm);
 				return NULL;
 			}
@@ -446,6 +534,7 @@ static char *http_options_url_normalize(const char *url)
 		if (!skip_add_slash)
 			strbuf_addch(&norm, '/');
 	}
+	path_len = norm.len - path_off;
 
 
 	/*
@@ -454,13 +543,33 @@ static char *http_options_url_normalize(const char *url)
 	 */
 	if (*url) {
 		if (!append_normalized_escapes(&norm, url, url_len, "", URL_RESERVED)) {
+			if (out_info) {
+				out_info->url = NULL;
+				out_info->err = _("invalid %XX escape sequence");
+			}
 			strbuf_release(&norm);
 			return NULL;
 		}
 	}
 
 
-	return strbuf_detach(&norm, NULL);
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
 }
 
 static size_t http_options_url_match_prefix(const char *url,
@@ -476,48 +585,120 @@ static size_t http_options_url_match_prefix(const char *url,
 	 * url must be NUL terminated.  url_prefix_len is the length of
 	 * url_prefix which need not be NUL terminated.
 	 *
-	 * The return value is the length of the match in characters (excluding
-	 * any final '/') or 0 for no match.  Passing "/" as url_prefix will
-	 * always cause 0 to be returned.
+	 * The return value is the length of the match in characters (including
+	 * the final '/' even if it's implicit) or 0 for no match.
 	 *
 	 * Passing NULL as url and/or url_prefix will always cause 0 to be
 	 * returned without causing any faults.
 	 */
-	size_t url_len;
 	if (!url || !url_prefix)
 		return 0;
-	if (url_prefix_len && url_prefix[url_prefix_len - 1] == '/')
+	if (!url_prefix_len || (url_prefix_len == 1 && *url_prefix == '/'))
+		return (!*url || *url == '/') ? 1 : 0;
+	if (url_prefix[url_prefix_len - 1] == '/')
 		url_prefix_len--;
-	if (!url_prefix_len || strncmp(url, url_prefix, url_prefix_len))
+	if (strncmp(url, url_prefix, url_prefix_len))
 		return 0;
-	url_len = strlen(url);
-	if ((url_len == url_prefix_len) || (url[url_prefix_len] == '/'))
-		return url_prefix_len;
+	if ((strlen(url) == url_prefix_len) || (url[url_prefix_len] == '/'))
+		return url_prefix_len + 1;
 	return 0;
 }
 
-static int new_match_is_shorter(size_t matchlen, enum http_option_type opt)
+static int http_options_match_urls(const struct url_info *url,
+				   const struct url_info *url_prefix,
+				   int *exactusermatch)
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
+
+static int match_is_ignored(size_t matchlen, int usermatch, enum http_option_type opt)
 {
 	/*
-	 * Compare matchlen to the last matched length of option opt and
+	 * Compare matchlen to the last matched path length of option opt and
 	 * return true if matchlen is shorter than the last matched length
 	 * (meaning the config setting should be ignored).  Upon seeing the
 	 * _same_ key (i.e. new key has the same match length which is therefore
-	 * not shorter) the new setting will override the previous setting.
-	 * Otherwise return false and record matchlen as the current last
-	 * matched length of option opt.
+	 * not shorter) the new setting will override the previous setting
+	 * unless the new setting did not match the user and the previous match
+	 * did.  Otherwise return false and record matchlen as the current last
+	 * matched path length of option opt and usermatch as the last user
+	 * matching state for option opt.
 	 */
 	if (matchlen < http_option_max_matched_len[opt])
 		return 1;
-	http_option_max_matched_len[opt] = matchlen;
+	if (matchlen > http_option_max_matched_len[opt]) {
+		http_option_max_matched_len[opt] = matchlen;
+		http_option_user_matched[opt] = usermatch;
+		return 0;
+	}
+	/*
+	 * If a previous match of the same length explicitly matched the user
+	 * name, but the current match matched on any user, ignore it.
+	 */
+	if (!usermatch && http_option_user_matched[opt])
+		return 1;
+	http_option_user_matched[opt] = usermatch;
 	return 0;
 }
 
 static int http_options(const char *var, const char *value, void *cb)
 {
-	const char *url = cb;
+	const struct url_info *info = cb;
 	const char *key, *dot;
 	size_t matchlen = 0;
+	int usermatch = 0;
 
 	key = skip_prefix(var, "http.");
 	if (!key)
@@ -532,12 +713,18 @@ static int http_options(const char *var, const char *value, void *cb)
 	 */
 	dot = strrchr(key, '.');
 	if (dot) {
-		char *config_url = xmemdupz(key, dot - key);
-		char *norm_url = http_options_url_normalize(config_url);
+		char *config_url;
+		struct url_info norm_info;
+		char *norm_url;
+
+		if (!info || !info->url)
+			return 0;
+		config_url = xmemdupz(key, dot - key);
+		norm_url = http_options_url_normalize(config_url, &norm_info);
 		free(config_url);
 		if (!norm_url)
 			return 0;
-		matchlen = http_options_url_match_prefix(url, norm_url, strlen(norm_url));
+		matchlen = http_options_match_urls(info, &norm_info, &usermatch);
 		free(norm_url);
 		if (!matchlen)
 			return 0;
@@ -545,49 +732,49 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp("sslverify", key)) {
-		if (new_match_is_shorter(matchlen, OPT_SSL_VERIFY))
+		if (match_is_ignored(matchlen, usermatch, OPT_SSL_VERIFY))
 			return 0;
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp("sslcert", key)) {
-		if (new_match_is_shorter(matchlen, OPT_SSL_CERT))
+		if (match_is_ignored(matchlen, usermatch, OPT_SSL_CERT))
 			return 0;
 		return git_config_string(&ssl_cert, var, value);
 	}
 #if LIBCURL_VERSION_NUM >= 0x070903
 	if (!strcmp("sslkey", key)) {
-		if (new_match_is_shorter(matchlen, OPT_SSL_KEY))
+		if (match_is_ignored(matchlen, usermatch, OPT_SSL_KEY))
 			return 0;
 		return git_config_string(&ssl_key, var, value);
 	}
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
 	if (!strcmp("sslcapath", key)) {
-		if (new_match_is_shorter(matchlen, OPT_SSL_CAPATH))
+		if (match_is_ignored(matchlen, usermatch, OPT_SSL_CAPATH))
 			return 0;
 		return git_config_string(&ssl_capath, var, value);
 	}
 #endif
 	if (!strcmp("sslcainfo", key)) {
-		if (new_match_is_shorter(matchlen, OPT_SSL_CAINFO))
+		if (match_is_ignored(matchlen, usermatch, OPT_SSL_CAINFO))
 			return 0;
 		return git_config_string(&ssl_cainfo, var, value);
 	}
 	if (!strcmp("sslcertpasswordprotected", key)) {
-		if (new_match_is_shorter(matchlen, OPT_PASSWD_REQ))
+		if (match_is_ignored(matchlen, usermatch, OPT_PASSWD_REQ))
 			return 0;
 		ssl_cert_password_required = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp("ssltry", key)) {
-		if (new_match_is_shorter(matchlen, OPT_SSL_TRY))
+		if (match_is_ignored(matchlen, usermatch, OPT_SSL_TRY))
 			return 0;
 		curl_ssl_try = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp("minsessions", key)) {
-		if (new_match_is_shorter(matchlen, OPT_MIN_SESSIONS))
+		if (match_is_ignored(matchlen, usermatch, OPT_MIN_SESSIONS))
 			return 0;
 		min_curl_sessions = git_config_int(var, value);
 #ifndef USE_CURL_MULTI
@@ -598,45 +785,45 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 #ifdef USE_CURL_MULTI
 	if (!strcmp("maxrequests", key)) {
-		if (new_match_is_shorter(matchlen, OPT_MAX_REQUESTS))
+		if (match_is_ignored(matchlen, usermatch, OPT_MAX_REQUESTS))
 			return 0;
 		max_requests = git_config_int(var, value);
 		return 0;
 	}
 #endif
 	if (!strcmp("lowspeedlimit", key)) {
-		if (new_match_is_shorter(matchlen, OPT_LOW_SPEED))
+		if (match_is_ignored(matchlen, usermatch, OPT_LOW_SPEED))
 			return 0;
 		curl_low_speed_limit = (long)git_config_int(var, value);
 		return 0;
 	}
 	if (!strcmp("lowspeedtime", key)) {
-		if (new_match_is_shorter(matchlen, OPT_LOW_TIME))
+		if (match_is_ignored(matchlen, usermatch, OPT_LOW_TIME))
 			return 0;
 		curl_low_speed_time = (long)git_config_int(var, value);
 		return 0;
 	}
 
 	if (!strcmp("noepsv", key)) {
-		if (new_match_is_shorter(matchlen, OPT_NO_EPSV))
+		if (match_is_ignored(matchlen, usermatch, OPT_NO_EPSV))
 			return 0;
 		curl_ftp_no_epsv = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp("proxy", key)) {
-		if (new_match_is_shorter(matchlen, OPT_HTTP_PROXY))
+		if (match_is_ignored(matchlen, usermatch, OPT_HTTP_PROXY))
 			return 0;
 		return git_config_string(&curl_http_proxy, var, value);
 	}
 
 	if (!strcmp("cookiefile", key)) {
-		if (new_match_is_shorter(matchlen, OPT_COOKIE_FILE))
+		if (match_is_ignored(matchlen, usermatch, OPT_COOKIE_FILE))
 			return 0;
 		return git_config_string(&curl_cookie_file, var, value);
 	}
 
 	if (!strcmp("postbuffer", key)) {
-		if (new_match_is_shorter(matchlen, OPT_POST_BUFFER))
+		if (match_is_ignored(matchlen, usermatch, OPT_POST_BUFFER))
 			return 0;
 		http_post_buffer = git_config_int(var, value);
 		if (http_post_buffer < LARGE_PACKET_MAX)
@@ -645,7 +832,7 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp("useragent", key)) {
-		if (new_match_is_shorter(matchlen, OPT_USER_AGENT))
+		if (match_is_ignored(matchlen, usermatch, OPT_USER_AGENT))
 			return 0;
 		return git_config_string(&user_agent, var, value);
 	}
@@ -774,13 +961,15 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
-	char *norm_url = http_options_url_normalize(url);
+	struct url_info info;
 
 	http_is_verbose = 0;
 
 	memset(http_option_max_matched_len, 0, sizeof(http_option_max_matched_len));
-	git_config(http_options, norm_url);
-	free(norm_url);
+	memset(http_option_user_matched, 0, sizeof(http_option_user_matched));
+	http_options_url_normalize(url, &info);
+	git_config(http_options, &info);
+	free(info.url);
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
diff --git a/t/t5200-url-normalize.sh b/t/t5200-url-normalize.sh
index d2dd886..f79bb0f 100755
--- a/t/t5200-url-normalize.sh
+++ b/t/t5200-url-normalize.sh
@@ -192,7 +192,8 @@ test_expect_success 'url config normalization matching' '
 	test "$(test-url-normalize -c "$tc-1" "noEPSV" "https://example.com")" = "true" &&
 	test "$(test-url-normalize -c "$tc-1" "noEPSV" "https://example.com/path")" = "true" &&
 	test "$(test-url-normalize -c "$tc-2" "useragent" "HTTPS://example.COM/p%61th")" = "example-agent" &&
-	test "$(test-url-normalize -c "$tc-2" "sslVerify" "HTTPS://example.COM/p%61th")" = "false"
+	test "$(test-url-normalize -c "$tc-2" "sslVerify" "HTTPS://example.COM/p%61th")" = "false" &&
+	test "$(test-url-normalize -c "$tc-3" "sslcainfo" "https://user@example.com/path/name/here")" = "file-1"
 '
 
 test_done
diff --git a/t/t5200/config-3 b/t/t5200/config-3
new file mode 100644
index 0000000..5c8d3e8
--- /dev/null
+++ b/t/t5200/config-3
@@ -0,0 +1,4 @@
+[http "https://example.com/path/name"]
+	sslcainfo = file-1
+[http "https://user@example.com/path"]
+	sslcainfo = file-2
diff --git a/test-url-normalize.c b/test-url-normalize.c
index f18bd88..4f870dc 100644
--- a/test-url-normalize.c
+++ b/test-url-normalize.c
@@ -11,12 +11,12 @@ int main()
 
 static int run_http_options(const char *file,
 			    const char *opt,
-			    const char *url)
+			    const struct url_info *info)
 {
 	struct strbuf opt_lc;
 	size_t i, len;
 
-	if (git_config_with_options(http_options, (void *)url, file, 0))
+	if (git_config_with_options(http_options, (void *)info, file, 0))
 		return 1;
 
 	len = strlen(opt);
@@ -65,7 +65,7 @@ static int run_http_options(const char *file,
 	return 0;
 }
 
-#define url_normalize(u) http_options_url_normalize(u)
+#define url_normalize(u,i) http_options_url_normalize(u,i)
 
 int main(int argc, char **argv)
 {
@@ -108,23 +108,24 @@ int main(int argc, char **argv)
 		die(usage);
 
 	if (argc == 2) {
-		url1 = url_normalize(argv[1]);
+		struct url_info info;
+		url1 = url_normalize(argv[1], &info);
 		if (!url1)
 			return 1;
 		if (opt_p)
 			printf("%s\n", url1);
 		if (opt_l)
-			printf("%u\n", (unsigned)strlen(url1));
+			printf("%u\n", (unsigned)info.url_len);
 		if (opt_c)
-			return run_http_options(file, optname, url1);
+			return run_http_options(file, optname, &info);
 		return 0;
 	}
 
 	if (opt_p || opt_l || opt_c)
 		die(usage);
 
-	url1 = url_normalize(argv[1]);
-	url2 = url_normalize(argv[2]);
+	url1 = url_normalize(argv[1], NULL);
+	url2 = url_normalize(argv[2], NULL);
 	return (url1 && url2 && !strcmp(url1, url2)) ? 0 : 1;
 }
 
-- 
1.8.3
