Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99851FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 21:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754914AbdDLVZR (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 17:25:17 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:35517 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753771AbdDLVZP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 17:25:15 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id yPlHcCVqsxR4byPlIcrHjX; Wed, 12 Apr 2017 22:25:12 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=1XWaLZrsAAAA:8
 a=_cEhrwtOhbUiMRuPaM0A:9 a=wPNLvfGTeEIA:10
Message-ID: <18BFDBF530F144FBA7EAE731625E3C91@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>, <bmwill@google.com>
Cc:     <git@vger.kernel.org>, <jrnieder@gmail.com>, <gitster@pobox.com>,
        "Stefan Beller" <sbeller@google.com>
References: <20170411234923.1860-1-sbeller@google.com> <20170411234923.1860-4-sbeller@google.com>
Subject: Re: [PATCH 3/4] submodule.c: harden submodule_move_head against broken submodules
Date:   Wed, 12 Apr 2017 12:32:02 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfCqgy2NQcT8g+b3uPaKkPzUTdAMgl7jlU9esGJ2KFdNQUCNSutpzymLGMgFw3e1UuaM4JwdK3zkoYvPWNOZr8zj//3mki+9ixigvelmebNvkJUCuiN1i
 fqmOq53OvebYriEk5cMKWY7sR/HoLkP1qJB5JfezUtzmgYWi7fUGUDErI9lEzl1TG5BQG3hVA4vy13sN79mrQODWUlIHODKYhnAiKkl4hatdQw4ty7X+hYXc
 uhMxrY/0zkfqOlDzLXRhWPGyfZGCG6ajQwSnv/j4lQlFJT5mJ7MdOQFFecVZWpxToiuu7clFpp0/kl1Aen9RpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
> Early on in submodule_move_head just after the check if the submodule is
> initialized, we need to check if the submodule is populated correctly.
>
> If the submodule is initialized but doesn't look like populated, this
s/like//   or     s/like/like it is/

> is a red flag and can indicate multiple sorts of failures:
> (1) The submodule may be recorded at an object name, that is missing.
> (2) The submodule '.git' file link may be broken and it is not pointing
>    at a repository.
>
> In both cases we want to complain to the user in the non-forced mode,
> and in the forced mode ignoring the old state and just moving the
> submodule into its new state with a fixed '.git' file link.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
--
Philip

> submodule.c               | 17 +++++++++++++++++
> t/lib-submodule-update.sh | 23 ++++++++++++++++++++---
> 2 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 2fa42519a4..dda1ead854 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1331,10 +1331,19 @@ int submodule_move_head(const char *path,
>  int ret = 0;
>  struct child_process cp = CHILD_PROCESS_INIT;
>  const struct submodule *sub;
> + int *errorcode, error_code;
>
>  if (!is_submodule_initialized(path))
>  return 0;
>
> + if (flags & SUBMODULE_MOVE_HEAD_FORCE)
> + errorcode = &error_code;
> + else
> + errorcode = NULL;
> +
> + if (old && !is_submodule_populated_gently(path, errorcode))
> + return 0;
> +
>  sub = submodule_from_path(null_sha1, path);
>
>  if (!sub)
> @@ -1361,6 +1370,14 @@ int submodule_move_head(const char *path,
>  /* make sure the index is clean as well */
>  submodule_reset_index(path);
>  }
> +
> + if (old && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
> + struct strbuf sb = STRBUF_INIT;
> + strbuf_addf(&sb, "%s/modules/%s",
> +     get_git_common_dir(), sub->name);
> + connect_work_tree_and_git_dir(path, sb.buf);
> + strbuf_release(&sb);
> + }
>  }
>
>  prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 22dd9e060c..f0b1b18206 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -1213,14 +1213,31 @@ test_submodule_forced_switch_recursing () {
>  )
>  '
>  # Updating a submodule from an invalid sha1 updates
> - test_expect_success "$command: modified submodule does not update 
> submodule work tree from invalid commit" '
> + test_expect_success "$command: modified submodule does update submodule 
> work tree from invalid commit" '
>  prolog &&
>  reset_work_tree_to_interested invalid_sub1 &&
>  (
>  cd submodule_update &&
>  git branch -t valid_sub1 origin/valid_sub1 &&
> - test_must_fail $command valid_sub1 &&
> - test_superproject_content origin/invalid_sub1
> + $command valid_sub1 &&
> + test_superproject_content origin/valid_sub1 &&
> + test_submodule_content sub1 origin/valid_sub1
> + )
> + '
> +
> + # Old versions of Git were buggy writing the .git link file
> + # (e.g. before f8eaa0ba98b and then moving the superproject repo
> + # whose submodules contained absolute paths)
> + test_expect_success "$command: updating submodules fixes .git links" '
> + prolog &&
> + reset_work_tree_to_interested add_sub1 &&
> + (
> + cd submodule_update &&
> + git branch -t modify_sub1 origin/modify_sub1 &&
> + echo "gitdir: bogus/path" >sub1/.git &&
> + $command modify_sub1 &&
> + test_superproject_content origin/modify_sub1 &&
> + test_submodule_content sub1 origin/modify_sub1
>  )
>  '
> }
> -- 
> 2.12.2.603.g7b28dc31ba
>
> 

