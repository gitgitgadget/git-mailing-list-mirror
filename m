Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4BF2405E5
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 22:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751151602; cv=none; b=SeMCnzf6sApbkzPZIg9DtdwKE4SZTEOBFJVWpOdq26oxHbiX7wroGcqIpxF55dJESH+S+GaB57TNOoGWqHZFyGwSdWfh9PhXSb/yTUrMZwHUmIqhc3bxcnEe2k31K0TOmx77XCSiRB3bmQdKAZFCZg4bpEwdrC1DUrLkPtaCuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751151602; c=relaxed/simple;
	bh=RRh+pu+bhzt8/ihQiT8K3k50uPH6/EJPiLzXqYPcQso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tb2RqomvFEP7KU+LAwPpYpIQBtHa6po46RRJfXFrfH8COFusnxpGXL5GtNzGt2sgCaG5XgblT6gfLImiE65xGFaSUn2iFohf0DkIp7b9Il98M/NPrWRrZl4jftYBNbSDR+NOOOpyp011V9SRyhaEKyiSTT0EB+WGKmbB2y2jn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=3iwzYIfu; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="3iwzYIfu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751151598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzTjZiY4htNSkHMwwUhv28rINR05fTCjYFMgFvM6wdg=;
	b=3iwzYIfugEulrI+HuY/MqXPep5FjNPkatpd4vhaOsRwKL/ygLWls4NqZz+N0d6ONxmEZj5
	KNAXxWEo3veaI1zloKY7yPQWcGMmwUkytYczH4Z3UhbyBKcxHDkpZ6WhNW966TDKTGh6fx
	CPO4YD+U7iMy/5c6OGb576YfHzajfYw=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH 3/5] apply: only write intents to add for new files
Date: Sat, 28 Jun 2025 18:52:05 -0400
Message-ID: <20250628225819.1294068-5-ray@ameretat.dev>
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

In the "update only the worktree" mode, the index should not be touched
except to record intents to add when --intent-to-add is on. Because
having --intent-to-add on sets update_index, to indicate that we are
touching the index, we can't rely only on that flag to decide whether to
write an index entry.

Instead, we must test whether we are in a mode which updates the
index, or else are in worktree-only mode with --intent-to-add on and
the current file being an addition. We do not need to check
state->apply, because we only enter write_out_results() if state->apply
is already set.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 1757d34618..5064a91fbf 100644
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
2.50.0.195.g74e6fc65d0

