Received: from mx1.ddevault.org (mx1.ddevault.org [172.233.46.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC02E54D4
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.233.46.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542531; cv=none; b=tTLpIripgTkkU4Qa+OQGF2x2d0ZFCt+JzlKkH4iHpDjX3sjZH/jONMUX5eGsezp2b3/c5/JbX2N1S5uV6uXWscxRoMHiRTc7EDaqur1twkbYHYx5ypTYud6zjk1Vu/x24sSelmpPsBI2HaWGGjL7jWtIljsJsAo1gaw+htI4Klw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542531; c=relaxed/simple;
	bh=DyccoDX8G9DtwuO/q7GUPM0v2x/j6dha5+sgHv+pxF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQ86CcpRRS+gRY+4dgfJXPlln/aaub9KM7xDGl2h8F8IO5WiDKPJJUSiJO5NN7oqUmKBQgIllnAXTZIn6gis5nZ+DyqGmq3lSH8ikQHxE0RQOc/W/GObYQelaFupCeMvSty/iuGjFPVDeJ7a3P50TxkVdxjCOwgmS0+NJiv5WAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org; spf=pass smtp.mailfrom=ddevault.org; dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b=oU0BiCbg; arc=none smtp.client-ip=172.233.46.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddevault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b="oU0BiCbg"
DKIM-Signature: a=rsa-sha256; bh=/Dllg9QIS0TV4sQtaLOa9Q3qzQASbVrRp/RrhCS7n1g=;
 c=relaxed/relaxed; d=ddevault.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@ddevault.org; s=default; t=1751542513; v=1; x=1751974513;
 b=oU0BiCbgCgHxEEeSOS+nqCkswRlvsWK8NZetFcCUDU1mA2dl2hJzBCWy8+GxeQ9fN2GSy/BE
 N2ngoWe/cMkiuZDtQhJcMkM+xR3etERgPjsON0pC+WSMPeXJyP3HY9UEAR1ehrHqbdz54M3dFlQ
 upOVutiYerZDDZj2pY8EyEoW7CkPLYuxTvEkLFaEZD6DWPu1JWZ/t1yxFJ+hk660KYWVg2VGexu
 evAhchq441djVcRSj8Gglm00UCqAC/AM//NtMJwOo2jWLG4FjVQMMqgWdhEGXbJ06Hfz7+B19fv
 VT051J1uM4uFC6hmv2yj+PBr6WnWRVae2l3xEvGr8PYpA==
Received: by mx1.ddevault.org (envelope-sender <drew@ddevault.org>) with
 ESMTPS id 4703ca09; Thu, 03 Jul 2025 11:35:13 +0000
Received: by taiga (Postfix, from userid 1000)
	id 9C67970206F2; Thu, 03 Jul 2025 13:35:13 +0200 (CEST)
From: Drew DeVault <drew@ddevault.org>
To: git@vger.kernel.org
Cc: Drew DeVault <drew@ddevault.org>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Patrick Steinhardt <ps@pks.im>,
	Andy Koppe <andy.koppe@gmail.com>,
	"Remo Senekowitsch" <remo@buenzli.dev>
Subject: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
Date: Thu,  3 Jul 2025 13:29:51 +0200
Message-ID: <20250703113505.11889-1-drew@ddevault.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the X-Change-ID header to emails prepared by git (i.e. via
format-patch, send-email). This allows tools which work with those
emails (e.g. patchwork, sourcehut) to meaningfully integrate with tools
that assign change IDs to commits.

With some follow-up work, this is also the first step towards ensuring
that those change IDs are preserved through from git-send-email to
git-am as a change moves through its review lifecycle.

Signed-off-by: Drew DeVault <drew@ddevault.org>
---
v2 is unchanged from v1.

One remark that occurs to me upon spinning v2 is that I'm not sure how
to test this behavior. There is no obvious way to cause git upstream to
produce a commit with a change-id -- presently these are only ever added
by third-party tools.

 pretty.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 0bc8ad8a9a..70fba7b023 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2045,7 +2045,7 @@ static void pp_header(struct pretty_print_context *pp,
 	int parents_shown = 0;
 
 	for (;;) {
-		const char *name, *line = *msg_p;
+		const char *name, *change_id, *line = *msg_p;
 		int linelen = get_one_line(*msg_p);
 
 		if (!linelen)
@@ -2089,6 +2089,11 @@ static void pp_header(struct pretty_print_context *pp,
 			strbuf_grow(sb, linelen + 80);
 			pp_user_info(pp, "Commit", sb, name, encoding);
 		}
+		if (skip_prefix(line, "change-id ", &change_id) &&
+		    cmit_fmt_is_mail(pp->fmt)) {
+			strbuf_addf(sb, "X-Change-ID: %.*s\n",
+				    linelen - 11, change_id);
+		}
 	}
 }
 
-- 
2.50.0

