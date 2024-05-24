Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A574407
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580055; cv=none; b=LasOtVMibP0GUhxSqyTVJslz+Tyjx8r6Cwm3DFBVhJSayIESM31Qbi5Nte3QOVAhvDcnjziEqKcaatddjIdXTfwI30CW1X4Iha3qIOAwU57B+Um9fpp0A3L7t0pVEq+kI3eyGgl1gjbXisZj9VPNnKKdkc+koIsUbw59Lec9NIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580055; c=relaxed/simple;
	bh=FxN9wm8sb28Uzj8MSoNt1QIynPZP+CRmydOpPPczsSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uo4w6+aas1oPDnQwFMeOLP9tchlZtl3OvLV1eZPboagfFgUyKMcsHYEu/de3DhhHdbWGQollrbMXCMdIdSAwdTNB2VokwAjoVqMBszqJht2EJXTUg2dqkzGGc1H+TivrlrDtCz/lSGV/m+dQ5ScqaaFF1ONFupy4BMeaq3wwPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JJsM55rt; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JJsM55rt"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E927C2B2B3;
	Fri, 24 May 2024 15:47:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=FxN9wm8sb28Uzj8MSoNt1QIyn
	PZP+CRmydOpPPczsSw=; b=JJsM55rtDw2kZ/Fh85cTHa6CaNbfTn43NiijCeKVD
	xppig60b0ZzJMYigGGVfqLgmUIQmYfFdeX7dMrl/O05dvFxUAM40gd5ABgZ8PHZZ
	gDmRKsaIuonqLuAPkpkHWS/lp6BwfHZGtfbFKFCWgIrjHRFb+Pc8LfZq3/7PSiix
	N8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF44F2B2B2;
	Fri, 24 May 2024 15:47:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50F8E2B2AF;
	Fri, 24 May 2024 15:47:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 07/12] init: use the correct path of the templates directory again
Date: Fri, 24 May 2024 12:47:10 -0700
Message-ID: <20240524194715.695916-8-gitster@pobox.com>
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
 75FDF30A-1A06-11EF-A927-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
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
2.45.1-246-gb9cfe4845c

