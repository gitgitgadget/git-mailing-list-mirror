Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8771494C4
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321443; cv=none; b=PWhS1TdmTGW2DUbOWFcSTag4svBX5DvIE8bREeFGIwENMvhcnVENxv2nyoJ1NpINmMvmYbMTwzQ/qcDGdmpuRm5u39Ibn2aY6trO+BZDMCvtl2ciUhTH4/oZhrkt6TC3+hhJsWqlgUVsTKSdrm/9kqbjRsBeHRmwHVy4+u1vSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321443; c=relaxed/simple;
	bh=tsBzMn6ZzXQDtyrDg97INTCA8rJBYuiSH2QIGRY5oZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6T1uju1++r+pXKZ1C+GbHGSZBhGj7kBKLsARnxOPcjI/spDBh5QSShWXza4TJzFeJ9cT6iSjA8OBP+Re5XczSbRa5YXEON9NJ4CdKqrqJLWUbQcSqRfvVteVJxTNwePQRuUXuqHQCdYUGJ4hqgcZtVdSDMwnTxdzCGIeEkBHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BvMW9Vm0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BvMW9Vm0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BAF3E31206;
	Tue, 21 May 2024 15:57:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=tsBzMn6ZzXQDtyrDg97INTCA8
	rJBYuiSH2QIGRY5oZ4=; b=BvMW9Vm0FxCJ7EACat+/ZUSlJs8Er9GnLN3yasZQr
	bbOO4/F9dTg1DGVELStshCfQF8zCaH9qzG2Te8+pod5yIc/h1Gxg7Wxsg6v7GJ/9
	7IhwctCwOxyr4zQVbhZOTKN5DifEdqeWG6DW6vmwYxIPdVTRdDm/gKOF8FTWro2p
	BQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B392331205;
	Tue, 21 May 2024 15:57:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1FA1131204;
	Tue, 21 May 2024 15:57:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 06/12] hook: plug a new memory leak
Date: Tue, 21 May 2024 12:56:52 -0700
Message-ID: <20240521195659.870714-7-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <20240521195659.870714-1-gitster@pobox.com>
References: <20240521195659.870714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 551B3C9E-17AC-11EF-9060-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 8db1e8743c0 (clone: prevent hooks from running during a clone,
2024-03-28), I introduced an inadvertent memory leak that was
unfortunately not caught before v2.45.1 was released. Here is a fix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 hook.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 632b537b99..fc974cee1d 100644
--- a/hook.c
+++ b/hook.c
@@ -18,8 +18,10 @@ static int identical_to_template_hook(const char *name=
, const char *path)
 		found_template_hook =3D access(template_path.buf, X_OK) >=3D 0;
 	}
 #endif
-	if (!found_template_hook)
+	if (!found_template_hook) {
+		strbuf_release(&template_path);
 		return 0;
+	}
=20
 	ret =3D do_files_match(template_path.buf, path);
=20
--=20
2.45.1-216-g4365c6fcf9

