Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECAB3BBE8
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580053; cv=none; b=EjsG7MzoaW1Hg/fApmaiGe0vLYb+bLat5jxuQG4/Xhe7JOZLXwwnumxU+vEtPYO75pe8ndMyk4AyGE9ieQrKisSPXb+HuKyC0gtkmr0wUfrE/BK72pBjlU2utTxTPXKxfx1EQgzL2GRzkxgvW9Zv6zXzGR4X3D6oB62wajROHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580053; c=relaxed/simple;
	bh=VgID3f/dAquF1ceQfjX9F+pp694KoVFcGsPxrpticYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgJKafCCF0G6bRRMmpKvgviAClsKQ//P0ktnRzIqycDjdsjXHpqp8EwqqJ1ynfAtPqD5ipDt1riC1SQMysLc+c7WyfNHdeAEG6QsPo3OAHl7EX058bCW4tk2EMn9V7aLDf5NOv13lfrDnSeLe1nYzKPQUX4nBwCcaeMsu6Tw2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W7gO4P7I; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W7gO4P7I"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 442A62B226;
	Fri, 24 May 2024 15:47:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=VgID3f/dAquF1ceQfjX9F+pp6
	94KoVFcGsPxrpticYs=; b=W7gO4P7InrVcpUhxSKFqs5hLPBSNz0v8nrYjqnzh/
	qq0JtrTJTWvfxqQ0Ix0SpAtl5+Ji98bPzcvq+h/m1rcGWcE+pe8FtD6z3bhG6hP+
	LxBodU8WURGyOOLiec0JQR697rbCMJCy5iKaZ9kSwcvb03YTd4aAOtXsGNHvAocw
	RQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CA8F2B225;
	Fri, 24 May 2024 15:47:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5BA322B224;
	Fri, 24 May 2024 15:47:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 06/12] hook: plug a new memory leak
Date: Fri, 24 May 2024 12:47:09 -0700
Message-ID: <20240524194715.695916-7-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-246-gb9cfe4845c
In-Reply-To: <20240524194715.695916-1-gitster@pobox.com>
References: <20240524194715.695916-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 743A58EC-1A06-11EF-B5A9-A19503B9AAD1-77302942!pb-smtp21.pobox.com
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
2.45.1-246-gb9cfe4845c

