From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/5] gpg_interface: allow to request status return
Date: Thu, 14 Feb 2013 17:04:44 +0100
Message-ID: <1d89315f4b9ef179cb7944582c22948e05e78f33.1360857415.git.git@drmicha.warpmail.net>
References: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
Cc: Mariusz Gronczewski <xani666@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 17:05:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U61JE-0004kJ-BW
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 17:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761389Ab3BNQEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 11:04:51 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44349 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758040Ab3BNQEu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2013 11:04:50 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6ED50209C9;
	Thu, 14 Feb 2013 11:04:49 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 14 Feb 2013 11:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Zs
	6ULzibLYtBlBWLtiDXPFHmRmo=; b=Uepf4MqUkRIW/FraeTioDnTQ8fBPS2kEYy
	4Rmzr3FsnioIr6sc43QGbuMiykUHmSmI3CTbiKuS9MPCrNWqZNH7RwMSM4tAoBnP
	N4EcDDyCSEeLmK4NP5Bn2fvXeGJDiWGyytq3GJUs7+QRdU+YUs4fxl243OmmQPlz
	x0R3PI2I8=
X-Sasl-enc: 2AkDBNyw5d9+TPLjdfAtzkaW3cRCwjvPze4YrJspaWa9 1360857888
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EEBE28E018E;
	Thu, 14 Feb 2013 11:04:48 -0500 (EST)
X-Mailer: git-send-email 1.8.1.3.797.ge0260c7
In-Reply-To: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
In-Reply-To: <cover.1360857415.git.git@drmicha.warpmail.net>
References: <cover.1360857415.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216313>

Currently, verify_signed_buffer() returns the user facing output only.

Allow callers to request the status output also.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/fmt-merge-msg.c |  2 +-
 builtin/verify-tag.c    |  2 +-
 gpg-interface.c         | 11 +++++++----
 gpg-interface.h         |  2 +-
 log-tree.c              |  4 ++--
 pretty.c                |  2 +-
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index b49612f..265a925 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -492,7 +492,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 
 		if (size == len)
 			; /* merely annotated */
-		else if (verify_signed_buffer(buf, len, buf + len, size - len, &sig)) {
+		else if (verify_signed_buffer(buf, len, buf + len, size - len, &sig, NULL)) {
 			if (!sig.len)
 				strbuf_addstr(&sig, "gpg verification failed.\n");
 		}
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index a8eee88..9cdf332 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -29,7 +29,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	if (size == len)
 		return error("no signature found");
 
-	return verify_signed_buffer(buf, len, buf + len, size - len, NULL);
+	return verify_signed_buffer(buf, len, buf + len, size - len, NULL, NULL);
 }
 
 static int verify_tag(const char *name, int verbose)
diff --git a/gpg-interface.c b/gpg-interface.c
index c582b2e..8b0e874 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -100,13 +100,14 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
  */
 int verify_signed_buffer(const char *payload, size_t payload_size,
 			 const char *signature, size_t signature_size,
-			 struct strbuf *gpg_output)
+			 struct strbuf *gpg_output, struct strbuf *gpg_status)
 {
 	struct child_process gpg;
 	const char *args_gpg[] = {NULL, "--status-fd=1", "--verify", "FILE", "-", NULL};
 	char path[PATH_MAX];
 	int fd, ret;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf *pbuf = &buf;
 
 	args_gpg[0] = gpg_program;
 	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
@@ -137,15 +138,17 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 		strbuf_read(gpg_output, gpg.err, 0);
 		close(gpg.err);
 	}
-	strbuf_read(&buf, gpg.out, 0);
+	if (gpg_status)
+		pbuf = gpg_status;
+	strbuf_read(pbuf, gpg.out, 0);
 	close(gpg.out);
 
 	ret = finish_command(&gpg);
 
 	unlink_or_warn(path);
 
-	ret |= !strstr(buf.buf, "\n[GNUPG:] GOODSIG ");
-	strbuf_release(&buf);
+	ret |= !strstr(pbuf->buf, "\n[GNUPG:] GOODSIG ");
+	strbuf_release(&buf); /* no matter it was used or not */
 
 	return ret;
 }
diff --git a/gpg-interface.h b/gpg-interface.h
index b9c3608..cf99021 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -2,7 +2,7 @@
 #define GPG_INTERFACE_H
 
 extern int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key);
-extern int verify_signed_buffer(const char *payload, size_t payload_size, const char *signature, size_t signature_size, struct strbuf *gpg_output);
+extern int verify_signed_buffer(const char *payload, size_t payload_size, const char *signature, size_t signature_size, struct strbuf *gpg_output, struct strbuf *gpg_status);
 extern int git_gpg_config(const char *, const char *, void *);
 extern void set_signing_key(const char *);
 extern const char *get_signing_key(void);
diff --git a/log-tree.c b/log-tree.c
index 912fe08..3d88823 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -444,7 +444,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 
 	status = verify_signed_buffer(payload.buf, payload.len,
 				      signature.buf, signature.len,
-				      &gpg_output);
+				      &gpg_output, NULL);
 	if (status && !gpg_output.len)
 		strbuf_addstr(&gpg_output, "No signature\n");
 
@@ -513,7 +513,7 @@ static void show_one_mergetag(struct rev_info *opt,
 		if (verify_signed_buffer(extra->value, payload_size,
 					 extra->value + payload_size,
 					 extra->len - payload_size,
-					 &verify_message)) {
+					 &verify_message, NULL)) {
 			if (verify_message.len <= gpg_message_offset)
 				strbuf_addstr(&verify_message, "No signature\n");
 			else
diff --git a/pretty.c b/pretty.c
index eae57ad..2a1e174 100644
--- a/pretty.c
+++ b/pretty.c
@@ -984,7 +984,7 @@ static void parse_commit_signature(struct format_commit_context *ctx)
 		goto out;
 	status = verify_signed_buffer(payload.buf, payload.len,
 				      signature.buf, signature.len,
-				      &gpg_output);
+				      &gpg_output, NULL);
 	if (status && !gpg_output.len)
 		goto out;
 	ctx->signature.gpg_output = strbuf_detach(&gpg_output, NULL);
-- 
1.8.1.3.797.ge0260c7
