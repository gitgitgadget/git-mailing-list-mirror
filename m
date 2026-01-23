Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031641A262D
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178807; cv=none; b=XAM1Ls9YHvcEjVwq23PF665ZKNMs+gnnz+GEtHJbGA6ZaTEciFGYC4RDe2cHfjbs63kyDq0UJzlYERTtNYGCxpc2hmvSiSo8iA4ERe9nyU8l3fNGoI0K5ySWomezTS8WBOmneSf4Qy07y8PA5KCt/CyhC/UozpaFZ1spe3x1ako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178807; c=relaxed/simple;
	bh=bzejH3B9r3dJlyq/lyjUZcAoilRab0QEKz++/xSpubY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=KJzORMQwW4XxBuH3MDlHxM2HayBsMsyOTqqz3k+eJCJ+H7ry8hyW3UDVDg8lqWlYcxYhPK7d2O4Hd1IXMRcQ1aPsvaqB5VBJpnOUNMZFpxRsi9tVOEbXisk0k7Bu0ll++mk8LYtwjRR54U2sAGA+dsOIOJSncqZeEVmK1NH4DT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=OBmI5WXL; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="OBmI5WXL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769178801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uyvAJUAIC3KwyVL1B7VM+YnEmIEz6FQErRsQh897ZJg=;
	b=OBmI5WXL9wQIyiK4Tgmgv7PNR42vVK6mlGFDb0Fg0CYKXK49i4OeXZY22xjviRrjr9NgUA
	CIRJoQrQRo2GGUNdQkykyloXgM2q5Fx/EqjEY2TC4cjjniRpa0IF66Sl4LLSXdJSg63LTg
	WXqT36RxdVfpWmz5fUMMQeiSTSwiIAk=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v4 0/4] Fix git-last-modified(1) bug triggered when passing
 a tree-ish
Date: Fri, 23 Jan 2026 15:33:00 +0100
Message-Id: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJyGc2kC/4XNzQrCMBAE4FeRnF1pkppWT76HeMjPRle0kSQWp
 fTdbeulCMXjwMw3HUsYCRPbrzoWsaVEoRlCuV4xe9HNGYHckJkohCo4F5BDaOCmU4Z7cOQJHeS
 ICN65nTLCo/YVG9aPiJ5ek3w8fXN6mivaPHJj40Iph/ierls+9v6/tBw4oDW2qmXJfaUOFLK9b
 Wy4s/GlFXOnXHYEFGC0NLxWRb2r/a8j545aduTgoNIOS2flVpu50/f9B4eFhJ9gAQAA
X-Change-ID: 20260112-toon-last-modified-tree-fdd96b2feaf7
In-Reply-To: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
References: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
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
      last-modified: rewrite error message when more than one revision given
      last-modified: fix memory leak when more than one revision is given
      last-modified: remove double error message
      last-modified: verify revision argument is a commit-ish

 builtin/last-modified.c  | 19 ++++++++++++++-----
 t/t8020-last-modified.sh | 24 +++++++++++++++++++-----
 2 files changed, 33 insertions(+), 10 deletions(-)

Range-diff versus v3:

1:  8786f5d6a4 ! 1:  1bd4bb7cb8 last-modified: rewrite error message when more than one revision given
    @@ Commit message
     
             error: last-modified can only operate on one revision at a time
     
    +    While at it, ensure modify the test to ensure the correct error message
    +    is printed.
    +
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## builtin/last-modified.c ##
    @@ t/t8020-last-modified.sh: test_expect_success 'setup' '
      '
      
     -test_expect_success 'cannot run last-modified on two trees' '
    +-	test_must_fail git last-modified HEAD HEAD~1
    +-'
    +-
    + check_last_modified() {
    + 	local indir= &&
    + 	while test $# != 0
    +@@ t/t8020-last-modified.sh: test_expect_success 'last-modified merge undoes changes' '
    + 	EOF
    + '
    + 
     +test_expect_success 'cannot run last-modified on two revision' '
    - 	test_must_fail git last-modified HEAD HEAD~1
    ++	test_must_fail git last-modified HEAD HEAD~1 2>err &&
    ++	test_grep "last-modified can only operate on one revision at a time" err
    ++'
    ++
    + test_expect_success 'last-modified complains about unknown arguments' '
    + 	test_must_fail git last-modified --foo 2>err &&
    +-	grep "unknown last-modified argument: --foo" err
    ++	test_grep "unknown last-modified argument: --foo" err
      '
      
    + test_done
2:  78ec93a9e2 = 2:  ed1bd102a2 last-modified: fix memory leak when more than one revision is given
3:  05b4424289 = 3:  7a6e587da1 last-modified: remove double error message
4:  00e29cd6a1 ! 4:  fee3aa92a9 last-modified: verify revision argument is a commit-ish
    @@ builtin/last-modified.c: static int populate_paths_from_revs(struct last_modifie
      		}
      
     +		if (!repo_peel_to_type(lm->rev.repo, obj->path, 0, obj->item, OBJ_COMMIT)) {
    -+			ret = error(_("revision argument is not a commit-ish"));
    ++			ret = error(_("revision argument '%s' is a %s, not a commit-ish"), obj->name, type_name(obj->item->type));
     +			goto out;
     +		}
     +
    @@ t/t8020-last-modified.sh: test_expect_success 'last-modified recursive' '
      	check_last_modified -r -t <<-\EOF
      	3 a/b
     @@ t/t8020-last-modified.sh: test_expect_success 'last-modified complains about unknown arguments' '
    - 	grep "unknown last-modified argument: --foo" err
    + 	test_grep "unknown last-modified argument: --foo" err
      '
      
     +test_expect_success 'last-modified expects commit-ish' '
     +	test_must_fail git last-modified HEAD^{tree} 2>err &&
    -+	grep "revision argument is not a commit-ish" err
    ++	grep "revision argument '"'"'HEAD^{tree}'"'"' is a tree, not a commit-ish" err
     +'
     +
      test_done


---
base-commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
change-id: 20260112-toon-last-modified-tree-fdd96b2feaf7

