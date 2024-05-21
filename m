Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330151494CD
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321444; cv=none; b=SWooktWgY10ixOCFVhbLQmWSKp2chW7/oEXfZrVt5a/nJfehlBQoXvkkIb8nfH/gMP9bwCbek1GdxrSgU4tgZa4IA4h5dzxkodqsXMEK4/IzdWuqCJXatKtMmP/897w9VKT9n/KT6voU84jLfY50gltTzdHY3jMzViDvFHH1udY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321444; c=relaxed/simple;
	bh=uCQM9Zlksy6MiYttstcPV+nkDsX8WJYmtLCG8s2WkYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MV/HRFnLqRa1chtJKzB3fcn6qYRkysH/yGcikKCqHFNM1h8Gov6AA6wUBxb+SI6uaRm8AssqkZXZla5apAJAmwfjqSBJNEOAJNi/vtqAhGh4PAwWvEiWz1DXrbQPAcN0UJJSvmFVx/bHCDFGHkwhMPqCoE53gcXrUWsVrd3Zd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uQKyYkDx; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uQKyYkDx"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DA752228D;
	Tue, 21 May 2024 15:57:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=uCQM9Zlksy6MiYttstcPV+nkD
	sX8WJYmtLCG8s2WkYs=; b=uQKyYkDx39gWtvo86S/bUjQwA87Lb4xs4Lqsf3UPQ
	nBTZNAsQxXI6gvKXFeltg2iqadp4sqiko32XepQzrbWXSttG1H8h8ONOB6W+Nx1K
	6D0ty2N/mcMRwIIuCFH5b+FeZQCWs8VEfciT3muqG5ls1xDQjf7z03ZAZlWIwmmY
	oA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 458322228C;
	Tue, 21 May 2024 15:57:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A73272228B;
	Tue, 21 May 2024 15:57:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 07/12] init: use the correct path of the templates directory again
Date: Tue, 21 May 2024 12:56:53 -0700
Message-ID: <20240521195659.870714-8-gitster@pobox.com>
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
 5608D4EA-17AC-11EF-8A22-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In df93e407f06 (init: refactor the template directory discovery into its
own function, 2024-03-29), I refactored the way the templates directory
is discovered.

The refactoring was faithful, but missed a reference in the `Makefile`
where the `DEFAULT_GIT_TEMPLATE_DIR` constant is defined. As a
consequence, Git v2.45.1 and friends will always use the hard-coded path
`/usr/share/git-core/templates`.

Let's fix that by defining the `DEFAULT_GIT_TEMPLATE_DIR` when building
`setup.o`, where that constant is actually used.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 093829ae28..4b1502ba2c 100644
--- a/Makefile
+++ b/Makefile
@@ -2751,7 +2751,7 @@ exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS =3D=
 \
 	'-DFALLBACK_RUNTIME_PREFIX=3D"$(prefix_SQ)"'
=20
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
-builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS =3D=
 \
+setup.sp setup.s setup.o: EXTRA_CPPFLAGS =3D \
 	-DDEFAULT_GIT_TEMPLATE_DIR=3D'"$(template_dir_SQ)"'
=20
 config.sp config.s config.o: GIT-PREFIX
--=20
2.45.1-216-g4365c6fcf9

