Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F22C433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 23:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbhLHXq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:46:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54215 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbhLHXq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:46:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9249C174107;
        Wed,  8 Dec 2021 18:43:23 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=KonDw/WEf2kNYEeFA1bofBimb
        qjiqZerLr5IilNFymk=; b=tnhJ/TygM19V560BA2n1HQXBVq7i0UDrY4m5RFaYf
        lcDS0IlE4MntrputEQrzbkHC/C0GQcvUshlWobe+od2D22H0keOHV/8bNaj+5QFe
        kCArchwcX+PphIyWFfZGC/eGUU6hqsJrSuRHqXYMYBix6w57xLqPLh3kTiJgtop0
        y4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8973A174106;
        Wed,  8 Dec 2021 18:43:23 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 857D8174105;
        Wed,  8 Dec 2021 18:43:19 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5.1 3/8] ssh signing: add key lifetime test prereqs
Date:   Wed,  8 Dec 2021 15:43:08 -0800
Message-Id: <20211208234313.3052303-4-gitster@pobox.com>
X-Mailer: git-send-email 2.34.1-365-gae484d3562
In-Reply-To: <20211208234313.3052303-1-gitster@pobox.com>
References: <20211208234313.3052303-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 9F6FD19E-5880-11EC-94B0-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

if ssh-keygen supports -Overify-time, add test keys marked as expired,
not yet valid and valid both within the test_tick timeframe and outside o=
f it.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-gpg.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index a3f285f515..fc03c8f89b 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -90,6 +90,10 @@ test_lazy_prereq RFC1991 '
 GPGSSH_KEY_PRIMARY=3D"${GNUPGHOME}/ed25519_ssh_signing_key"
 GPGSSH_KEY_SECONDARY=3D"${GNUPGHOME}/rsa_2048_ssh_signing_key"
 GPGSSH_KEY_UNTRUSTED=3D"${GNUPGHOME}/untrusted_ssh_signing_key"
+GPGSSH_KEY_EXPIRED=3D"${GNUPGHOME}/expired_ssh_signing_key"
+GPGSSH_KEY_NOTYETVALID=3D"${GNUPGHOME}/notyetvalid_ssh_signing_key"
+GPGSSH_KEY_TIMEBOXEDVALID=3D"${GNUPGHOME}/timeboxed_valid_ssh_signing_ke=
y"
+GPGSSH_KEY_TIMEBOXEDINVALID=3D"${GNUPGHOME}/timeboxed_invalid_ssh_signin=
g_key"
 GPGSSH_KEY_WITH_PASSPHRASE=3D"${GNUPGHOME}/protected_ssh_signing_key"
 GPGSSH_KEY_PASSPHRASE=3D"super_secret"
 GPGSSH_ALLOWED_SIGNERS=3D"${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
@@ -119,7 +123,20 @@ test_lazy_prereq GPGSSH '
 	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")"=
 >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 enc=
rypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
 	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.=
pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
-	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRU=
STED}" >/dev/null
+'
+
+test_lazy_prereq GPGSSH_VERIFYTIME '
+	# Check if ssh-keygen has a verify-time option by passing an invalid da=
te to it
+	ssh-keygen -Overify-time=3DINVALID -Y check-novalidate -s doesnotmatter=
 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
+	ssh-keygen -t ed25519 -N "" -C "timeboxed valid key" -f "${GPGSSH_KEY_T=
IMEBOXEDVALID}" >/dev/null &&
+	echo "\"timeboxed valid key\" valid-after=3D\"20050407000000\",valid-be=
fore=3D\"200504100000\" $(cat "${GPGSSH_KEY_TIMEBOXEDVALID}.pub")" >> "${=
GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "timeboxed invalid key" -f "${GPGSSH_KEY=
_TIMEBOXEDINVALID}" >/dev/null &&
+	echo "\"timeboxed invalid key\" valid-after=3D\"20050401000000\",valid-=
before=3D\"20050402000000\" $(cat "${GPGSSH_KEY_TIMEBOXEDINVALID}.pub")" =
>> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "expired key" -f "${GPGSSH_KEY_EXPIRED}"=
 >/dev/null &&
+	echo "\"principal with expired key\" valid-before=3D\"20000101000000\" =
$(cat "${GPGSSH_KEY_EXPIRED}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "not yet valid key" -f "${GPGSSH_KEY_NOT=
YETVALID}" >/dev/null &&
+	echo "\"principal with not yet valid key\" valid-after=3D\"299901010000=
00\" $(cat "${GPGSSH_KEY_NOTYETVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS=
}"
 '
=20
 sanitize_pgp() {
--=20
2.34.1-365-gae484d3562

