Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78FF331A76
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862511; cv=none; b=auDu1LMdMHejFGmJNjWWMipPxmE+qA8LzgH6Sv4ACbjoGDCB6kOjZifVZxid1VgrNR0XDPPOM96ABzO2Mpv6Mdhk92SkgEJLKOkqZgrhTxPBfgrYmszUPcIonOpVbCVcnZTOpejBHjaGWfpwkjyJ3Cbb4VIVBbjsjXQ7VpZ7Poo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862511; c=relaxed/simple;
	bh=pcCZ41eN9MbloJVdjCq5qYydcNTTQ+fiboftuCyBt9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqClRSpoi6kMvMiJybW9/rmIyIMS4CZ1wdINhTO3VRoXmiuQPBb+NdhjH0Dk2vjoMNJIWWe8/Ov1VvUwJMddQbeReQlOgtoTIl3auF91dWEABynFu/7S5wJIRLWsqJK5bUhYUj6GheezeJyehSEyEXlVUeOpb74FNnRsQAyfrQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=RUChBsvT; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="RUChBsvT"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id EF65E600DE;
	Fri, 19 Jun 2026 09:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781862509; bh=pcCZ41eN9MbloJVdjCq5qYydcNTTQ+fiboftuCyBt9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUChBsvTScvFb+VTitxFkOyfuo+ogzV63LDrqSfLla/99vV7rEioDrYF1pOhQ82GS
	 zf34HX77yZOSnKmwXJZ+IEHm0ztquCBokz9jn0MF5NidHsbgdR7cp0mnV8Feu5lNAX
	 olHaLaLZ+mQPF9F3rhtAwEuE+eVp2Ws+zlUyDdYk=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/8] fetch: return 0 on known git_fetch_config
Date: Fri, 19 Jun 2026 05:44:24 -0400
Message-ID: <20260619094751.2996804-6-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619094751.2996804-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260619094751.2996804-1-m@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git config callback for git-fetch should only forward calls to
git_default_config when an unknown key is given.  Prevent this in the
case of 'fetch.output' by returning '0', as the other known keys do.

Signed-off-by: Matt Hunter <m@lfurio.us>
---
 builtin/fetch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9a45e1e7a44d..1036e8edbc59 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -171,6 +171,7 @@ static int git_fetch_config(const char *k, const char *v,
 		else
 			die(_("invalid value for '%s': '%s'"),
 			    "fetch.output", v);
+		return 0;
 	}
 
 	return git_default_config(k, v, ctx, cb);
-- 
2.54.0

