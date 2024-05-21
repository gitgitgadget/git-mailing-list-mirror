Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E3149019
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321438; cv=none; b=FhbcAvXgeGKerQcND3t4nyt/G0MMI7FOYQg8Aexl1tTypuYiMjfcGNj61PajSarnZ98y5Eym9CpyB2iN++zHozgL4Kom5XNz40rSWOkS0Dln3KghNFMFGz6CtrdnzUV/idtF/wKz8eaSt4AOSmqksge2MDLD9JNWmrDLxuNVbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321438; c=relaxed/simple;
	bh=7PFmRwx+Lng41DVj1knKkE4I7Ga+gV8zAlMAceBRVXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzsLMnLd66k2SoAfoyPOsVbCRU1WSRdcvsKYslP40s9Z2SJSk0e+J787guO+x4p9kv6UgKu+yN4XXx3dGNLE8UC1Ryl5AYrTpn6GsxnrpFHt8fbwCJ7KAszQzKbgZsupU0hzsIaimKmdKf1D0A9gddOjBH9VytnAk0tmkozMYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JqSlcVOx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JqSlcVOx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8803A2DBE4;
	Tue, 21 May 2024 15:57:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=7PFmRwx+Lng41DVj1knKkE4I7
	Ga+gV8zAlMAceBRVXw=; b=JqSlcVOxVZAQWNHoi4K7/x3R0gtc8Ylgkkku/jWK5
	tYmzVXNfRL/2PQ4BZFSXyRiZpUqGjTEhEV3b5/351dRgtggfbCBt5FLqvPJP/T1o
	nTI2eeofwZiQELqnAWAuC6+FnbJj+c/dNOG+oHgSDLWS6Ni9qaXTgoueC/yDcKiA
	+Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 80BF32DBE3;
	Tue, 21 May 2024 15:57:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0733D2DBE1;
	Tue, 21 May 2024 15:57:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 04/12] ci: avoid bare "gcc" for osx-gcc job
Date: Tue, 21 May 2024 12:56:50 -0700
Message-ID: <20240521195659.870714-5-gitster@pobox.com>
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
 50E02BB2-17AC-11EF-839D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
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
2.45.1-216-g4365c6fcf9

