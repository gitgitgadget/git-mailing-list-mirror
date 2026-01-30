Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A530EF64
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783219; cv=none; b=bOn3kjcPlskbZnh9GZ/on5AUweISMCxct+qu8Zo0LiUwRM2FzQqBUIZhb4EP7W+sWeYrrH9eqIXHGBrkzcmuCS5ZcGNHR5TYpHx4rfPnMT+dFr5j5GtTxbuhn3gbQM5d6ZbpOW6YB7PMBZW+DMpFn0xZ+jrH1/EOW5OcOcjffuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783219; c=relaxed/simple;
	bh=DtiJcVHuLE0v8Wnecx2E3QC8Dl/asqpGCD4o0JLYk+k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=uQ8ehquksdoEUaqRelHNLBxcXg+39z3o+CUOnS1sYC4WcQeLpd6dGo1U/PVP/2S/0lGovlKO/2hRwkmR2ni7HeI6oxPvOv6DxhpbXQRCALlStr2indaj+GqpHKsY5P5AgGBe7u5FEi9uIfUkQ4ukEsz/W4U7l8DAu/dcc1Wdi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=5Ttm4Wad; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="5Ttm4Wad"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769783212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35V+QE6KcgoSQ9syETWbbJx5WZU936ark9JRUaB5Yk0=;
	b=5Ttm4WadpCbMaXYYjQWT7vA457rhiAIBgjpVOa6Q+fMnRFvE4iszbi/H/q/2wBPIadnze9
	uv1WbiPvHsrcFvTFz88n05T9fKRbCkSbU3Y18af37wJdyXY2lNBkh8ozQVLnAkTPHGJPBp
	mzkKEwGcKvvJHp7uxq9Go1/4YNRgTE0=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v6 0/4] Fix git-last-modified(1) bug triggered when passing
 a tree-ish
Date: Fri, 30 Jan 2026 15:26:34 +0100
Message-Id: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNTW7DIBQE4KtErEvFnzHOqveougDeo6FKTAXUa
 hX57sXpBlmyuhxp5ps7KZgjFnI+3UnGJZaY5hb004n4i53fkUZomQgmNONc0JrSTK+2VHpLEEN
 EoDUj0gAwaScC2jCStv7MGOL3Q359+8vly32grxu3NS6x1JR/HtcL33r/vyyccore+dFIxcOoX
 2Kq/vrs041sL4voHXXsCMqos9Jxo5mZTNg7snf0sSObg9oCKvBysG7vqM4R8thRzTHahWl0FhS
 KvTP0znjsDM2RBrixbBo0qN5Z1/UXl2iLF/ABAAA=
X-Change-ID: 20260112-toon-last-modified-tree-fdd96b2feaf7
In-Reply-To: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
References: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Recently there was a bug reported[1] passing a tree OID triggers a BUG:

    $ git last-modified fb06ce04173d47aaaa498385621cba8b8dfd7584
    BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified
    [1]    690163 IOT instruction (core dumped)  git last-modified

    `fb06ce04173d47aaaa498385621cba8b8dfd7584` is the tree commit id of web_src. I
    suppose this should've returned a nice error message or blank output.

Fix this bug by checking the revision argument.

[1]: https://lore.kernel.org/git/03f96860-29fc-42a7-a220-c3ec65eb8516@codeberg.org/

---
Changes in v6:
- Fix CI failure with Meson on Windows.
- Link to v5: https://patch.msgid.link/20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com

Changes in v5:
- Use 'commit' instead of 'revision'.
- Small typo fixes.
- Link to v4: https://patch.msgid.link/20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com

Changes in v4:
- Extend the error message when revision is not a tree
- Extend the test to verify the error message when more than one
  revision is given.
- Link to v3: https://patch.msgid.link/20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com

Changes in v3:
- Split the change to plug the leak into a separate commit.
- Small changes to commit messages.
- Link to v2: https://patch.msgid.link/20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com

Changes in v2:
- Prepend the change with a commit that modifies the error message
  when more than one revision is given.
- Prepend another commit that removes double error message.
- Add test to ensure the command works with annotated tags too.
- Link to v1: https://patch.msgid.link/20260112-toon-last-modified-tree-v1-1-ecbc78341f76@iotcl.com

---
Toon Claes (4):
      last-modified: rewrite error message when more than one commit given
      last-modified: fix memory leak when more than one commit is given
      last-modified: remove double error message
      last-modified: verify revision argument is a commit-ish

 builtin/last-modified.c  | 19 ++++++++++++++-----
 t/t8020-last-modified.sh | 26 ++++++++++++++++++++------
 2 files changed, 34 insertions(+), 11 deletions(-)

Range-diff versus v5:

1:  d9f9531e67 = 1:  455e9bc0ca last-modified: rewrite error message when more than one commit given
2:  19ccaa2aae = 2:  2d51b5e381 last-modified: fix memory leak when more than one commit is given
3:  4bff975458 = 3:  68b3acefd7 last-modified: remove double error message
4:  a5d4c74ad7 ! 4:  d66ab6a033 last-modified: verify revision argument is a commit-ish
    @@ Commit message
     
         Fix this error by ensuring that the given revision peels to a commit.
     
    +    This change also adds a test to verify git-last-modified(1) can operate
    +    on an annotated tag. For this an annotated tag is added that points to
    +    the second commit. But this causes ambiguous results when calling
    +    git-name-rev(1) with `--tags`, because now two tags point to the same
    +    commit. To remove this ambiguity, pass `--exclude=<tag>` to
    +    git-name-rev(1) to exclude the new annotated tag.
    +
         Reported-by: Gusted <gusted@codeberg.org>
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    @@ t/t8020-last-modified.sh: test_expect_success 'setup' '
      	mkdir a/b &&
      	test_commit 3 a/b/file
      '
    +@@ t/t8020-last-modified.sh: check_last_modified() {
    + 
    + 	cat >expect &&
    + 	git ${indir:+-C "$indir"} last-modified "$@" >tmp.1 &&
    +-	git name-rev --annotate-stdin --name-only --tags \
    ++	git name-rev --annotate-stdin --name-only --tags --exclude=t2 \
    + 		<tmp.1 >tmp.2 &&
    + 	tr '\t' ' ' <tmp.2 >actual &&
    + 	test_cmp expect actual
     @@ t/t8020-last-modified.sh: test_expect_success 'last-modified recursive' '
      	EOF
      '
    @@ t/t8020-last-modified.sh: test_expect_success 'last-modified complains about unk
      
     +test_expect_success 'last-modified expects commit-ish' '
     +	test_must_fail git last-modified HEAD^{tree} 2>err &&
    -+	grep "revision argument '"'"'HEAD^{tree}'"'"' is a tree, not a commit-ish" err
    ++	test_grep "revision argument ${SQ}HEAD^{tree}${SQ} is a tree, not a commit-ish" err
     +'
     +
      test_done


---
base-commit: ea717645d199f6f1b66058886475db3e8c9330e9
change-id: 20260112-toon-last-modified-tree-fdd96b2feaf7

