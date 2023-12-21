Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F4BA33
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wtmct93/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 793461C14CD;
	Thu, 21 Dec 2023 01:59:34 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=asSYES2xfwjUEIIqviMsxtR6C
	tA6D9Wd9mUvvXLivP0=; b=wtmct93/rn+yGy678qTnm1wQAK9Lg4doGNduoWDM9
	XBWHuVGWsul8DaViWp4HTe8JPSt/N4ZvfrOtbuzt/BOsLJae+/hH+B7kMFPUoKKC
	eBvvOWVAOA9SOZWBGlAPKm5Oa0VN8VmNKRpPdSnBZ0npx/0lBJys2xs1TIkAOSMv
	7o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 718AD1C14CC;
	Thu, 21 Dec 2023 01:59:34 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D03B51C14CB;
	Thu, 21 Dec 2023 01:59:33 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/3] sparse-checkout: use default patterns for 'set' only !stdin
Date: Wed, 20 Dec 2023 22:59:24 -0800
Message-ID: <20231221065925.3234048-3-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-174-g055bb6e996
In-Reply-To: <20231221065925.3234048-1-gitster@pobox.com>
References: <20231221065925.3234048-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 7F0D1546-9FCE-11EE-8622-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"git sparse-checkout set ---no-cone" uses default patterns when none
is given from the command line, but it should do so ONLY when
--stdin is not being used.  Right now, add_patterns_from_input()
called when reading from the standard input is sloppy and does not
check if there are extra command line parameters that the command
will silently ignore, but that will change soon and not setting this
unnecessary and unused default patterns start to matter when it gets
fixed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This came from f2e3a218 (sparse-checkout: enable `set` to
   initialize sparse-checkout mode, 2021-12-14) by Elijah.

 builtin/sparse-checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8f55127202..04ae81fce8 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -837,7 +837,7 @@ static int sparse_checkout_set(int argc, const char *=
*argv, const char *prefix)
 	 * non-cone mode, if nothing is specified, manually select just the
 	 * top-level directory (much as 'init' would do).
 	 */
-	if (!core_sparse_checkout_cone && argc =3D=3D 0) {
+	if (!core_sparse_checkout_cone && !set_opts.use_stdin && argc =3D=3D 0)=
 {
 		argv =3D default_patterns;
 		argc =3D default_patterns_nr;
 	} else {
--=20
2.43.0-174-g055bb6e996

