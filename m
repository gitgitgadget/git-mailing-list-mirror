From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/3] revert most of the http_options() change
Date: Mon, 29 Jul 2013 19:13:38 -0700
Message-ID: <7v1u6gztf1.fsf_-_@alter.siamese.dyndns.org>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
	<1375138150-19520-1-git-send-email-gitster@pobox.com>
	<7v7gg8ztvk.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 30 04:13:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3zRa-00027V-Ui
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 04:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab3G3CNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 22:13:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094Ab3G3CNl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 22:13:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C75D2B595;
	Tue, 30 Jul 2013 02:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/O6trFf06V+zDmej+4TqhY04Rmk=; b=R1sMjd
	FW8W2q4+jE06N/swlSya4KRAUBMbEUGYaAT2b5u3zo/pMM7VFAh7sPeeB5Cv4jZI
	b7P+ZmYG7TgAKZvNMFaR5VXozbPWlX0loQ45DAoZ6R2QjUt417VfAtm5QcM3dCbG
	v4ettIs/xR0IX39a6k/WTimbXDbW6cYvrwWZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FDyucqPZP5zOI1RrrBhTFxvR5drB1pQ4
	aqYSMmyaWHNVqu6O+mTv/QX4pYWBRSCAvGrXOX03Zc/szif2EvPDznaShbYRs6BY
	LSsrdYyGtWMHRnjwJDA46ETycojxhYKfJqwqrl4GshOHyUd8NRYBOa8/Sttx2bU2
	DgIItGuGxXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20E062B591;
	Tue, 30 Jul 2013 02:13:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9E9A2B589;
	Tue, 30 Jul 2013 02:13:39 +0000 (UTC)
In-Reply-To: <7v7gg8ztvk.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 29 Jul 2013 19:03:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A66A1E68-F8BD-11E2-A418-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231344>

With the previous preparation step, the earlier 1bb00006 (config:
add support for http.<url>.* settings, 2013-07-21) that introduced
many repeated changes:

        -if (!strcmp("http.key", var)) {
        +if (!strcmp("key", key)) {
        +       if (match_is_shorter(..., OPT_KEY_NAME))
        +               return 0;
                ... original processing for KEY_NAME ...
         }

can be reverted.

This allows us to also get rid of the "repeating yourself to the
death" enum http_option_type, and new code (like db/http-savecookies
patch) that wants to add a new configuration to the http.* subsystem
does not have to conflict with http.<urlpattern>.variable series at
all.

This is more-or-less how I want the endgame to look like. Not even
compile tested, but it is getting late so I'll show it to the list
in case people may want to play with it and polish it while I am
away for the night ;-).

If people can agree that this is going in the right direction,
perhaps we should rebuild Kyle's series without detouring of adding
and then yanking what 1bb00006 (config: add support for http.<url>.*
settings, 2013-07-21) did in the next cycle.

 http.c               | 181 +++++++++------------------------------------------
 test-url-normalize.c |   9 ++-
 2 files changed, 39 insertions(+), 151 deletions(-)

diff --git a/http.c b/http.c
index a91a00b..c7f513b 100644
--- a/http.c
+++ b/http.c
@@ -31,35 +31,6 @@ static CURL *curl_default;
 
 char curl_errorstr[CURL_ERROR_SIZE];
 
-enum http_option_type {
-	OPT_POST_BUFFER,
-	OPT_MIN_SESSIONS,
-	OPT_SSL_VERIFY,
-	OPT_SSL_TRY,
-	OPT_SSL_CERT,
-	OPT_SSL_CAINFO,
-	OPT_LOW_SPEED,
-	OPT_LOW_TIME,
-	OPT_NO_EPSV,
-	OPT_HTTP_PROXY,
-	OPT_COOKIE_FILE,
-	OPT_USER_AGENT,
-	OPT_PASSWD_REQ,
-#ifdef USE_CURL_MULTI
-	OPT_MAX_REQUESTS,
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070903
-	OPT_SSL_KEY,
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-	OPT_SSL_CAPATH,
-#endif
-	OPT_MAX
-};
-
-static size_t http_option_max_matched_len[OPT_MAX];
-static int http_option_user_matched[OPT_MAX];
-
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *ssl_cert;
@@ -171,119 +142,37 @@ static void process_curl_messages(void)
 }
 #endif
 
-static int match_is_ignored(size_t matchlen, int usermatch, enum http_option_type opt)
+static int http_options(const char *var, const char *value, void *cb, void *matched)
 {
-	/*
-	 * Compare matchlen to the last matched path length of option opt and
-	 * return true if matchlen is shorter than the last matched length
-	 * (meaning the config setting should be ignored).  Upon seeing the
-	 * _same_ key (i.e. new key has the same match length which is therefore
-	 * not shorter) the new setting will override the previous setting
-	 * unless the new setting did not match the user and the previous match
-	 * did.  Otherwise return false and record matchlen as the current last
-	 * matched path length of option opt and usermatch as the last user
-	 * matching state for option opt.
-	 */
-	if (matchlen < http_option_max_matched_len[opt])
-		return 1;
-	if (matchlen > http_option_max_matched_len[opt]) {
-		http_option_max_matched_len[opt] = matchlen;
-		http_option_user_matched[opt] = usermatch;
-		return 0;
-	}
-	/*
-	 * If a previous match of the same length explicitly matched the user
-	 * name, but the current match matched on any user, ignore it.
-	 */
-	if (!usermatch && http_option_user_matched[opt])
-		return 1;
-	http_option_user_matched[opt] = usermatch;
-	return 0;
-}
-
-static int http_options(const char *var, const char *value, void *cb)
-{
-	const struct url_info *info = cb;
-	const char *key, *dot;
-	size_t matchlen = 0;
-	int usermatch = 0;
-
-	key = skip_prefix(var, "http.");
-	if (!key)
-		return git_default_config(var, value, cb);
-
-	/*
-	 * If the part following the leading "http." contains a '.' then check
-	 * to see if the part between "http." and the last '.' is a match to
-	 * url.  If it's not then ignore the setting.  Otherwise set key to
-	 * point to the option which is the part after the final '.' and
-	 * use key in subsequent comparisons to determine the option type.
-	 */
-	dot = strrchr(key, '.');
-	if (dot) {
-		char *config_url;
-		struct url_info norm_info;
-		char *norm_url;
-
-		if (!info || !info->url)
-			return 0;
-		config_url = xmemdupz(key, dot - key);
-		norm_url = url_normalize(config_url, &norm_info);
-		free(config_url);
-		if (!norm_url)
-			return 0;
-		matchlen = match_urls(info, &norm_info, &usermatch);
-		free(norm_url);
-		if (!matchlen)
-			return 0;
-		key = dot + 1;
-	}
-
-	if (!strcmp("sslverify", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_SSL_VERIFY))
-			return 0;
+	if (!strcmp("http.sslverify", var)) {
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("sslcert", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_SSL_CERT))
-			return 0;
+	if (!strcmp("http.sslcert", var)) {
 		return git_config_string(&ssl_cert, var, value);
 	}
 #if LIBCURL_VERSION_NUM >= 0x070903
-	if (!strcmp("sslkey", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_SSL_KEY))
-			return 0;
+	if (!strcmp("http.sslkey", var)) {
 		return git_config_string(&ssl_key, var, value);
 	}
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
-	if (!strcmp("sslcapath", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_SSL_CAPATH))
-			return 0;
+	if (!strcmp("http.sslcapath", var)) {
 		return git_config_string(&ssl_capath, var, value);
 	}
 #endif
-	if (!strcmp("sslcainfo", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_SSL_CAINFO))
-			return 0;
+	if (!strcmp("http.sslcainfo", var)) {
 		return git_config_string(&ssl_cainfo, var, value);
 	}
-	if (!strcmp("sslcertpasswordprotected", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_PASSWD_REQ))
-			return 0;
+	if (!strcmp("http.sslcertpasswordprotected", var)) {
 		ssl_cert_password_required = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("ssltry", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_SSL_TRY))
-			return 0;
+	if (!strcmp("http.ssltry", var)) {
 		curl_ssl_try = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("minsessions", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_MIN_SESSIONS))
-			return 0;
+	if (!strcmp("http.minsessions", var)) {
 		min_curl_sessions = git_config_int(var, value);
 #ifndef USE_CURL_MULTI
 		if (min_curl_sessions > 1)
@@ -292,56 +181,40 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 #ifdef USE_CURL_MULTI
-	if (!strcmp("maxrequests", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_MAX_REQUESTS))
-			return 0;
+	if (!strcmp("http.maxrequests", var)) {
 		max_requests = git_config_int(var, value);
 		return 0;
 	}
 #endif
-	if (!strcmp("lowspeedlimit", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_LOW_SPEED))
-			return 0;
+	if (!strcmp("http.lowspeedlimit", var)) {
 		curl_low_speed_limit = (long)git_config_int(var, value);
 		return 0;
 	}
-	if (!strcmp("lowspeedtime", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_LOW_TIME))
-			return 0;
+	if (!strcmp("http.lowspeedtime", var)) {
 		curl_low_speed_time = (long)git_config_int(var, value);
 		return 0;
 	}
 
-	if (!strcmp("noepsv", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_NO_EPSV))
-			return 0;
+	if (!strcmp("http.noepsv", var)) {
 		curl_ftp_no_epsv = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp("proxy", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_HTTP_PROXY))
-			return 0;
+	if (!strcmp("http.proxy", var)) {
 		return git_config_string(&curl_http_proxy, var, value);
 	}
 
-	if (!strcmp("cookiefile", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_COOKIE_FILE))
-			return 0;
+	if (!strcmp("http.cookiefile", var)) {
 		return git_config_string(&curl_cookie_file, var, value);
 	}
 
-	if (!strcmp("postbuffer", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_POST_BUFFER))
-			return 0;
+	if (!strcmp("http.postbuffer", var)) {
 		http_post_buffer = git_config_int(var, value);
 		if (http_post_buffer < LARGE_PACKET_MAX)
 			http_post_buffer = LARGE_PACKET_MAX;
 		return 0;
 	}
 
-	if (!strcmp("useragent", key)) {
-		if (match_is_ignored(matchlen, usermatch, OPT_USER_AGENT))
-			return 0;
+	if (!strcmp("http.useragent", var)) {
 		return git_config_string(&user_agent, var, value);
 	}
 
@@ -469,15 +342,23 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
-	struct url_info info;
+	char *normalized_url;
+	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+
+	config.fn = http_options;
+	config.cascade_fn = git_default_config;
+	config.item_alloc = NULL;
+	config.item_clear = NULL;
+	config.cb = NULL;
 
 	http_is_verbose = 0;
+	normalized_url = url_normalize(url, &config.url);
+
+	config.section = "http";
+	config.key = NULL;
 
-	memset(http_option_max_matched_len, 0, sizeof(http_option_max_matched_len));
-	memset(http_option_user_matched, 0, sizeof(http_option_user_matched));
-	url_normalize(url, &info);
-	git_config(http_options, &info);
-	free(info.url);
+	git_config(urlmatch_config_entry, &config);
+	free(normalized_url);
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
diff --git a/test-url-normalize.c b/test-url-normalize.c
index 0b809eb..fab94e5 100644
--- a/test-url-normalize.c
+++ b/test-url-normalize.c
@@ -15,8 +15,15 @@ static int run_http_options(const char *file,
 {
 	struct strbuf opt_lc;
 	size_t i, len;
+	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
 
-	if (git_config_with_options(http_options, (void *)info, file, 0))
+	config.fn = http_options;
+	config.cascade_fn = git_default_config;
+	config.item_alloc = NULL;
+	config.item_clear = NULL;
+	config.cb = NULL;
+
+	if (git_config_with_options(urlmatch_config_entry, &config, file, 0))
 		return 1;
 
 	len = strlen(opt);
