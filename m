From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/10] fmt-merge-msg: Add contents of merged tag in the merge
 message
Date: Fri,  4 Nov 2011 23:01:39 -0700
Message-ID: <1320472900-6601-10-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 07:02:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMZKn-0005jr-9d
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 07:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab1KEGCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 02:02:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab1KEGCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 02:02:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33D6D3C2F
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:02:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Zlzm
	wMOhpttyRERLZZCTvtutgxg=; b=jPXFd9J+hr1JvGktnNmg31dAjtF+xu/YP98S
	nAzt03bJ18x2aJTMq8FnoqUQWUQlXE4tYqpzogJdvY9VCucH5wk2ZwvbPyFNRb20
	RQ9v/WsuB+H0nGgpbmqAzjVPEtkvNqr7yivd+4VtuTfy81kjSg9aHw4mYl9D6tws
	jPxATVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qDye7O
	Ohz15UfSeuMFAEr0mWe1YmI/dPbk8TD6PufWyor3CQRdo2K1+rVOME4vJmws23jQ
	GxWUTlChF6Rh8C/XOazYtqL/CU7w1m1MLaScqqoPRVQOopzlKFp6dXAdI/MKcwBT
	ctyhtYZvQQTay4jdAqWVy20QGLZ3GPcznSxwI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A8413C2E
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:02:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2534D3C2D for
 <git@vger.kernel.org>; Sat,  5 Nov 2011 02:02:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.8.rc0.108.g71b5ec
In-Reply-To: <1320472900-6601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: ACEC19A4-0773-11E1-8E95-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184828>

When a contributor asks the integrator to merge her history, a signed tag
can be a good vehicle to communicate the authenticity of the request while
conveying other information such as the purpose of the topic.

E.g. a signed tag "for-linus" can be created, and the integrator can run:

   $ git pull git://example.com/work.git/ for-linus

This would allow the integrator to run "git verify-tag FETCH_HEAD" to
validate the signed tag.

While we do not necessarily want to clutter the global tag namespace of
the project, we would want to leave enough information in the repository
to allow third party to later validate the resulting history.

Update fmt-merge-msg that prepares the merge message template, and store
the contents of the signed tag object and the message that comes from GPG
signature validation at the end of it. The integrator can choose to leave
the contents of the tag in the resulting merge commit, or can choose to
remove it. The GPG validation message is inserted as a comment only to
help the integrator to review the validation result but otherwise will not
be recorded in the resulting merge commit, because later validation by
third parties does not need it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is the most interesting one.

 builtin/fmt-merge-msg.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3ff9564..f615fa5 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -5,6 +5,7 @@
 #include "revision.h"
 #include "tag.h"
 #include "string-list.h"
+#include "gpg-interface.h"
 
 static const char * const fmt_merge_msg_usage[] = {
 	"git fmt-merge-msg [-m <message>] [--log[=<n>]|--no-log] [--file <file>]",
@@ -262,6 +263,80 @@ static void fmt_merge_msg_title(struct strbuf *out,
 		strbuf_addf(out, " into %s\n", current_branch);
 }
 
+static void add_lines_with_prefix(struct strbuf *out, const char *prefix,
+				  const char *buf, size_t size)
+{
+	while (size) {
+		const char *next = memchr(buf, '\n', size);
+		next = next ? (next + 1) : (buf + size);
+		strbuf_addstr(out, prefix);
+		strbuf_add(out, buf, next - buf);
+		size -= next - buf;
+		buf = next;
+	}
+}
+
+static void fmt_tag_signature(struct strbuf *tagbuf,
+			      struct strbuf *sig,
+			      const char *buf,
+			      unsigned long size)
+{
+	add_lines_with_prefix(tagbuf, "tag:", buf, size);
+	add_lines_with_prefix(tagbuf, "# ", sig->buf, sig->len);
+	if (tagbuf->len && tagbuf->buf[tagbuf->len-1] != '\n')
+		strbuf_addch(tagbuf, '\n');
+}
+
+
+static void fmt_merge_msg_sigs(struct strbuf *out)
+{
+	int i, tag_number;
+	struct strbuf tagbuf = STRBUF_INIT;
+
+	for (i = tag_number = 0; i < origins.nr; i++) {
+		unsigned char *sha1 = origins.items[i].util;
+		enum object_type type;
+		unsigned long size, len;
+		char *buf = read_sha1_file(sha1, &type, &size);
+		struct strbuf sig = STRBUF_INIT;
+
+		if (!buf || type != OBJ_TAG)
+			goto next;
+		len = parse_signature(buf, size);
+		if (size == len)
+			goto next; /* not a signed tag */
+		if (verify_signed_buffer(buf, len, buf + len, size - len,
+					 &sig) ||
+		    !sig.len)
+			goto next;
+
+		if (!tag_number++)
+			fmt_tag_signature(&tagbuf, &sig, buf, size);
+		else {
+			if (tag_number == 2) {
+				static const char first_tag[] = "[Tag 1]\n";
+				strbuf_insert(&tagbuf, 0, first_tag,
+					      sizeof(first_tag) - 1);
+			}
+			strbuf_addf(&tagbuf, "\n[Tag %d]\n", tag_number);
+			fmt_tag_signature(&tagbuf, &sig, buf, size);
+		}
+		strbuf_release(&sig);
+	next:
+		free(buf);
+	}
+	if (tagbuf.len) {
+		strbuf_addch(out, '\n');
+		if (tag_number == 1)
+			strbuf_addstr(out, "Signature in merged tag\n");
+		else
+			strbuf_addstr(out, "Signatures in merged tags\n");
+		strbuf_addch(out, '\n');
+		strbuf_addbuf(out, &tagbuf);
+	}
+	strbuf_release(&tagbuf);
+}
+
 int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		  struct fmt_merge_msg_opts *opts)
 {
@@ -310,6 +385,10 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			shortlog(origins.items[i].string, origins.items[i].util,
 				 head, &rev, opts->shortlog_len, out);
 	}
+
+	if (origins.nr)
+		fmt_merge_msg_sigs(out);
+
 	if (out->len && out->buf[out->len-1] != '\n')
 		strbuf_addch(out, '\n');
 	return 0;
-- 
1.7.8.rc0.108.g71b5ec
