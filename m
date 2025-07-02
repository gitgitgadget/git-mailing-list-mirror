Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C91E5B72
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491720; cv=none; b=elFYfei99OxYtE38JsJ3YOACdNOxBH4IKnu9YyKmiL5WX4zLMMAM2TaIvOa77i52cIsMesdYug5OCg3/7M1/Mls3PSfwKj7+iDQRxcIwNuS9vHPVTAYSPbOAY+JUwcBrVXh6YWAM3wDEpgEYyL5NN5CXBwCejBzy8KOvGdepxOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491720; c=relaxed/simple;
	bh=Y7EGYCziLfTU7v18nvaUBXbhfQ6WnA+UXveJvNhMeqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuaELnC5QgOv5GI9vqJHiDg8UuIyq1BJH8Eg/ifbK182A8mzQYug/0Y4Fr6TsQGNGmDSa56kbQzjm0ceKoBfbG+miYaUxo5q2064J4XYjI6p0WWhxfG3s/xGzdiYS6kragPpi/2HtY4WUZSoYJ4ccmpHcwWs6b5VezN0DLTtSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=ofCLtUb2; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="ofCLtUb2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751491713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YzmbRG6JuMj4YIuN8Wp6gW1/K1cUx1LLUACn3Bob5aU=;
	b=ofCLtUb2jNXYkD/ctaTgRjKUd/YA2EqeKzz+mdsgiiAw+K1VQWtab3Jr38Hxk9ndxTc2PW
	44VaGxBC1dX3KDl8dAfLzcHLlxQ2tIix9VKg+/r6PaESvk13q/6aEnoh9oF3zx2X64XDOs
	D78LAv1kK9wLsfooi4g34rEtIaPOQB0=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: ray@ameretat.dev
Cc: aclopte@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jason11choca@proton.me,
	kristofferhaugsbakk@fastmail.com,
	rhodges@cisco.com
Subject: [PATCH v2 0/4] fix apply --intent-to-add
Date: Wed,  2 Jul 2025 17:26:43 -0400
Message-ID: <20250702212814.1923253-1-ray@ameretat.dev>
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

I've rerolled this taking comments into consideration; I've removed the
first patch, because I'm convinced not erroring out is fine here, and
expanded on the log messages somewhat. I've also fixed an issue where I
was outsmarted by a text editor when writing the test patch.

Raymond E. Pasco (4):
  apply: read in the index in --intent-to-add mode
  apply: only write intents to add for new files
  t4140: test apply --intent-to-add interactions
  apply docs: clarify wording for --intent-to-add

 Documentation/git-apply.adoc |  9 +++++----
 apply.c                      |  4 ++--
 t/t4140-apply-ita.sh         | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 7 deletions(-)

Range-diff against v1:
1:  b1c9ea7cac < -:  ---------- apply: error on --intent-to-add outside gitdir
2:  3a422c8124 ! 1:  71ec291fba apply: read in the index in --intent-to-add mode
    @@ Commit message
         cases, because the index was never read in (in apply, this is done
         in read_apply_cache()) before writing to it.
     
    -    If we merely gate read_apply_cache() behind update_index, then it will
    -    not be read when state->apply is false, even if it must be checked.
    -    Therefore, we instead read the index if it will be either checked or
    -    updated, because reading the index is a prerequisite to either.
    +    This causes the operation to clobber the old, correct index with a
    +    new empty-tree index before writing intent-to-add entries to this
    +    empty index; the final result is that the index now records every
    +    existing file in the repository as deleted, which is incorrect.
    +
    +    This error can be corrected by first reading the index. The
    +    update_index flag is correctly set if ita_only is true, because
    +    this mode updates the index. However, if we merely gate the call
    +    to read_apply_cache() behind update_index, then it will not be read
    +    when state->apply is false, even if it must be checked. Therefore,
    +    we instead read the index if it will be either checked or updated,
    +    because reading the index is a prerequisite to either.
     
         Reported-by: Ryan Hodges <rhodges@cisco.com>
         Original-patch-by: Johannes Altmanninger <aclopte@gmail.com>
3:  df28144f82 ! 2:  5f49ff9035 apply: only write intents to add for new files
    @@ Commit message
         touching the index, we can't rely only on that flag to decide whether to
         write an index entry.
     
    -    Instead, we must test whether we are in a mode which updates the
    -    index, or else are in worktree-only mode with --intent-to-add on and
    -    the current file being an addition. We do not need to check
    -    state->apply, because we only enter write_out_results() if state->apply
    -    is already set.
    +    Because we have already entered write_out_results() and are performing
    +    writes, we know that state->apply is true. If state->check_index is
    +    additionally true, we are in a mode which updates the index and should
    +    always write, whereas if we are merely in ita_only mode we must only
    +    write if the patch is a new file creation patch.
     
         Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
     
4:  0bbae13b63 ! 3:  f8a6d8032f t4140: test apply --intent-to-add interactions
    @@ t/t4140-apply-ita.sh: test_description='git apply of i-t-a file'
      test_expect_success setup '
      	test_write_lines 1 2 3 4 5 >blueprint &&
      
    -+  cat blueprint >committed-file &&
    -+  git add committed-file &&
    -+  git commit -m "commit" &&
    ++	cat blueprint >committed-file &&
    ++	git add committed-file &&
    ++	git commit -m "commit" &&
     +
      	cat blueprint >test-file &&
      	git add -N test-file &&
    @@ t/t4140-apply-ita.sh: test_expect_success 'apply deletion patch to ita path (--i
      '
      
     +test_expect_success 'apply creation patch to existing index with -N' '
    -+  git rm -f test-file &&
    -+  cat blueprint >index-file &&
    -+  git add index-file &&
    -+  git apply -N creation-patch &&
    ++	git rm -f test-file &&
    ++	cat blueprint >index-file &&
    ++	git add index-file &&
    ++	git apply -N creation-patch &&
     +
    -+  git ls-files --stage --error-unmatch index-file &&
    -+  git ls-files --stage --error-unmatch test-file
    ++	git ls-files --stage --error-unmatch index-file &&
    ++	git ls-files --stage --error-unmatch test-file
     +'
     +
     +test_expect_success 'apply complex patch with -N' '
    -+  git rm -f test-file index-file &&
    -+  git apply -N complex-patch &&
    ++	git rm -f test-file index-file &&
    ++	git apply -N complex-patch &&
     +
    -+  git ls-files --stage --error-unmatch test-file &&
    -+  git diff | grep "a/committed-file"
    ++	git ls-files --stage --error-unmatch test-file &&
    ++	git diff | grep "a/committed-file"
     +'
     +
      test_done
5:  970c739ca9 ! 4:  ad42992d03 apply docs: clarify wording for --intent-to-add
    @@ Documentation/git-apply.adoc: OPTIONS
     -	Note that `--index` could be implied by other options such
     -	as `--cached` or `--3way`.
     +	option in linkgit:git-add[1]). This option is ignored if
    -+	`--index` or `--cached` are used. Note that `--index` could
    -+	be implied by other options such as `--3way`.
    ++	`--index` or `--cached` are used, and has no effect outside a Git
    ++	repository. Note that `--index` could be implied by other options
    ++	such as `--3way`.
      
      -3::
      --3way::
-- 
2.50.0.201.gfeb04032fb

