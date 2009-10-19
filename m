From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] strbuf_nested_expand(): allow expansion to interrupt
 in the middle
Date: Mon, 19 Oct 2009 00:30:12 -0700
Message-ID: <1255937414-10043-2-git-send-email-gitster@pobox.com>
References: <1255937414-10043-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzmhW-0001Sz-9x
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 09:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbZJSHaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 03:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755213AbZJSHaQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 03:30:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbZJSHaN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 03:30:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E16837D936
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Mtjf
	o+12HoAfcLu240PYHMnWBEs=; b=oIp2G4IUoyGzn+p8E8YSar+QBIvGW2AX6kT/
	ktAMp74z99ESbwNhV/CpzflTQiuY0yFMd9NGtKCFrL2f4q3VwE9xFK4FYDe8j4bz
	GGgh9ErJ45Cdk2ipHK/KuVEx+cjZDE7pjYwKFJJqmJ3Zj5G3IfifeSdLHhDuIG9h
	l4PX0LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=WybRX3
	DNBDS3fPvEJxlc4PnEgFXrKesCa4VSuBViuSvS0ywKU7Qaklp1Zk0behx9vRFm++
	7mmkm/gphpHLF7EXflqhOsWto1UYaPhR7/mrEx/eGW+gaMEWu1e1zg6JuLoNodIE
	3JE20VB9ppI0TdRQQotTf4NodCGAFqppB4hCs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE4B07D935
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2A46A7D934 for
 <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:16 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.1.95.g09fbd
In-Reply-To: <1255937414-10043-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4006BE46-BC81-11DE-B2EA-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130669>

This itself does not do a "nested" expansion, but it paves a way for
supporting an extended syntax to express a function that works on an
expanded substring, e.g. %[function(param...)expanded-string%], by
allowing the callback function to tell where the argument to the function
ends.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Dropped sloppy casts, as suggested by Dscho.

 pretty.c |    4 ++--
 strbuf.c |   29 ++++++++++++++++++++++-------
 strbuf.h |    5 +++--
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/pretty.c b/pretty.c
index 587101f..126be56 100644
--- a/pretty.c
+++ b/pretty.c
@@ -595,8 +595,8 @@ static void format_decoration(struct strbuf *sb, const struct commit *commit)
 		strbuf_addch(sb, ')');
 }
 
-static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
-                               void *context)
+static ssize_t format_commit_item(struct strbuf *sb, const char *placeholder,
+				  void *context)
 {
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
diff --git a/strbuf.c b/strbuf.c
index a6153dc..af96155 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -214,29 +214,44 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	strbuf_setlen(sb, sb->len + len);
 }
 
-void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
-		   void *context)
+void strbuf_nested_expand(struct strbuf *sb, const char **format_p,
+			  expand_fn_t fn, void *context)
 {
+	const char *format = *format_p;
 	for (;;) {
 		const char *percent;
-		size_t consumed;
+		ssize_t consumed;
 
 		percent = strchrnul(format, '%');
 		strbuf_add(sb, format, percent - format);
+		format = percent;
 		if (!*percent)
 			break;
-		format = percent + 1;
+		format++;
 
 		consumed = fn(sb, format, context);
-		if (consumed)
+		if (consumed < 0)
+			break;
+		else if (consumed)
 			format += consumed;
 		else
 			strbuf_addch(sb, '%');
 	}
+	*format_p = format;
+}
+
+void strbuf_expand(struct strbuf *sb, const char *o_format, expand_fn_t fn,
+		   void *context)
+{
+	const char *format = o_format;
+	strbuf_nested_expand(sb, &format, fn, context);
+	if (*format)
+		die("format error: negative return from expand function: %s",
+		    o_format);
 }
 
-size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
-		void *context)
+ssize_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
+			      void *context)
 {
 	struct strbuf_expand_dict_entry *e = context;
 	size_t len;
diff --git a/strbuf.h b/strbuf.h
index d05e056..256d615 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -109,13 +109,14 @@ static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2) {
 }
 extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
 
-typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
+typedef ssize_t (*expand_fn_t)(struct strbuf *sb, const char *placeholder, void *context);
 extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn, void *context);
+extern void strbuf_nested_expand(struct strbuf *sb, const char **format_p, expand_fn_t fn, void *context);
 struct strbuf_expand_dict_entry {
 	const char *placeholder;
 	const char *value;
 };
-extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder, void *context);
+extern ssize_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder, void *context);
 
 __attribute__((format(printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
-- 
1.6.5.1.95.g09fbd
