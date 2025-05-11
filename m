Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017C11713
	for <git@vger.kernel.org>; Sun, 11 May 2025 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924045; cv=none; b=I4pKQerfmwbktOcjDTHDFi49JgLq2Q8pCrgoxy3MRzkieDuzSnTFW/Amij2Hc/+zF0prX4dDMU9WiPMER2xPOkhqH9m28w7WDnWIRxBX5hl6/kH4B61Pzr6vjsCDd9jnrTUC02aIevEBKva8VT42maeg8leV0Db2lmW9AVOhC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924045; c=relaxed/simple;
	bh=DQZKkF1lkUZgwfwQaFB/xfp4xgFpld57hTmz5HCibKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkJHbIo9UXKcx5c1gZ5oJicviDt0FS/uoqv3Py5iA3ye4nQwF2oB5eIPGwlvkWIGOkOTZYETSR/n525a6j6Kz+4+ZGYiUaA9v0WewvBYIa6zjwighUnWhbfwMgfgrh9kXQyMhn6qUKHXq8XzLqbgFwTV8KU4/lqTKHmtEYbHASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=AAa0Ln0z; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="AAa0Ln0z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1746924040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ojto6064C1wz7OIMiB6GKo3OcUd9JFctcy/+wrjpxA=;
	b=AAa0Ln0z5nGiHfEMam479lSfK3ayV0ISFxwwaa00b+53WE6NLbhuU5MFZ+LsG5jVkKDrVC
	T+X72MyGJI0lV8fcu8NisfJUYFqzxxfFTC1G1aoB8oxLX7bQU9I/Y0ybayarr1JEW3b8vE
	HgADrod5cVwM9PoR+dKNhGdhMHZp/U0=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"aclopte@gmail.com" <aclopte@gmail.com>,
	Ryan Hodges <rhodges@cisco.com>,
	"Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH 1/5] apply: error on --intent-to-add outside gitdir
Date: Sat, 10 May 2025 20:36:44 -0400
Message-ID: <20250511003955.242889-2-ray@ameretat.dev>
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

It makes no sense to register an intent to add outside a repository. We
should error out here.

Based-on-patch-by: Johannes Altmanninger <aclopte@gmail.com>
Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 apply.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index f274a37948..5e39cadde4 100644
--- a/apply.c
+++ b/apply.c
@@ -174,8 +174,12 @@ int check_apply_state(struct apply_state *state, int force_apply)
 			return error(_("'%s' outside a repository"), "--cached");
 		state->check_index = 1;
 	}
-	if (state->ita_only && (state->check_index || is_not_gitdir))
-		state->ita_only = 0;
+	if (state->ita_only) {
+		if (is_not_gitdir)
+			return error(_("'%s' outside a repository"), "--intent-to-add");
+		if (state->check_index)
+			state->ita_only = 0;
+	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
 
-- 
2.49.0.1106.gc0efa3ba58

