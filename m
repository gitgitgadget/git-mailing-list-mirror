Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E80B500942
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994238; cv=none; b=HoNzJ2puS1ZLNMFxhmBcbX0EM7fZSPLREG7y1XEdUKSNGrP7YPQ0PqVMX6KQnb3jE88+vVDuaVEp16pi1KM0yW7uC153PHuI9wFEVG+0JNLZ+lqLB7CJrJOqdTqtwaZ6wWibXa6bE0/ENB9EewGthWNlWhp9RRhNzOJFU6E6+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994238; c=relaxed/simple;
	bh=JHCRNfLpygJb4FiptLbhXtkAb+j8zBfjX8mppFbWtRk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LW1iBXrv7l34MzgY3nnc9NyXcUzSHLgFCH7ts0RT0M7GNHFIzGFVcOqB/kUdmsVnWWC9fYJlkf8C4Kb8mEu7iRMC+CkJdhYl/AK9H0wu8v9BYT8ecm+9PPttJ53EcOVdtqfijkNYL1C/a6fA5a9TOCxlVpxYWd0iZuPbXRqaY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=MW798LJT; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="MW798LJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767994222; x=1768599022; i=l.s.r@web.de;
	bh=l4/sMYPledX5LMhKKt0d3BfWlfJym+ZIvFCPD7hh5Xg=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MW798LJTBASQvFUfxQGiB9r1jndRulENnPMFkWnXshMrTiXGeIDWzbMBPfpepSVr
	 b+lwSCc1CzjCJBxY+RH1zdXDrawi1cT/5h7zM1G2xJ61dkrJ8fzkREDbtZf/Jp+BW
	 WPyTY53TBjjA13YdbGPOB5KqJKvTgMgeWDU8gcSIgPat2t4jgypL0mf+LmuqAYUok
	 1ujj6taaGze2AZcnF8DtchLtHqELLyJTZDbbrgI1fvD4OIxVzlhvpbPn1zHq6g4TO
	 +FQsUYZ8j7Av+PHHDs8Pqz+n0fO2t01hc3izQ2z6G0viEMEaFdVisuGXmBAYqDbUo
	 2PKv782za/F2RTICbQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.19.215]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MqZQY-1w9Cta34qW-00fKdE for <git@vger.kernel.org>; Fri, 09 Jan 2026 22:30:22
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 05/10] delta-islands: use repo_parse_tree()
Date: Fri,  9 Jan 2026 22:30:16 +0100
Message-ID: <20260109213021.2546-6-l.s.r@web.de>
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
X-Provags-ID: V03:K1:B2AUn8tIALlHp9D+IDDudJcDs4Xf22HTBnUeVh4Bi+wnjZod/o8
 c3kqpIavhK98MFrATCmYSglbHNfkN/aBgqOrJwA2Yi5wZdLUpag79KEWldYWj0ggukvB0Bn
 pbnOdFCUs9qsZSwrDrHKO3MCp/JUcphZqz6UIITJ/NOLjDR2vY1i7G88RlIcXEkFPJO9IY+
 JDeu/8/66m/s02Yf/UloA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xCCBs2C4koo=;mt/+R3PbS/i9vltNjEbvK8Bam6g
 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

19be71db9c (delta-islands: stop depending on `the_repository`,
2025-03-10) replaced explicit uses of the_repository.  parse_tree() uses
it internally, though, so call repo_parse_tree() instead and hand it the
correct repository.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 delta-islands.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/delta-islands.c b/delta-islands.c
index 7cfebc4162b..f4d2468790c 100644
=2D-- a/delta-islands.c
+++ b/delta-islands.c
@@ -283,7 +283,7 @@ void resolve_tree_islands(struct repository *r,
 		root_marks =3D kh_value(island_marks, pos);
=20
 		tree =3D lookup_tree(r, &ent->idx.oid);
-		if (!tree || parse_tree(tree) < 0)
+		if (!tree || repo_parse_tree(r, tree) < 0)
 			die(_("bad tree object %s"), oid_to_hex(&ent->idx.oid));
=20
 		init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
=2D-=20
2.52.0

