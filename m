From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] Add proof-of-concept %[w(width,in1,in2)<<any-string>>%]
 implementation
Date: Fri, 16 Oct 2009 01:28:22 -0700
Message-ID: <1255681702-5215-4-git-send-email-gitster@pobox.com>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 10:33:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyiFj-0000yJ-CU
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 10:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467AbZJPI3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 04:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757464AbZJPI3i
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 04:29:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757182AbZJPI3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 04:29:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB4A95A89B
	for <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=E2tP
	yC4zPQbWbOjfqOz82aTFvQU=; b=M+t6SkyIJmf8uiEOjOQouKiwVxlYPfdYY0H2
	6r9EwL/W3h4Z+c9BccU1M4tmjoE3D7xVpeTr3h9KXGvSbnggCnRDqsK3p2BuVxHY
	5LZLO6Go6NQ4GS47m4nTojvOyGBbRS43xfQCDEoI3VUFf6c6hc2fGakoTA7/YDZY
	WfYnPkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=JFoJe7
	hkh6F+SfBRYKSrSmqO54inSpwlyvYPJxAP5M+GrHDe9L4PPEs4pudOykHxFBDWIH
	Zv+qCAI7vgzt+aet/Zo3BA3DoT6gs9foNRpLUuD3iHR6XGVlXjtyshUc116rHvhq
	Uyxf2LzmzReMuOctUgtOXBr0ViMuJwHhWrrGI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B73BA5A89A
	for <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09F335A899 for
 <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:29 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.99.g9ed7e
In-Reply-To: <1255681702-5215-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E2B0384E-BA2D-11DE-98F9-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130463>

This uses the strbuf_nested_expand() mechanism introduced earlier
to demonstrate how to implement a nested string function.  It does
not "wrap" using the line-wrap code, but lifting the change by Dscho
and plugging it in should be a trivial exercise.

The overall idea is to parse something like "%[w(72,4,8)%an %ae %s%]" in
these steps:

  #1 "%[" introduces the nested string function.

  #2 After that, a name identifies what function to call.

  #3 The function parses its parameters ("(72,4,8)" in the above example),
     and makes a nested expansion on the remainder of the format string.

  #4 The nested expansion is terminated at "%]" and returned to the
     function.

  #5 The function massages the string returned from #4, and the result
     becomes the expansion of the whole thing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index 587101f..a8a38c3 100644
--- a/pretty.c
+++ b/pretty.c
@@ -595,6 +595,80 @@ static void format_decoration(struct strbuf *sb, const struct commit *commit)
 		strbuf_addch(sb, ')');
 }
 
+typedef int (*string_fmt_fn)(struct strbuf *sb, const char *placeholder, void *context);
+static size_t format_commit_item(struct strbuf *, const char *, void *);
+
+static int wrap_fn(struct strbuf *sb, const char *placeholder, void *context)
+{
+	const char *template = placeholder;
+	char *endptr;
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
+	/*
+	 * NEEDSWORK: here you wrap the contents of substr with
+	 * strbuf_wrap(&substr, width, indent1, indent2);
+	 *
+	 * ... but I am too lazy to do that here, and I just demonstrate
+	 * how it should work by just upcasing the result ;-)
+	 */
+	{
+		int i;
+		for (i = 0; i < sb->len; i++)
+			sb->buf[i] = toupper(sb->buf[i]);
+	}
+	return template - placeholder;
+}
+
+static struct {
+	const char *name;
+	string_fmt_fn fn;
+} format_fn_list[] = {
+	{ "w(", wrap_fn }
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
 static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
                                void *context)
 {
@@ -603,9 +677,19 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	const char *msg = commit->buffer;
 	struct commit_list *p;
 	int h1, h2;
+	size_t nested;
 
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
-- 
1.6.5.99.g9ed7e
