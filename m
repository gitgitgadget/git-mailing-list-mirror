Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D814EC73
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890553; cv=none; b=fes2/VQW1cs8i0c8Rvwf3RrOl+hx4I2M6/BAAQV0NIWMDhnmHtlq4nKF/1w9YlTgOc3piWLxRKGj5vecQalgA9MqN9i6AfClh6fNgRTzRqViBDX1SHcEblwyin9i0S/uhHY/pfaPHj+wwoIevIyj8muYH51aqSrQtIgzmTrGWOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890553; c=relaxed/simple;
	bh=zPHrUgYWKQU6TXWjzdxMShE8a4nSU37+fR/yFdDDyys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlvCixhreIthx1zHcX6ME4/xbA2BDttgoEO00Vmul1yufY1eUCwcYWVucXUwAZR2J+QJEVBQRS1qsfF0DBrI+YYzhw95b5K17xNilyq0b44BS3sRT3/HfMK5qwGoYe8p94R7kCRenWaEEA36tDsrQv6YG+8EWa+gp54j2Fky+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=LOgT+72i; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="LOgT+72i"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751890547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AG+3ovkoSvi5hW8jrr1x02javbqwgY39IfyT2jGPvgQ=;
	b=LOgT+72iH7/N8mUf6eej+QkfgVGI+Yp0tn1nW4Yhaac1FUm0x6tabrdpkc8r9mkJLkTp72
	1ce/M2mpFpKBIf4WQk/m7FOJDHG/FM6ga5dzHjHTHt7GSPS5VkJDcUcPWBeB1Y56WNTQNV
	tJCIHEup57C7eu0/JwEWx8HkT7CJk8w=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: ray@ameretat.dev
Cc: aclopte@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jason11choca@proton.me,
	kristofferhaugsbakk@fastmail.com,
	rhodges@cisco.com
Subject: [PATCH v3 0/4] fix apply --intent-to-add
Date: Mon,  7 Jul 2025 08:12:29 -0400
Message-ID: <20250707121534.2933349-1-ray@ameretat.dev>
In-Reply-To: <20250702212814.1923253-1-ray@ameretat.dev>
References: <20250702212814.1923253-1-ray@ameretat.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

I've rerolled this to considerably expand the commit messages, because
it took me a while to learn apply.c and a while to relearn it as well,
so the messages should be as specific as possible to aid the next
person.

A note about this series: the code changes (first two patches) apply
fine to cff5dc09ed, which introduced the feature in a broken state, and
fix it there. However, that is from 2018, and t4140 did not exist yet at
that time (I wrote it in 2020) and the docs have moved around some in
the interim as well. If it were a year-old, and not a nearly
seven-year-old, issue, I would prioritize making it all work there, but
I'm not sure it's worth adding an entirely new test. Unsure what the
correct thing to do here is.

Raymond E. Pasco (4):
  apply: read in the index in --intent-to-add mode
  apply: only write intents to add for new files
  t4140: test apply --intent-to-add interactions
  apply docs: clarify wording for --intent-to-add

 Documentation/git-apply.adoc |  9 +++++----
 apply.c                      |  4 ++--
 t/t4140-apply-ita.sh         | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 7 deletions(-)

Range-diff against v2:
1:  71ec291fba ! 1:  f3120189b3 apply: read in the index in --intent-to-add mode
    @@ Commit message
         only to the index (--cached).
     
         The --intent-to-add flag modifies the first of these modes, applying
    -    only to the worktree, in a way which touches the index, because
    -    intents to add are special index entries. However, it has not ever
    +    only to the worktree, in a way which touches the index, because intents
    +    to add are special index entries. However, since its introduction
    +    in cff5dc09ed (apply: add --intent-to-add, 2018-05-26), it has not
         worked correctly in any but the most trivial (empty repository)
    -    cases, because the index was never read in (in apply, this is done
    -    in read_apply_cache()) before writing to it.
    +    cases, because the index is never read in (in apply, this is done in
    +    read_apply_cache()) before writing to it.
     
         This causes the operation to clobber the old, correct index with a
         new empty-tree index before writing intent-to-add entries to this
    @@ Commit message
         existing file in the repository as deleted, which is incorrect.
     
         This error can be corrected by first reading the index. The
    -    update_index flag is correctly set if ita_only is true, because
    -    this mode updates the index. However, if we merely gate the call
    -    to read_apply_cache() behind update_index, then it will not be read
    -    when state->apply is false, even if it must be checked. Therefore,
    -    we instead read the index if it will be either checked or updated,
    -    because reading the index is a prerequisite to either.
    +    update_index flag is correctly set if ita_only is true, because this
    +    flag causes the index to be updated. However, if we merely gate the
    +    call to read_apply_cache() behind update_index, then it will not be
    +    read when state->apply is false, even if it must be checked due to
    +    being in --index or --cached mode. Therefore, we instead read the
    +    index if it will be either checked or updated, because reading the
    +    index is a prerequisite to either.
     
         Reported-by: Ryan Hodges <rhodges@cisco.com>
         Original-patch-by: Johannes Altmanninger <aclopte@gmail.com>
2:  5f49ff9035 ! 2:  907a90d849 apply: only write intents to add for new files
    @@ Metadata
      ## Commit message ##
         apply: only write intents to add for new files
     
    -    In the "update only the worktree" mode, the index should not be touched
    -    except to record intents to add when --intent-to-add is on. Because
    -    having --intent-to-add on sets update_index, to indicate that we are
    -    touching the index, we can't rely only on that flag to decide whether to
    -    write an index entry.
    +    In the "apply only to files" mode (i.e., neither --index nor --cached
    +    mode), the index should not be touched except to record intents to
    +    add when --intent-to-add is on. Because having --intent-to-add on sets
    +    update_index, to indicate that we may touch the index, we can't rely
    +    only on that flag in create_file() (which is called to write both new
    +    files and updated files) to decide whether to write an index entry;
    +    if we did, we would write an index entry for every file being patched
    +    (which would moreover be an intent-to-add entry despite not being a
    +    new file, because we are going to turn on the CE_INTENT_TO_ADD flag
    +    in add_index_entry() if we enter it here and ita_only is true).
     
    -    Because we have already entered write_out_results() and are performing
    -    writes, we know that state->apply is true. If state->check_index is
    -    additionally true, we are in a mode which updates the index and should
    +    To decide whether to touch the index, we need to check the
    +    specific reason the index would be updated, rather than merely
    +    their aggregate in the update_index flag. Because we have already
    +    entered write_out_results() and are performing writes, we know that
    +    state->apply is true. If state->check_index is additionally true, we
    +    are in --index or --cached mode, which updates the index and should
         always write, whereas if we are merely in ita_only mode we must only
         write if the patch is a new file creation patch.
     
3:  f8a6d8032f ! 3:  b7603de201 t4140: test apply --intent-to-add interactions
    @@ Metadata
      ## Commit message ##
         t4140: test apply --intent-to-add interactions
     
    -    Test that applying a new file creation patch to an existing index works,
    -    and that applying a patch with both modifications and new file creations
    -    works.
    +    Test that applying a new file creation patch with --intent-to-add to
    +    an existing index does not modify the index outside adding the correct
    +    intents-to-add, and that applying a patch with both modifications
    +    and new file creations with --intent-to-add correctly only adds
    +    intents-to-add to the index.
     
         Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
     
4:  ad42992d03 = 4:  4c786a77c9 apply docs: clarify wording for --intent-to-add
-- 
2.50.0.229.gc167f4d905

