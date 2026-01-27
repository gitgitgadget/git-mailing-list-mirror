Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DE63563D3
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520394; cv=none; b=CRWAyGhzsbIgwrpWNi17RXT8lE7ENb8JN3LqaggSugSJ2yAdxN6rF1e8f1sTeAo+zKmlqZkMb/6EPUv47N7r8kBymC7S5CRhQNhIgCRY79AepejMLVXv8ou+CsAsrga9RCclA/IrX2PYP6304QyywRYXBkEVV0HKJkSIiyyeLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520394; c=relaxed/simple;
	bh=g1IQC8d5B9Bs5sGI43UEeDgMJ8fVkdpaEcLxoVyO37Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ULbxA/oQ8Su8ZFDjImLbCchlQ4Hvg7W5TkpnuO2MhnJNjr1AslGiV5OhmvEJyJ9fC2SaINAfGLqx/CX3vzmwe2x5vSnbxh9aWpePyi9Gf0WGAQCBywOG417KN8iUSszuN+DdyUTW6AabNL7fF4sxrfEaQ6vegc7PsZVsWOirklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=yZWSJpVn; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="yZWSJpVn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769520388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPdRDmE+zXurPaTc6bcy1LuIEKon9LQro920T7IgEw8=;
	b=yZWSJpVnGbnIW68awJ6vo28nv/ZSFu4Q5RIC4Syu5guwkYpmS34JIDtDUCvCIoNtE1e8Rw
	AwAC2ObB8I/u26BkhhW8WbN8xCzKVXmpOY5ijL2cya0UWlgMvj8xrVM15G+qT6CgdzvKzy
	RM7WvALUZxkivmJa/o7aVPM6GQItERs=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v5 0/4] Fix git-last-modified(1) bug triggered when passing
 a tree-ish
Date: Tue, 27 Jan 2026 14:26:16 +0100
Message-Id: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNy2rDMBQE0F8JWucW6xFZzir/UbrQ46q5IbGCp
 JqW4H+vnG5MwHQ5MHPmwQpmwsKOuwfLOFGhNLZw2O+YP9vxE4FCy0x0QnecC6gpjXC1pcItBYq
 EAWpGhBjCoJ2IaGPP2vqeMdL3U37/+Mvly13Q14VbGmcqNeWf5/XEl97/LxMHDuid741UPPb6R
 Kn665tPN7a8TGLtqG1HQAfOSseN7sxg4qsj147edmRzUNuAKnh5sO7VUStHyG1HNcdoF4fe2aB
 QrJ15nn8BDyFvGagBAAA=
X-Change-ID: 20260112-toon-last-modified-tree-fdd96b2feaf7
In-Reply-To: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
References: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Gusted <gusted@codeberg.org>
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
 t/t8020-last-modified.sh | 24 +++++++++++++++++++-----
 2 files changed, 33 insertions(+), 10 deletions(-)

Range-diff versus v4:

1:  497901f0ab ! 1:  2107d672e9 last-modified: rewrite error message when more than one revision given
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    last-modified: rewrite error message when more than one revision given
    +    last-modified: rewrite error message when more than one commit given
     
    -    When more than one revision is passed to the git-last-modified(1)
    -    command, this error message was printed:
    +    When more than one commit is passed to the git-last-modified(1) command,
    +    this error message was printed:
     
             error: last-modified can only operate on one tree at a time
     
    @@ Commit message
     
         Rephrase the error message to:
     
    -        error: last-modified can only operate on one revision at a time
    +        error: last-modified can only operate on one commit at a time
     
    -    While at it, ensure modify the test to ensure the correct error message
    -    is printed.
    +    While at it, modify the test to ensure the correct error message is
    +    printed.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    @@ builtin/last-modified.c: static int populate_paths_from_revs(struct last_modifie
      
      		if (num_interesting++)
     -			return error(_("last-modified can only operate on one tree at a time"));
    -+			return error(_("last-modified can only operate on one revision at a time"));
    ++			return error(_("last-modified can only operate on one commit at a time"));
      
      		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
      			      &obj->item->oid, "", &diffopt);
    @@ t/t8020-last-modified.sh: test_expect_success 'last-modified merge undoes change
      	EOF
      '
      
    -+test_expect_success 'cannot run last-modified on two revision' '
    ++test_expect_success 'cannot run last-modified on two commits' '
     +	test_must_fail git last-modified HEAD HEAD~1 2>err &&
    -+	test_grep "last-modified can only operate on one revision at a time" err
    ++	test_grep "last-modified can only operate on one commit at a time" err
     +'
     +
      test_expect_success 'last-modified complains about unknown arguments' '
2:  1316ca90b4 ! 2:  dbabde6b54 last-modified: fix memory leak when more than one revision is given
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    last-modified: fix memory leak when more than one revision is given
    +    last-modified: fix memory leak when more than one commit is given
     
    -    When more than one revision is given, the function
    +    When more than one commit is given, the function
         populate_paths_from_revs() leaks a `struct pathspec`. Plug it.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
    @@ builtin/last-modified.c: static int populate_paths_from_revs(struct last_modifie
      			continue;
      
     -		if (num_interesting++)
    --			return error(_("last-modified can only operate on one revision at a time"));
    +-			return error(_("last-modified can only operate on one commit at a time"));
     +		if (num_interesting++) {
    -+			ret = error(_("last-modified can only operate on one revision at a time"));
    ++			ret = error(_("last-modified can only operate on one commit at a time"));
     +			goto out;
     +		}
      
3:  151f0ff0ae = 3:  8f37827504 last-modified: remove double error message
4:  f2cf0dd371 ! 4:  9a810e12be last-modified: verify revision argument is a commit-ish
    @@ Metadata
      ## Commit message ##
         last-modified: verify revision argument is a commit-ish
     
    -    Passing a tree OID to git-last-modified(1) would trigger BUG behavior.
    +    Passing a non-committish revision to git-last-modified(1) triggers the
    +    following BUG:
     
             git last-modified HEAD^{tree}
             BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified
     
    -    Fix this error by verifying the parsed revision is a commit-ish.
    +    Fix this error by ensuring that the given revision peels to a commit.
     
         Reported-by: Gusted <gusted@codeberg.org>
         Signed-off-by: Toon Claes <toon@iotcl.com>


---
base-commit: ab689ea7f91ab0858e85776f31102203d3ea7b83
change-id: 20260112-toon-last-modified-tree-fdd96b2feaf7

