Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE91096F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568935; cv=none; b=KCfXOYHDm8u6byMBXDdiByQlLvM6f1id6rYDkTujTb0s+1k7wgHQ0TlE+B2Gi21PWBQemjB13qWEqU/FEf2nmtS46nGXGTo66BxCEy1Ohqe3K6jDmJKJk2jVmlVMW8U6qFsL89WNrExUHr8qJJjjORWkzC32sD9UYxAODmNW9hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568935; c=relaxed/simple;
	bh=WNU1T5ek+mxL0nBbHGv6+Zzp6bmC8pk9xjaxYbB9bts=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=RZHmkMFrWtW73GSIOzTwsV93wFf/AF+eS+M5Obw4YYivlrZys2QYufdnpu9jnziRXxd9cofaTJNJvpS6O8InBGzIshEJRPnxxFN0KxIttSE8gFTPjm/IzXhSsIA6ah4L0Sx0+nUs00PMNz9qRoMXCYB+mQYicpJowsWEP+qIwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=pNzHAb6v; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="pNzHAb6v"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768568931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svFQa4uK+/AUB5jVl/PwNtLmgRXbmfOy7ywWWD4Boxk=;
	b=pNzHAb6vVP0Ltp4DyGYpBm2HBzOqGeZDF4oYzHZL79V6tRNYN5SpU1lCPjMzLXUHxEuf49
	tsWkgsBuxcZReqIo2fgifTHc77PNyqfLHh+tb4UC1K5oE7+6ZIKARQ0JDxUSmhI2JixI2F
	Lu7NKcwWq9v2zmdwOy/wLN0IkknwmtQ=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v3 0/4] Fix git-last-modified(1) bug triggered when passing
 a tree-ish
Date: Fri, 16 Jan 2026 14:08:36 +0100
Message-Id: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFU4amkC/4WNwQ6CMBAFf4X07BpaSAFP/ofxQNutrAFq2tpoC
 P8u4IWL8TjJezMTC+gJAztlE/OYKJAbFygOGdNdO94QyCzMRC5kzrmA6NwIfRsiDM6QJTQQPSJ
 YYxqphMXWVmx5Pzxaem3my/XL4anuqOOqWxcdhej8e0snvu7+VxIHDqiVruqi5LaSZ3JR90ftB
 rZWkth7yt8eATmotlC8lnnd1Hbvmef5Axf0LFIYAQAA
X-Change-ID: 20260112-toon-last-modified-tree-fdd96b2feaf7
In-Reply-To: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
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
      last-modified: rewrite error message when more than one revision given
      last-modified: fix memory leak when more than one revision is given
      last-modified: remove double error message
      last-modified: verify revision argument is a commit-ish

 builtin/last-modified.c  | 19 ++++++++++++++-----
 t/t8020-last-modified.sh | 15 ++++++++++++++-
 2 files changed, 28 insertions(+), 6 deletions(-)

Range-diff versus v2:

-:  ---------- > 1:  053c119ab1 last-modified: rewrite error message when more than one revision given
1:  5c9936500b ! 2:  827b1500fe last-modified: rewrite error message when more than one revision given
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    last-modified: rewrite error message when more than one revision given
    +    last-modified: fix memory leak when more than one revision is given
     
    -    When more than one revision is passed to the git-last-modified(1)
    -    command, this error message was printed:
    -
    -        error: last-modified can only operate on one tree at a time
    -
    -    Calling these a "tree" is technically not correct. git-last-modified(1)
    -    expects revisions that peel to a commit.
    -
    -    Rephrase the error message to:
    -
    -        error: last-modified can only operate on one revision at a time
    -
    -    While at it, also fix a memory leak that remained uncovered so far.
    +    When more than one revision is given, the function
    +    populate_paths_from_revs() leaks a `struct pathspec`. Plug it.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    @@ builtin/last-modified.c: static int populate_paths_from_revs(struct last_modifie
      			continue;
      
     -		if (num_interesting++)
    --			return error(_("last-modified can only operate on one tree at a time"));
    +-			return error(_("last-modified can only operate on one revision at a time"));
     +		if (num_interesting++) {
     +			ret = error(_("last-modified can only operate on one revision at a time"));
     +			goto out;
    @@ builtin/last-modified.c: static int populate_paths_from_revs(struct last_modifie
      }
      
      static void last_modified_emit(struct last_modified *lm,
    -
    - ## t/t8020-last-modified.sh ##
    -@@ t/t8020-last-modified.sh: test_expect_success 'setup' '
    - 	test_commit 3 a/b/file
    - '
    - 
    --test_expect_success 'cannot run last-modified on two trees' '
    -+test_expect_success 'cannot run last-modified on two revision' '
    - 	test_must_fail git last-modified HEAD HEAD~1
    - '
    - 
2:  5c964488fd = 3:  7748574724 last-modified: remove double error message
3:  cb6ff40853 ! 4:  6846722750 last-modified: verify revision argument is a commit-ish
    @@ Commit message
             git last-modified HEAD^{tree}
             BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified
     
    -    Fix this error by verifying the parsed revision peels to a commit-ish.
    -
    -    While at it, also fix a memory leak in populate_paths_from_revs().
    +    Fix this error by verifying the parsed revision is a commit-ish.
     
         Reported-by: Gusted <gusted@codeberg.org>
         Signed-off-by: Toon Claes <toon@iotcl.com>


---
base-commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
change-id: 20260112-toon-last-modified-tree-fdd96b2feaf7

