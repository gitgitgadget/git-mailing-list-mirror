Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A23BBE8
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580050; cv=none; b=f8RQwC9xePutZs+3WI1BM3t9aYs78ZMeiNqpn8z2xva2kKIlsiYzmnugE3tDOCJfRMbJ25d4IDspCiS5s8U9ncC0/cB6fOgZuTQeKVNdbxzqFLrmXLXaLgw6AyEKHMbTgGJcI4h5YE3T5laBTVhUcaVBut7LgLrwELl7AcEVm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580050; c=relaxed/simple;
	bh=24m0vmy1mYJEaxM28E1Q/AuWGMrl8QVsaJ0xHn071us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=un7aRGp9oav8VsnehGu/bCdW2J9yrDmKvtNc0TzBS98N/CkB7xbWihyTttrwYyiv+U5RqoU9HobujRgTsxnBa2Povx3/eGBXGVfTojqPCqILEjcvxDuJNknd1tsq4WkqJfFwegUnE1fGUMV7vxMKRdOq/V74Jf6bEAOnw4JfjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BHErqaUD; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BHErqaUD"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3730B1BD20;
	Fri, 24 May 2024 15:47:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=24m0vmy1mYJEaxM28E1Q/AuWG
	Mrl8QVsaJ0xHn071us=; b=BHErqaUDf4q8Bgklg4yT/tXAFACsIvpulwpYEZJrw
	F2D5GVy/8SpRSOIAqljVPoX8HftukNecFrBkxRTqGdtKG8VnajAw4CyZYdMrB5bp
	pK7vNV3u6nfCIF/OtSqjMleFZVOy6LDckJMZJAIQHY5o5B+8ow2fYtVNyqjtyh30
	EU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 306C51BD1F;
	Fri, 24 May 2024 15:47:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 880DB1BD1E;
	Fri, 24 May 2024 15:47:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v2 05/12] ci: stop installing "gcc-13" for osx-gcc
Date: Fri, 24 May 2024 12:47:08 -0700
Message-ID: <20240524194715.695916-6-gitster@pobox.com>
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
 7325DD00-1A06-11EF-9410-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Jeff King <peff@peff.net>

Our osx-gcc job explicitly asks to install gcc-13. But since the GitHub
runner image already comes with gcc-13 installed, this is mostly doing
nothing (or in some cases it may install an incremental update over the
runner image). But worse, it recently started causing errors like:

    =3D=3D> Fetching gcc@13
    =3D=3D> Downloading https://ghcr.io/v2/homebrew/core/gcc/13/blobs/sha=
256:fb2403d97e2ce67eb441b54557cfb61980830f3ba26d4c5a1fe5ecd0c9730d1a
    =3D=3D> Pouring gcc@13--13.2.0.ventura.bottle.tar.gz
    Error: The `brew link` step did not complete successfully
    The formula built, but is not symlinked into /usr/local
    Could not symlink bin/c++-13
    Target /usr/local/bin/c++-13
    is a symlink belonging to gcc. You can unlink it:
      brew unlink gcc

which cause the whole CI job to bail.

I didn't track down the root cause, but I suspect it may be related to
homebrew recently switching the "gcc" default to gcc-14. And it may even
be fixed when a new runner image is released. But if we don't need to
run brew at all, it's one less thing for us to worry about.

[jc: cherry-picked from v2.45.0-3-g7df2405b38]

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/workflows/main.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 583e7cd5f0..76e3f1e768 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -265,7 +265,6 @@ jobs:
             pool: macos-13
           - jobname: osx-gcc
             cc: gcc-13
-            cc_package: gcc-13
             pool: macos-13
           - jobname: linux-gcc-default
             cc: gcc
--=20
2.45.1-246-gb9cfe4845c

