Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3BC2DE6E2
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491720; cv=none; b=XuU9Snncwrm7NJdoWpPFj7Rq9a1YO5QOwV+UUr0F6+pj9huOqE4SYoR5xIuJ7AaP2VExEoatb3FYsj9G3MMiKIxx1fZY/7vme/bRglY8238dAlw/HocLoerhc0SBVkotz+U+0bNBA+nyCxuvWNYO0YjReEjR4UNLkt3x2U2eQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491720; c=relaxed/simple;
	bh=qdYX/62g7TtcWRNngwdnEA3utwKmakHsD0nxjCW/mk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6LwBmtrvAq/AkvequxFp3raD/FuWdj6RSiTPgxoxRMvM8mJll8nX/W+lAkJLxTjAJ2/zTdUWojfqZQXxIjkmfRYbezG0oX1qa9reNcIDwCdBEmZ5fU/Mhx3kqTR0QP7Jud64VM0ERHTb5lVHMqyqCOrX4hnO2JxeXfrN3UXKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=AyjFIGUG; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="AyjFIGUG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751491715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odKTjhoWvP1XfktzaQ+NG7Dsg2urG40DmwHI2xYJ6L4=;
	b=AyjFIGUG4xo4/Kcg4Hck90HTpsirBJ6KSCm4d1RU7noGQ+e4Ui1qWYxh2LPjFt73G/tECt
	G4jUpydPmPvO+iH3uoLO3aNIqat0UrcN9IROx6LJ8BJ+ezD4qTKmmsjql0ENPFqR9ALnGX
	xvjdktqFKkW6sMGLSfz5RNdL33ZsA74=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: ray@ameretat.dev
Cc: aclopte@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jason11choca@proton.me,
	kristofferhaugsbakk@fastmail.com,
	rhodges@cisco.com
Subject: [PATCH v2 1/4] apply: read in the index in --intent-to-add mode
Date: Wed,  2 Jul 2025 17:26:44 -0400
Message-ID: <20250702212814.1923253-2-ray@ameretat.dev>
In-Reply-To: <20250702212814.1923253-1-ray@ameretat.dev>
References: <20250628225819.1294068-2-ray@ameretat.dev>
 <20250702212814.1923253-1-ray@ameretat.dev>
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

This causes the operation to clobber the old, correct index with a
new empty-tree index before writing intent-to-add entries to this
empty index; the final result is that the index now records every
existing file in the repository as deleted, which is incorrect.

This error can be corrected by first reading the index. The
update_index flag is correctly set if ita_only is true, because
this mode updates the index. However, if we merely gate the call
to read_apply_cache() behind update_index, then it will not be read
when state->apply is false, even if it must be checked. Therefore,
we instead read the index if it will be either checked or updated,
because reading the index is a prerequisite to either.

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
2.50.0.201.gfeb04032fb

