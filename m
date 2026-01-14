Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898E38A28A
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386306; cv=none; b=Z85yOQY+Vq6AbMNbEd0AJDhz9RXUgfi5MtJhlktks9DVTTiTIINRqeba8/39rohx3zFMzRLwzCF+uz3q96wU8hkQdkpUFHVLuBlrjJDS6BaH1Ui4peuY/6y/DE3V6IxnbOjSUmsU3hdaYkBJ9uzvKfD2yAMNcSUXUYr/hs2xy9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386306; c=relaxed/simple;
	bh=RIMa4Gtovog52oUp5ZnONvZrCYWcMp7sHkscMcEAtBQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=GBPtygAadFI/v0lL08icQLiEz+AteI7vJ+kawMefpWXxhadeFFRW+Ke78QOv2O3br4qMtiaTDIQR/rwvuMNjmQ8oHx8re9q0j0gTwYnFsQrQvDeyZnhhbh9m6l3F2NKg2NGcGHQ6EmglMUBfsKAghidHrCqzloK11y63G/JA6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=TESOiIAd; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="TESOiIAd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768386298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0K2i1aswwIVbfZyAalsAJWFKaZ6H8TlrKkXQMrzQG8=;
	b=TESOiIAdGB6RA+RmrWZu88ss8KfhTRdX/RASDtXORJOANFJZxWrt8afRNCdVcw0nnOYNSD
	U5t08N6bsQBBCuNQsm3nv2H5Xo7HOOhNiEVuErekugvzjJLkmlsQ2iT7GjzrbsMTY1MJ2Q
	Kk3mIvN12F+g+ZMaoZcfsYjb/eqwEKk=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 0/3] Fix git-last-modified(1) bug triggered when passing
 a tree-ish
Date: Wed, 14 Jan 2026 11:24:44 +0100
Message-Id: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOxuZ2kC/4WNQQ6CMBBFr0Jm7RhaDagr72FY0HYqY4AxbSUa0
 rsLeACXL3n//RkiBaYIl2KGQBNHlnEBvSvAdu14J2S3MOhSV6VSGpPIiH0bEw7i2DM5TIEIvXP
 nymhPra9hWT8DeX5v5Vvz4/gyD7Jpza1GxzFJ+GzXk1q9/y+TQoVkja1Ph6PydXVlSbbfWxmgy
 Tl/AeQVKw7QAAAA
X-Change-ID: 20260112-toon-last-modified-tree-fdd96b2feaf7
In-Reply-To: <20260112-toon-last-modified-tree-v1-1-ecbc78341f76@iotcl.com>
References: <20260112-toon-last-modified-tree-v1-1-ecbc78341f76@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, 
 Gusted <gusted@codeberg.org>
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
Changes in v2:
- Prepend the change with a commit that modifies the error message
  when more than one revision is given.
- Prepend another commit that removes double error message.
- Add test to ensure the command works with annotated tags too.
- Link to v1: https://patch.msgid.link/20260112-toon-last-modified-tree-v1-1-ecbc78341f76@iotcl.com

---
Toon Claes (3):
      last-modified: rewrite error message when more than one revision given
      last-modified: remove double error message
      last-modified: verify revision argument is a commit-ish

 builtin/last-modified.c  | 19 ++++++++++++++-----
 t/t8020-last-modified.sh | 15 ++++++++++++++-
 2 files changed, 28 insertions(+), 6 deletions(-)

Range-diff versus v1:

1:  ebd05211ab ! 1:  70baa9b4eb last-modified: verify revision argument is a commit-ish
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    last-modified: verify revision argument is a commit-ish
    +    last-modified: rewrite error message when more than one revision given
     
    -    Passing a tree OID to git-last-modified(1) would trigger BUG behavior.
    +    When more than one revision is passed to the git-last-modified(1)
    +    command, this error message was printed:
     
    -        git last-modified HEAD^{tree}
    -        BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified
    +        error: last-modified can only operate on one tree at a time
     
    -    Fix this error by verifying the parsed revision is peels to a
    -    commit-ish.
    +    Calling these a "tree" is technically not correct. git-last-modified(1)
    +    expects revisions that peel to a commit.
     
    -    While at it, also fix a memory leak in populate_paths_from_revs().
    +    Rephrase the error message to:
    +
    +        error: last-modified can only operate on one revision at a time
    +
    +    While at it, also fix a memory leak that remained uncovered so far.
     
    -    Reported-by: Gusted <gusted@codeberg.org>
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## builtin/last-modified.c ##
    @@ builtin/last-modified.c: static int populate_paths_from_revs(struct last_modifie
     -		if (num_interesting++)
     -			return error(_("last-modified can only operate on one tree at a time"));
     +		if (num_interesting++) {
    -+			ret = error(_("last-modified can only operate on one tree at a time"));
    -+			break;
    -+		}
    -+
    -+		if (!repo_peel_to_type(lm->rev.repo, obj->path, 0, obj->item, OBJ_COMMIT)) {
    -+			ret = error(_("revision argument is not a commit-ish"));
    -+			break;
    ++			ret = error(_("last-modified can only operate on one revision at a time"));
    ++			goto out;
     +		}
      
      		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
      			      &obj->item->oid, "", &diffopt);
    -@@ builtin/last-modified.c: static int populate_paths_from_revs(struct last_modified *lm)
    + 		diff_flush(&diffopt);
      	}
    ++
    ++out:
      	clear_pathspec(&diffopt.pathspec);
      
     -	return 0;
    @@ builtin/last-modified.c: static int populate_paths_from_revs(struct last_modifie
      static void last_modified_emit(struct last_modified *lm,
     
      ## t/t8020-last-modified.sh ##
    -@@ t/t8020-last-modified.sh: test_expect_success 'last-modified complains about unknown arguments' '
    - 	grep "unknown last-modified argument: --foo" err
    +@@ t/t8020-last-modified.sh: test_expect_success 'setup' '
    + 	test_commit 3 a/b/file
    + '
    + 
    +-test_expect_success 'cannot run last-modified on two trees' '
    ++test_expect_success 'cannot run last-modified on two revision' '
    + 	test_must_fail git last-modified HEAD HEAD~1
      '
      
    -+test_expect_success 'last-modified expects commit-ish' '
    -+	test_must_fail git last-modified HEAD^{tree} 2>err &&
    -+	grep "revision argument is not a commit-ish" err
    -+'
    -+
    - test_done
-:  ---------- > 2:  150c43580d last-modified: remove double error message
-:  ---------- > 3:  ab89cb1ef3 last-modified: verify revision argument is a commit-ish


---
base-commit: d529f3a197364881746f558e5652f0236131eb86
change-id: 20260112-toon-last-modified-tree-fdd96b2feaf7

