Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300DEC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086E8207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgEUS3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:29:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:53732 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbgEUS3d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:29:33 -0400
Received: (qmail 14930 invoked by uid 109); 21 May 2020 18:29:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 May 2020 18:29:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29799 invoked by uid 111); 21 May 2020 18:29:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 May 2020 14:29:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 May 2020 14:29:28 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/4] lib-submodule-update: pass OVERWRITING_FAIL
Message-ID: <20200521182928.GA1308647@coredump.intra.peff.net>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <cover.1590019226.git.liu.denton@gmail.com>
 <48598e3f9859dc525ec878cd7f3eaadee8bb61b1.1590019226.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48598e3f9859dc525ec878cd7f3eaadee8bb61b1.1590019226.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 08:24:18PM -0400, Denton Liu wrote:

> We are using `test_must_fail $command`. However, $command is not
> necessarily a git command; it could be a test helper function.
>
> In an effort to stop using test_must_fail with non-git commands, instead
> of invoking `test_must_fail $command`, run
> `OVERWRITING_FAIL=test_must_fail $command` instead in
> test_submodule_switch_common().

I think there are really two separate issues being addressed by this
patch.

One is using "test_must_fail" with a helper function. IMHO this is not
something we should go too far in trying to deal with. It's mostly a
style issue about how test_must_fail is meant to be used, and there's no
real downside if we occasionally use it for a non-git command.

I don't mind cleaning up spots where it's obviously misused, but in this
case we're introducing a lot of new complexity to handle the "sometimes"
nature of this call. And I'm not sure it's worth it on its own.

> This is useful because currently, when we run a test helper function, we
> just mark the whole thing as `test_must_fail`. However, it's possible
> that the helper function might fail earlier or later than expected due
> to an introduced bug. If this happens, then the test case will still
> report as passing but it should really be marked as failing since it
> didn't actually display the intended behaviour.

Now this second concern I think is much more interesting, because it
impacts the test results. And it's really not even about test_must_fail
in particular, but is a general problem with checking failure in any
compound operation. We may expect the early parts to succeed, but the
later parts to fail, and we want to tell the difference. And that's true
whether you're using "!", test_must_fail, etc.

You solve it here by passing OVERWRITING_FAIL down into the callback
functions. And that does work. But I think it may be easier to
understand if we invert the responsibility. Let the outer caller specify
two callbacks: one for setup/prep that must succeed, and one for a
single operation where we might expect success or failure.

The changes in lib-submodule-update look something like:

  @@ -326,7 +327,8 @@ test_submodule_switch_common() {
                  (
                          cd submodule_update &&
                          git branch -t add_sub1 origin/add_sub1 &&
  -                       $command add_sub1 &&
  +                       $prep add_sub1 &&
  +                       $command &&
                          test_superproject_content origin/add_sub1 &&
                          test_dir_is_empty sub1 &&
                          git submodule update --init --recursive &&

And in the caller we can simplify greatly:

  diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
  index f916729a12..e3ae7c89f1 100755
  --- a/t/t5572-pull-submodule.sh
  +++ b/t/t5572-pull-submodule.sh
  @@ -11,36 +11,13 @@ reset_branch_to_HEAD () {
   	git branch --set-upstream-to="origin/$1" "$1"
   }
   
  -git_pull () {
  -	reset_branch_to_HEAD "$1" &&
  -	git pull
  -}
  -
   # pulls without conflicts
  -test_submodule_switch "git_pull"
  -
  -git_pull_ff () {
  -	reset_branch_to_HEAD "$1" &&
  -	git pull --ff
  -}
  -
  -test_submodule_switch "git_pull_ff"
  -
  -git_pull_ff_only () {
  -	reset_branch_to_HEAD "$1" &&
  -	git pull --ff-only
  -}
  -
  -test_submodule_switch "git_pull_ff_only"
  -
  -git_pull_noff () {
  -	reset_branch_to_HEAD "$1" &&
  -	git pull --no-ff
  -}
  -
  +test_submodule_switch "reset_branch_to_HEAD" "git pull"
  +test_submodule_switch "reset_branch_to_HEAD" "git pull -ff"
  +test_submodule_switch "reset_branch_to_HEAD" "git pull --ff-only"
   KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
   KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
  -test_submodule_switch "git_pull_noff"
  +test_submodule_switch "reset_branch_to_HEAD" "git pull --no-ff"
   
   test_expect_success 'pull --recurse-submodule setup' '
   	test_create_repo child &&

I suspect this approach involves touching more lines than yours (it has
to add $prep everywhere $command is used). But IMHO the result is much
simpler to understand, because there's no spooky-action-at-a-distance
from magic environment variables.

A more complete patch is below, which is enough to get t5572 passing. I
think it would need the other test_submodule_switch() function updated,
and other scripts would need to adapt to the 2-arg style.

-Peff
