From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 14/22] gpg-interface: move parse_signature() to where it should be
Date: Fri,  5 Sep 2014 13:55:02 -0700
Message-ID: <1409950510-10209-15-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:56:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0YY-0006DI-MF
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbaIEUzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57631 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbaIEUzq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 01723366B8;
	Fri,  5 Sep 2014 16:55:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+m+Q
	d42JnkaBYEaACpXQ/3i01zw=; b=ux8k6dZYu+Umba5n3AaHw/Sd5MpMclink3b8
	wB9uX97d4x6Sge2YuSG/9izexKUJPxmrtfEif8nnHbMh1JT5e8Atm6RlhQM/waCl
	UxiKHhAQC2eQ10ogMrQDSRj+hOcCqh+FIZCCdcVr0bL/Kkxcf9F52W5aRQLYhqpD
	Z3Jdm5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=du0wby
	m5v22UxTqeN9hQ8siMVFU4lCjymAfXRXXA94zT4fGotbViGTJA1qGeEIgW36ds72
	RTp93z3DAIyrCFcimjtF8MjaxeoYbA05NqHm81n+qfXrmYE2O4w/PoLtrr9kx/3H
	VR3sPmM5/uWDCEFTgADScHqP3oU+IxYiVJO/k=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECC8F366B7;
	Fri,  5 Sep 2014 16:55:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4F6EA366B4;
	Fri,  5 Sep 2014 16:55:45 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 018F22A2-353F-11E4-B651-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256536>

Our signed-tag objects set the standard format used by Git to store
GPG-signed payload (i.e. the payload followed by its detached
signature) [*1*], and it made sense to have a helper to find the
boundary between the payload and its signature in tag.c back then.

Newer code added later to parse other kinds of objects that learned
to use the same format to store GPG-signed payload (e.g. signed
commits), however, kept using the helper from the same location.

Move it to gpg-interface; the helper is no longer about signed tag,
but it is how our code and data interact with GPG.

[Reference]
*1* http://thread.gmane.org/gmane.linux.kernel/297998/focus=1383

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gpg-interface.c | 21 +++++++++++++++++++++
 gpg-interface.h |  1 +
 tag.c           | 20 --------------------
 tag.h           |  1 -
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 3c9624c..0dd11ea 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,6 +7,9 @@
 static char *configured_signing_key;
 static const char *gpg_program = "gpg";
 
+#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+#define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
+
 void signature_check_clear(struct signature_check *sigc)
 {
 	free(sigc->payload);
@@ -57,6 +60,24 @@ void parse_gpg_output(struct signature_check *sigc)
 	}
 }
 
+/*
+ * Look at GPG signed content (e.g. a signed tag object), whose
+ * payload is followed by a detached signature on it.  Return the
+ * offset where the embedded detached signature begins, or the end of
+ * the data when there is no such signature.
+ */
+size_t parse_signature(const char *buf, unsigned long size)
+{
+	char *eol;
+	size_t len = 0;
+	while (len < size && !starts_with(buf + len, PGP_SIGNATURE) &&
+			!starts_with(buf + len, PGP_MESSAGE)) {
+		eol = memchr(buf + len, '\n', size - len);
+		len += eol ? eol - (buf + len) + 1 : size - len;
+	}
+	return len;
+}
+
 void set_signing_key(const char *key)
 {
 	free(configured_signing_key);
diff --git a/gpg-interface.h b/gpg-interface.h
index 82493b7..87a4f2e 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -20,6 +20,7 @@ struct signature_check {
 };
 
 extern void signature_check_clear(struct signature_check *sigc);
+extern size_t parse_signature(const char *buf, unsigned long size);
 extern void parse_gpg_output(struct signature_check *);
 extern int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key);
 extern int verify_signed_buffer(const char *payload, size_t payload_size, const char *signature, size_t signature_size, struct strbuf *gpg_output, struct strbuf *gpg_status);
diff --git a/tag.c b/tag.c
index 82d841b..5b0ac62 100644
--- a/tag.c
+++ b/tag.c
@@ -4,9 +4,6 @@
 #include "tree.h"
 #include "blob.h"
 
-#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
-#define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
-
 const char *tag_type = "tag";
 
 struct object *deref_tag(struct object *o, const char *warn, int warnlen)
@@ -143,20 +140,3 @@ int parse_tag(struct tag *item)
 	free(data);
 	return ret;
 }
-
-/*
- * Look at a signed tag object, and return the offset where
- * the embedded detached signature begins, or the end of the
- * data when there is no such signature.
- */
-size_t parse_signature(const char *buf, unsigned long size)
-{
-	char *eol;
-	size_t len = 0;
-	while (len < size && !starts_with(buf + len, PGP_SIGNATURE) &&
-			!starts_with(buf + len, PGP_MESSAGE)) {
-		eol = memchr(buf + len, '\n', size - len);
-		len += eol ? eol - (buf + len) + 1 : size - len;
-	}
-	return len;
-}
diff --git a/tag.h b/tag.h
index bc8a1e4..f4580ae 100644
--- a/tag.h
+++ b/tag.h
@@ -17,6 +17,5 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
-extern size_t parse_signature(const char *buf, unsigned long size);
 
 #endif /* TAG_H */
-- 
2.1.0-399-g2df620b
