From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] Add %[wrap(width,in1,in2)<<any-string>>%]
 implementation
Date: Mon, 19 Oct 2009 00:30:13 -0700
Message-ID: <1255937414-10043-3-git-send-email-gitster@pobox.com>
References: <1255937414-10043-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzmhW-0001Sz-QI
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 09:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376AbZJSHaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 03:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755193AbZJSHaS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 03:30:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040AbZJSHaP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 03:30:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FD2A5E7B9
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4i6L
	5Qn/LlAaMd5kv7MIjQZ23GQ=; b=j5m9H4F1FWM4B41xjUWFpl+lIwGpj0r/vwnk
	Ejph2WFlTdjBr6CYa3M0NfZ7eV7cBxlGGJzXbFAorDUwoSnRjJCH9Dyex2owQjED
	ujI4YIsh/B0TcijAINXkGonTRGdOl5lnVPXvHkNeJQ8mSUFXWrJGXPC6RApYcZgK
	LrWHDI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=k2xc0c
	syFgJnACZOldQ3DpUxA3v+2R1cosJz6vfUkiNKTLiqmsGc7QZwj/7H/lyNmwWW5x
	uZowMNXRuaU1MNYAWVQZkmpc5pG9RvoqN3ZvkaxX5/ZwOuHkmjxCcXg5CTHPXS0A
	v88dD2X/38cVvFYP73eCvLaQnh/GQroeF+bfo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D69B5E7B8
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E44935E7B7 for
 <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:18 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.1.95.g09fbd
In-Reply-To: <1255937414-10043-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 40F208D8-BC81-11DE-9952-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130667>

This uses the strbuf_nested_expand() mechanism introduced earlier to
demonstrate how to implement a nested string function, by plugging Dscho's
implementation of strbuf_add_wrapped_text().

The log is much more pleasant to read with

    $ git log --format='commit %H%nAuthor: %an%n%n%[wrap(66,4,4)%s%n%n%b%]'

in some repositories (e.g. git-svn conversion of rockbox).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Renamed w() to wrap() and actually plugged Dscho's strbuf_add_wrapped_text().

 pretty.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index 126be56..bc74c25 100644
--- a/pretty.c
+++ b/pretty.c
@@ -595,6 +595,72 @@ static void format_decoration(struct strbuf *sb, const struct commit *commit)
 		strbuf_addch(sb, ')');
 }
 
+typedef int (*string_fmt_fn)(struct strbuf *sb, const char *placeholder, void *context);
+static ssize_t format_commit_item(struct strbuf *, const char *, void *);
+
+static int wrap_fn(struct strbuf *sb, const char *placeholder, void *context)
+{
+	const char *template = placeholder;
+	char *endptr, *nested;
+	long width = 0, indent1 = 0, indent2 = 0;
+
+	width = strtol(template, &endptr, 10);
+	if (*endptr == ',') {
+		template = endptr + 1;
+		indent1 = strtol(template, &endptr, 10);
+		if (*endptr == ',') {
+			template = endptr + 1;
+			indent2 = strtol(template, &endptr, 10);
+		}
+	}
+	if (*endptr++ != ')')
+		return 0;
+
+	template = endptr;
+	strbuf_nested_expand(sb, &template, format_commit_item, context);
+	if (*template++ != ']')
+		return 0;
+
+	nested = strbuf_detach(sb, NULL);
+	strbuf_add_wrapped_text(sb, nested, indent1, indent2, width);
+	free(nested);
+
+	return template - placeholder;
+}
+
+static struct {
+	const char *name;
+	string_fmt_fn fn;
+} format_fn_list[] = {
+	{ "wrap(", wrap_fn }
+};
+
+static size_t format_fn(struct strbuf *sb, const char *placeholder,
+			void *context)
+{
+	const char *template = placeholder;
+	size_t consumed;
+	struct strbuf substr = STRBUF_INIT;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(format_fn_list); i++)
+		if (!prefixcmp(template, format_fn_list[i].name))
+			break;
+	if (ARRAY_SIZE(format_fn_list) <= i)
+		return 0;
+	template += strlen(format_fn_list[i].name);
+	consumed = format_fn_list[i].fn(&substr, template, context);
+	if (!consumed) {
+		strbuf_release(&substr);
+		return 0;
+	}
+
+	strbuf_add(sb, substr.buf, substr.len);
+	template += consumed;
+	strbuf_release(&substr);
+	return template - placeholder;
+}
+
 static ssize_t format_commit_item(struct strbuf *sb, const char *placeholder,
 				  void *context)
 {
@@ -603,9 +669,19 @@ static ssize_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	const char *msg = commit->buffer;
 	struct commit_list *p;
 	int h1, h2;
+	ssize_t nested;
 
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
+	case ']':
+		return -1;
+	case '[':
+		/*
+		 * %[func(arg...) string %]: we consumed the opening '['
+		 * and the callee consumed up to the closing '%]'.
+		 */
+		nested = format_fn(sb, placeholder + 1, context);
+		return nested ? 1 + nested : 0;
 	case 'C':
 		if (placeholder[1] == '(') {
 			const char *end = strchr(placeholder + 2, ')');
