Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BEFC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 23:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbhLHXrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:47:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55133 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbhLHXrH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:47:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99ED017410E;
        Wed,  8 Dec 2021 18:43:34 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Hm5bRfa/txaq+Pyg9shDYyiM4
        diFWemjQD9oOHlDBlo=; b=LeAUH5c1owHyX7zZW+1L0jctTUQmTKfy3R5tpzaSR
        HzJHIG085pRVLE8EZQJQe/e7XBOlOH0FM6Wf75ZlbqH6eTtjxs77podJX5YWr8x1
        zDjm0qWV36OGAHqA7ofQ0AHK2xx24zcxmz+UGkx2TQRXu8L4hD1usEjqvQejPDJd
        6g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92A5217410D;
        Wed,  8 Dec 2021 18:43:34 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9720D17410B;
        Wed,  8 Dec 2021 18:43:30 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5.1 7/8] ssh signing: make fmt-merge-msg consider key lifetime
Date:   Wed,  8 Dec 2021 15:43:12 -0800
Message-Id: <20211208234313.3052303-8-gitster@pobox.com>
X-Mailer: git-send-email 2.34.1-365-gae484d3562
In-Reply-To: <20211208234313.3052303-1-gitster@pobox.com>
References: <20211208234313.3052303-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: A6097280-5880-11EC-950F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

Set the payload_type for check_signature() when generating merge messages=
 to
verify merged tags signatures key lifetimes.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fmt-merge-msg.c          |  1 +
 t/t6200-fmt-merge-msg.sh | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index deca1ea3a3..e4f7810be2 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -533,6 +533,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		else {
 			buf =3D payload.buf;
 			len =3D payload.len;
+			sigc.payload_type =3D SIGNATURE_PAYLOAD_TAG;
 			sigc.payload =3D strbuf_detach(&payload, &sigc.payload_len);
 			if (check_signature(&sigc, sig.buf, sig.len) &&
 			    !sigc.output)
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index b18ba58745..12a1e62bf0 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -91,6 +91,26 @@ test_expect_success GPGSSH 'created ssh signed commit =
and tag' '
 	git tag -s -u"${GPGSSH_KEY_UNTRUSTED}" -m signed-ssh-tag-msg-untrusted =
signed-untrusted-ssh-tag left
 '
=20
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed tags with ke=
ys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+	git checkout -b signed-expiry-ssh &&
+	touch file &&
+	git add file &&
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
 test_expect_success 'message for merging local branch' '
 	echo "Merge branch ${apos}left${apos}" >expected &&
=20
@@ -138,6 +158,44 @@ test_expect_success GPGSSH 'message for merging loca=
l tag signed by unknown ssh
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
 '
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local =
tag signed by expired ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . expired-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}expired-signed${apos}" actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local =
tag signed by not yet valid ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . notyetvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}notyetvalid-signed${apos}" actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local =
tag signed by valid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}timeboxedvalid-signed${apos}" actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local =
tag signed by invalid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedinvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}timeboxedinvalid-signed${apos}" actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success 'message for merging external branch' '
 	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
=20
--=20
2.34.1-365-gae484d3562

