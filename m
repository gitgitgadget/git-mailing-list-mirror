From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v4 1/5] Move commit GPG signature verification to commit.c
Date: Tue, 26 Mar 2013 12:05:39 +0100
Message-ID: <51518103.6010707@physik.tu-berlin.de>
References: <7vli9bue40.fsf@alter.siamese.dyndns.org> <cover.1364295502.git.jaseg@physik-pool.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 12:06:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKRhj-0001e1-JI
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 12:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab3CZLFo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Mar 2013 07:05:44 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:5216 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab3CZLFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 07:05:41 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UKRhE-0006mP-Dh; Tue, 26 Mar 2013 12:05:40 +0100
Received: from [192.168.0.100] (cable-124-189.zeelandnet.nl [82.176.124.189])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id E654B11401;
	Tue, 26 Mar 2013 12:05:39 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <cover.1364295502.git.jaseg@physik-pool.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219152>

Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
---
 commit.c        | 59 +++++++++++++++++++++++++++++++++++++++++++++
 commit.h        |  9 +++++++
 gpg-interface.h |  8 ++++++
 pretty.c        | 75 ++++---------------------------------------------=
--------
 4 files changed, 81 insertions(+), 70 deletions(-)

diff --git a/commit.c b/commit.c
index e8eb0ae..1aeb17a 100644
--- a/commit.c
+++ b/commit.c
@@ -1023,6 +1023,65 @@ free_return:
 	free(buf);
 }
=20
+static struct {
+	char result;
+	const char *check;
+} signature_check[] =3D {
+	{ 'G', "\n[GNUPG:] GOODSIG " },
+	{ 'B', "\n[GNUPG:] BADSIG " },
+};
+
+static void parse_signature_lines(struct signature *sig)
+{
+	const char *buf =3D sig->gpg_status;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(signature_check); i++) {
+		const char *found =3D strstr(buf, signature_check[i].check);
+		const char *next;
+		if (!found)
+			continue;
+		sig->check_result =3D signature_check[i].result;
+		found +=3D strlen(signature_check[i].check);
+		sig->key =3D xmemdupz(found, 16);
+		found +=3D 17;
+		next =3D strchrnul(found, '\n');
+		sig->signer =3D xmemdupz(found, next - found);
+		break;
+	}
+}
+
+void check_commit_signature(const struct commit* commit, struct signat=
ure *sig)
+{
+	struct strbuf payload =3D STRBUF_INIT;
+	struct strbuf signature =3D STRBUF_INIT;
+	struct strbuf gpg_output =3D STRBUF_INIT;
+	struct strbuf gpg_status =3D STRBUF_INIT;
+	int status;
+
+	sig->check_result =3D 'N';
+
+	if (parse_signed_commit(commit->object.sha1,
+				&payload, &signature) <=3D 0)
+		goto out;
+	status =3D verify_signed_buffer(payload.buf, payload.len,
+				      signature.buf, signature.len,
+				      &gpg_output, &gpg_status);
+	if (status && !gpg_output.len)
+		goto out;
+	sig->gpg_output =3D strbuf_detach(&gpg_output, NULL);
+	sig->gpg_status =3D strbuf_detach(&gpg_status, NULL);
+	parse_signature_lines(sig);
+
+ out:
+	strbuf_release(&gpg_status);
+	strbuf_release(&gpg_output);
+	strbuf_release(&payload);
+	strbuf_release(&signature);
+}
+
+
+
 void append_merge_tag_headers(struct commit_list *parents,
 			      struct commit_extra_header ***tail)
 {
diff --git a/commit.h b/commit.h
index 4138bb4..cf35472 100644
--- a/commit.h
+++ b/commit.h
@@ -5,6 +5,7 @@
 #include "tree.h"
 #include "strbuf.h"
 #include "decorate.h"
+#include "gpg-interface.h"
=20
 struct commit_list {
 	struct commit *item;
@@ -230,4 +231,12 @@ extern void print_commit_list(struct commit_list *=
list,
 			      const char *format_cur,
 			      const char *format_last);
=20
+/*
+ * Check the signature of the given commit. The result of the check is=
 stored in
+ * sig->check_result, 'G' for a good signature, 'B' for a bad signatur=
e and 'N'
+ * for no signature at all.
+ * This may allocate memory for sig->gpg_output, sig->gpg_status, sig-=
>signer and sig->key.
+ */
+extern void check_commit_signature(const struct commit* commit, struct=
 signature *sig);
+
 #endif /* COMMIT_H */
diff --git a/gpg-interface.h b/gpg-interface.h
index cf99021..2a536d9 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -1,6 +1,14 @@
 #ifndef GPG_INTERFACE_H
 #define GPG_INTERFACE_H
=20
+struct signature {
+	char *gpg_output;
+	char *gpg_status;
+	char check_result; /* 0 (not checked), N (checked but no further resu=
lt), G (good) or B (bad) */
+	char *signer;
+	char *key;
+};
+
 extern int sign_buffer(struct strbuf *buffer, struct strbuf *signature=
, const char *signing_key);
 extern int verify_signed_buffer(const char *payload, size_t payload_si=
ze, const char *signature, size_t signature_size, struct strbuf *gpg_ou=
tput, struct strbuf *gpg_status);
 extern int git_gpg_config(const char *, const char *, void *);
diff --git a/pretty.c b/pretty.c
index b57adef..3aac5d8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -756,14 +756,7 @@ struct format_commit_context {
 	const struct pretty_print_context *pretty_ctx;
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
-	unsigned commit_signature_parsed:1;
-	struct {
-		char *gpg_output;
-		char *gpg_status;
-		char good_bad;
-		char *signer;
-		char *key;
-	} signature;
+	struct signature signature;
 	char *message;
 	size_t width, indent1, indent2;
=20
@@ -946,64 +939,6 @@ static void rewrap_message_tail(struct strbuf *sb,
 	c->indent2 =3D new_indent2;
 }
=20
-static struct {
-	char result;
-	const char *check;
-} signature_check[] =3D {
-	{ 'G', "\n[GNUPG:] GOODSIG " },
-	{ 'B', "\n[GNUPG:] BADSIG " },
-};
-
-static void parse_signature_lines(struct format_commit_context *ctx)
-{
-	const char *buf =3D ctx->signature.gpg_status;
-	int i;
-
-	for (i =3D 0; i < ARRAY_SIZE(signature_check); i++) {
-		const char *found =3D strstr(buf, signature_check[i].check);
-		const char *next;
-		if (!found)
-			continue;
-		ctx->signature.good_bad =3D signature_check[i].result;
-		found +=3D strlen(signature_check[i].check);
-		ctx->signature.key =3D xmemdupz(found, 16);
-		found +=3D 17;
-		next =3D strchrnul(found, '\n');
-		ctx->signature.signer =3D xmemdupz(found, next - found);
-		break;
-	}
-}
-
-static void parse_commit_signature(struct format_commit_context *ctx)
-{
-	struct strbuf payload =3D STRBUF_INIT;
-	struct strbuf signature =3D STRBUF_INIT;
-	struct strbuf gpg_output =3D STRBUF_INIT;
-	struct strbuf gpg_status =3D STRBUF_INIT;
-	int status;
-
-	ctx->commit_signature_parsed =3D 1;
-
-	if (parse_signed_commit(ctx->commit->object.sha1,
-				&payload, &signature) <=3D 0)
-		goto out;
-	status =3D verify_signed_buffer(payload.buf, payload.len,
-				      signature.buf, signature.len,
-				      &gpg_output, &gpg_status);
-	if (status && !gpg_output.len)
-		goto out;
-	ctx->signature.gpg_output =3D strbuf_detach(&gpg_output, NULL);
-	ctx->signature.gpg_status =3D strbuf_detach(&gpg_status, NULL);
-	parse_signature_lines(ctx);
-
- out:
-	strbuf_release(&gpg_status);
-	strbuf_release(&gpg_output);
-	strbuf_release(&payload);
-	strbuf_release(&signature);
-}
-
-
 static int format_reflog_person(struct strbuf *sb,
 				char part,
 				struct reflog_walk_info *log,
@@ -1189,18 +1124,18 @@ static size_t format_commit_one(struct strbuf *=
sb, const char *placeholder,
 	}
=20
 	if (placeholder[0] =3D=3D 'G') {
-		if (!c->commit_signature_parsed)
-			parse_commit_signature(c);
+		if (!c->signature.check_result)
+			check_commit_signature(c->commit, &(c->signature));
 		switch (placeholder[1]) {
 		case 'G':
 			if (c->signature.gpg_output)
 				strbuf_addstr(sb, c->signature.gpg_output);
 			break;
 		case '?':
-			switch (c->signature.good_bad) {
+			switch (c->signature.check_result) {
 			case 'G':
 			case 'B':
-				strbuf_addch(sb, c->signature.good_bad);
+				strbuf_addch(sb, c->signature.check_result);
 			}
 			break;
 		case 'S':
--=20
1.8.1.5
