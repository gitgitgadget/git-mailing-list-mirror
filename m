From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] config: --get-urlmatch
Date: Mon, 29 Jul 2013 15:49:10 -0700
Message-ID: <1375138150-19520-4-git-send-email-gitster@pobox.com>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
 <1375138150-19520-1-git-send-email-gitster@pobox.com>
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 30 00:49:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3wGH-0008Bj-4J
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 00:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756278Ab3G2Wt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 18:49:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756245Ab3G2WtV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 18:49:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDC66340F9;
	Mon, 29 Jul 2013 22:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=VBc5
	ibhC4OfCkD+Nmg6aW1LcnMc=; b=hLoLrNRp45iYNmjU47PZnV6em7jMOD8yrvtd
	XqypQqNAF7TsrFwO5bU2AusWDJA886DjpBDQ8rxBvhe/uTJvd9sUn6vh8zduGXfU
	qF3T0WbK6BVfp7qKlVE+EvCxQXxO4PqAQbRGlK2PATtY2BsN7z/iYURm8edy61Iv
	x5kt0oY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	slJhXHicd1x5yx8F6bg9Wk/1SX7UNoVncoM27n521TIe8rGwVzBtIwFzmQ/vMdIE
	gc7XBx+sjkqe1KPSN7jA98UbakaWw/klLwqmhiPAdLoFJrATzCji625l2PbLFhD8
	vHOlVOM5DXIpfEhkrVZ+b2MDFNXzRnk90XTKtBHNb6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C22A2340F8;
	Mon, 29 Jul 2013 22:49:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E179340F5;
	Mon, 29 Jul 2013 22:49:19 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc0-137-g17832d4
In-Reply-To: <1375138150-19520-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1ABD514E-F8A1-11E2-A4EF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231337>

"git config --get-urlmatch $section[.$variable] $url" is a way to
learn what the configured value for $section.$variable is for the
given URL, using the logic introduced by the http.<url>.config
topic.  In addition to $section.$variable, entries in the
configuration file(s) that match $section.<urlpattern>.$variable are
looked up and the one with <urlpattern> that matches the given $url
the best is used to answer the query.

This can still be further refactored to remove code from http_options()
in http.c, I think.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/config.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index 12c5073..c1d32ae 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "color.h"
 #include "parse-options.h"
+#include "url-match.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config [options]"),
@@ -41,6 +42,7 @@ static int respect_includes = -1;
 #define ACTION_SET_ALL (1<<12)
 #define ACTION_GET_COLOR (1<<13)
 #define ACTION_GET_COLORBOOL (1<<14)
+#define ACTION_GET_URLMATCH (1<<15)
 
 #define TYPE_BOOL (1<<0)
 #define TYPE_INT (1<<1)
@@ -57,6 +59,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
 	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]"), ACTION_GET_ALL),
 	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex [value-regex]"), ACTION_GET_REGEXP),
+	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: section[.var] URL"), ACTION_GET_URLMATCH),
 	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: name value [value_regex]"), ACTION_REPLACE_ALL),
 	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_ADD),
 	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-regex]"), ACTION_UNSET),
@@ -348,6 +351,140 @@ static int get_colorbool(int print)
 		return get_colorbool_found ? 0 : 1;
 }
 
+struct urlmatch_collect {
+	struct string_list vars;
+	struct url_info url;
+	const char *section;
+	const char *key;
+};
+
+struct urlmatch_item {
+	size_t max_matched_len;
+	char user_matched;
+	char value_is_null;
+	struct strbuf value;
+};
+
+static int urlmatch_collect(const char *var, const char *value, void *cb)
+{
+	struct string_list_item *item;
+	struct urlmatch_collect *collect = cb;
+	struct urlmatch_item *matched;
+	struct url_info *url = &collect->url;
+	const char *key, *dot;
+	size_t matchlen = 0;
+	int usermatch = 0;
+
+	key = skip_prefix(var, collect->section);
+	if (!key || *(key++) != '.')
+		return 0; /* not interested */
+	dot = strrchr(key, '.');
+	if (dot) {
+		char *config_url, *norm_url;
+		struct url_info norm_info;
+		int matchlen;
+
+		config_url = xmemdupz(key, dot - key);
+		norm_url = url_normalize(config_url, &norm_info);
+		free(config_url);
+		if (!norm_url)
+			return 0;
+		matchlen = match_urls(url, &norm_info, &usermatch);
+		free(norm_url);
+		if (!matchlen)
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
+		strbuf_init(&matched->value, 0);
+	} else {
+		matched = item->util;
+		/*
+		 * Is our match shorter?  Is our match the same
+		 * length, and without user while the current
+		 * candidate is with user?  Then we cannot use it.
+		 */
+		if (matchlen < matched->max_matched_len ||
+		    ((matchlen == matched->max_matched_len) &&
+		     (!usermatch && matched->user_matched)))
+			return 0;
+		/*
+		 * Otherwise, release the old one and replace
+		 * with ours.
+		 */
+		strbuf_release(&matched->value);
+	}
+
+	matched->max_matched_len = matchlen;
+	matched->user_matched = usermatch;
+	if (value) {
+		strbuf_addstr(&matched->value, value);
+		matched->value_is_null = 0;
+	} else {
+		matched->value_is_null = 1;
+	}
+	return 0;
+}
+
+static int get_urlmatch(const char *var, const char *url)
+{
+	const char *section_tail;
+	struct string_list_item *item;
+	struct urlmatch_collect collect = { STRING_LIST_INIT_DUP };
+
+	if (!url_normalize(url, &collect.url))
+		die(collect.url.err);
+
+	section_tail = strchr(var, '.');
+	if (section_tail) {
+		collect.section = xmemdupz(var, section_tail - var);
+		collect.key = strrchr(var, '.') + 1;
+		show_keys = 0;
+	} else {
+		collect.section = var;
+		collect.key = NULL;
+		show_keys = 1;
+	}
+
+	git_config_with_options(urlmatch_collect, &collect,
+				given_config_file, respect_includes);
+
+	for_each_string_list_item(item, &collect.vars) {
+		struct urlmatch_item *matched = item->util;
+		struct strbuf key = STRBUF_INIT;
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_addstr(&key, collect.section);
+		strbuf_addch(&key, '.');
+		strbuf_addstr(&key, item->string);
+		format_config(&buf, key.buf,
+			      matched->value_is_null ? NULL : matched->value.buf);
+		fwrite(buf.buf, 1, buf.len, stdout);
+		strbuf_release(&key);
+		strbuf_release(&buf);
+
+		strbuf_release(&matched->value);
+	}
+	string_list_clear(&collect.vars, 1);
+
+	/*
+	 * section name may have been copied to replace the dot, in which
+	 * case it needs to be freed.  key name is either NULL (e.g. 'http'
+	 * alone) or points into var (e.g. 'http.savecookies'), and we do
+	 * not own the storage.
+	 */
+	if (collect.section != var)
+		free((void *)collect.section);
+	return 0;
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
@@ -499,6 +636,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		return get_value(argv[0], argv[1]);
 	}
+	else if (actions == ACTION_GET_URLMATCH) {
+		check_argc(argc, 2, 2);
+		return get_urlmatch(argv[0], argv[1]);
+	}
 	else if (actions == ACTION_UNSET) {
 		check_argc(argc, 1, 2);
 		if (argc == 2)
-- 
1.8.4-rc0-137-g17832d4
