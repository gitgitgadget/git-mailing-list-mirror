Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59CCC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 23:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbhLHXrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:47:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52128 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbhLHXrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:47:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95AF51605AF;
        Wed,  8 Dec 2021 18:43:27 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=2WplS0V21UM0vV78+vgDmhOtB
        dODQoDpN9G7SlFA4K4=; b=L2YxiMlD0xQ6FcVfaURzKN0QytBYWEloW2SLlnrUE
        tb0jCYazdwBZkRR09+e1aD9P39N5dtsmR9PgMI925qUXUQd0izVz8SinACpf57Ru
        Vu6cXlty6dxlmvXyN7dH5p2ejvWBaB+quypUezL2WmdYCvk+5PZqvwCim/RIXyE6
        6Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EF3A1605AD;
        Wed,  8 Dec 2021 18:43:27 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 933171605AC;
        Wed,  8 Dec 2021 18:43:23 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5.1 4/8] ssh signing: make verify-commit consider key lifetime
Date:   Wed,  8 Dec 2021 15:43:09 -0800
Message-Id: <20211208234313.3052303-5-gitster@pobox.com>
X-Mailer: git-send-email 2.34.1-365-gae484d3562
In-Reply-To: <20211208234313.3052303-1-gitster@pobox.com>
References: <20211208234313.3052303-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: A1DABC8C-5880-11EC-BB52-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

If valid-before/after dates are configured for this signatures key in the
allowedSigners file then the verification should check if the key was val=
id at
the time the commit was made. This allows for graceful key rollover and
revoking keys without invalidating all previous commits.
This feature needs openssh > 8.8. Older ssh-keygen versions will simply
ignore this flag and use the current time.
Strictly speaking this feature is available in 8.7, but since 8.7 has a
bug that makes it unusable in another needed call we require 8.8.

Timestamp information is present on most invocations of check_signature.
However signer ident is not. We will need the signer email / name to be a=
ble
to implement "Trust on first use" functionality later.
Since the payload contains all necessary information we can parse it
from there. The caller only needs to provide us some info about the
payload by setting payload_type in the signature_check struct.

 - Add payload_type field & enum and payload_timestamp to struct
   signature_check
 - Populate the timestamp when not already set if we know about the
   payload type
 - Pass -Overify-time=3D{payload_timestamp} in the users timezone to all
   ssh-keygen verification calls
 - Set the payload type when verifying commits
 - Add tests for expired, not yet valid and keys having a commit date
   outside of key validity as well as within

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/gpg.txt |  5 ++++
 commit.c                     |  1 +
 gpg-interface.c              | 53 ++++++++++++++++++++++++++++++++++++
 gpg-interface.h              |  9 ++++++
 t/t7528-signed-commit-ssh.sh | 42 ++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 4f30c7dbdd..c9be554c73 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -64,6 +64,11 @@ A repository that only allows signed commits can store=
 the file
 in the repository itself using a path relative to the top-level of the w=
orking tree.
 This way only committers with an already valid key can add or change key=
s in the keyring.
 +
+Since OpensSSH 8.8 this file allows specifying a key lifetime using vali=
d-after &
+valid-before options. Git will mark signatures as valid if the signing k=
ey was
+valid at the time of the signatures creation. This allows users to chang=
e a
+signing key without invalidating all previously made signatures.
++
 Using a SSH CA key with the cert-authority option
 (see ssh-keygen(1) "CERTIFICATES") is also valid.
=20
diff --git a/commit.c b/commit.c
index 64e040a99b..a348f085b2 100644
--- a/commit.c
+++ b/commit.c
@@ -1213,6 +1213,7 @@ int check_commit_signature(const struct commit *com=
mit, struct signature_check *
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <=3D=
 0)
 		goto out;
=20
+	sigc->payload_type =3D SIGNATURE_PAYLOAD_COMMIT;
 	sigc->payload =3D strbuf_detach(&payload, &sigc->payload_len);
 	ret =3D check_signature(sigc, signature.buf, signature.len);
=20
diff --git a/gpg-interface.c b/gpg-interface.c
index 75ab6faacb..330cfc5845 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -439,6 +439,13 @@ static int verify_ssh_signed_buffer(struct signature=
_check *sigc,
 	struct strbuf ssh_principals_err =3D STRBUF_INIT;
 	struct strbuf ssh_keygen_out =3D STRBUF_INIT;
 	struct strbuf ssh_keygen_err =3D STRBUF_INIT;
+	struct strbuf verify_time =3D STRBUF_INIT;
+	const struct date_mode verify_date_mode =3D {
+		.type =3D DATE_STRFTIME,
+		.strftime_fmt =3D "%Y%m%d%H%M%S",
+		/* SSH signing key validity has no timezone information - Use the loca=
l timezone */
+		.local =3D 1,
+	};
=20
 	if (!ssh_allowed_signers) {
 		error(_("gpg.ssh.allowedSignersFile needs to be configured and exist f=
or ssh signature verification"));
@@ -456,11 +463,16 @@ static int verify_ssh_signed_buffer(struct signatur=
e_check *sigc,
 		return -1;
 	}
=20
+	if (sigc->payload_timestamp)
+		strbuf_addf(&verify_time, "-Overify-time=3D%s",
+			show_date(sigc->payload_timestamp, 0, &verify_date_mode));
+
 	/* Find the principal from the signers */
 	strvec_pushl(&ssh_keygen.args, fmt->program,
 		     "-Y", "find-principals",
 		     "-f", ssh_allowed_signers,
 		     "-s", buffer_file->filename.buf,
+		     verify_time.buf,
 		     NULL);
 	ret =3D pipe_command(&ssh_keygen, NULL, 0, &ssh_principals_out, 0,
 			   &ssh_principals_err, 0);
@@ -478,6 +490,7 @@ static int verify_ssh_signed_buffer(struct signature_=
check *sigc,
 			     "-Y", "check-novalidate",
 			     "-n", "git",
 			     "-s", buffer_file->filename.buf,
+			     verify_time.buf,
 			     NULL);
 		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
@@ -512,6 +525,7 @@ static int verify_ssh_signed_buffer(struct signature_=
check *sigc,
 				     "-f", ssh_allowed_signers,
 				     "-I", principal,
 				     "-s", buffer_file->filename.buf,
+				     verify_time.buf,
 				     NULL);
=20
 			if (ssh_revocation_file) {
@@ -556,10 +570,46 @@ static int verify_ssh_signed_buffer(struct signatur=
e_check *sigc,
 	strbuf_release(&ssh_principals_err);
 	strbuf_release(&ssh_keygen_out);
 	strbuf_release(&ssh_keygen_err);
+	strbuf_release(&verify_time);
=20
 	return ret;
 }
=20
+static int parse_payload_metadata(struct signature_check *sigc)
+{
+	const char *ident_line =3D NULL;
+	size_t ident_len;
+	struct ident_split ident;
+	const char *signer_header;
+
+	switch (sigc->payload_type) {
+	case SIGNATURE_PAYLOAD_COMMIT:
+		signer_header =3D "committer";
+		break;
+	case SIGNATURE_PAYLOAD_TAG:
+		signer_header =3D "tagger";
+		break;
+	case SIGNATURE_PAYLOAD_UNDEFINED:
+	case SIGNATURE_PAYLOAD_PUSH_CERT:
+		/* Ignore payloads we don't want to parse */
+		return 0;
+	default:
+		BUG("invalid value for sigc->payload_type");
+	}
+
+	ident_line =3D find_commit_header(sigc->payload, signer_header, &ident_=
len);
+	if (!ident_line || !ident_len)
+		return 1;
+
+	if (split_ident_line(&ident, ident_line, ident_len))
+		return 1;
+
+	if (!sigc->payload_timestamp && ident.date_begin && ident.date_end)
+		sigc->payload_timestamp =3D parse_timestamp(ident.date_begin, NULL, 10=
);
+
+	return 0;
+}
+
 int check_signature(struct signature_check *sigc,
 		    const char *signature, size_t slen)
 {
@@ -573,6 +623,9 @@ int check_signature(struct signature_check *sigc,
 	if (!fmt)
 		die(_("bad/incompatible signature '%s'"), signature);
=20
+	if (parse_payload_metadata(sigc))
+		return 1;
+
 	status =3D fmt->verify_signed_buffer(sigc, fmt, signature, slen);
=20
 	if (status && !sigc->output)
diff --git a/gpg-interface.h b/gpg-interface.h
index 5ee7d8b6b9..b30cbdcd3d 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -15,9 +15,18 @@ enum signature_trust_level {
 	TRUST_ULTIMATE,
 };
=20
+enum payload_type {
+	SIGNATURE_PAYLOAD_UNDEFINED,
+	SIGNATURE_PAYLOAD_COMMIT,
+	SIGNATURE_PAYLOAD_TAG,
+	SIGNATURE_PAYLOAD_PUSH_CERT,
+};
+
 struct signature_check {
 	char *payload;
 	size_t payload_len;
+	enum payload_type payload_type;
+	timestamp_t payload_timestamp;
 	char *output;
 	char *gpg_status;
=20
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index badf3ed320..dae76ded0c 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -76,6 +76,23 @@ test_expect_success GPGSSH 'create signed commits' '
 	git tag twelfth-signed-alt $(cat oid)
 '
=20
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with=
 keys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+
+	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH=
_KEY_EXPIRED}" &&
+	git tag expired-signed &&
+
+	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"=
${GPGSSH_KEY_NOTYETVALID}" &&
+	git tag notyetvalid-signed &&
+
+	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedval=
id -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
+	git tag timeboxedvalid-signed &&
+
+	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedi=
nvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
+	git tag timeboxedinvalid-signed
+'
+
 test_expect_success GPGSSH 'verify and show signatures' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_config gpg.mintrustlevel UNDEFINED &&
@@ -122,6 +139,31 @@ test_expect_success GPGSSH 'verify-commit exits fail=
ure on untrusted signature'
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
 '
=20
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failur=
e on expired signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-commit expired-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failur=
e on not yet valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-commit notyetvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit succeeds wit=
h commit date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git verify-commit timeboxedvalid-signed 2>actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failur=
e with commit date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-commit timeboxedinvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPGSSH 'verify-commit exits success with matching mi=
nTrustLevel' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_config gpg.minTrustLevel fully &&
--=20
2.34.1-365-gae484d3562

