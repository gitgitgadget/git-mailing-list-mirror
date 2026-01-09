Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC07221F13
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994233; cv=none; b=FvsuCHgmRgaN+uKNPS0GOmIS6xGVuZoPlqgUv6SSAXwqUfaNSHlQMrY8sKFkCpdNMzdFJC1dIr3SwFuoL10zNhMQH7At+v0jeCKCkwA9Toc55cNStQLJNg+Tj7lGiAykPnTcRZ6VzW2t0D0ghyqrwRDzakAsnzqF7zXBnINppZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994233; c=relaxed/simple;
	bh=BJMm8rhcw4v1rjkNDf6Ut+R7xY8idJq1K2f+HsaSzRM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHoRhi+8E4TIJyWeatt/KL6eg6yID6PkO4EfIOhqgZQpIAd/Gf7LiQ7FntvkD467HCLq7/DRQ3Qyuhyxo6Q5KBEbup4lzVusjAcZXBBFRQWN7X/MWWRL1UIg3JotaGGP5puZqcPjQtT+Dy20rVszWKOmmKoaJTLenYA67zcnmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=H5VAnRDS; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="H5VAnRDS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767994223; x=1768599023; i=l.s.r@web.de;
	bh=20EXPfEYyq9m6/g7S6eUP1Sf0GXICrWkmubKhc3eVY8=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H5VAnRDSBU0w62hTH5XVWndzRKjod0Z5bCI7o3ZndLQ3pC2+yv0Ed+Nd1KVTGqlK
	 sQtwSCoF1+Rev8GHBfRLYbcPNk0h9lqVUbzecghnDX3D63upbgFiHyiU+QrGznV77
	 Oy9v7i+YTCeS8FUk1qz/+Ox+7f00Pl1VCBP1krjS/cJoJ7aTKPRQOtwXQFMjkwPNZ
	 Z2crn/INDnqe0thT+k61DOKYYr7bMTVVBct/uQIP2LI0zKuHHeaFILgm7UhlIbk1+
	 7J3WMXARX07AO0wPl0hCFUtsnEUBgsYB6xG98HPrNnUv+s5nrBA77FXbutA5eQyqC
	 cEUYS8tEqKQEQfdqUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.19.215]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N7gbY-1vs5S04AKI-00wJHm for <git@vger.kernel.org>; Fri, 09 Jan 2026 22:30:23
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 07/10] path-walk: use repo_parse_tree_gently()
Date: Fri,  9 Jan 2026 22:30:18 +0100
Message-ID: <20260109213021.2546-8-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109213021.2546-1-l.s.r@web.de>
References: <20260109213021.2546-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6w757XGm++F8Z4XsUK+4sl1TVGhAtrOshSJcDkdPp/tP1W3IqWU
 s/Ac42j4/0gd2DYGoVjVqEokn7c3CrIitx3D7Dg8DWhfz4/0ynYsxzdEZlFO9zuv17hatxz
 EDaU6BNoabwenXu0QKgaDMiUkX3aSYD4jISYDEANrN1vj5H4X1ff/PgmOa6fpjb85AEYrmR
 pM8fJcfv0/6flIDkCsNTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1/ypXSNNRIc=;H8IbxUG4/vcCwSi5CwtVsqMp8jz
 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
 RFzKOfK1nHzpqqZ6A=

Use the passed in repository instead of the implicit the_repository when
parsing the tree.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 path-walk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path-walk.c b/path-walk.c
index f1ceed99e94..364e4cfa19b 100644
=2D-- a/path-walk.c
+++ b/path-walk.c
@@ -137,7 +137,7 @@ static int add_tree_entries(struct path_walk_context *=
ctx,
 		error(_("failed to walk children of tree %s: not found"),
 		      oid_to_hex(oid));
 		return -1;
-	} else if (parse_tree_gently(tree, 1)) {
+	} else if (repo_parse_tree_gently(ctx->repo, tree, 1)) {
 		error("bad tree object %s", oid_to_hex(oid));
 		return -1;
 	}
=2D-=20
2.52.0

