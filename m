Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB21A285
	for <git@vger.kernel.org>; Sun, 11 May 2025 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924051; cv=none; b=o25COAAQyZzObwfZ/IA19RouzVcUVpsiSkS6ZMGStHEL/NpDD5n96/hIzHbsqZZqOY9JeHxlxyv3iwpZ0NkKcY5z2u43mqZUF/D1656qQ6pZGZk/ILUIcUbojX1Jb+Xe3qaRX2KLPe44r1XHIN895XbVVFYDb4GyAIqmFQ35n84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924051; c=relaxed/simple;
	bh=llvJ9FRmPbgdhhSgkA/uPMilDq33t2IHkaRW9qIbXV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK9aexBOo+fF3euK6UQtjbdy0Aab6hUpP7ir8WZbs9Zs6ZsOl/7LohkgpyQEDaDtrA2+l+A4UK67NmU9Tq53PPpn3e5Z0rnrRAIExhnDktKbTBsdTbbPKZLyqPJcE5zGfcGXjzoMyX44gXokeDM1UGFXhgi4jniCRT2vHFqTxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=QNkDnKyp; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="QNkDnKyp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1746924045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7fmdjQJU8hwhyIcGXxa5qsaPcUk7Ea9os6Rg7jbtww=;
	b=QNkDnKypHJm/DHPVsDoN4sK4KNt4/DbPKaEsgeuB2Ry13BtWztyGLJQAuF8ft6vwnuyW4i
	krxeWgCXR8qRJvzK/uuNq/vX0gTFvmI7Ol4HQtUwDICWeP9EUvgsL/qWhISNw1h81c2vAs
	p7dZB5FCiRgegvHcfL1Q30pqOsvPUC4=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"aclopte@gmail.com" <aclopte@gmail.com>,
	Ryan Hodges <rhodges@cisco.com>,
	"Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH 3/5] apply: only write intents to add for new files
Date: Sat, 10 May 2025 20:36:46 -0400
Message-ID: <20250511003955.242889-4-ray@ameretat.dev>
In-Reply-To: <20250511003955.242889-1-ray@ameretat.dev>
References: <4e2szrowd43w6lrzawqtddamdxvp6ke65jkzmdoru4gjin7xhn@kaqe7skrktgt>
 <20250511003955.242889-1-ray@ameretat.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the "update only the worktree" mode, the index should not be touched
except to record intents to add when --intent-to-add is on. Because
having --intent-to-add on sets update_index, to indicate that we are
touching the index, we can't rely only on that flag to decide whether to
write an index entry. Instead, we must test whether we are in a mode
which updates the index, or else are in worktree-only mode with
--intent-to-add on and the current file being an addition.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 3bde54a04a..a749f904c7 100644
--- a/apply.c
+++ b/apply.c
@@ -4569,7 +4569,7 @@ static int create_file(struct apply_state *state, struct patch *patch)
 
 	if (patch->conflicted_threeway)
 		return add_conflicted_stages_file(state, patch);
-	else if (state->update_index)
+	else if (state->check_index || (state->ita_only && patch->is_new > 0))
 		return add_index_file(state, path, mode, buf, size);
 	return 0;
 }
-- 
2.49.0.1106.gc0efa3ba58

