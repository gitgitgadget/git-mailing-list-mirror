Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672771BF3F
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580049; cv=none; b=OMCkEd8thjYtS0el+xtxchQ7eGOcXlB6KxJagDca2qUfopXgv+CXaIdmzWdZbTYzCVI9nccO3xcfoUm/AQF/mCsLfh5wn40T+UPynYhwortr9mo9aYcCRrN+p2kG4xscEicesUPAe3J8FrDCGzGJg1cZMlrYtlC4F5+RDc0h4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580049; c=relaxed/simple;
	bh=4BVD17Iepmxey6bJP1WfgVoe0jtjb8FKifltmsONg/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3ICteLRbw6W1EecCp517gW7B1oU3lQQWXrAcyvYqmuzSNX0SeMNrYcPkdfn1F/vP9yAasDCN+8slGyvDyd0ehWxlDT07vS9KJY6sfXSQhgDORW6naPtUkP6Vgd2jHnNTAS2AcsKrUzoVbjA8d1qCaYPdk35+fP3HpxkR2Ywu2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fqp995pC; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fqp995pC"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AF4EE276DE;
	Fri, 24 May 2024 15:47:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=4BVD17Iepmxey6bJP1WfgVoe0
	jtjb8FKifltmsONg/E=; b=Fqp995pCqvBjqMZVL07rg6wNo2/EoewBQR5FutDli
	UjZ7qR4lmJ1o39Y9aSQ6oBBxMlGIGTEcpmOktlt4KN66VxOXuSTP21/N1yhyNvV1
	XD1kSF4G6Ng+b1j5pXuqSIYQah946nJJ1UDGL6R223TzK0qy4svE927qhVDwweJN
	4A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 85700276DD;
	Fri, 24 May 2024 15:47:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A0F1B276DA;
	Fri, 24 May 2024 15:47:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v2 04/12] ci: avoid bare "gcc" for osx-gcc job
Date: Fri, 24 May 2024 12:47:07 -0700
Message-ID: <20240524194715.695916-5-gitster@pobox.com>
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
 716A9B0E-1A06-11EF-B1E5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Jeff King <peff@peff.net>

On macOS, a bare "gcc" (without a version) will invoke a wrapper for
clang, not actual gcc. Even when gcc is installed via homebrew, that
only provides version-specific links in /usr/local/bin (like "gcc-13"),
and never a version-agnostic "gcc" wrapper.

As far as I can tell, this has been the case for a long time, and this
osx-gcc job has largely been doing nothing. We can point it at "gcc-13",
which will pick up the homebrew-installed version.

The fix here is specific to the github workflow file, as the gitlab one
does not have a matching job.

It's a little unfortunate that we cannot just ask for the latest version
of gcc which homebrew provides, but as far as I can tell there is no
easy alias (you'd have to find the highest number gcc-* in
/usr/local/bin yourself).

[jc: cherry-picked from v2.45.0-2-g11c7001e3d]

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 2dc0221f7f..583e7cd5f0 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -264,7 +264,7 @@ jobs:
             cc: clang
             pool: macos-13
           - jobname: osx-gcc
-            cc: gcc
+            cc: gcc-13
             cc_package: gcc-13
             pool: macos-13
           - jobname: linux-gcc-default
--=20
2.45.1-246-gb9cfe4845c

