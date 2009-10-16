From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] strbuf_nested_expand(): allow expansion to interrupt in
 the middle
Date: Fri, 16 Oct 2009 01:28:21 -0700
Message-ID: <1255681702-5215-3-git-send-email-gitster@pobox.com>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 10:33:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyiFi-0000yJ-RW
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 10:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbZJPI3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 04:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757182AbZJPI3M
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 04:29:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339AbZJPI3K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 04:29:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D59079894
	for <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=oN/4
	nURNlRaPYgK7CQivQn9DQw4=; b=xU2t/LSiEHlosrhM3Kslv4qnfc8G4uRjpaXA
	LC78+QOKZO+ja3byqH78ztVopaxJ9OKgCfD3/EeKA+3rN0YEW5JTsa7Fsb31U+p8
	YsqOgGqTpXw9xV+EZ542IeesxlJgYBUK2ELNzTfUwki6Jw4t5gkjTt9wcgBujl0/
	kIWhBoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=WM7pX9
	P2sA5P6qGVxw5ZczZqzOZj7r+HTHN43cjjPxX028XiCQUC2zPgoHizE1gWhEfWI7
	jMk6jL9FkczgvahsZZQ8zi6HLadEZLxsVk2IgzZ/iFayojWU4lp71/6OyYyEk+dK
	bR7I/gUxYs31ZFRTQ69+ubcxtxIvdEFmVq0ew=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A05E79893
	for <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2DEBA79892 for
 <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:27 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.99.g9ed7e
In-Reply-To: <1255681702-5215-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E1B3E04E-BA2D-11DE-8CF6-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130467>

This itself does not do a "nested" expansion, but it paves a way for
supporting an extended syntax to express a function that works on an
expanded substring, e.g. %[function(param...)expanded-string%], by
allowing the callback function to tell where the argument to the function
ends.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 strbuf.c |   23 +++++++++++++++++++----
 strbuf.h |    3 ++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index a6153dc..2bbc49c 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -214,25 +214,40 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
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
 		size_t consumed;
 
 		percent = strchrnul(format, '%');
 		strbuf_add(sb, format, percent - format);
+		format = percent;
 		if (!*percent)
 			break;
-		format = percent + 1;
+		format++;
 
 		consumed = fn(sb, format, context);
-		if (consumed)
+		if ((ssize_t) consumed < 0)
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
 
 size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
diff --git a/strbuf.h b/strbuf.h
index d05e056..e602899 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -109,8 +109,9 @@ static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2) {
 }
 extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
 
-typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
+typedef size_t (*expand_fn_t)(struct strbuf *sb, const char *placeholder, void *context);
 extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn, void *context);
+extern void strbuf_nested_expand(struct strbuf *sb, const char **format_p, expand_fn_t fn, void *context);
 struct strbuf_expand_dict_entry {
 	const char *placeholder;
 	const char *value;
-- 
1.6.5.99.g9ed7e
