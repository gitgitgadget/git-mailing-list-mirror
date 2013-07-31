From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 5/6] builtin/config: refactor collect_config()
Date: Wed, 31 Jul 2013 12:26:07 -0700
Message-ID: <1375298768-7740-6-git-send-email-gitster@pobox.com>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com>
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 21:26:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4c2l-0006eE-IO
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 21:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760592Ab3GaT0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 15:26:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760518Ab3GaT0d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 15:26:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA2EE357CB;
	Wed, 31 Jul 2013 19:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HT9l
	TM7wuEQZbB+by4y7Zf+y1ns=; b=jGDXBvl0gAU4o6nXoclvJiKGTsEjY3rePm88
	J+xSENQhhoY9u9iy5KRmCCmOkj6auGlNzANRLrmBI3XbrPjg/SndtSB+jS4e4VhP
	3neR0aILtTfYSllqVNm2c6puzh5sOpAQzhzNLvD8ZWA8ptJhwDQiOMJM/POo00Bj
	PrF6oHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	vcw+ARrPMBaKlB0CiCwF1+4lSlj5TbYJXBDunQSNsuhXoshGaZbMo5Bwgkj7DezE
	cExsh1zH4x6iQCvDAKCWWE7zUAvmCUTVyocCs+Hp+mo+L/3k5TEdzRzJQ37f711O
	dm9mMn7ku+EX2QEbuFutWeemE52tKmwSWqYUIr87Q2U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 706EF357C9;
	Wed, 31 Jul 2013 19:26:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80A5E357C0;
	Wed, 31 Jul 2013 19:26:28 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc0-153-g9820077
In-Reply-To: <1375298768-7740-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 19163884-FA17-11E2-9F2C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231448>

In order to reuse the logic to format the configuration value while
honouring the requested type, split this function into two.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/config.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 33c9bf9..12c5073 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -100,25 +100,13 @@ struct strbuf_list {
 	int alloc;
 };
 
-static int collect_config(const char *key_, const char *value_, void *cb)
+static int format_config(struct strbuf *buf, const char *key_, const char *value_)
 {
-	struct strbuf_list *values = cb;
-	struct strbuf *buf;
-	char value[256];
-	const char *vptr = value;
 	int must_free_vptr = 0;
 	int must_print_delim = 0;
+	char value[256];
+	const char *vptr = value;
 
-	if (!use_key_regexp && strcmp(key_, key))
-		return 0;
-	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
-		return 0;
-	if (regexp != NULL &&
-	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
-		return 0;
-
-	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
-	buf = &values->items[values->nr++];
 	strbuf_init(buf, 0);
 
 	if (show_keys) {
@@ -126,7 +114,7 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 		must_print_delim = 1;
 	}
 	if (types == TYPE_INT)
-		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
+		sprintf(value, "%d", git_config_int(key_, value_ ? value_ : ""));
 	else if (types == TYPE_BOOL)
 		vptr = git_config_bool(key_, value_) ? "true" : "false";
 	else if (types == TYPE_BOOL_OR_INT) {
@@ -154,15 +142,27 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 	strbuf_addch(buf, term);
 
 	if (must_free_vptr)
-		/* If vptr must be freed, it's a pointer to a
-		 * dynamically allocated buffer, it's safe to cast to
-		 * const.
-		*/
 		free((char *)vptr);
-
 	return 0;
 }
 
+static int collect_config(const char *key_, const char *value_, void *cb)
+{
+	struct strbuf_list *values = cb;
+
+	if (!use_key_regexp && strcmp(key_, key))
+		return 0;
+	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
+		return 0;
+	if (regexp != NULL &&
+	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
+		return 0;
+
+	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
+
+	return format_config(&values->items[values->nr++], key_, value_);
+}
+
 static int get_value(const char *key_, const char *regex_)
 {
 	int ret = CONFIG_GENERIC_ERROR;
-- 
1.8.4-rc0-153-g9820077
