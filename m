Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67277C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 23:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbhLHXqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:46:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51696 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbhLHXqv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:46:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A2A3F4292;
        Wed,  8 Dec 2021 18:43:18 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=g+EukEHUyF9Aip0Gf3G+bLfAD
        a0DUGdxl2hY4+sgKog=; b=uH2nwzIVBxP1v8/ydwxEYt0UPxsIqlyvvZI7Vs2nq
        9gcYXxQsUc9gNI+PvcdTVdhQS9x0d9Hmf0oFZL5TLiRiY1FAm1tbLlerjtnVJ25p
        OmKMHwEsH/AyyeFey8RKiJW9JT4sA1Vvf34ZTZrJ8KIbkfsbiP9L783/Coln3l0q
        s4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80C09F4291;
        Wed,  8 Dec 2021 18:43:18 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AB58F428F;
        Wed,  8 Dec 2021 18:43:17 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5.1 2/8] ssh signing: use sigc struct to pass payload
Date:   Wed,  8 Dec 2021 15:43:07 -0800
Message-Id: <20211208234313.3052303-3-gitster@pobox.com>
X-Mailer: git-send-email 2.34.1-365-gae484d3562
In-Reply-To: <20211208234313.3052303-1-gitster@pobox.com>
References: <20211208234313.3052303-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 9E4C5F08-5880-11EC-8B74-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

To be able to extend the payload metadata with things like its creation
timestamp or the creators ident we remove the payload parameters to
check_signature() and use the already existing sigc->payload field
instead, only adding the length field to the struct. This also allows
us to get rid of the xmemdupz() calls in the verify functions. Since
sigc is now used to input data as well as output the result move it to
the front of the function list.

 - Add payload_length to struct signature_check
 - Populate sigc.payload/payload_len on all call sites
 - Remove payload parameters to check_signature()
 - Remove payload parameters to internal verify_* functions and use sigc
   instead
 - Remove xmemdupz() used for verbose output since payload is now already
   populated.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c |  6 ++++--
 commit.c               |  5 +++--
 fmt-merge-msg.c        |  4 ++--
 gpg-interface.c        | 37 +++++++++++++++++--------------------
 gpg-interface.h        |  6 +++---
 log-tree.c             |  8 ++++----
 tag.c                  |  4 ++--
 7 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d960..61ab63c2ea 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -769,8 +769,10 @@ static void prepare_push_cert_sha1(struct child_proc=
ess *proc)
 		memset(&sigcheck, '\0', sizeof(sigcheck));
=20
 		bogs =3D parse_signed_buffer(push_cert.buf, push_cert.len);
-		check_signature(push_cert.buf, bogs, push_cert.buf + bogs,
-				push_cert.len - bogs, &sigcheck);
+		sigcheck.payload =3D xmemdupz(push_cert.buf, bogs);
+		sigcheck.payload_len =3D bogs;
+		check_signature(&sigcheck, push_cert.buf + bogs,
+				push_cert.len - bogs);
=20
 		nonce_status =3D check_nonce(push_cert.buf, bogs);
 	}
diff --git a/commit.c b/commit.c
index 551de4903c..64e040a99b 100644
--- a/commit.c
+++ b/commit.c
@@ -1212,8 +1212,9 @@ int check_commit_signature(const struct commit *com=
mit, struct signature_check *
=20
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <=3D=
 0)
 		goto out;
-	ret =3D check_signature(payload.buf, payload.len, signature.buf,
-		signature.len, sigc);
+
+	sigc->payload =3D strbuf_detach(&payload, &sigc->payload_len);
+	ret =3D check_signature(sigc, signature.buf, signature.len);
=20
  out:
 	strbuf_release(&payload);
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5216191488..deca1ea3a3 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -533,8 +533,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		else {
 			buf =3D payload.buf;
 			len =3D payload.len;
-			if (check_signature(payload.buf, payload.len, sig.buf,
-					    sig.len, &sigc) &&
+			sigc.payload =3D strbuf_detach(&payload, &sigc.payload_len);
+			if (check_signature(&sigc, sig.buf, sig.len) &&
 			    !sigc.output)
 				strbuf_addstr(&sig, "gpg verification failed.\n");
 			else
diff --git a/gpg-interface.c b/gpg-interface.c
index 3e7255a2a9..75ab6faacb 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -19,8 +19,8 @@ struct gpg_format {
 	const char **verify_args;
 	const char **sigs;
 	int (*verify_signed_buffer)(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size);
 	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
@@ -53,12 +53,12 @@ static const char *ssh_sigs[] =3D {
 };
=20
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size);
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size);
 static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signatu=
re,
 			   const char *signing_key);
@@ -314,8 +314,8 @@ static void parse_gpg_output(struct signature_check *=
sigc)
 }
=20
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size)
 {
 	struct child_process gpg =3D CHILD_PROCESS_INIT;
@@ -343,14 +343,13 @@ static int verify_gpg_signed_buffer(struct signatur=
e_check *sigc,
 		     NULL);
=20
 	sigchain_push(SIGPIPE, SIG_IGN);
-	ret =3D pipe_command(&gpg, payload, payload_size, &gpg_stdout, 0,
+	ret =3D pipe_command(&gpg, sigc->payload, sigc->payload_len, &gpg_stdou=
t, 0,
 			   &gpg_stderr, 0);
 	sigchain_pop(SIGPIPE);
=20
 	delete_tempfile(&temp);
=20
 	ret |=3D !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
-	sigc->payload =3D xmemdupz(payload, payload_size);
 	sigc->output =3D strbuf_detach(&gpg_stderr, NULL);
 	sigc->gpg_status =3D strbuf_detach(&gpg_stdout, NULL);
=20
@@ -426,8 +425,8 @@ static void parse_ssh_output(struct signature_check *=
sigc)
 }
=20
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size)
 {
 	struct child_process ssh_keygen =3D CHILD_PROCESS_INIT;
@@ -480,7 +479,7 @@ static int verify_ssh_signed_buffer(struct signature_=
check *sigc,
 			     "-n", "git",
 			     "-s", buffer_file->filename.buf,
 			     NULL);
-		pipe_command(&ssh_keygen, payload, payload_size,
+		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
=20
 		/*
@@ -526,7 +525,7 @@ static int verify_ssh_signed_buffer(struct signature_=
check *sigc,
 			}
=20
 			sigchain_push(SIGPIPE, SIG_IGN);
-			ret =3D pipe_command(&ssh_keygen, payload, payload_size,
+			ret =3D pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 					   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
 			sigchain_pop(SIGPIPE);
=20
@@ -540,7 +539,6 @@ static int verify_ssh_signed_buffer(struct signature_=
check *sigc,
 		}
 	}
=20
-	sigc->payload =3D xmemdupz(payload, payload_size);
 	strbuf_stripspace(&ssh_keygen_out, 0);
 	strbuf_stripspace(&ssh_keygen_err, 0);
 	/* Add stderr outputs to show the user actual ssh-keygen errors */
@@ -562,8 +560,8 @@ static int verify_ssh_signed_buffer(struct signature_=
check *sigc,
 	return ret;
 }
=20
-int check_signature(const char *payload, size_t plen, const char *signat=
ure,
-	size_t slen, struct signature_check *sigc)
+int check_signature(struct signature_check *sigc,
+		    const char *signature, size_t slen)
 {
 	struct gpg_format *fmt;
 	int status;
@@ -575,8 +573,7 @@ int check_signature(const char *payload, size_t plen,=
 const char *signature,
 	if (!fmt)
 		die(_("bad/incompatible signature '%s'"), signature);
=20
-	status =3D fmt->verify_signed_buffer(sigc, fmt, payload, plen, signatur=
e,
-					   slen);
+	status =3D fmt->verify_signed_buffer(sigc, fmt, signature, slen);
=20
 	if (status && !sigc->output)
 		return !!status;
@@ -593,7 +590,7 @@ void print_signature_buffer(const struct signature_ch=
eck *sigc, unsigned flags)
 							    sigc->output;
=20
 	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
-		fputs(sigc->payload, stdout);
+		fwrite(sigc->payload, 1, sigc->payload_len, stdout);
=20
 	if (output)
 		fputs(output, stderr);
diff --git a/gpg-interface.h b/gpg-interface.h
index beefacbb1e..5ee7d8b6b9 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -17,6 +17,7 @@ enum signature_trust_level {
=20
 struct signature_check {
 	char *payload;
+	size_t payload_len;
 	char *output;
 	char *gpg_status;
=20
@@ -70,9 +71,8 @@ const char *get_signing_key(void);
  * Either a GPG KeyID or a SSH Key Fingerprint
  */
 const char *get_signing_key_id(void);
-int check_signature(const char *payload, size_t plen,
-		    const char *signature, size_t slen,
-		    struct signature_check *sigc);
+int check_signature(struct signature_check *sigc,
+		    const char *signature, size_t slen);
 void print_signature_buffer(const struct signature_check *sigc,
 			    unsigned flags);
=20
diff --git a/log-tree.c b/log-tree.c
index 644893fd8c..a46cf60e1e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -513,8 +513,8 @@ static void show_signature(struct rev_info *opt, stru=
ct commit *commit)
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <=3D=
 0)
 		goto out;
=20
-	status =3D check_signature(payload.buf, payload.len, signature.buf,
-				 signature.len, &sigc);
+	sigc.payload =3D strbuf_detach(&payload, &sigc.payload_len);
+	status =3D check_signature(&sigc, signature.buf, signature.len);
 	if (status && !sigc.output)
 		show_sig_lines(opt, status, "No signature\n");
 	else
@@ -583,8 +583,8 @@ static int show_one_mergetag(struct commit *commit,
 	status =3D -1;
 	if (parse_signature(extra->value, extra->len, &payload, &signature)) {
 		/* could have a good signature */
-		status =3D check_signature(payload.buf, payload.len,
-					 signature.buf, signature.len, &sigc);
+		sigc.payload =3D strbuf_detach(&payload, &sigc.payload_len);
+		status =3D check_signature(&sigc, signature.buf, signature.len);
 		if (sigc.output)
 			strbuf_addstr(&verify_message, sigc.output);
 		else
diff --git a/tag.c b/tag.c
index 3e18a41841..62fb09f5a5 100644
--- a/tag.c
+++ b/tag.c
@@ -25,8 +25,8 @@ static int run_gpg_verify(const char *buf, unsigned lon=
g size, unsigned flags)
 		return error("no signature found");
 	}
=20
-	ret =3D check_signature(payload.buf, payload.len, signature.buf,
-				signature.len, &sigc);
+	sigc.payload =3D strbuf_detach(&payload, &sigc.payload_len);
+	ret =3D check_signature(&sigc, signature.buf, signature.len);
=20
 	if (!(flags & GPG_VERIFY_OMIT_STATUS))
 		print_signature_buffer(&sigc, flags);
--=20
2.34.1-365-gae484d3562

