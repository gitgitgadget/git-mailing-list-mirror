Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF86C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 23:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbhLHXrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:47:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56107 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241256AbhLHXrL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:47:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8ADD81605B2;
        Wed,  8 Dec 2021 18:43:38 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=3nsBaVLQllLyxuuO47eF4uvAS
        gh4Ki36xAz3+TxC2Yw=; b=cAg5M69jlx6fupVMOF25JuGOriQucQ5+FPwgfSB3G
        dfpkdu+ksS+RxB89ll4+9d1IbEOITdgpNJ+QM61HcZnhLDQyURC8MAnYNh0YYDmJ
        gRUVsf2Xl9A+NjjgsPWKeyjjkNFYS9A2quPIBGTNbujdDwrCeJ5Y4d0eK61hFb4v
        gU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83F4F1605B1;
        Wed,  8 Dec 2021 18:43:38 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85F4B1605B0;
        Wed,  8 Dec 2021 18:43:34 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5.1 8/8] ssh signing: verify ssh-keygen in test prereq
Date:   Wed,  8 Dec 2021 15:43:13 -0800
Message-Id: <20211208234313.3052303-9-gitster@pobox.com>
X-Mailer: git-send-email 2.34.1-365-gae484d3562
In-Reply-To: <20211208234313.3052303-1-gitster@pobox.com>
References: <20211208234313.3052303-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: A860E3BA-5880-11EC-819E-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

Do a full ssh signing, find-principals and verify operation in the test
prereq's to make sure ssh-keygen works as expected. Only generating the
keys and verifying its presence is not sufficient in some situations.
One example was ssh-keygen creating unusable ssh keys in cygwin because
of unsafe default permissions for the key files. The other a broken
openssh 8.7 that segfaulted on any find-principals operation. This
extended prereq check avoids future test breakages in case ssh-keygen or
any environment behaviour changes.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-gpg.sh | 53 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index fc03c8f89b..3fadfcb306 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -109,34 +109,61 @@ test_lazy_prereq GPGSSH '
 	echo $ssh_version | grep -q "find-principals:missing signature file"
 	test $? =3D 0 || exit 1;
=20
-	# some broken versions of ssh-keygen segfault on find-principals;
-	# avoid testing with them.
-	ssh-keygen -Y find-principals -f /dev/null -s /dev/null
-	test $? =3D 139 && exit 1
-
+	# Setup some keys and an allowed signers file
 	mkdir -p "${GNUPGHOME}" &&
 	chmod 0700 "${GNUPGHOME}" &&
 	(setfacl -k "${GNUPGHOME}" 2>/dev/null || true) &&
 	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_PRIMA=
RY}" >/dev/null &&
-	echo "\"principal with number 1\" $(cat "${GPGSSH_KEY_PRIMARY}.pub")" >=
> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GPGSSH_KEY_S=
ECONDARY}" >/dev/null &&
-	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")"=
 >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 enc=
rypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
-	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.=
pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
-	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRU=
STED}" >/dev/null
+	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRU=
STED}" >/dev/null &&
+
+	cat >"${GPGSSH_ALLOWED_SIGNERS}" <<-EOF &&
+	"principal with number 1" $(cat "${GPGSSH_KEY_PRIMARY}.pub")"
+	"principal with number 2" $(cat "${GPGSSH_KEY_SECONDARY}.pub")"
+	"principal with number 3" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")"
+	EOF
+
+	# Verify if at least one key and ssh-keygen works as expected
+	echo "testpayload" |
+	ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_PRIMARY}" >gpgssh_prereq.s=
ig &&
+	ssh-keygen -Y find-principals -f "${GPGSSH_ALLOWED_SIGNERS}" -s gpgssh_=
prereq.sig &&
+	echo "testpayload" |
+	ssh-keygen -Y verify -n "git" -f "${GPGSSH_ALLOWED_SIGNERS}" -I "princi=
pal with number 1" -s gpgssh_prereq.sig
 '
=20
 test_lazy_prereq GPGSSH_VERIFYTIME '
 	# Check if ssh-keygen has a verify-time option by passing an invalid da=
te to it
 	ssh-keygen -Overify-time=3DINVALID -Y check-novalidate -s doesnotmatter=
 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
+
+	# Set up keys with key lifetimes
 	ssh-keygen -t ed25519 -N "" -C "timeboxed valid key" -f "${GPGSSH_KEY_T=
IMEBOXEDVALID}" >/dev/null &&
-	echo "\"timeboxed valid key\" valid-after=3D\"20050407000000\",valid-be=
fore=3D\"200504100000\" $(cat "${GPGSSH_KEY_TIMEBOXEDVALID}.pub")" >> "${=
GPGSSH_ALLOWED_SIGNERS}" &&
+	key_valid=3D$(cat "${GPGSSH_KEY_TIMEBOXEDVALID}.pub") &&
 	ssh-keygen -t ed25519 -N "" -C "timeboxed invalid key" -f "${GPGSSH_KEY=
_TIMEBOXEDINVALID}" >/dev/null &&
-	echo "\"timeboxed invalid key\" valid-after=3D\"20050401000000\",valid-=
before=3D\"20050402000000\" $(cat "${GPGSSH_KEY_TIMEBOXEDINVALID}.pub")" =
>> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	key_invalid=3D$(cat "${GPGSSH_KEY_TIMEBOXEDINVALID}.pub") &&
 	ssh-keygen -t ed25519 -N "" -C "expired key" -f "${GPGSSH_KEY_EXPIRED}"=
 >/dev/null &&
-	echo "\"principal with expired key\" valid-before=3D\"20000101000000\" =
$(cat "${GPGSSH_KEY_EXPIRED}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	key_expired=3D$(cat "${GPGSSH_KEY_EXPIRED}.pub") &&
 	ssh-keygen -t ed25519 -N "" -C "not yet valid key" -f "${GPGSSH_KEY_NOT=
YETVALID}" >/dev/null &&
-	echo "\"principal with not yet valid key\" valid-after=3D\"299901010000=
00\" $(cat "${GPGSSH_KEY_NOTYETVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS=
}"
+	key_notyetvalid=3D$(cat "${GPGSSH_KEY_NOTYETVALID}.pub") &&
+
+	# Timestamps outside of test_tick span
+	ts2005a=3D20050401000000 ts2005b=3D200504020000 &&
+	# Timestamps within test_tick span
+	ts2005c=3D20050407000000 ts2005d=3D200504100000 &&
+	# Definitely not yet valid / expired timestamps
+	ts2000=3D20000101000000 ts2999=3D29990101000000 &&
+
+	cat >>"${GPGSSH_ALLOWED_SIGNERS}" <<-EOF &&
+	"timeboxed valid key" valid-after=3D"$ts2005c",valid-before=3D"$ts2005d=
" $key_valid"
+	"timeboxed invalid key" valid-after=3D"$ts2005a",valid-before=3D"$ts200=
5b" $key_invalid"
+	"principal with expired key" valid-before=3D"$ts2000" $key_expired"
+	"principal with not yet valid key" valid-after=3D"$ts2999" $key_notyetv=
alid"
+	EOF
+
+	# and verify ssh-keygen verifies the key lifetime
+	echo "testpayload" |
+	ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_EXPIRED}" >gpgssh_verifyti=
me_prereq.sig &&
+	! (ssh-keygen -Y verify -n "git" -f "${GPGSSH_ALLOWED_SIGNERS}" -I "pri=
ncipal with expired key" -s gpgssh_verifytime_prereq.sig)
 '
=20
 sanitize_pgp() {
--=20
2.34.1-365-gae484d3562

