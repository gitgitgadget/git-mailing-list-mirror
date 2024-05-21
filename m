Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C111494DD
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321451; cv=none; b=aPZ14+C9oShvUWiTGXOKwvAmg4pPl80Gfn0Gut/Zh+awUFtgR79vCqnykCkPN0AOTcLZGYDIdYi10PE9X1H/cUd1o/Hf6ZBosrWAD+JhWCJ5t7uhPslHyPBKrNmIBpNH+kpl3hehMMd4goT3vTM13KEgQPi47htnPWjqW8D1iJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321451; c=relaxed/simple;
	bh=RF1htK79hEhaPg2EN1SMbIx/fjbxT7dL9fOAa6ajORg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFE9PPD2ub1oetx7wwFgsVh7WTeg2+WE/RySbbd6PJp9pHgfxbHfTvn2sIeWGlx7ZIC5SUD0mBma38vZxiMtpUtMYCjBflIX3o3rN4xlSfRyoZb5AX1KvcVcH/vyyN1anVN+dtcMt1Hcvy+JzaozPJOqNmJ1mCluM6j3LeLokp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xklYn4Ob; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xklYn4Ob"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CAB1D3123C;
	Tue, 21 May 2024 15:57:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=RF1htK79hEhaPg2EN1SMbIx/f
	jbxT7dL9fOAa6ajORg=; b=xklYn4ObYWIV5FxcXE9gQv/Cg0yrqx0gUU6rcatat
	fsfDkTpqr7HGswYMVk56p5aSm4K9jr8LT+9TxyTeLjy92xo+Ns0oAww/hmgyxSTf
	lhiX0EtUcA6QkZEQNM1VWAJntsaPR8AyHf/5yeezbjwEPduopqWUmV+K+XZCl3La
	dM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C2BB53123B;
	Tue, 21 May 2024 15:57:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2C793123A;
	Tue, 21 May 2024 15:57:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 09/12] tests: verify that `clone -c core.hooksPath=/dev/null` works again
Date: Tue, 21 May 2024 12:56:55 -0700
Message-ID: <20240521195659.870714-10-gitster@pobox.com>
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
 591EF1AA-17AC-11EF-9D7A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As part of the protections added in Git v2.45.1 and friends,
repository-local `core.hooksPath` settings are no longer allowed, as a
defense-in-depth mechanism to prevent future Git vulnerabilities to
raise to critical level if those vulnerabilities inadvertently allow the
repository-local config to be written.

What the added protection did not anticipate is that such a
repository-local `core.hooksPath` can not only be used to point to
maliciously-placed scripts in the current worktree, but also to
_prevent_ hooks from being called altogether.

We just reverted the `core.hooksPath` protections, based on the Git
maintainer's recommendation in
https://lore.kernel.org/git/xmqq4jaxvm8z.fsf@gitster.g/ to address this
concern as well as related ones. Let's make sure that we won't regress
while trying to protect the clone operation further.

Reported-by: Brooke Kuhlmann <brooke@alchemists.io>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1350-config-hooks-path.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index f6dc83e2aa..45a0492917 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -41,4 +41,11 @@ test_expect_success 'git rev-parse --git-path hooks' '
 	test .git/custom-hooks/abc =3D "$(cat actual)"
 '
=20
+test_expect_success 'core.hooksPath=3D/dev/null' '
+	git clone -c core.hooksPath=3D/dev/null . no-templates &&
+	value=3D"$(git -C no-templates config --local core.hooksPath)" &&
+	# The Bash used by Git for Windows rewrites `/dev/null` to `nul`
+	{ test /dev/null =3D "$value" || test nul =3D "$value"; }
+'
+
 test_done
--=20
2.45.1-216-g4365c6fcf9

