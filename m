Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B623D2B0
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 22:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751151601; cv=none; b=AlWJycrfcrU6nwnKfmdnFmXq0YItUPX+WucbQFaszocqqhOKP2VCPtW9Wx72bS0N67CGd07UEB0SERWMaZae+Rnwy12PaV69xiGAejSCWd6pab2+in3q8wms6SqHLk1FY1PLvL105FXKZTHU7Oas/oc6kPXy85mSZblqnW5jJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751151601; c=relaxed/simple;
	bh=TmHff7gPdq6eypkAPKemBDVOOPCZNK6veg2+GVaMxyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMyWbYXB0B18fN/9gC/t+2C8Ae5xTTcLizmXfEMjj/ZLo7zz3V34oej7dZIgzcjdwp3DBhid2QsYAPYtme/mIf4eqrYoZXqRLXNvbYcTTmpEpDCWPKo728VxLgB7B0sJJA+g/o7UfmojjsWvDbo79yxpQXQVu0+olLc3FuDDuug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=gaeFG/Xv; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="gaeFG/Xv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751151597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9+Md9SLgk6DP2/B+ejKcRC1pc0FfhzOmPQ7xRdbWvk=;
	b=gaeFG/XvfdhFgGaA7Fhoe966xKSZKezIbfoVEEJ9mdkxkKmsTdjX2UqAbgQKP/T6PR/3ZU
	5jxuub7Sj8GYqakSWjarZjBoCkRBbFCET1HOzCe3uAtKqpq3yaPmgnoXcTFkLf3xWMZ21i
	4J4MAoTrcS1+oYkcqalObDxAyqLHBA4=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: "Raymond E. Pasco" <ray@ameretat.dev>,
	Ryan Hodges <rhodges@cisco.com>,
	Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH 2/5] apply: read in the index in --intent-to-add mode
Date: Sat, 28 Jun 2025 18:52:04 -0400
Message-ID: <20250628225819.1294068-4-ray@ameretat.dev>
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

There are three main modes of operation for apply: applying only to the
worktree, applying to the worktree and index (--index), and applying
only to the index (--cached).

The --intent-to-add flag modifies the first of these modes, applying
only to the worktree, in a way which touches the index, because
intents to add are special index entries. However, it has not ever
worked correctly in any but the most trivial (empty repository)
cases, because the index was never read in (in apply, this is done
in read_apply_cache()) before writing to it.

If we merely gate read_apply_cache() behind update_index, then it will
not be read when state->apply is false, even if it must be checked.
Therefore, we instead read the index if it will be either checked or
updated, because reading the index is a prerequisite to either.

Reported-by: Ryan Hodges <rhodges@cisco.com>
Original-patch-by: Johannes Altmanninger <aclopte@gmail.com>
Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index e7856ae6b3..1757d34618 100644
--- a/apply.c
+++ b/apply.c
@@ -4837,7 +4837,7 @@ static int apply_patch(struct apply_state *state,
 					       LOCK_DIE_ON_ERROR);
 	}
 
-	if (state->check_index && read_apply_cache(state) < 0) {
+	if ((state->check_index || state->update_index) && read_apply_cache(state) < 0) {
 		error(_("unable to read index file"));
 		res = -128;
 		goto end;
-- 
2.50.0.195.g74e6fc65d0

