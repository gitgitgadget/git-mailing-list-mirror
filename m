Received: from star.nullroute.lt (star.nullroute.lt [80.209.228.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC041E8332
	for <git@vger.kernel.org>; Wed, 13 May 2026 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.209.228.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656551; cv=none; b=l4/Vp/mPLQNuk57lwxM/zNQSVTpY4d9KWeNVbyXC9zFuQwJyQW5uVu+c/By745/IVykIONtLsQv5JGf0ggDoybZDQuorzcS7YAsRazYd6sAby2NQXnNWfnqmVunn8Tl1RZ8URHozPg1RjuMmtERvAp3dTHCXsULz2qX+Y1KhR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656551; c=relaxed/simple;
	bh=NaWcnIRSkrUZA9P/k003/bDNH62GN0ZA1/p/Ag6IkNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QIllj7Djnbyy+BSFagCEuWOCY+MoeeYCfWLKPzsemhwpjftkicAnNY2/5F7IAEkWehpnrQebO3hB3GtgbN1zBY4JgtX7zIuHOq0mKXxtcd4Bzz8ODeAIu75+HkR/z2srEAwqVO5fLUqO33Vhm+vCFIWYB/4RE/xcKi90gcs7Y4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nullroute.lt; spf=pass smtp.mailfrom=nullroute.lt; dkim=pass (2048-bit key) header.d=nullroute.lt header.i=@nullroute.lt header.b=IxVK3FGv; arc=none smtp.client-ip=80.209.228.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nullroute.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nullroute.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nullroute.lt header.i=@nullroute.lt header.b="IxVK3FGv"
Received: from localhost (ember.nullroute.lt [IPv6:2001:778:e27f:0:9618:82ff:fe38:e480])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature ECDSA (prime256v1) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: grawity)
	by star.nullroute.lt (Postfix) with ESMTPSA id 2643320130B;
	Wed, 13 May 2026 10:08:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nullroute.lt;
	s=20211002; t=1778656135;
	bh=NaWcnIRSkrUZA9P/k003/bDNH62GN0ZA1/p/Ag6IkNE=;
	h=From:To:Cc:Subject:Date;
	b=IxVK3FGvgpR+RWcM70cu5ASeZg9EyYn9rZ2Mk2QBdg8KRKj/0naNYNfVjrWS1DY4u
	 Y6M4JJZ/YtocbuDUcCJA/v1FFwDdZfQ0jEDLZG0KiLPtXL0tr1qyZnMtcUfx7Agdxj
	 r5pdpxgECNfbcNyGSSIYrpupNeUG8q1MO0+e0771iTkk05KAndFwZ1KKrILR1p2tsd
	 6dIBQPybs4eQpFGiyaaxozGmjyJQBb9GGMRl2OvqtXEvjde4Sva38cmwSgWgL3F3QE
	 skuPUpevW3YBkjNzxr0s+4aQMwi8ONqXTuvrXMCr8zOOwqATW2eJhvEHvD1xPV0Fpx
	 VxmVP/o/mHZAg==
From: grawity@nullroute.lt
To: git@vger.kernel.org
Cc: =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] sideband: allow ANSI SGR with colon-separated subfields
Date: Wed, 13 May 2026 10:08:03 +0300
Message-ID: <20260513070803.163546-1-grawity@nullroute.lt>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mantas Mikulėnas <grawity@gmail.com>

The SGR values used for 256-color formatting are officially defined to
be a single field with :-separated subfields (e.g. "\e[1;38:5:XX;40m")
despite the more common but kludgy use of separate values (which then
become context-dependent and lead to misinterpretation by incompatible
terminals).

See also: https://github.com/ThomasDickey/xterm-snapshots/blob/6380a3eaed857c182ea6cfa78cd706966b2628d0/charproc.c#L2047-L2118

Signed-off-by: Mantas Mikulėnas <grawity@gmail.com>
---
 sideband.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sideband.c b/sideband.c
index 04282a568e..6cf70ef6f6 100644
--- a/sideband.c
+++ b/sideband.c
@@ -163,6 +163,10 @@ static int handle_ansi_sequence(struct strbuf *dest, const char *src, int n)
 	 *
 	 * ESC [ [<n> [; <n>]*] m
 	 *
+	 * where <n> can be either zero-length, or a decimal number, or a
+	 * series of decimal numbers separated by a colon (for 256-color or
+	 * true-color codes).
+	 *
 	 * These are part of the Select Graphic Rendition sequences which
 	 * contain more than just color sequences, for more details see
 	 * https://en.wikipedia.org/wiki/ANSI_escape_code#SGR.
@@ -210,7 +214,7 @@ static int handle_ansi_sequence(struct strbuf *dest, const char *src, int n)
 			strbuf_add(dest, src, i + 1);
 			return i;
 		}
-		if (!isdigit(src[i]) && src[i] != ';')
+		if (!isdigit(src[i]) && src[i] != ':' && src[i] != ';')
 			break;
 	}
 
-- 
2.54.0

