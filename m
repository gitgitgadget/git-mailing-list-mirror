Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D749C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 23:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbhLHXrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:47:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55527 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241226AbhLHXrC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:47:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B78EF429E;
        Wed,  8 Dec 2021 18:43:29 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=v96o96R0iwv+wovmNaKxjBzqE
        3WnJinxqLD2gFzvPPc=; b=P2cPF4+jsXfFqGYw/PhewGJMbba293NFSoD9w13cN
        QU6zjCukZAPKzUQBP+JixvCOI48NAL8ay6I5vpAKahaCTLcwSVbCDYBkUWKENOVu
        88RpXRdB7SWQiulfolWV6vqF8KJtJ0CMcEkN9kncGOq+MyU5Qgd2cDQfH3lqaeBN
        FE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 624E7F429D;
        Wed,  8 Dec 2021 18:43:29 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1BDAF429C;
        Wed,  8 Dec 2021 18:43:28 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5.1 6/8] ssh signing: make verify-tag consider key lifetime
Date:   Wed,  8 Dec 2021 15:43:11 -0800
Message-Id: <20211208234313.3052303-7-gitster@pobox.com>
X-Mailer: git-send-email 2.34.1-365-gae484d3562
In-Reply-To: <20211208234313.3052303-1-gitster@pobox.com>
References: <20211208234313.3052303-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: A4F2D742-5880-11EC-9079-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

Set the payload_type for check_signature() when calling verify-tag.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7031-verify-tag-signed-ssh.sh | 42 ++++++++++++++++++++++++++++++++
 tag.c                            |  1 +
 2 files changed, 43 insertions(+)

diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed=
-ssh.sh
index 06c9dd6c93..1cb36b9ab8 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -48,6 +48,23 @@ test_expect_success GPGSSH 'create signed tags ssh' '
 	git tag -u"${GPGSSH_KEY_UNTRUSTED}" -m eighth eighth-signed-alt
 '
=20
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed tags with ke=
ys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+
+	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH=
_KEY_EXPIRED}" &&
+	git tag -s -u "${GPGSSH_KEY_EXPIRED}" -m expired-signed expired-signed =
&&
+
+	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"=
${GPGSSH_KEY_NOTYETVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_NOTYETVALID}" -m notyetvalid-signed notyetv=
alid-signed &&
+
+	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedval=
id -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDVALID}" -m timeboxedvalid-signed t=
imeboxedvalid-signed &&
+
+	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedi=
nvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDINVALID}" -m timeboxedinvalid-sign=
ed timeboxedinvalid-signed
+'
+
 test_expect_success GPGSSH 'verify and show ssh signatures' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	(
@@ -80,6 +97,31 @@ test_expect_success GPGSSH 'verify and show ssh signat=
ures' '
 	)
 '
=20
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag exits failure o=
n expired signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag expired-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag exits failure o=
n not yet valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag notyetvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag succeeds with t=
ag date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git verify-tag timeboxedvalid-signed 2>actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag failes with tag=
 date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag timeboxedinvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPGSSH 'detect fudged ssh signature' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git cat-file tag seventh-signed >raw &&
diff --git a/tag.c b/tag.c
index 62fb09f5a5..dfbcd7fcc2 100644
--- a/tag.c
+++ b/tag.c
@@ -25,6 +25,7 @@ static int run_gpg_verify(const char *buf, unsigned lon=
g size, unsigned flags)
 		return error("no signature found");
 	}
=20
+	sigc.payload_type =3D SIGNATURE_PAYLOAD_TAG;
 	sigc.payload =3D strbuf_detach(&payload, &sigc.payload_len);
 	ret =3D check_signature(&sigc, signature.buf, signature.len);
=20
--=20
2.34.1-365-gae484d3562

