From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v6 1/5] Move commit GPG signature verification to commit.c
Date: Sat, 30 Mar 2013 15:15:03 +0100
Message-ID: <5156F367.1010608@physik.tu-berlin.de>
References: <7vvc89k15t.fsf@alter.siamese.dyndns.org> <cover.1364652339.git.jaseg@physik-pool.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 15:16:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULwZc-0002o6-Kj
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 15:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab3C3OP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 10:15:28 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:24032 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab3C3OPX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 10:15:23 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-2) with esmtp 
	id 1ULwYv-00038k-JG; Sat, 30 Mar 2013 15:15:22 +0100
Received: from [94.45.252.144] (unknown [94.45.252.144])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 5B3AC11403;
	Sat, 30 Mar 2013 15:15:12 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <cover.1364652339.git.jaseg@physik-pool.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219588>

Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
---
 commit.c        | 59 +++++++++++++++++++++++++++++++++++++
 commit.h        | 10 +++++++
 gpg-interface.h | 11 +++++++
 pretty.c        | 91 +++++++++----------------------------------------=
--------
 4 files changed, 93 insertions(+), 78 deletions(-)

diff --git a/commit.c b/commit.c
index e8eb0ae..eb645af 100644
--- a/commit.c
+++ b/commit.c
@@ -1023,6 +1023,65 @@ free_return:
 	free(buf);
 }
=20
+static struct {
+	char result;
+	const char *check;
+} sigcheck_gpg_status[] =3D {
+	{ 'G', "\n[GNUPG:] GOODSIG " },
+	{ 'B', "\n[GNUPG:] BADSIG " },
+};
+
+static void parse_gpg_output(struct signature_check *sigc)
+{
+	const char *buf =3D sigc->gpg_status;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
+		const char *found =3D strstr(buf, sigcheck_gpg_status[i].check);
+		const char *next;
+		if (!found)
+			continue;
+		sigc->result =3D sigcheck_gpg_status[i].result;
+		found +=3D strlen(sigcheck_gpg_status[i].check);
+		sigc->key =3D xmemdupz(found, 16);
+		found +=3D 17;
+		next =3D strchrnul(found, '\n');
+		sigc->signer =3D xmemdupz(found, next - found);
+		break;
+	}
+}
+
+void check_commit_signature(const struct commit* commit, struct signat=
ure_check *sigc)
+{
+	struct strbuf payload =3D STRBUF_INIT;
+	struct strbuf signature =3D STRBUF_INIT;
+	struct strbuf gpg_output =3D STRBUF_INIT;
+	struct strbuf gpg_status =3D STRBUF_INIT;
+	int status;
+
+	sigc->result =3D 'N';
+
+	if (parse_signed_commit(commit->object.sha1,
+				&payload, &signature) <=3D 0)
+		goto out;
+	status =3D verify_signed_buffer(payload.buf, payload.len,
+				      signature.buf, signature.len,
+				      &gpg_output, &gpg_status);
+	if (status && !gpg_output.len)
+		goto out;
+	sigc->gpg_output =3D strbuf_detach(&gpg_output, NULL);
+	sigc->gpg_status =3D strbuf_detach(&gpg_status, NULL);
+	parse_gpg_output(sigc);
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
index 4138bb4..8bbcf13 100644
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
@@ -230,4 +231,13 @@ extern void print_commit_list(struct commit_list *=
list,
 			      const char *format_cur,
 			      const char *format_last);
=20
+/*
+ * Check the signature of the given commit. The result of the check is=
 stored in
+ * sig->result, 'G' for a good signature, 'B' for a bad signature and =
'N'
+ * for no signature at all.
+ * This may allocate memory for sig->gpg_output, sig->gpg_status, sig-=
>signer
+ * and sig->key.
+ */
+extern void check_commit_signature(const struct commit* commit, struct=
 signature_check *sigc);
+
 #endif /* COMMIT_H */
diff --git a/gpg-interface.h b/gpg-interface.h
index cf99021..5884aa4 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -1,6 +1,17 @@
 #ifndef GPG_INTERFACE_H
 #define GPG_INTERFACE_H
=20
+struct signature_check {
+	char *gpg_output;
+	char *gpg_status;
+	char result; /* 0 (not checked),
+		      * N (checked but no further result),
+		      * G (good)
+		      * B (bad) */
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
index b57adef..cf84d3a 100644
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
+	struct signature_check signature_check;
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
@@ -1189,27 +1124,27 @@ static size_t format_commit_one(struct strbuf *=
sb, const char *placeholder,
 	}
=20
 	if (placeholder[0] =3D=3D 'G') {
-		if (!c->commit_signature_parsed)
-			parse_commit_signature(c);
+		if (!c->signature_check.result)
+			check_commit_signature(c->commit, &(c->signature_check));
 		switch (placeholder[1]) {
 		case 'G':
-			if (c->signature.gpg_output)
-				strbuf_addstr(sb, c->signature.gpg_output);
+			if (c->signature_check.gpg_output)
+				strbuf_addstr(sb, c->signature_check.gpg_output);
 			break;
 		case '?':
-			switch (c->signature.good_bad) {
+			switch (c->signature_check.result) {
 			case 'G':
 			case 'B':
-				strbuf_addch(sb, c->signature.good_bad);
+				strbuf_addch(sb, c->signature_check.result);
 			}
 			break;
 		case 'S':
-			if (c->signature.signer)
-				strbuf_addstr(sb, c->signature.signer);
+			if (c->signature_check.signer)
+				strbuf_addstr(sb, c->signature_check.signer);
 			break;
 		case 'K':
-			if (c->signature.key)
-				strbuf_addstr(sb, c->signature.key);
+			if (c->signature_check.key)
+				strbuf_addstr(sb, c->signature_check.key);
 			break;
 		}
 		return 2;
@@ -1347,8 +1282,8 @@ void format_commit_message(const struct commit *c=
ommit,
 	rewrap_message_tail(sb, &context, 0, 0, 0);
=20
 	logmsg_free(context.message, commit);
-	free(context.signature.gpg_output);
-	free(context.signature.signer);
+	free(context.signature_check.gpg_output);
+	free(context.signature_check.signer);
 }
=20
 static void pp_header(const struct pretty_print_context *pp,
--=20
1.8.1.5
