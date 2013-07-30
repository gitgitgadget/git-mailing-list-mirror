From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/3] url-match: generalize configuration collection logic
Date: Mon, 29 Jul 2013 19:03:43 -0700
Message-ID: <7v7gg8ztvk.fsf_-_@alter.siamese.dyndns.org>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
	<1375138150-19520-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 30 04:03:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3zHz-0005Pi-Jf
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 04:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab3G3CDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 22:03:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52729 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab3G3CDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 22:03:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1E5E2AF72;
	Tue, 30 Jul 2013 02:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eERbSXb8ctUY7K6j+pN2Po28gfo=; b=eSnMdG
	tVAL+4yNmZAjRJ2uZAVZzziij/BqXQOi5VMZj4tyWNnh06u5q+OjMKVlevO2bR2X
	03gLEpwtCZn2UwkjC/Nm3rmkaQXGl1zy/5DSFwKkzWsNK/h50RFsIyvsVybEiver
	QNgLztaP0l8ThCBlLlwxvAUUYsSaL/Uz6u0xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cEytsBhSAnv7IJw6AseHcaP/nLiSw7ME
	/kZdTzNPHqZ3tsZScZBK1CQ65mTyZkffOAkaDW3j0UNYLSWbA47PBo84+u+cYJwO
	taElLlpJSuCZAxr+Aio593IOByUZhItSIhCoU3R6riviZDquNjPm4/t6V7pV7I5W
	Im+bmWkQh9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E81062AF71;
	Tue, 30 Jul 2013 02:03:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C83832AF6E;
	Tue, 30 Jul 2013 02:03:44 +0000 (UTC)
In-Reply-To: <1375138150-19520-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Mon, 29 Jul 2013 15:49:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43B9317E-F8BC-11E2-893A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231343>

Instead of always collecting the found value in the strbuf in the
string list item for each found key, allow a set of callback
functions to be specified by the user to be called back at strategic
places.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/config.c | 117 +++++++++++++++++--------------------------------------
 url-match.c      |  75 +++++++++++++++++++++++++++++++++++
 url-match.h      |  22 +++++++++++
 3 files changed, 133 insertions(+), 81 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index c1d32ae..173c18f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -351,79 +351,17 @@ static int get_colorbool(int print)
 		return get_colorbool_found ? 0 : 1;
 }
 
-struct urlmatch_collect {
-	struct string_list vars;
-	struct url_info url;
-	const char *section;
-	const char *key;
-};
-
-struct urlmatch_item {
-	size_t max_matched_len;
-	char user_matched;
+struct urlmatch_config_item {
+	struct urlmatch_item match;
 	char value_is_null;
 	struct strbuf value;
 };
 
-static int urlmatch_collect(const char *var, const char *value, void *cb)
+static int urlmatch_collect_fn(const char *var, const char *value,
+			       void *cb, void *matched_cb)
 {
-	struct string_list_item *item;
-	struct urlmatch_collect *collect = cb;
-	struct urlmatch_item *matched;
-	struct url_info *url = &collect->url;
-	const char *key, *dot;
-	size_t matchlen = 0;
-	int usermatch = 0;
-
-	key = skip_prefix(var, collect->section);
-	if (!key || *(key++) != '.')
-		return 0; /* not interested */
-	dot = strrchr(key, '.');
-	if (dot) {
-		char *config_url, *norm_url;
-		struct url_info norm_info;
-		int matchlen;
-
-		config_url = xmemdupz(key, dot - key);
-		norm_url = url_normalize(config_url, &norm_info);
-		free(config_url);
-		if (!norm_url)
-			return 0;
-		matchlen = match_urls(url, &norm_info, &usermatch);
-		free(norm_url);
-		if (!matchlen)
-			return 0;
-		key = dot + 1;
-	}
-
-	if (collect->key && strcmp(key, collect->key))
-		return 0;
+	struct urlmatch_config_item *matched = matched_cb;
 
-	item = string_list_insert(&collect->vars, key);
-	if (!item->util) {
-		matched = xcalloc(1, sizeof(*matched));
-		item->util = matched;
-		strbuf_init(&matched->value, 0);
-	} else {
-		matched = item->util;
-		/*
-		 * Is our match shorter?  Is our match the same
-		 * length, and without user while the current
-		 * candidate is with user?  Then we cannot use it.
-		 */
-		if (matchlen < matched->max_matched_len ||
-		    ((matchlen == matched->max_matched_len) &&
-		     (!usermatch && matched->user_matched)))
-			return 0;
-		/*
-		 * Otherwise, release the old one and replace
-		 * with ours.
-		 */
-		strbuf_release(&matched->value);
-	}
-
-	matched->max_matched_len = matchlen;
-	matched->user_matched = usermatch;
 	if (value) {
 		strbuf_addstr(&matched->value, value);
 		matched->value_is_null = 0;
@@ -433,35 +371,52 @@ static int urlmatch_collect(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static void *urlmatch_alloc_fn(const char *var, const char *value, void *cb)
+{
+	return xcalloc(1, sizeof(struct urlmatch_config_item));
+}
+
+static void urlmatch_clear_fn(void *matched_cb)
+{
+	struct urlmatch_config_item *matched = matched_cb;
+	strbuf_init(&matched->value, 0);
+}
+
 static int get_urlmatch(const char *var, const char *url)
 {
 	const char *section_tail;
 	struct string_list_item *item;
-	struct urlmatch_collect collect = { STRING_LIST_INIT_DUP };
+	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+
+	config.fn = urlmatch_collect_fn;
+	config.cascade_fn = NULL;
+	config.item_alloc = urlmatch_alloc_fn;
+	config.item_clear = urlmatch_clear_fn;
+	config.cb = NULL;
 
-	if (!url_normalize(url, &collect.url))
-		die(collect.url.err);
+	if (!url_normalize(url, &config.url))
+		die(config.url.err);
 
 	section_tail = strchr(var, '.');
 	if (section_tail) {
-		collect.section = xmemdupz(var, section_tail - var);
-		collect.key = strrchr(var, '.') + 1;
+		config.section = xmemdupz(var, section_tail - var);
+		config.key = strrchr(var, '.') + 1;
 		show_keys = 0;
 	} else {
-		collect.section = var;
-		collect.key = NULL;
+		config.section = var;
+		config.key = NULL;
 		show_keys = 1;
 	}
 
-	git_config_with_options(urlmatch_collect, &collect,
+	git_config_with_options(urlmatch_config_entry, &config,
 				given_config_file, respect_includes);
 
-	for_each_string_list_item(item, &collect.vars) {
-		struct urlmatch_item *matched = item->util;
+	for_each_string_list_item(item, &config.vars) {
+		struct urlmatch_config_item *matched = item->util;
 		struct strbuf key = STRBUF_INIT;
 		struct strbuf buf = STRBUF_INIT;
 
-		strbuf_addstr(&key, collect.section);
+		strbuf_addstr(&key, config.section);
 		strbuf_addch(&key, '.');
 		strbuf_addstr(&key, item->string);
 		format_config(&buf, key.buf,
@@ -472,7 +427,7 @@ static int get_urlmatch(const char *var, const char *url)
 
 		strbuf_release(&matched->value);
 	}
-	string_list_clear(&collect.vars, 1);
+	string_list_clear(&config.vars, 1);
 
 	/*
 	 * section name may have been copied to replace the dot, in which
@@ -480,8 +435,8 @@ static int get_urlmatch(const char *var, const char *url)
 	 * alone) or points into var (e.g. 'http.savecookies'), and we do
 	 * not own the storage.
 	 */
-	if (collect.section != var)
-		free((void *)collect.section);
+	if (config.section != var)
+		free((void *)config.section);
 	return 0;
 }
 
diff --git a/url-match.c b/url-match.c
index 424a0a0..290ba40 100644
--- a/url-match.c
+++ b/url-match.c
@@ -466,3 +466,78 @@ int match_urls(const struct url_info *url,
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
+		if (collect->item_alloc)
+			matched = collect->item_alloc(var, value, cb);
+		else
+			matched = xcalloc(1, sizeof(*matched));
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
+		/*
+		 * Otherwise, clear the old one and replace it
+		 * with this one.
+		 */
+		if (collect->item_clear)
+			collect->item_clear(matched);
+	}
+
+	matched->matched_len = matched_len;
+	matched->user_matched = user_matched;
+	strbuf_addstr(&synthkey, collect->section);
+	strbuf_addch(&synthkey, '.');
+	strbuf_addstr(&synthkey, key);
+	retval = collect->fn(synthkey.buf, value, collect->cb, matched);
+
+	strbuf_release(&synthkey);
+	return retval;
+}
diff --git a/url-match.h b/url-match.h
index e9cecd3..c3a5783 100644
--- a/url-match.h
+++ b/url-match.h
@@ -1,4 +1,5 @@
 #ifndef URL_MATCH_H
+#include "string-list.h"
 
 struct url_info {
 	/* normalized url on success, must be freed, otherwise NULL */
@@ -32,4 +33,25 @@ struct url_info {
 extern char *url_normalize(const char *, struct url_info *);
 extern int match_urls(const struct url_info *url, const struct url_info *url_prefix, int *exactusermatch);
 
+struct urlmatch_item {
+	size_t matched_len;
+	char user_matched;
+	/* possibly more */
+};
+
+struct urlmatch_config {
+	struct string_list vars;
+	struct url_info url;
+	const char *section;
+	const char *key;
+
+	void *cb;
+	int (*fn)(const char *var, const char *value, void *cb, void *matched);
+	int (*cascade_fn)(const char *var, const char *value, void *cb);
+	void *(*item_alloc)(const char *var, const char *value, void *cb);
+	void (*item_clear)(void *);
+};
+
+extern int urlmatch_config_entry(const char *var, const char *value, void *cb);
+
 #endif /* URL_MATCH_H */
-- 
1.8.4-rc0-137-g17832d4
