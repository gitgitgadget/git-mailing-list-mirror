Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B849BA45
	for <git@vger.kernel.org>; Sun, 11 May 2025 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924047; cv=none; b=FvlWTD4XjuxROcfme2092A11tPqg+rqVfM2oVfLbnBaA6RDwgLCvogQWCHhJIOGMdELlxGKPdQ2mtCqomiz46wrfE6Ul3TilAuBDWqiCkLMuk4t8xF8fnzsKEMkm9yjKF5eGg43RX34NHqZWd026A78F0vnqg0HACMQSsjrDPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924047; c=relaxed/simple;
	bh=aToh6ITyV8xFr7y1pFTw6WEivR7P2CWJghx9gHN0jic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3ZfLDKCCVD2TT2R/Iyn9GxzX5zCoSYC6L3DA/1egUpscY/FpVh7wR6r3tl/MlHTcGqz6sDvjtZmCVaQlDoudWVdBL2lMHsHokdPxk1h1yZqjWHDXi9J6btRNU1/6AE/apIY3RX7sv8olkYSl6IMY2v+aSQvFJE14vMjJcr9uR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=gLslmXLE; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="gLslmXLE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1746924043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4yBgfuriyo+z9+fHKwPtHpGxmFG18Uncvp6yQWwODb0=;
	b=gLslmXLEq183SYlcZqgU48qSz5w0QDcTLlz/tvN0e0iVQ4R9T2/2DN7U70pV+ZNj6gSwQi
	Z+sQu5yiS1Xp6+8rDb27dMtzTEqH8OaGTmyWojdJPW592oDavOpkkgvWIQPhgoH+YbL1Pz
	BoM4roXdpvZ70H/+ofeAD4FCFTJmMFs=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"aclopte@gmail.com" <aclopte@gmail.com>,
	Ryan Hodges <rhodges@cisco.com>,
	"Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH 2/5] apply: read in the index in --intent-to-add mode
Date: Sat, 10 May 2025 20:36:45 -0400
Message-ID: <20250511003955.242889-3-ray@ameretat.dev>
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

There are three main modes of operation for apply: applying only to the
worktree, applying to the worktree and index (--index), and applying
only to the index (--cached).

The --intent-to-add flag modifies the first of these modes, applying
only to the worktree, in a way which touches the index, because
intents to add are special index entries. However, it has not ever
worked correctly in any but the most trivial (empty repository)
cases, because the index was never read in (in apply, this is done
in read_apply_cache()) before writing to it.

The update_index flag is set in apply_patch() to mean that we
are touching the index at all, as opposed to the check_index flag
indicating --index mode.  Therefore, the reading of the index should
be gated by the update_index flag rather than the check_index flag,
so that we are prepared to work with the index before we begin adding
intents to add to it.

Reported-by: Ryan Hodges <rhodges@cisco.com>
Original-patch-by: Johannes Altmanninger <aclopte@gmail.com>
Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 5e39cadde4..3bde54a04a 100644
--- a/apply.c
+++ b/apply.c
@@ -4837,7 +4837,7 @@ static int apply_patch(struct apply_state *state,
 					       LOCK_DIE_ON_ERROR);
 	}
 
-	if (state->check_index && read_apply_cache(state) < 0) {
+	if (state->update_index && read_apply_cache(state) < 0) {
 		error(_("unable to read index file"));
 		res = -128;
 		goto end;
-- 
2.49.0.1106.gc0efa3ba58

