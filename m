From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/12] fmt-merge-msg: Add contents of merged tag in the
 merge message
Date: Mon,  7 Nov 2011 19:00:41 -0800
Message-ID: <1320721245-13223-9-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 04:01:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbwE-0001XL-Lq
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 04:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab1KHDBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 22:01:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794Ab1KHDBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 22:01:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C18E7651A;
	Mon,  7 Nov 2011 22:01:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=OvSk
	IR5p8iGd3lXgNKUhddeVFCs=; b=NIlULliVGQRd68OWBI1O3VArd0GaWHOjJcHm
	KiifW+8XsmDSGW8zFFK/TyGElnYm/xvid/2PVWEfHP2Pk1GaMsWb97MUr9oycRD0
	xxq+1pQIf3TMFnO9y5341JiS2PxLXbEAlT1uVe6xwENllTdccnrTHvqWdG+tjp/h
	jxoH5kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	DTP8I20xKJEj3t+fUjIqV7g2GxWWsTXCaiSplwORCQcZEzZKBxU4artOPwIBGPE0
	lDHXDHcsZZP886AxlJ0VpPiiQjAmYp+tK5FM5IA9jV91NE8tX257KnviDuh3WQjW
	kBnohWYpghhoxnYXRdInXS6w9WjL6Mn4YTN8rjkPHK4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9A0F6519;
	Mon,  7 Nov 2011 22:01:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E91C6518; Mon,  7 Nov 2011
 22:01:03 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.g90e080
In-Reply-To: <1320721245-13223-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E56D3846-09B5-11E1-AC89-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185061>

When a contributor asks the integrator to merge her history, a signed tag
can be a good vehicle to communicate the authenticity of the request while
conveying other information such as the purpose of the topic.

E.g. a signed tag "for-linus" can be created, and the integrator can run:

   $ git pull git://example.com/work.git/ for-linus

This would allow the integrator to run "git verify-tag FETCH_HEAD" to
validate the signed tag.

Update fmt-merge-msg so that it pre-fills the merge message template with
the body (but not signature) of the tag object to help the integrator write
a better merge message, in the same spirit as the existing merge.log summary
lines.

The message that comes from GPG signature validation is also included in
the merge message template to help the integrator verify it, but they are
prefixed with "#" to make them comments.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fmt-merge-msg.c |   72 +++++++++++++++++++++++++++++++++++++++++++++-
 strbuf.c                |   15 ++++++++++
 strbuf.h                |    8 +++++
 3 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3ff9564..7dae846 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -5,6 +5,7 @@
 #include "revision.h"
 #include "tag.h"
 #include "string-list.h"
+#include "gpg-interface.h"
 
 static const char * const fmt_merge_msg_usage[] = {
 	"git fmt-merge-msg [-m <message>] [--log[=<n>]|--no-log] [--file <file>]",
@@ -262,6 +263,70 @@ static void fmt_merge_msg_title(struct strbuf *out,
 		strbuf_addf(out, " into %s\n", current_branch);
 }
 
+static void fmt_tag_signature(struct strbuf *tagbuf,
+			      struct strbuf *sig,
+			      const char *buf,
+			      unsigned long len)
+{
+	const char *tag_body = strstr(buf, "\n\n");
+	if (tag_body) {
+		tag_body += 2;
+		strbuf_add(tagbuf, tag_body, buf + len - tag_body);
+	}
+	strbuf_complete_line(tagbuf);
+	strbuf_add_lines(tagbuf, "# ", sig->buf, sig->len);
+}
+
+static void fmt_merge_msg_sigs(struct strbuf *out)
+{
+	int i, tag_number = 0, first_tag = 0;
+	struct strbuf tagbuf = STRBUF_INIT;
+
+	for (i = 0; i < origins.nr; i++) {
+		unsigned char *sha1 = origins.items[i].util;
+		enum object_type type;
+		unsigned long size, len;
+		char *buf = read_sha1_file(sha1, &type, &size);
+		struct strbuf sig = STRBUF_INIT;
+
+		if (!buf || type != OBJ_TAG)
+			goto next;
+		len = parse_signature(buf, size);
+
+		if (size == len)
+			; /* merely annotated */
+		else if (verify_signed_buffer(buf, len, buf + len, size - len, &sig)) {
+			if (!sig.len)
+				strbuf_addstr(&sig, "gpg verification failed.\n");
+		}
+
+		if (!tag_number++) {
+			fmt_tag_signature(&tagbuf, &sig, buf, len);
+			first_tag = i;
+		} else {
+			if (tag_number == 2) {
+				struct strbuf tagline = STRBUF_INIT;
+				strbuf_addf(&tagline, "\n# %s\n",
+					    origins.items[first_tag].string);
+				strbuf_insert(&tagbuf, 0, tagline.buf,
+					      tagline.len);
+				strbuf_release(&tagline);
+			}
+			strbuf_addf(&tagbuf, "\n# %s\n",
+				    origins.items[i].string);
+			fmt_tag_signature(&tagbuf, &sig, buf, len);
+		}
+		strbuf_release(&sig);
+	next:
+		free(buf);
+	}
+	if (tagbuf.len) {
+		strbuf_addch(out, '\n');
+		strbuf_addbuf(out, &tagbuf);
+	}
+	strbuf_release(&tagbuf);
+}
+
 int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		  struct fmt_merge_msg_opts *opts)
 {
@@ -293,6 +358,9 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 	if (opts->add_title && srcs.nr)
 		fmt_merge_msg_title(out, current_branch);
 
+	if (origins.nr)
+		fmt_merge_msg_sigs(out);
+
 	if (opts->shortlog_len) {
 		struct commit *head;
 		struct rev_info rev;
@@ -310,8 +378,8 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			shortlog(origins.items[i].string, origins.items[i].util,
 				 head, &rev, opts->shortlog_len, out);
 	}
-	if (out->len && out->buf[out->len-1] != '\n')
-		strbuf_addch(out, '\n');
+
+	strbuf_complete_line(out);
 	return 0;
 }
 
diff --git a/strbuf.c b/strbuf.c
index 3ad2cc0..a3c2e84 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -397,3 +397,18 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 
 	return len;
 }
+
+void strbuf_add_lines(struct strbuf *out, const char *prefix,
+		      const char *buf, size_t size)
+{
+	strbuf_complete_line(out);
+	while (size) {
+		const char *next = memchr(buf, '\n', size);
+		next = next ? (next + 1) : (buf + size);
+		strbuf_addstr(out, prefix);
+		strbuf_add(out, buf, next - buf);
+		size -= next - buf;
+		buf = next;
+	}
+	strbuf_complete_line(out);
+}
diff --git a/strbuf.h b/strbuf.h
index 46a33f8..08fc13d 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -100,6 +100,14 @@ extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
 __attribute__((format (printf,2,0)))
 extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
+extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
+
+static inline void strbuf_complete_line(struct strbuf *sb)
+{
+	if (sb->len && sb->buf[sb->len - 1] != '\n')
+		strbuf_addch(sb, '\n');
+}
+
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
-- 
1.7.8.rc0.128.g31aa4
