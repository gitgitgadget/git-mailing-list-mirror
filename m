Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B108C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 00:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbhLVALt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 19:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbhLVALs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 19:11:48 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E204C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 16:11:48 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id u13-20020a17090a450d00b001b1e6726fccso2481323pjg.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 16:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KpzqLLmko4eH3WQKX2DVSz/0b4r3lq1GmEdvcAF2R5A=;
        b=sV2mPGyAXQVkIsbtK+/Tqa5ipBcedsMFJq5oa/tLM8DicrC41lJI9TyBUw0qF3sdbO
         Tyqxg4sp1lGJJ6WMJyekWaJWoft9peJ2CFzb2vL8Z3/NmZOdk0LAjALNmLz82EGYv5eQ
         k+XAIfjB2vssGjXjjoNSkf6rvb9Te05MVYVjUlbq7cLcs88kPGEJpWty8se2iiTrZFLe
         o6a55SqKF08COE/ul6/N5EeUmlHizHA8421SYC+gNNRRHAnAm+uivbsBtk2oZLxPbH9v
         huEQBF/TMZoqr7Gravc+wu15wx8wGi/mN/S+eHNGhvGRd3UYKQFWaJz/LcZsXuJRefiU
         Ab6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KpzqLLmko4eH3WQKX2DVSz/0b4r3lq1GmEdvcAF2R5A=;
        b=I1Qk3PM8TY2Ed0JKfDy6tQEZ0LivmnmNpKdrLiwZRmWFoIab2sC9lSIcMJsjaHxu6u
         BxUixGFvrvt843bfaL4ZUpJen2v9qcKxPMrqMKL9reRTj6VSYepslqymLk+mUlkOomyO
         OQOE3d4jgWMHmZlZao1oKf/VNkgzpKBV4P/unTlGipdRDO4OYfeGm1UTscqt1AxA8085
         0c2tHRjQQ3UtpI/WKpt90Vb8NPKmY+up+n3zqlLPsLP6dnAdXMWUCoPWVM0Dfmrb1TcO
         yN/AKEvxGsQpIzbYq4aALJfI1gr9wciYW+n1F9AZ+QkaDQug2RJGnPiyvUpC8B0V2j8a
         eefA==
X-Gm-Message-State: AOAM530lmv7zZm3gFh2PDMsdQ/FnA3ELZkzGECZpt3Xanrnv95AGoe5C
        I+Go31unqkvtZKCcLVO4sqz1q04pPYH9wUpYdUWeCpAZUnIjzk7EqgB115CK1Hj0uACIIeimMWv
        1lY8ICIUdlN0x7vPZl/qJAQClIUSY3WVbBRz21eSs6pxfJ3pqVNXXex79MIr+lVw=
X-Google-Smtp-Source: ABdhPJw0Mh8AATAgkQE4vFH9htZUzJyYGtbUOKEhuyVyxpVy7505dM9xPQozFqqVpM7tkIt6/gYbZJIcfhFmYA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:9099:0:b0:4ba:9e72:e5d3 with SMTP id
 i25-20020aa79099000000b004ba9e72e5d3mr442776pfa.75.1640131907839; Tue, 21 Dec
 2021 16:11:47 -0800 (PST)
Date:   Tue, 21 Dec 2021 16:11:31 -0800
In-Reply-To: <20211217000235.68996-1-chooglen@google.com>
Message-Id: <20211222001134.28933-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211217000235.68996-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v3 0/3] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_fetch() performs certain tasks with the assumption that objects are
fetched, but `git fetch --negotiate-only` does not fetch objects, as its
name implies. This is results in behavior that is unnecessary at best,
and incorrect at worst:

* Submodules are updated if enabled by recurse.submodules=true, but
  negotiation fetch doesn't actually update the repo, so this doesn't
  make sense (introduced in [1]).
* Commit graphs will be written if enabled by
  fetch.writeCommitGraph=true. But according to
  Documentation/config/fetch.txt [2], this should only be done if a
  pack-file is downloaded.
* gc is run, but according to [3], we only do this because we expect
  `git fetch` to introduce objects.

Make `git fetch --negotiate-only` handle these tasks more rigorously by
doing the following:

* Make cmd_fetch() return early if we know for certain that objects will
  not be fetched
* Disable submodule recursion and die() if a user explicitly asks for it

[1] 7dce19d374 (fetch/pull: Add the --recurse-submodules option, 2010-11-12)
[2] 50f26bd035 (fetch: add fetch.writeCommitGraph config setting, 2019-09-02)
[3] 131b8fcbfb (fetch: run gc --auto after fetching, 2013-01-26)

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
  builtin/fetch: use goto cleanup in cmd_fetch()
  builtin/fetch: skip unnecessary tasks when using --negotiate-only
  builtin/fetch: die on --negotiate-only and --recurse-submodules

 Documentation/fetch-options.txt |  1 +
 builtin/fetch.c                 | 41 +++++++++++++++++++++++++++++----
 t/t5516-fetch-push.sh           | 12 ++++++++++
 t/t5702-protocol-v2.sh          | 17 ++++++++++++++
 4 files changed, 67 insertions(+), 4 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  97e2cba633 builtin/fetch: use goto cleanup in cmd_fetch()
1:  9d18270a41 ! 2:  3a3a04b649 builtin/fetch: skip unnecessary tasks when using --negotiate-only
    @@ Commit message
         return early whenever objects are not fetched, but for now this only
         considers --negotiate-only.
     
    +    A similar optimization would be to skip irrelevant tasks in `git fetch
    +    --dry-run`. This optimization was not done in this commit because a dry
    +    run will actually fetch objects; we'd presumably still want to recurse
    +    into submodules and run gc.
    +
         [1] 7dce19d374 (fetch/pull: Add the --recurse-submodules option, 2010-11-12)
         [2] 50f26bd035 (fetch: add fetch.writeCommitGraph config setting, 2019-09-02)
         [3] 131b8fcbfb (fetch: run gc --auto after fetching, 2013-01-26)
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
     +		 * submodules, so there is no need to read .gitmodules.
     +		 */
     +		recurse_submodules = RECURSE_SUBMODULES_OFF;
    -+		if (!negotiation_tip.nr)
    -+			die(_("--negotiate-only needs one or more --negotiate-tip=*"));
     +	}
     +
      	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
      		int *sfjc = submodule_fetch_jobs_config == -1
      			    ? &submodule_fetch_jobs_config : NULL;
    -@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
    - 		fetch_config_from_gitmodules(sfjc, rs);
    - 	}
    - 
    --	if (negotiate_only && !negotiation_tip.nr)
    --		die(_("--negotiate-only needs one or more --negotiate-tip=*"));
    --
    - 	if (deepen_relative) {
    - 		if (deepen_relative < 0)
    - 			die(_("Negative depth in --deepen is not supported"));
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
      		result = fetch_multiple(&list, max_children);
      	}
      
    -+	string_list_clear(&list, 0);
    -+
     +	/*
     +	 * Skip irrelevant tasks because we know objects were not
     +	 * fetched.
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
     +	 * of them.
     +	 */
     +	if (negotiate_only)
    -+		return result;
    ++		goto cleanup;
     +
      	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
      		struct strvec options = STRVEC_INIT;
      		int max_children = max_jobs;
    -@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
    - 		strvec_clear(&options);
    - 	}
    - 
    --	string_list_clear(&list, 0);
    --
    - 	prepare_repo_settings(the_repository);
    - 	if (fetch_write_commit_graph > 0 ||
    - 	    (fetch_write_commit_graph < 0 &&
     
      ## t/t5516-fetch-push.sh ##
     @@ t/t5516-fetch-push.sh: test_expect_success 'push with negotiation proceeds anyway even if negotiation f
-:  ---------- > 3:  97792b5214 builtin/fetch: die on --negotiate-only and --recurse-submodules

base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
-- 
2.33.GIT

