Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F313824A3
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890554; cv=none; b=m8MSVm1yqnEMpB81NE82Y4QePUIRtwTe4WP1CB9i5qcWcQ4FfMaZci/51mPKDCZRLTuNxu/Ck9IRTv9s3po+2EpGDu1CL4a/ILJb3Ob74wGmUVT2uGXwKGBmnxoJWSK2JwRnnyk9ZG2L/hzxX765Fbe0uRLyxkjzXnXlCk5BfrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890554; c=relaxed/simple;
	bh=8neSJ+Rs1AkctAoRjPT/vzlpBRD38ztG4+I6zdT2aKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riElgOpgTafNG5LF83R4b3ktJAw0NzmWLyyXkOWWv1IZMBetPXL6yD04QIjlv6U47zwJwLSI+ygfm8Bdhoq0Cod1Xov8jB50H2LTaIftkli0RUFNeO4DMaB9nvMt7qNcqBo+XaiTCvBuWb606+hTRrhgI0Xm8/Gd7YD4VP0pLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=Zt+xQA+A; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="Zt+xQA+A"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751890549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNJC+JG4mcg/e4TVwQmg1Xx1iqv8L+jSHP/4kyzBFz0=;
	b=Zt+xQA+A3CvuX7IrReRQWQG4wTvFhanB4frR0IfIHWhMIt+7X9JoCg8+sZp1F2HZaaL3I/
	+tjnW+4v1QOSysV8YL1NMwGO0LEm/fNcWEq62JqwjR7jr0H/MzBYwJxFnZi6IXwwj+A7T9
	hSduHCaSn0z4V2Ano41VwL8sjSaN/FI=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: ray@ameretat.dev
Cc: aclopte@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jason11choca@proton.me,
	kristofferhaugsbakk@fastmail.com,
	rhodges@cisco.com
Subject: [PATCH v3 1/4] apply: read in the index in --intent-to-add mode
Date: Mon,  7 Jul 2025 08:12:30 -0400
Message-ID: <20250707121534.2933349-2-ray@ameretat.dev>
In-Reply-To: <20250707121534.2933349-1-ray@ameretat.dev>
References: <20250702212814.1923253-1-ray@ameretat.dev>
 <20250707121534.2933349-1-ray@ameretat.dev>
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
only to the worktree, in a way which touches the index, because intents
to add are special index entries. However, since its introduction
in cff5dc09ed (apply: add --intent-to-add, 2018-05-26), it has not
worked correctly in any but the most trivial (empty repository)
cases, because the index is never read in (in apply, this is done in
read_apply_cache()) before writing to it.

This causes the operation to clobber the old, correct index with a
new empty-tree index before writing intent-to-add entries to this
empty index; the final result is that the index now records every
existing file in the repository as deleted, which is incorrect.

This error can be corrected by first reading the index. The
update_index flag is correctly set if ita_only is true, because this
flag causes the index to be updated. However, if we merely gate the
call to read_apply_cache() behind update_index, then it will not be
read when state->apply is false, even if it must be checked due to
being in --index or --cached mode. Therefore, we instead read the
index if it will be either checked or updated, because reading the
index is a prerequisite to either.

Reported-by: Ryan Hodges <rhodges@cisco.com>
Original-patch-by: Johannes Altmanninger <aclopte@gmail.com>
Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 8bbe6ed224..c8d4517c0a 100644
--- a/apply.c
+++ b/apply.c
@@ -4833,7 +4833,7 @@ static int apply_patch(struct apply_state *state,
 					       LOCK_DIE_ON_ERROR);
 	}
 
-	if (state->check_index && read_apply_cache(state) < 0) {
+	if ((state->check_index || state->update_index) && read_apply_cache(state) < 0) {
 		error(_("unable to read index file"));
 		res = -128;
 		goto end;
-- 
2.50.0.229.gc167f4d905

