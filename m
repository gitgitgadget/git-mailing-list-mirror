Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E27202965
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890555; cv=none; b=uhFFMpJV7KaBcs6NLn3zoXFumVtb+YHGCIxURdYr8ZC+MDTwB/Z3O//qwkXxg6q22rSNbgPsyvjO4lf3rKeNOSX357xBudjFNYkgXRAf83AB44Wcv7BD8RZqRxZl2mZqz+obZF7jyKWUuK485JUwWe8ev5CUA5Danll9WdMLI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890555; c=relaxed/simple;
	bh=xrb0eK56QItrpvphJAUFgRN2H/HSrjcvKHH1JeWV1n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pboe1e1CW+zYr0yZS91PTxLIHJlI56JVLZBNN7MhAvhfIL8SUXPvFOBg/twI7p4pBT+97Pl06+tABj6pE5q781uKIXTQC5swHGQyEuUmttcbFd6qZPPaliW/kf86NgBrJYCJy2SJC0xBsvRYxRK1WG8bVpDv2Zezmpg0XOP8RXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=fXub38LC; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="fXub38LC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751890551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADazzzCkNHE0fbCstBmpH/uE01Znh+Wz8WjD1q88deU=;
	b=fXub38LCXiYAZMXqxkvr2qhmdqbZ+XXyqsva/0TzF4U9qafeZTH6ipYcdSmY3akv5nuDZ4
	TfUQe9sitOKcC8s244s4Gp5G8dNMsNNGgkAmu156F3A2ZcjLCqTmTC+UvYCh9rWrewvANw
	mGSPZ6qU4RQXSD3xUIH11XslwknCfuA=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: ray@ameretat.dev
Cc: aclopte@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jason11choca@proton.me,
	kristofferhaugsbakk@fastmail.com,
	rhodges@cisco.com
Subject: [PATCH v3 2/4] apply: only write intents to add for new files
Date: Mon,  7 Jul 2025 08:12:31 -0400
Message-ID: <20250707121534.2933349-3-ray@ameretat.dev>
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

In the "apply only to files" mode (i.e., neither --index nor --cached
mode), the index should not be touched except to record intents to
add when --intent-to-add is on. Because having --intent-to-add on sets
update_index, to indicate that we may touch the index, we can't rely
only on that flag in create_file() (which is called to write both new
files and updated files) to decide whether to write an index entry;
if we did, we would write an index entry for every file being patched
(which would moreover be an intent-to-add entry despite not being a
new file, because we are going to turn on the CE_INTENT_TO_ADD flag
in add_index_entry() if we enter it here and ita_only is true).

To decide whether to touch the index, we need to check the
specific reason the index would be updated, rather than merely
their aggregate in the update_index flag. Because we have already
entered write_out_results() and are performing writes, we know that
state->apply is true. If state->check_index is additionally true, we
are in --index or --cached mode, which updates the index and should
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
2.50.0.229.gc167f4d905

