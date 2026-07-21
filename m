Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE337CD50
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642703; cv=none; b=q+NjFBO8rdHaXp/L7PsmhJRbnY3gTdIHg9EUj8cJa+3pGCHq4uBlf7USnc9rO2deiEpGOzUX2x8AVZtL77do+nXmC8t5jzaVJ9THgNi8BMtXltRPVcNtgSf5brRMfw7kcY0Uv70BB8vKiY4M2UYvyEogpTuEJhzYvBUIlqh6o5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642703; c=relaxed/simple;
	bh=X3z48CWaZjvfc+M8JyfyrJXs0R6PrLrqLR52SUZMvrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezsnEmzDtP0vEjGtNUfDckdtibja7XSn+/LtdCDiEd97PdvAbZMr94lu9ws7+W1v8L89fus3/XNfhbg3xzZluGYMpS6IiMJqbAp1KN1IvpZNSp9McRHV3MhK8YY3siJ5nqp1gPmkJTCD7ys/8pP2NN3OPti1MissJLZscKAwHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es; spf=pass smtp.mailfrom=hsal.es; dkim=pass (2048-bit key) header.d=hsal.es header.i=@hsal.es header.b=R9iRJSGg; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hsal.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hsal.es header.i=@hsal.es header.b="R9iRJSGg"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h4Jzn3Q6GzMlZr;
	Tue, 21 Jul 2026 16:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
	t=1784642693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zNgE3lmQcWREOsM0V7D5WRPD8ZtMGFVH4R8wl3AUTX8=;
	b=R9iRJSGgPNsLiAxX7SaedE5hrVmMx3Sr15qI53Aaf5NDaWha/w/STapeDRu4TFt/OqnCIz
	deFmY72X+T4koNWRZXtLGLPc4W7sVTk/bm6c/7V6V2V1aYgOfWsLAM98fKPCO4732CmJsg
	A2F4i9LGO1VmUBM4zCs8SIX3AXGA8FNRFwtjTyXCUGXfr8aJcjJzCOM7E11Ne9SpIClt7e
	1SkqSEDOPLdDR0svhoiQMu3B0xVMHb5r+gRFp0Z67DrGxznUdwCC0NPMnSyZuAIKqCbL0y
	eQYHAZ4tKMiG90l+LfF0dHKcidEsEDpBryunolYf8qF2yvcEXZqXr2HzVdjyKQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: git@vger.kernel.org
Cc: Hugo Sales <hugo@hsal.es>
Subject: [PATCH 0/1] rebase: add --[no-]edit to --continue
Date: Tue, 21 Jul 2026 15:04:41 +0100
Message-ID: <20260721140443.1809379-1-hugo@hsal.es>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4h4Jzn3Q6GzMlZr

When a rebase stops for conflicts and the user runs `git rebase --continue`, the
merge backend opens $EDITOR so the commit message can be revised. That is often
useful, but not always: sometimes the user only wants to keep the message that
is already there.

This series adds:

- `git rebase --continue --no-edit` to commit without opening an editor
- `rebase.noEdit` to make that the default on continue
- `git rebase --continue --edit` to override `rebase.noEdit`

The command-line flags apply only to the current `--continue` invocation, not to
later picks in the same rebase.

Tests are added in t3436. I also ran all tests locally.

Hugo Sales (1):
  rebase: add --[no-]edit to --continue

 Documentation/config/rebase.adoc |  6 ++++
 Documentation/git-rebase.adoc    | 17 +++++++++--
 builtin/rebase.c                 | 29 ++++++++++++++++--
 sequencer.c                      | 29 +++++++++++++++++-
 t/t3436-rebase-more-options.sh   | 52 ++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 7 deletions(-)

-- 
2.54.0
