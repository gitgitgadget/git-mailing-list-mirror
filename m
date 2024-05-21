Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A08149019
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321442; cv=none; b=rNY9Jh/SpDUvmo6SMdDq0oMPzaZADJ9jmuUFkOSD0qWUStnhtzqvlQtxh/1i0a6Gp4i3ldPLSdRVIPPf9pi1Nojf+i55JZUXedI04Moa1iDne/HeZ9YBKMEYqN6AlB6NUStX3V9OPoCmnjbW64B3dpGnH+ogtX3ifQDNxIJFz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321442; c=relaxed/simple;
	bh=NqtsZEw5rRD3wqADGXQuaBM5sAJ7oiBuxod5LHb6P6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2Y7J3Wh9LeDjTMw7ggSBxPpiTcvimxSuiTkT1nFAPcvr+UJUk9a1/av8gYgDSfS0mJQD0ZVS/jRjCE0U01D+ApH0I7MEVmUBOKTw+Ss6m1SDq4OuR4AW7E+UiOMvyvk5pxg4OjWySvbOS9J8A8UFL/2jx54gyigXd6yCc5xBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rcCHMylq; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rcCHMylq"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 07D7C31239;
	Tue, 21 May 2024 15:57:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=NqtsZEw5rRD3wqADGXQuaBM5s
	AJ7oiBuxod5LHb6P6k=; b=rcCHMylq+/han8NkGhngP2JG9x3XoZbNckvtaRfkW
	9EUiU5ZDV5CtMRvrwJmECeqNUY4AxuVcvodGbIaxpSUK7JQlQzww7jrigSRX8dt+
	CraOXmqRp/uOGWyHY3y8PJcPbqIcJRbLyHoVpPqKwy7YdRC68i4zkfziZSGq8Ljz
	ys=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 00B3C31238;
	Tue, 21 May 2024 15:57:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 126E731237;
	Tue, 21 May 2024 15:57:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 05/12] ci: stop installing "gcc-13" for osx-gcc
Date: Tue, 21 May 2024 12:56:51 -0700
Message-ID: <20240521195659.870714-6-gitster@pobox.com>
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
 534969E0-17AC-11EF-B374-A19503B9AAD1-77302942!pb-smtp21.pobox.com
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
2.45.1-216-g4365c6fcf9

