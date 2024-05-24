Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2515EE97
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580059; cv=none; b=kxDhps8RXv5822KVrbD2+DG8vAwOq8CqOk+EiLtkW/ObupZNKa8x9L3pO4ikkQ8XPKTY4zjRPyRskEgY3h/IGekG4D1PX4IiDVE90HKEPh6VSQTyK8UQdYG12bij06ralKLgogAu+kQ6ZFTdP4TBKxWHJc8jf1oRXmJkuptZANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580059; c=relaxed/simple;
	bh=11AqBprsJUs8zFqEr8qYzsEK8p+XCN9gOBcG75Ea6mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUKgIUkRJgsPq9sVESBbF2jGxBk98jPqtFgGPYt8lpS7Fk/jkKweOWJwGAOmoQFfSTglyxi2W3C46B0rUpmD7xJFUgjB4ec6yeWaWQIRHcVR5U4dFUHAV+Z6c9U1HIM+QJ4P4b1z9AR8+V3Wv/2TwPFulWq3zOLljbNAhn1zkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FeDxY/zv; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FeDxY/zv"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B32141BD23;
	Fri, 24 May 2024 15:47:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=11AqBprsJUs8zFqEr8qYzsEK8
	p+XCN9gOBcG75Ea6mo=; b=FeDxY/zv8heOgNYCLtkN9axXScWMlAbAEFYaDEPSQ
	mQRi7Ixqs2OMQGUFoJfDDOh5ScgGP8oKrAZS1Aft5N5t4kZP+t1YJN3WbejXBD0y
	82WA65qjMzOpBUohGXtG4BcfrgcHco+hWAH8fD/uSTcOQlV8ChHyIlcWAn12oLvA
	TA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AA8861BD22;
	Fri, 24 May 2024 15:47:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19FEB1BD21;
	Fri, 24 May 2024 15:47:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH v2 09/12] tests: verify that `clone -c core.hooksPath=/dev/null` works again
Date: Fri, 24 May 2024 12:47:12 -0700
Message-ID: <20240524194715.695916-10-gitster@pobox.com>
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
 78D6A702-1A06-11EF-8527-25B3960A682E-77302942!pb-smtp2.pobox.com
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
2.45.1-246-gb9cfe4845c

