Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F370C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 00:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiAMApc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 19:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiAMApP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 19:45:15 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF9FC061759
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 16:45:14 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id j13-20020a17090a318d00b001b3e4f72bfbso4714246pjb.9
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 16:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tvx6HAbV/ovTGnxzuKriJA4lbhwl0bBqtO59iNKNOGM=;
        b=jE7Wz3sTdIGKLAPkrr+oclv6fEcSYu9xuyFiSbQl6ZR8SOeQSbBZRtkSrGS1RE9g46
         wmx3cs5yTDkfVkJRCDZnUPPyIJsbOIBIZYswNEZ1FvS3zI8ZXlJ30jkWMTe5QSaCvKJQ
         GR7DGB1YIRLvfvZoV07YfLfcuaEkZ0qlt+f/ykDmBL82pLfYmHCKAA5kNRzO3VSlVIrr
         gTmtiQ19z3mtcO0XwrBqmpuwhm8HPgZbYSDOjG7BZ3wH1JCsjPbQoR9lM1AClE9PEItC
         6M9UGKwGrLM4Azvb5+ASdSJVXUgeoyUblaB+73hmo+GbNL1QsoOg0VpmXsO80V26CYGV
         7OWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tvx6HAbV/ovTGnxzuKriJA4lbhwl0bBqtO59iNKNOGM=;
        b=GUilzCq2unIEa9ILH0DzWoI/5B6zGeeaOIDH20VzZ3yAucnAOsAj4+OP6lUSG2J42a
         Eg/7xJOpwpxygZdyqniv5eSnCYqiRvw9RQYLcPlgGeRwD57nrVeQGvH1T2wtAg0R7Oqm
         EzOG3QfsA/xpvblJOn8bKvNufGv25GAMj5pnoj1y0Alu3UyLDvXII5HTxnrbfrpftSx7
         hOVIELoEOeRwEOl8JxDENFTRMRpDZgdhuIM6f52jlH7FJDIjYkUbAkSXgDwUxR/B0+bD
         D0JnLn8L1yluPmOP93X3aKA1n6+VmlHeE603mFZC9Q7/C3wj0eyFIT1N5YjnkkH5EhVu
         6tKg==
X-Gm-Message-State: AOAM530hoGb9IY2CSN/8gSVY9hnrkSGB+QoV7envS8TVRFeqCEqtjo3T
        GzPOFkgso8W8x8tH4oAUe2n6iafspssqXshoVSLMGq8Z2YR9gfUqjv+jQD/zawd23tO1BWOksZJ
        kI36iIVVR8ZVRoiSWUZlnqU1Rxzs6aZ5WQZidN9nUo4LvWLQk/NNSn+2QBSReNlU=
X-Google-Smtp-Source: ABdhPJywsJSnfefewzrGpLV8FBxwTbvKibSjl/9RpyjPXWIZQLJ0U6GtfXp3y30r2OVPLmQpZtqdz09pvVsRLA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:348d:: with SMTP id
 b135mr1828343pga.481.1642034714073; Wed, 12 Jan 2022 16:45:14 -0800 (PST)
Date:   Wed, 12 Jan 2022 16:44:58 -0800
In-Reply-To: <20211222001134.28933-1-chooglen@google.com>
Message-Id: <20220113004501.78822-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211222001134.28933-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v4 0/3] fetch: skip unnecessary tasks when using --negotiate-only
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

Range-diff against v3:
1:  97e2cba633 ! 1:  ffa1a24109 builtin/fetch: use goto cleanup in cmd_fetch()
    @@ Metadata
     Author: Glen Choo <chooglen@google.com>
     
      ## Commit message ##
    -    builtin/fetch: use goto cleanup in cmd_fetch()
    +    fetch: use goto cleanup in cmd_fetch()
     
         Replace an early return with 'goto cleanup' in cmd_fetch() so that the
    -    string_list is always cleared.
    -
    -    The string_list_clear() call is purely cleanup; the string_list was not
    -    reused.
    +    string_list is always cleared (the string_list_clear() call is purely
    +    cleanup; the string_list is not reused). This makes cleanup consistent
    +    so that a subsequent commit can use 'goto cleanup' to bail out early.
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     
    @@ builtin/fetch.c
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
      			gtransport->smart_options->acked_commits = &acked_commits;
      		} else {
    - 			warning(_("Protocol does not support --negotiate-only, exiting."));
    + 			warning(_("protocol does not support --negotiate-only, exiting"));
     -			return 1;
     +			result = 1;
     +			goto cleanup;
2:  3a3a04b649 < -:  ---------- builtin/fetch: skip unnecessary tasks when using --negotiate-only
-:  ---------- > 2:  b0c73e8135 fetch: skip tasks related to fetching objects
3:  97792b5214 ! 3:  914d30866f builtin/fetch: die on --negotiate-only and --recurse-submodules
    @@ Metadata
     Author: Glen Choo <chooglen@google.com>
     
      ## Commit message ##
    -    builtin/fetch: die on --negotiate-only and --recurse-submodules
    +    fetch --negotiate-only: do not update submodules
     
    -    The previous commit ignores the value of --recurse-submodules if
    -    --negotiate-only is given. Since non "no" values of --recurse-submodules
    -    are not supported with --negotiate-only, make cmd_fetch() check for
    -    this invalid combination and die.
    +    `git fetch --negotiate-only` is an implementation detail of push
    +    negotiation and, unlike most `git fetch` invocations, does not actually
    +    update the main repository. Thus it should not update submodules even
    +    if submodule recursion is enabled.
     
    -    This is unlikely to affect internal usage of --negotiate-only, but it
    -    may be helpful for users. We may also want to discourage users from
    -    using --negotiate-only altogether because it was not intended for them.
    +    This is not just slow, it is wrong e.g. push negotiation with
    +    "submodule.recurse=true" will cause submodules to be updated because it
    +    invokes `git fetch --negotiate-only`.
    +
    +    Fix this by disabling submodule recursion if --negotiate-only was given.
    +    Since this makes --negotiate-only and --recurse-submodules incompatible,
    +    check for this invalid combination and die.
    +
    +    This does not use the "goto cleanup" introduced in the previous commit
    +    because we want to recurse through submodules whenever a ref is fetched,
    +    and this can happen without introducing new objects.
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     
    @@ Documentation/fetch-options.txt: configuration variables documented in linkgit:g
      	ancestors of the provided `--negotiation-tip=*` arguments,
      	which we have in common with the server.
      +
    -+This is incompatible with `--recurse-submodules[=yes|on-demand]`.
    ++This is incompatible with `--recurse-submodules=[yes|on-demand]`.
      Internally this is used to implement the `push.negotiate` option, see
      linkgit:git-config[1].
      
    @@ builtin/fetch.c: static struct transport *gtransport;
      static struct transport *gsecondary;
      static const char *submodule_prefix = "";
      static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
    -+static int recurse_submodules_explicit = RECURSE_SUBMODULES_DEFAULT;
    ++static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
      static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
      static int shown_url = 0;
      static struct refspec refmap = REFSPEC_INIT_FETCH;
    @@ builtin/fetch.c: static struct option builtin_fetch_options[] = {
      	OPT_BOOL('P', "prune-tags", &prune_tags,
      		 N_("prune local tags no longer on remote and clobber changed tags")),
     -	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
    -+	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_explicit, N_("on-demand"),
    ++	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-demand"),
      		    N_("control recursive fetching of submodules"),
      		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
      	OPT_BOOL(0, "dry-run", &dry_run,
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
    + 
      	argc = parse_options(argc, argv, prefix,
      			     builtin_fetch_options, builtin_fetch_usage, 0);
    - 
    -+	if (recurse_submodules_explicit != RECURSE_SUBMODULES_DEFAULT)
    -+		recurse_submodules = recurse_submodules_explicit;
     +
    - 	if (negotiate_only) {
    --		/*
    --		 * --negotiate-only should never recurse into
    --		 * submodules, so there is no need to read .gitmodules.
    --		 */
    --		recurse_submodules = RECURSE_SUBMODULES_OFF;
    -+		switch (recurse_submodules_explicit) {
    ++	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
    ++		recurse_submodules = recurse_submodules_cli;
    ++
    ++	if (negotiate_only) {
    ++		switch (recurse_submodules_cli) {
     +		case RECURSE_SUBMODULES_OFF:
     +		case RECURSE_SUBMODULES_DEFAULT: {
     +			/*
     +			 * --negotiate-only should never recurse into
    -+			 * submodules, so there is no need to read .gitmodules.
    ++			 * submodules. Skip it by setting recurse_submodules to
    ++			 * RECURSE_SUBMODULES_OFF.
     +			 */
     +			recurse_submodules = RECURSE_SUBMODULES_OFF;
     +			break;
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
     +		default:
     +			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
     +		}
    - 	}
    - 
    ++	}
    ++
      	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
    + 		int *sfjc = submodule_fetch_jobs_config == -1
    + 			    ? &submodule_fetch_jobs_config : NULL;
    +
    + ## t/t5516-fetch-push.sh ##
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push with negotiation proceeds anyway even if negotiation f
    + 	test_i18ngrep "push negotiation failed" err
    + '
    + 
    ++test_expect_success 'push with negotiation does not attempt to fetch submodules' '
    ++	mk_empty submodule_upstream &&
    ++	test_commit -C submodule_upstream submodule_commit &&
    ++	git submodule add ./submodule_upstream submodule &&
    ++	mk_empty testrepo &&
    ++	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
    ++	test_commit -C testrepo unrelated_commit &&
    ++	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
    ++	git -c submodule.recurse=true -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
    ++	! grep "Fetching submodule" err
    ++'
    ++
    + test_expect_success 'push without wildcard' '
    + 	mk_empty testrepo &&
    + 
     
      ## t/t5702-protocol-v2.sh ##
     @@ t/t5702-protocol-v2.sh: test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
    @@ t/t5702-protocol-v2.sh: test_expect_success 'usage: --negotiate-only without --n
      '
      
     +test_expect_success 'usage: --negotiate-only with --recurse-submodules' '
    -+	SERVER="server" &&
    -+	URI="file://$(pwd)/server" &&
    -+
    -+	setup_negotiate_only "$SERVER" "$URI" &&
    -+
     +	cat >err.expect <<-\EOF &&
     +	fatal: --negotiate-only and --recurse-submodules cannot be used together
     +	EOF

base-commit: 90d242d36e248acfae0033274b524bfa55a947fd
-- 
2.33.GIT

