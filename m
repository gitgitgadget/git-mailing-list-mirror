Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3950C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 23:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbhLHXrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:47:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61505 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241213AbhLHXrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:47:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E98F1ECD78;
        Wed,  8 Dec 2021 18:43:27 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=nTZcbM8xt2YG51mcy67rxSylX
        avmAKezw3aBaghz71I=; b=a88N2hN7P3ubweGE81WltkaRSbpL9SKnl+1YnKJL1
        vYJd3OoyAN9KWt8S/GFXpYeQ1hZq7s9+v6mwZcAw0yc3w8NBdzHGHPYAQOyBruIy
        onKUfPUfbxAIKN/1FEagNMOXxIZxj/lP4l8/Ig0Jrb655xIXgt/SeVTcQJyf3+HN
        jI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E10A5ECD76;
        Wed,  8 Dec 2021 18:43:27 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45404ECD75;
        Wed,  8 Dec 2021 18:43:27 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5.1 5/8] ssh signing: make git log verify key lifetime
Date:   Wed,  8 Dec 2021 15:43:10 -0800
Message-Id: <20211208234313.3052303-6-gitster@pobox.com>
X-Mailer: git-send-email 2.34.1-365-gae484d3562
In-Reply-To: <20211208234313.3052303-1-gitster@pobox.com>
References: <20211208234313.3052303-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: A40CF4A2-5880-11EC-B087-C48D900A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

Set the payload_type for check_signature() when calling git log.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 log-tree.c     |  2 ++
 t/t4202-log.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index a46cf60e1e..d3e7a40b64 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -513,6 +513,7 @@ static void show_signature(struct rev_info *opt, stru=
ct commit *commit)
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <=3D=
 0)
 		goto out;
=20
+	sigc.payload_type =3D SIGNATURE_PAYLOAD_COMMIT;
 	sigc.payload =3D strbuf_detach(&payload, &sigc.payload_len);
 	status =3D check_signature(&sigc, signature.buf, signature.len);
 	if (status && !sigc.output)
@@ -583,6 +584,7 @@ static int show_one_mergetag(struct commit *commit,
 	status =3D -1;
 	if (parse_signature(extra->value, extra->len, &payload, &signature)) {
 		/* could have a good signature */
+		sigc.payload_type =3D SIGNATURE_PAYLOAD_TAG;
 		sigc.payload =3D strbuf_detach(&payload, &sigc.payload_len);
 		status =3D check_signature(&sigc, signature.buf, signature.len);
 		if (sigc.output)
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7884e3d46b..ba855ec893 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1677,6 +1677,24 @@ test_expect_success GPGSSH 'setup sshkey signed br=
anch' '
 	git commit -S -m signed_commit
 '
=20
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with=
 keys having defined lifetimes' '
+	test_config gpg.format ssh &&
+	touch file &&
+	git add file &&
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
 test_expect_success GPGSM 'log x509 fingerprint' '
 	echo "F8BF62E0693D0694816377099909C779FA23FD65 | " >expect &&
 	git log -n1 --format=3D"%GF | %GP" signed-x509 >actual &&
@@ -1714,6 +1732,31 @@ test_expect_success GPGSSH 'log --graph --show-sig=
nature ssh' '
 	grep "${GOOD_SIGNATURE_TRUSTED}" actual
 '
=20
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on expir=
ed signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 expired-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on not y=
et valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 notyetvalid-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log show success with comm=
it date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 timeboxedvalid-signed >actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure with com=
mit date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 timeboxedinvalid-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	test_when_finished "git reset --hard && git checkout main" &&
 	git checkout -b plain main &&
--=20
2.34.1-365-gae484d3562

