Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AFF1D545
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535059; cv=none; b=VEFZG5B5fys1VaNCWNzrmFl3OMDWvOr/R0+Nbgpwfayf77jmGOqkUZw7Jax76gspx3/jOmjZpnLqrN72iAt8IVEifPiyY6Hg0i5cGEWtzjr5je/gyeAlFpWjXiorYZ7ZYozXuX+zY+BAmpjxQvIDIOB809dCsKdNQn7jUwK3gJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535059; c=relaxed/simple;
	bh=v+Do3dJ78HtoSGnDmPcbfy0t423C3lMyQWdX75QnLDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CuClboSbZ2IdGaiwgI/MzrE5bKdKB7W+KPdrT7Cjg8ZwSeEQYb3BtyXfOTGItubvQimd6Z0mIV1u2GNgob2g1EjEFUjYyXLll79Cq1TUk8ZcytLMZd9282kTnSrM7g1plTMRHDn92NPSJD+VrOTicEoTkT/JXH54ZUPppubXhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=nldR4iyf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nldR4iyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1719534467;
	bh=v+Do3dJ78HtoSGnDmPcbfy0t423C3lMyQWdX75QnLDk=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=nldR4iyfKGfyjc7Ozb2gH5ZG51Fa7mlazFFNuyAQGiSiNe0upGumIooHcoTj/rf5o
	 /GxmzQter4bTOQPPwBqzIgSOLYofQXiURyharBNQ4F9EdzYClUCV+HQSnUsrfYtG0D
	 RoA2YIdv9uj9tksxg0KmNFLESJQmkQwsaMGHRPPZjw0AgFOiLxoLGEXKGBUv8/YTiz
	 xPFzGBSnOsk0Fu0cl/I9vZ287z9FmlYw7ZXPQ2dHtYkMSE8r7X5JwEiPLRpiEdw4Dp
	 BaXi4TKi5h6jVOaLzLNxq84LMfvFzcx3Nk7SI7kuGr6ptVgZDe8niAPGVJAnjYF8GG
	 O6s7FhOwPNyw2fsKb4xHHd/HBCGAckwauReiaQDC1kQilYq+rPmzAMS6+qLzMkFV49
	 kXzcl1BTMvjfybHUiV8R6ST1hRaox4mpp2JTjqElmOTrunEPVBnddnuCtQkv3gQzYR
	 OwPg4o3wssbbnLYYLxNm0vUDZqZKCNNg9POcInZiP67OMk8idsf
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 39F0C263A9;
	Fri, 28 Jun 2024 00:27:47 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/1] Proactive authentication over HTTP
Date: Fri, 28 Jun 2024 00:27:41 +0000
Message-ID: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently Git only sends authentication over HTTP once it's received a
401 response from the server.  This series allows users to indicate that
they (or the credential helper) know what kind of authentication is to
be performed and avoid the extra round trip.

This has a couple of use cases:

* Some connections are high-latency or potentially unreliable and the
  extra round trip is expensive or flaky, so avoiding it can be
  desirable.
* Users can authenticate even to public repositories for fetches and
  clones, such as to access higher rate limits or to allow better
  identification of the requesting party.  This can be useful to help
  identify, say, an internal service that is requesting excessive
  amounts of resources and throttle it appropriately.  (An incident
  involving this very situation is the impetus for this series.)
* Some environments have very unusual proxy setups which require all
  requests to be authenticated, and this might be useful there.  (This
  is not a goal of this series and not a problem I'm generally
  interested in solving, but it happens to benefit those people as well,
  so I thought I'd mention it.)

Note that the types of authentication for which we can do proactive auth
are relatively limited.  Of the standard forms provided by libcurl, I
believe only Basic is possible, because the others require a nonce or
challenge from the server that is used in the computation of the
authentication value.  Due to the new credential functionality recently
introduced, Bearer is also a useful possibility.

brian m. carlson (1):
  http: allow authenticating proactively

 Documentation/config/http.txt |  15 +++++
 http.c                        |  59 +++++++++++++++--
 t/t5563-simple-http-auth.sh   | 116 ++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 6 deletions(-)

