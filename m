Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F63C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 18:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348449AbiARSzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 13:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348469AbiARSzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 13:55:00 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09FCC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 10:54:59 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id h9-20020a170902680900b0014adffcba60so690156plk.7
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 10:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BlaQXyI4h+2CaalVfb+/PiVZ8ybNIiJ3AjlqIUM07w0=;
        b=mwBdUvL7X/fZs6eRSk6wFmmS4NU44krrq7j7N1O/h12i9c+9epgKqX6t6s5fKMo5E7
         0k6CodenD/ATMVswLAEYWMr/bKQkNcqnmzCykGMMhOZOfyXOAEJmfM8GF0ic9gmg2pGh
         h07oh6oghZ6HVxVDSdwExa1xn7X2lJkjE5KujV4tBIKpIIfHbbEzvEsqjFSQIQXxAiR8
         M2YN4Cdu+QwIGrN6Bi4mCkkxYjtBsZKPnuUzonY1ybhWTR7X1pruTiNiG4PgajNJmP95
         FMoCVyCm7v+mTZ30o6FUw1jB8OdKxLEXYLhn4YQF7q3qwETR2F1jQ3zjpMLgIajDgszW
         WYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BlaQXyI4h+2CaalVfb+/PiVZ8ybNIiJ3AjlqIUM07w0=;
        b=jEWr4LTBHx1Q4UodamKCxQmE0Myy/bAKUCMPQwh+mp6uz80fGKlsHQHHjC4ejIm+gs
         eO2bvyGVuer7KW2TGVfuJAY0XBmAWFEHqjM8j32/27vIOf7PYH0ro+JXMjAWPg1YHYCl
         b+J3xB84s+2TGz7DbXwK/RxgoyH4+M+uaU3oZ3iPkCHFlOzCp2gQ/v8tvkFJV2b29Yw5
         +/MjAAEelCoi6w59trf9HM2kvYw0d5L8+IC4Re2NQU8k/E0RpTpODiWCI6lWZYn4MmYh
         IFeGjDLWYo6gWQg2psNIuF7KVy376aggRZidL8ByLciijip2rTc2jqtQ+r12SS2KLhiv
         Z9Eg==
X-Gm-Message-State: AOAM530wk/sJ3femdDHAYGQzqPXPQMP2uVOv7ZSLSuKgKlE5l4UZKwgV
        atxLTTQVOBn6rl9ugsHhRzHBHRhkp4QoT5y8X1/iO1BzUj5wfEKjBpBUDyOqoZ7ZNCXlHc/e+vj
        9d2CGhryAgVKt1n0ZLSOhcRGVuagdLgRA5OYnLDAH8mJlcevDw7FmONMUabhZZhE=
X-Google-Smtp-Source: ABdhPJzygCN/bXyIOHC0Thn+UNBcEpe19FV+IN0zOten71xtmabTf0ZNkpg38VwVTO2ws2+s+vbWSZbaY5/b7A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:5c41:: with SMTP id
 n1mr5570155pgm.280.1642532099293; Tue, 18 Jan 2022 10:54:59 -0800 (PST)
Date:   Tue, 18 Jan 2022 10:54:50 -0800
In-Reply-To: <20220113004501.78822-1-chooglen@google.com>
Message-Id: <20220118185453.33710-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220113004501.78822-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v5 0/3] fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git fetch --negotiate-only` is used internally by push negotation and
it behaves very differently from other uses of `git fetch`, e.g. it does
not update refs or fetch objects. But because of how cmd_fetch() is
written, `git fetch --negotiate-only` performs tasks that it shouldn't.
This is results in behavior that is unnecessary at best, and incorrect
at worst:

* Submodules are updated if enabled by recurse.submodules=true, but
  negotiation fetch doesn't actually update the repo, so this doesn't
  make sense.
* Commit graphs will be written if enabled by
  fetch.writeCommitGraph=true, but this is unnecessary because no
  objects are fetched [1]. 
* gc is run, but according to the commit message in [2], we only do this
  because we expect `git fetch` to introduce objects.

Make `git fetch --negotiate-only` handle these tasks more rigorously by
doing the following:

* Make cmd_fetch() skip irrelevant tasks if we know for certain that
objects will not be fetched
* Disable submodule recursion and die() if a user explicitly asks for it

[1] This is also confirmed by Documentation/config/fetch.txt, which
  states that Git should only write commit graphs if a pack-file is
  downloaded.
[2] 131b8fcbfb (fetch: run gc --auto after fetching, 2013-01-26)

Changes since v4:
* drop an unnecessary block (thanks Junio!)

Changes since v3:
* change commit message subject: builtin/fetch -> fetch --negotiate-only
* move the 'goto cleanup' to _after_ the submodule updating task because
  we may want to update submodules even if objects were not fetched (as
  pointed out by Junio, thanks!)
* disable submodule recursion in the patch that checks for
  --negotiate-only + --recurse-submodules, so we never silently ignore
  --recurse-submodules.
* incorporate some of Jonathan's suggestions (thanks!)

Changes since v2:
* added a prepatory patch that introduces a "goto cleanup"
* drop an unnecessary line move (as suggested by Junio)
* check for user-given --recurse-submodules and die() (as suggested by
  Jonathan and Junio)
* update --negotiate-only's documentation

Changes since v1:
* added more context to commit message
* added a NEEDSWORK comment

Glen Choo (3):
  fetch: use goto cleanup in cmd_fetch()
  fetch: skip tasks related to fetching objects
  fetch --negotiate-only: do not update submodules

 Documentation/fetch-options.txt |  1 +
 builtin/fetch.c                 | 40 ++++++++++++++++++++++++++++++---
 t/t5516-fetch-push.sh           | 12 ++++++++++
 t/t5702-protocol-v2.sh          | 12 ++++++++++
 4 files changed, 62 insertions(+), 3 deletions(-)

Range-diff against v4:
1:  ffa1a24109 = 1:  ffa1a24109 fetch: use goto cleanup in cmd_fetch()
2:  b0c73e8135 = 2:  b0c73e8135 fetch: skip tasks related to fetching objects
3:  914d30866f ! 3:  f929297961 fetch --negotiate-only: do not update submodules
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
     +	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
     +		recurse_submodules = recurse_submodules_cli;
     +
    -+	if (negotiate_only) {
    ++	if (negotiate_only)
     +		switch (recurse_submodules_cli) {
     +		case RECURSE_SUBMODULES_OFF:
     +		case RECURSE_SUBMODULES_DEFAULT: {
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
     +		default:
     +			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
     +		}
    -+	}
    ++
     +
      	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
      		int *sfjc = submodule_fetch_jobs_config == -1

base-commit: 90d242d36e248acfae0033274b524bfa55a947fd
-- 
2.33.GIT

