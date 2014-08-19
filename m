From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/18] gpg-interface: move parse_signature() to where it should be
Date: Tue, 19 Aug 2014 15:06:22 -0700
Message-ID: <1408485987-3590-14-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:09:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrai-0006jD-1h
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbaHSWIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:08:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54818 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbaHSWIp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:08:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A893433168;
	Tue, 19 Aug 2014 18:08:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=y6R4
	/joESQLt+jujx6nUDAml5WM=; b=s6KeIPO3rDOs6lma0DakMXpB/JOLxD4JELso
	IIFLcuE8wUQ6eOMo/XXPmpOrgxxJLvdD6mfVV4freOsKBQLyHq+RtXic+AATMrgc
	NVKleRFWHuiJk4gYmPYpdRU5RPoFJshRu3CJPgAOVYLypxo8S0hv1dIetpIAAuck
	D9PGf9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BPc3e1
	cCD2+is4JD3ADFprt8uXCrdoUAKfhhuLtZm+f5i/jcQswv9HyLaSAOllxI/gdwQt
	aLrxHB40EMOFhk4iMaHEvzzjmAyZSt2baOLolsyh2mK6xpUdwkmPVa/IgeI5Ez7q
	m6ch98aroEUIeN+iZ2LJ2J904GQZGpoc553Lo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E4B933167;
	Tue, 19 Aug 2014 18:08:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1103C3314A;
	Tue, 19 Aug 2014 18:08:36 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5E4CE2B8-27ED-11E4-A0AF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255535>

Our signed-tag objects set the standard format used by Git to store
GPG-signed payload (i.e. the payload followed by its detached
signature), and it made sense to have a helper to find the boundary
between the payload and its signature in tag.c back then.

Newer code added later to parse other kinds of objects that learned
to use the same format to store GPG-signed payload (e.g. signed
commits), however, kept using the helper from the same location.

Move it to gpg-interface; the helper is no longer about signed tag,
but it is how our code and data interact with GPG.

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
index 8d677cc..93c76c2 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -20,6 +20,7 @@ struct signature_check {
 };
 
 extern void signature_check_clear(struct signature_check *sigc);
+extern size_t parse_signature(const char *buf, unsigned long size);
 extern void parse_gpg_output(struct signature_check *);
 
 extern int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key);
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
2.1.0-301-g54593e2
