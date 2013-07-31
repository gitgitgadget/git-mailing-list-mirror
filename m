From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 3/6] config: add generic callback wrapper to parse section.<url>.key
Date: Wed, 31 Jul 2013 12:26:05 -0700
Message-ID: <1375298768-7740-4-git-send-email-gitster@pobox.com>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com>
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 21:26:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4c2Z-0006Sv-UK
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 21:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760510Ab3GaT0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 15:26:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760436Ab3GaT0X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 15:26:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1D40357B0;
	Wed, 31 Jul 2013 19:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=iu1M
	YgIJFhFHXe+xllYwcQd7vi8=; b=LT4krvXO780TUz0rFMk684clDMDBblzXgrxr
	5ALnLNVISvitDWCk0zYbBhK6IDVYqcJpxMYJKTvXKnTRZVkWBiYc9lkWyw6+0fHy
	zGgoggu6m45wGblAcOHuPoglUOvmXOlWxC29ZCYYhfNDI8YtRuZ81FxrBSI3zBGP
	dQIalRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	OQElOmTiQarzP3Bv1IS9/LmBvM5U/mwrfx7ixZDzfi5/GyHc9AVVEBuFhlFkfle2
	XN3YxAZlwTITE1l6p2oM2pNOn7yuYmtxwWa+Dvrfd6D1YE/k7o3EOqGLJWZFN60r
	jqiQXAKCv43SASVxrPdocD09ZthGV+mdChdpZyoJffE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E086357AE;
	Wed, 31 Jul 2013 19:26:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18A8B357A8;
	Wed, 31 Jul 2013 19:26:20 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc0-153-g9820077
In-Reply-To: <1375298768-7740-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 14517A20-FA17-11E2-B17B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231447>

Existing configuration parsing functions (e.g. http_options() in
http.c) know how to parse two-level configuration variable names.
We would like to exploit them and parse something like this:

	[http]
		sslVerify = true
	[http "https://weak.example.com"]
		sslVerify = false

and pretend as if http.sslVerify were set to false when talking to
"https://weak.example.com/path".

Introduce `urlmatch_config_entry()` wrapper that:

 - is called with the target URL (e.g. "https://weak.example.com/path"),
   and the two-level variable parser (e.g. `http_options`);

 - uses `url_normalize()` and `match_urls()` to see if configuration
   data matches the target URL; and

 - calls the traditional two-level configuration variable parser
   only for the configuration data whose <url> part matches the
   target URL (and if there are multiple matches, only do so if the
   current match is a better match than the ones previously seen).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 urlmatch.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 urlmatch.h | 18 +++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/urlmatch.c b/urlmatch.c
index e1b03ee..073fdd3 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -466,3 +466,70 @@ int match_urls(const struct url_info *url,
 		*exactusermatch = usermatched;
 	return pathmatchlen;
 }
+
+int urlmatch_config_entry(const char *var, const char *value, void *cb)
+{
+	struct string_list_item *item;
+	struct urlmatch_config *collect = cb;
+	struct urlmatch_item *matched;
+	struct url_info *url = &collect->url;
+	const char *key, *dot;
+	struct strbuf synthkey = STRBUF_INIT;
+	size_t matched_len = 0;
+	int user_matched = 0;
+	int retval;
+
+	key = skip_prefix(var, collect->section);
+	if (!key || *(key++) != '.') {
+		if (collect->cascade_fn)
+			return collect->cascade_fn(var, value, cb);
+		return 0; /* not interested */
+	}
+	dot = strrchr(key, '.');
+	if (dot) {
+		char *config_url, *norm_url;
+		struct url_info norm_info;
+
+		config_url = xmemdupz(key, dot - key);
+		norm_url = url_normalize(config_url, &norm_info);
+		free(config_url);
+		if (!norm_url)
+			return 0;
+		matched_len = match_urls(url, &norm_info, &user_matched);
+		free(norm_url);
+		if (!matched_len)
+			return 0;
+		key = dot + 1;
+	}
+
+	if (collect->key && strcmp(key, collect->key))
+		return 0;
+
+	item = string_list_insert(&collect->vars, key);
+	if (!item->util) {
+		matched = xcalloc(1, sizeof(*matched));
+		item->util = matched;
+	} else {
+		matched = item->util;
+		/*
+		 * Is our match shorter?  Is our match the same
+		 * length, and without user while the current
+		 * candidate is with user?  Then we cannot use it.
+		 */
+		if (matched_len < matched->matched_len ||
+		    ((matched_len == matched->matched_len) &&
+		     (!user_matched && matched->user_matched)))
+			return 0;
+		/* Otherwise, replace it with this one. */
+	}
+
+	matched->matched_len = matched_len;
+	matched->user_matched = user_matched;
+	strbuf_addstr(&synthkey, collect->section);
+	strbuf_addch(&synthkey, '.');
+	strbuf_addstr(&synthkey, key);
+	retval = collect->collect_fn(synthkey.buf, value, collect->cb);
+
+	strbuf_release(&synthkey);
+	return retval;
+}
diff --git a/urlmatch.h b/urlmatch.h
index b67f57f..b461dfd 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -33,4 +33,22 @@ struct url_info {
 extern char *url_normalize(const char *, struct url_info *);
 extern int match_urls(const struct url_info *url, const struct url_info *url_prefix, int *exactusermatch);
 
+struct urlmatch_item {
+	size_t matched_len;
+	char user_matched;
+};
+
+struct urlmatch_config {
+	struct string_list vars;
+	struct url_info url;
+	const char *section;
+	const char *key;
+
+	void *cb;
+	int (*collect_fn)(const char *var, const char *value, void *cb);
+	int (*cascade_fn)(const char *var, const char *value, void *cb);
+};
+
+extern int urlmatch_config_entry(const char *var, const char *value, void *cb);
+
 #endif /* URL_MATCH_H */
-- 
1.8.4-rc0-153-g9820077
