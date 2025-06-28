Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55513DDAE
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751151600; cv=none; b=qBUrSLKORI0uhwSGRJre4O6G/7v5A+k+mbBuDc/XWZMH8G9NcK2COL7keQ7jOabhItKlH2hWwFkUGfJf0wvn2yFS7wUPeaid3/smk1KXYPxnEYmnghRBaM0YOlbydVqhnUUSv+kMzXxItKO3frQd1ItqTQK3q/rOeSRaonuPSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751151600; c=relaxed/simple;
	bh=lbRnG6TxVDmZYb75rmnWVTzSKglsDBRsvr4dqPBbNhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmuA0f8ql/kuRDvqNa3ItsXwAGjlTSlGAf3uByHxGxnqZGnwTrNjP4OmjJkju/4E6XHLMA69/BSrieBQ7ruVRXc3zMwj9sY+xsnyjXZpl4Cxdn4pqEkTs4mwsZI/yf5n15hUEPBtSHvmfd0ik2yC8pwRhkUsO+BaOA7iUOLztIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=Jhw/deko; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="Jhw/deko"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751151596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHK2z/xOVepYECf9nhjsMA0b0fu0NTKlA2Wxg22FOCE=;
	b=Jhw/dekobvR2P7mQJhjg8lXM2JABilFMzRwhgc3oEquj5RBNPyQSivpQBhnKvUclnPHm/j
	fXbvkpmxZVpPLXgfnIPpdJEGX7lZlQA+DXMkJwMMtz5jXGozS1yGUDirtfXC6+K083EpuO
	JMZA8tFgvVDK5lqWSVAKOVyrwD2BPJU=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: "Raymond E. Pasco" <ray@ameretat.dev>,
	Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH 1/5] apply: error on --intent-to-add outside gitdir
Date: Sat, 28 Jun 2025 18:52:03 -0400
Message-ID: <20250628225819.1294068-3-ray@ameretat.dev>
In-Reply-To: <20250628225819.1294068-2-ray@ameretat.dev>
References: <20250628225819.1294068-2-ray@ameretat.dev>
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
index 8bbe6ed224..e7856ae6b3 100644
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
2.50.0.195.g74e6fc65d0

