Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64657236F95
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909347; cv=none; b=iaYlwmSCYHUwLV26ZPdSbr9mXd7quLLDO9BWcD35Ogk0+LJGu9Z5/z1Gxy9JsskvcsWtPuNQDjePBI1zLECpAOqvtmAcT/nAGe+8ofA+q3Ak1ew77eNlygoDFXWOPwtJ23sPUDsIPym0Yex/oGeTDnKUYzvb5PwXY4ShKaP7jO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909347; c=relaxed/simple;
	bh=PlClc1XiF019YiTBEC1Ed7jUWJ731Nh54kobZyel3mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=og2T6gzKOUmcdwf+G6NkvhenEJoD7gVoMOYalZSR/MyU3RCIaAV7GUWspmWYzd7u6VApQAbWO4EEy+ZQ9NHDiWr6/pcUr3EuaXC61Rq62JKhowfzBdzTlDBrTZHvghepS/yLRqWhmqUwCAO4iWpc5oGPVKUHz7RpVTxzHyx88MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=WO7FV9FO; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="WO7FV9FO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1733909336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4mKavrfZcOBBIvVKPKjzzchH4Cu8U4N0ev2rddZtumQ=;
	b=WO7FV9FO96NKu7wTt59Usd7vicsP8kV2xf1qyA9P5Tecx49TmeK2MoK4Bf0+xIULTPrLi5
	cDoLTIewOR8iC2YCn/9I8f4Fjl0VkzOTZqMMAPiTR8+gLlRnsev8L8cHCm0LFzPQqU5+D5
	3kIpcDd8qejeKPO3nPOicNu4R5euCf0=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 11 Dec 2024 10:28:15 +0100
Subject: [PATCH v2] bundle: remove unneeded code
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-bundle-create-race-v2-1-6a18bd07edec@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAC5bWWcC/3WNzQrCMBCEX6Xs2ZUkVjGefA/pIT8bu1CbksSil
 L67seDR4zfMfLNApsSU4dIskGjmzHGsoHYNuN6Md0L2lUEJ1UolWgz8Qvsc/UDoEplCmIwj9MJ
 6Z6QNWmuo4ylRbW7iW1e551xiem8/s/ymP6X+p5wlSqTTUR6q2oazuXIsbti7+IBuXdcP4UDGk
 rwAAAA=
X-Change-ID: 20241204-fix-bundle-create-race-d0bdca1bf999
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The changes in commit c06793a4ed (allow git-bundle to create bottomless
bundle, 2007-08-08) ensure annotated tags are properly preserved when
creating a bundle using a revision range operation.

At the time the range notation would peel the ends to their
corresponding commit, meaning ref v2.0 would point to the v2.0^0 commit.
So the above workaround was introduced. This code looks up the ref
before it's written to the bundle, and if the ref doesn't point to the
object we expect (for tags this would be a tag object), we skip the ref
from the bundle. Instead, when the ref is a tag that's the positive end
of the range (e.g. v2.0 from the range "v1.0..v2.0"), then that ref is
written to the bundle instead.

Later, in 895c5ba3c1 (revision: do not peel tags used in range notation,
2013-09-19), the behavior of parsing ranges was changed and the problem
was fixed at the cause. But the workaround in bundle.c was not reverted.

Now it seems this workaround can cause a race condition. git-bundle(1)
uses setup_revisions() to parse the input into `struct rev_info`. Later,
in write_bundle_refs(), it uses this info to write refs to the bundle.
As mentioned at this point each ref is looked up again and checked
whether it points to the object we expect. If not, the ref is not
written to the bundle. But, when creating a bundle in a heavy traffic
repository (a repo with many references, and frequent ref updates) it's
possible a branch ref was updated between setup_revisions() and
write_bundle_refs() and thus the extra check causes the ref to be
skipped.

The workaround was originally added to deal with tags, but the code path
also gets hit by non-tag refs, causing this race condition. Because it's
no longer needed, remove it and fix the possible race condition.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
Earlier I reported[1] a race condition bug could occur if a ref is
updated while a git-bundle(1) creation process is running. I've
demonstrated it's possible to reproduce this by using a debugger.

> To reproduce, I've been running git-bundle(1) with
> `create my.bndl --all --ignore-missing` in a debugger. I've set a
> breakpoint at bundle.c:515[1] where setup_revisions() is called. After
> stepping over this line I see in the debugger `revs.pending` is
> populated.
>
>     (gdb) p *revs.pending.objects
>     $6 = {item = 0x7a2fb0, name = 0x78d7e0 "refs/heads/master", path = 0x0, mode = 12288}
>     (gdb) p *revs.pending.objects.item
>     $7 = {parsed = 1, type = 1, flags = 0, oid = {hash = "R\026\370\365\304\b\236\302\234\344\232\372\024t4\302>\017\001c\000\000\000\000sS\344\367\377\177\000", algo = 1}}
>
> The hash value is the binary representation of
> `5216f8f5c4089ec29ce49afa147434c23e0f0163`, the current HEAD of
> `master`. At this point I've updated `master` in another terminal
> window:
>
>     git commit --allow-empty -m"dummy"
>
> Then in the debugger I continue the process to create the bundle. The
> resulting bundle seems to be missing `refs/heads/master`.

I started digging into this bug again. And I've discovered the changes
made by c06793a4ed (allow git-bundle to create bottomless bundle,
2007-08-08) cause some trouble. Those changes look up the refs for a
second time, and if they mismatch, they might not get written to the
bundle output file.

It seems the workaround is not needed anymore since
895c5ba3c1 (revision: do not peel tags used in range notation,
2013-09-19) and thus I'm removing it while adding some tests.
Unfortunately, I was not able to implement a test that hits the race
condition bug.

[1]: https://lore.kernel.org/git/87eddlpx5k.fsf@iotcl.com/
---
Changes in v2:

- No longer user the term "bottomless bundle" and use "full bundle" and
  "incremental bundle" instead, because they are more commonly used.

- To verify the full bundle created upto tag actually contains the tag
  object, add a test to clone from the created bundle.

- Explicitly mention in the test names that annotated tags are used,
  because it's not obvious to see the function test_commit_setvar() used
  with option `--tag` calls git-tag(1) with `-m` which implies `-a`.

- Link to v1: https://lore.kernel.org/r/20241209-fix-bundle-create-race-v1-1-e6513bdcbf8a@iotcl.com

Range-diff against v1:

1:  2816666488 ! 1:  a7974c232f bundle: remove unneeded code
    @@ t/t6020-bundle-misc.sh: test_expect_success 'unfiltered bundle with --objects' '
        test_cmp expect actual
      '

    -+test_expect_success 'bottomless bundle upto tag' '
    ++test_expect_success 'full bundle upto annotated tag' '
     +  git bundle create v2.bdl \
     +          v2 &&
     +
    @@ t/t6020-bundle-misc.sh: test_expect_success 'unfiltered bundle with --objects' '
     +  test_cmp expect actual
     +'
     +
    -+test_expect_success 'bundle between two tags' '
    ++test_expect_success 'clone from full bundle upto annotated tag' '
    ++  git clone --mirror v2.bdl tag-clone.git &&
    ++  git -C tag-clone.git show-ref |
    ++          make_user_friendly_and_stable_output >actual &&
    ++  cat >expect <<-\EOF &&
    ++  <TAG-2> refs/tags/v2
    ++  EOF
    ++  false &&
    ++  test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'incremental bundle between two annotated tags' '
     +  git bundle create v1-v2.bdl \
     +          v1..v2 &&
     +
---
 bundle.c               | 30 ------------------------------
 t/t6020-bundle-misc.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4773b51eb1df8057466c87f48445c49bc1f594ee..dfb5b7a5ec6b98e00078359afe991bac55cae739 100644
--- a/bundle.c
+++ b/bundle.c
@@ -420,36 +420,6 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 				e->name);
 			goto skip_write_ref;
 		}
-		/*
-		 * If you run "git bundle create bndl v1.0..v2.0", the
-		 * name of the positive ref is "v2.0" but that is the
-		 * commit that is referenced by the tag, and not the tag
-		 * itself.
-		 */
-		if (!oideq(&oid, &e->item->oid)) {
-			/*
-			 * Is this the positive end of a range expressed
-			 * in terms of a tag (e.g. v2.0 from the range
-			 * "v1.0..v2.0")?
-			 */
-			struct commit *one = lookup_commit_reference(revs->repo, &oid);
-			struct object *obj;
-
-			if (e->item == &(one->object)) {
-				/*
-				 * Need to include e->name as an
-				 * independent ref to the pack-objects
-				 * input, so that the tag is included
-				 * in the output; otherwise we would
-				 * end up triggering "empty bundle"
-				 * error.
-				 */
-				obj = parse_object_or_die(&oid, e->name);
-				obj->flags |= SHOWN;
-				add_pending_object(revs, obj, e->name);
-			}
-			goto skip_write_ref;
-		}
 
 		ref_count++;
 		write_or_die(bundle_fd, oid_to_hex(&e->item->oid), the_hash_algo->hexsz);
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 5d444bfe201a330527e86dde7229721fc386fc93..e7e8de92cd904f2f9a2dd6b4be21b288b6ea6154 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -504,6 +504,51 @@ test_expect_success 'unfiltered bundle with --objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'full bundle upto annotated tag' '
+	git bundle create v2.bdl \
+		v2 &&
+
+	git bundle verify v2.bdl |
+		make_user_friendly_and_stable_output >actual &&
+
+	format_and_save_expect <<-EOF &&
+	The bundle contains this ref:
+	<TAG-2> refs/tags/v2
+	The bundle records a complete history.
+	$HASH_MESSAGE
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'clone from full bundle upto annotated tag' '
+	git clone --mirror v2.bdl tag-clone.git &&
+	git -C tag-clone.git show-ref |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-\EOF &&
+	<TAG-2> refs/tags/v2
+	EOF
+	false &&
+	test_cmp expect actual
+'
+
+test_expect_success 'incremental bundle between two annotated tags' '
+	git bundle create v1-v2.bdl \
+		v1..v2 &&
+
+	git bundle verify v1-v2.bdl |
+		make_user_friendly_and_stable_output >actual &&
+
+	format_and_save_expect <<-EOF &&
+	The bundle contains this ref:
+	<TAG-2> refs/tags/v2
+	The bundle requires these 2 refs:
+	<COMMIT-E> Z
+	<COMMIT-B> Z
+	$HASH_MESSAGE
+	EOF
+	test_cmp expect actual
+'
+
 for filter in "blob:none" "tree:0" "tree:1" "blob:limit=100"
 do
 	test_expect_success "filtered bundle: $filter" '

---
base-commit: e66fd72e972df760a53c3d6da023c17adfc426d6
change-id: 20241204-fix-bundle-create-race-d0bdca1bf999

Best regards,
-- 
Toon Claes <toon@iotcl.com>

