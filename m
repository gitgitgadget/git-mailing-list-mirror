From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] builtin/config: refactor collect_config()
Date: Mon, 29 Jul 2013 15:49:09 -0700
Message-ID: <1375138150-19520-3-git-send-email-gitster@pobox.com>
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
	id 1V3wGG-0008Bj-Jd
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 00:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267Ab3G2Wt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 18:49:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756241Ab3G2WtS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 18:49:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F573340F4;
	Mon, 29 Jul 2013 22:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rrmo
	M5ntn6QEvVyikk64NwFMfus=; b=TkUemhRWov7ei5mnygBx/hbUF6JfZN5eI2NN
	8mf5Wqmk+ZP6IdMeRxIh0RkO4UgD6NFwQUDYeHQ0DagQZgQM3Wtgmgnv9YO1GBNW
	kz7cpBoDgJdL4buGeIgE+0M/Yw4a9wCied8GjdVmnUrGSlAfqkIHsXoLavt3Lfjx
	kpUe0rY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	pohCP4xMQsKTSPUEfaS7aX864RWtZKqkG7e7v2+PULmZsRSlBQPn5cE7UXVXhJd6
	WeCoQnH2D14WF0KuLYs4IyInQh+5XRPDhKbvQTfKcG53oHMnUu5hw43nOAEW4rzv
	enp7BPD4sYVkO9Z5I93hZsr+Zl1IcRh+D/RXfXtjyEM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 448F9340F3;
	Mon, 29 Jul 2013 22:49:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E52D340F2;
	Mon, 29 Jul 2013 22:49:17 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc0-137-g17832d4
In-Reply-To: <1375138150-19520-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1963E65A-F8A1-11E2-819B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231336>

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
1.8.4-rc0-137-g17832d4
