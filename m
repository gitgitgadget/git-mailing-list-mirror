Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96E23A995
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491721; cv=none; b=sSGHCMjq4mK7NXO+JJREPUgEpHZIm7oLztNlUdE9LVrOR7r6/YOx9I+lIIg6xwVKp7QJqKNuQHY19rjnlOqgHX9eZ3hYMJROpzDHRTmmBujxqdKbX/fnblP8h9zmr7GOFHwn/biGmddBAc1XsuDhCrl3uqsUJY/i3Cmst0fHhpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491721; c=relaxed/simple;
	bh=Ga8qb7F3/FMqH3XBlSkMNd0LIBu9VrWk/SHBg/KTc44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6Dd29QOe4QtgcQXRcVAgiB5+TkBazD09w9N+BwcQWBdgyGnwj/RHLSkFUbf9VqVALjzxjKfpX/NqY0lWc5SaFKfSTttFzvj+TBWuTfRd1p6FFK5SoD/mf4VSKgRyBJbGXLtxjav8IC8Xt6Sq75DaSP3++y2ZJ40U8GZUgYOIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=vgJzQj9X; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="vgJzQj9X"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751491716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuTzbNrgQiSMA52wHIV1sCqlAe3EEg765zDC98t0Gqk=;
	b=vgJzQj9XBicQqPFkqSUIvRm4LNlKsdA3Ypu5OuKOmRL7vibW0m0ak3jJdGOiLyq9rEPuz9
	bQU1Gki46kXlXE6136A9y+Zj4Op9+m5E09Qf0uTY82lq7to05/3Ihx8qequMxGe4VqX55C
	/sS2IYBOsoX4J9W+Xlw0dx6wnHZIJ8c=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: ray@ameretat.dev
Cc: aclopte@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jason11choca@proton.me,
	kristofferhaugsbakk@fastmail.com,
	rhodges@cisco.com
Subject: [PATCH v2 2/4] apply: only write intents to add for new files
Date: Wed,  2 Jul 2025 17:26:45 -0400
Message-ID: <20250702212814.1923253-3-ray@ameretat.dev>
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

In the "update only the worktree" mode, the index should not be touched
except to record intents to add when --intent-to-add is on. Because
having --intent-to-add on sets update_index, to indicate that we are
touching the index, we can't rely only on that flag to decide whether to
write an index entry.

Because we have already entered write_out_results() and are performing
writes, we know that state->apply is true. If state->check_index is
additionally true, we are in a mode which updates the index and should
always write, whereas if we are merely in ita_only mode we must only
write if the patch is a new file creation patch.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index c8d4517c0a..8637ad4c9f 100644
--- a/apply.c
+++ b/apply.c
@@ -4565,7 +4565,7 @@ static int create_file(struct apply_state *state, struct patch *patch)
 
 	if (patch->conflicted_threeway)
 		return add_conflicted_stages_file(state, patch);
-	else if (state->update_index)
+	else if (state->check_index || (state->ita_only && patch->is_new > 0))
 		return add_index_file(state, path, mode, buf, size);
 	return 0;
 }
-- 
2.50.0.201.gfeb04032fb

