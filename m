Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD4FC636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 21:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjBJVce (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 16:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjBJVcd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 16:32:33 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A74F1BAF1
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 13:32:32 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d2so6560842pjd.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 13:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1676064751;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v0JeeUJ3aVQTyS2OxeofYQOw7HHr8EDqYhOoFR6mtgs=;
        b=IB22GMcqxSKD4BTnh5/0SpLU6ymsKfL4ErYRyVAghFDQ6MTD4I2En7sy35TfAlKwUC
         9V1jC+IPp9KS/UmhSSlFbWnSTCshPf4txwWulUhnY2E/y1WbHn/nqq7sWDx2cxEi08fQ
         bWuVZXVYKKTAR3ZK90J0zXi4GQoWuMwjfuUOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676064751;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0JeeUJ3aVQTyS2OxeofYQOw7HHr8EDqYhOoFR6mtgs=;
        b=SywGPEScG1VNVz7ixD1PnlviV2hoyHaPUmK1O6GOgsJlR2v04y6EqWwrjNmuIqBRNi
         sHIiaax5pCjZFLr+isSxKTMYtb5ZZxGcFEaY/4rVJj5gskUt4jaFLYWZ2AnXUqeLuq/v
         pm+TAXhCkFevbzUcdgYLuVG1jJ1O1dUb/vq36SOZ6U5lxl3CxuuNDFR//xIe61iwZxwG
         TBP3K+ifX/M5qVzTS61V+jnfPFymhH4tIdD5s00ZCwbFTLBMNDfjo7XSax6v284LDpFO
         2qiPCqJGpclpzFKdxADGdlpfyaMgJ3ptYXF1Txc1QaIABWd8EbFvAvgRsdDb4S7CXg2w
         /KQA==
X-Gm-Message-State: AO0yUKUdGh/Fxed/FOR26YURRRHO8e1DDuIDGmv24XsLVGH1um/abp3S
        hR30fsAe08iLn8hj8CmbNUYeiuSCcsbRV/NFpZDpsd7B2A5qCtq0
X-Google-Smtp-Source: AK7set9RGM4+G4wFY/J5JRb5YOYOINSJRI5qThHOspefIgJ6tNqYSDgeOxzKCnSSJrV8hGVFycpMsysbjObE0FApna8=
X-Received: by 2002:a17:903:41c9:b0:199:642:1c2c with SMTP id
 u9-20020a17090341c900b0019906421c2cmr4094301ple.33.1676064750937; Fri, 10 Feb
 2023 13:32:30 -0800 (PST)
MIME-Version: 1.0
From:   Andrew Wansink <wansink@uber.com>
Date:   Fri, 10 Feb 2023 13:31:54 -0800
Message-ID: <CA+tAvojz0u7AbcNnY1qyy3VznKhYTiAO1dL+rfOD3O6mOtsa8A@mail.gmail.com>
Subject: Subject: [RFC PATCH] upload_pack.c: make deepen-not more tree-ish
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This unlocks `git clone --shallow-exclude=<commit-sha1>`

git-clone only accepts --shallow-excude arguments where
the argument is a branch or tag because upload_pack only
searches deepen-not arguments for branches and tags.

Make process_deepen_not search for commit objects if no
branch or tag is found then add them to the deepen_not
list.

Signed-off-by: Andrew Wansink <wansink@uber.com>
---

At Uber we have a lot of patches in CI simultaneously,
the CI jobs will frequently clone the monorepo multiple
times for each patch.  They do this to calculate diffs
between a patch and its parent commit.

One optimisation in this flow is to clone only to a specific
depth, this may or may not work, depending on how old the
patch is.  In this case we have to --unshallow or discard
the shallow clone and fully clone the repo.

This patch would allow us to clone to exactly the depth we
need to find a patch's parent commit.

 t/t5500-fetch-pack.sh | 30 ++++++++++++++++++++++++++++++
 upload-pack.c         | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d18f2823d86..8d5045cc1b9 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -899,6 +899,36 @@ test_expect_success 'shallow clone exclude tag two' '
  )
 '

+test_expect_success 'shallow clone exclude commit' '
+ test_create_repo shallow-exclude-commit &&
+ (
+ cd shallow-exclude-commit &&
+ test_commit one &&
+ test_commit two &&
+ test_commit three &&
+ commit_two_sha1=$(git log -n 1 --pretty=tformat:%h HEAD^) &&
+ git clone --shallow-exclude=${commit_two_sha1} "file://$(pwd)/."
../shallow3-by-commit &&
+ git -C ../shallow3-by-commit log --pretty=tformat:%s HEAD >actual &&
+ git log -n 1 --pretty=tformat:%s HEAD >expected &&
+ test_cmp expected actual
+ )
+'
+
+test_expect_success 'shallow clone exclude commit^' '
+ test_create_repo shallow-exclude-commit-carat &&
+ (
+ cd shallow-exclude-commit-carat &&
+ test_commit one &&
+ test_commit two &&
+ test_commit three &&
+ commit_two_sha1=$(git log -n 1 --pretty=tformat:%h HEAD^) &&
+ git clone --shallow-exclude=${commit_two_sha1}^ "file://$(pwd)/."
../shallow23-by-commit &&
+ git -C ../shallow23-by-commit log --pretty=tformat:%s HEAD >actual &&
+ git log -n 2 --pretty=tformat:%s HEAD >expected &&
+ test_cmp expected actual
+ )
+'
+
 test_expect_success 'fetch exclude tag one' '
  git -C shallow12 fetch --shallow-exclude one origin &&
  git -C shallow12 log --pretty=tformat:%s origin/main >actual &&
diff --git a/upload-pack.c b/upload-pack.c
index 551f22ffa5d..0c8594f4744 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -985,10 +985,37 @@ static int process_deepen_not(const char *line,
struct string_list *deepen_not,
  if (skip_prefix(line, "deepen-not ", &arg)) {
  char *ref = NULL;
  struct object_id oid;
- if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref) != 1)
- die("git upload-pack: ambiguous deepen-not: %s", line);
- string_list_append(deepen_not, ref);
- free(ref);
+
+ switch (expand_ref(the_repository, arg, strlen(arg), &oid, &ref)) {
+ case 1:
+ // tag or branch matching arg found
+ string_list_append(deepen_not, ref);
+ free(ref);
+ break;
+ case 0: {
+ // no tags or branches matching arg
+ struct object *obj = NULL;
+ struct commit *commit = NULL;
+
+ if (get_oid(arg, &oid))
+ die("git upload-pack: deepen-not: no ref or object %s", arg);
+
+ obj = parse_object(the_repository, &oid);
+ if (!obj)
+ die("git upload-pack: deepen-not: object could not be parsed: %s", arg);
+
+ commit = (struct commit *)peel_to_type(arg, 0, obj, OBJ_COMMIT);
+ if (!commit)
+ die("git upload-pack: deepen-not: object not a commit: %s", arg);
+
+ string_list_append(deepen_not, oid_to_hex(&commit->object.oid));
+ break;
+ }
+ default:
+ // more than 1 tag or branch matches arg
+ die("git upload-pack: ambiguous deepen-not: %s", arg);
+ }
+
  *deepen_rev_list = 1;
  return 1;
  }
-- 
2.39.1
