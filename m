Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C912CC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 23:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350488AbiEPXxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 19:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350487AbiEPXxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 19:53:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C470D3EF3B
        for <git@vger.kernel.org>; Mon, 16 May 2022 16:53:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC32612909B;
        Mon, 16 May 2022 19:53:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q3PrcZ3rxmK+Gw9uVU9uVia3y51G3543EDgjE8
        +cNaQ=; b=NNo+ee4mRTKIxdgkamCICnoagF2BmBioMl0x0PbXsNReZUluXneua6
        4YsSNkEedRCvn1VvhBzvKxxlvuOGnizGIX5Vrd/DLoBStlAmLGyn3uEgcAGPtSg/
        +ZWXeJ1H0Bq0VgpDUhwnOCIKRWqIHpB4aux3cerAbfTjjulFO6vu8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C353912909A;
        Mon, 16 May 2022 19:53:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 307FA129099;
        Mon, 16 May 2022 19:53:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Benedek Kozma <cyberbeni@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: [PATCH v2] fetch: do not run a redundant fetch from submodule
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
        <xmqqczgzdc1r.fsf@gitster.g>
        <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq1qxfbqtq.fsf@gitster.g>
        <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqpmkg8z58.fsf@gitster.g>
        <kl6l7d6ljrrg.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq4k1p2v40.fsf@gitster.g> <xmqqwnel1eqb.fsf@gitster.g>
        <xmqqczgd16wx.fsf_-_@gitster.g>
Date:   Mon, 16 May 2022 16:53:40 -0700
In-Reply-To: <xmqqczgd16wx.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Mon, 16 May 2022 14:53:02 -0700")
Message-ID: <xmqqk0alyqyj.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A3F8882-D573-11EC-B51D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 7dce19d3 (fetch/pull: Add the --recurse-submodules option,
2010-11-12) introduced the "--recurse-submodule" option, the
approach taken was to perform fetches in submodules only once, after
all the main fetching (it may usually be a fetch from a single
remote, but it could be fetching from a group of remotes using
fetch_multiple()) succeeded.  Later we added "--all" to fetch from
all defined remotes, which complicated things even more.

If your project has a submodule, and you try to run "git fetch
--recurse-submodule --all", you'd see a fetch for the top-level,
which invokes another fetch for the submodule, followed by another
fetch for the same submodule.  All but the last fetch for the
submodule come from a "git fetch --recurse-submodules" subprocess
that is spawned via the fetch_multiple() interface for the remotes,
and the last fetch comes from the code at the end.

Because recursive fetching from submodules is done in each fetch for
the top-level in fetch_multiple(), the last fetch in the submodule
is redundant.  It only matters when fetch_one() interacts with a
single remote at the top-level.

While we are at it, there is one optimization that exists in dealing
with a group of remote, but is missing when "--all" is used.  In the
former, when the group turns out to be a group of one, instead of
spawning "git fetch" as a subprocess via the fetch_multiple()
interface, we use the normal fetch_one() code path.  Do the same
when handing "--all", if it turns out that we have only one remote
defined.

Helped-by: Glen Choo <chooglen@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

So here is a second attempt.  It demonstrates a bit interesting
funny in range-diff where similar changes from the previous round
gets applied to a different target.

t5617 is much cleanly organized than t5526, and we may want to clean
up the latter after dust settles.

1:  006fe43da1 ! 1:  da0a4e341b fetch: do not run a redundant fetch from submodule
    @@ Commit message
         when handing "--all", if it turns out that we have only one remote
         defined.
     
    +    Helped-by: Glen Choo <chooglen@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/fetch.c ##
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
      			die(_("fetch --all does not make sense with refspecs"));
      		(void) for_each_remote(get_one_remote_for_fetch, &list);
     +
    -+		/* no point doing fetch_multiple() of one */
    ++		/* do not do fetch_multiple() of one */
     +		if (list.nr == 1)
     +			remote = remote_get(list.items[0].string);
      	} else if (argc == 0) {
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
      	}
      
     -	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
    ++
    ++	/*
    ++	 * This is only needed after fetch_one(), which does not fetch
    ++	 * submodules by itself.
    ++	 *
    ++	 * When we fetch from multiple remotes, fetch_multiple() has
    ++	 * already updated submodules to grab commits necessary for
    ++	 * the fetched history from each remote, so there is no need
    ++	 * to fetch submodules from here.
    ++	 */
     +	if (!result && remote && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
      		struct strvec options = STRVEC_INIT;
      		int max_children = max_jobs;
      
     
    - ## t/t5617-clone-submodules-remote.sh ##
    -@@ t/t5617-clone-submodules-remote.sh: test_expect_success 'clone with --single-branch' '
    + ## t/t5526-fetch-submodules.sh ##
    +@@ t/t5526-fetch-submodules.sh: test_expect_success 'fetch --recurse-submodules updates name-conflicted, unpopul
      	)
      '
      
     +test_expect_success 'fetch --all with --recurse-submodules' '
    -+	test_when_finished "rm -fr super_clone" &&
    -+	git clone --recurse-submodules srv.bare super_clone &&
    ++	test_when_finished "rm -fr src_clone" &&
    ++	git clone --recurse-submodules src src_clone &&
     +	(
    -+		cd super_clone &&
    ++		cd src_clone &&
     +		git config submodule.recurse true &&
     +		git config fetch.parallel 0 &&
     +		git fetch --all 2>../fetch-log
     +	) &&
    -+	grep "Fetching sub" fetch-log >fetch-subs &&
    ++	grep "^Fetching submodule sub$" fetch-log >fetch-subs &&
     +	test_line_count = 1 fetch-subs
     +'
     +
    - # do basic partial clone from "srv.bare"
    - # confirm partial clone was registered in the local config for super and sub.
    - test_expect_success 'clone with --filter' '
    ++test_expect_success 'fetch --all with --recurse-submodules with multiple' '
    ++	test_when_finished "rm -fr src_clone" &&
    ++	git clone --recurse-submodules src src_clone &&
    ++	(
    ++		cd src_clone &&
    ++		git remote add secondary ../src &&
    ++		git config submodule.recurse true &&
    ++		git config fetch.parallel 0 &&
    ++		git fetch --all 2>../fetch-log
    ++	) &&
    ++	grep "Fetching submodule sub" fetch-log >fetch-subs &&
    ++	test_line_count = 2 fetch-subs
    ++'
    ++
    + test_done


 builtin/fetch.c             | 16 +++++++++++++++-
 t/t5526-fetch-submodules.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed..8b15c40bb2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2187,6 +2187,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		else if (argc > 1)
 			die(_("fetch --all does not make sense with refspecs"));
 		(void) for_each_remote(get_one_remote_for_fetch, &list);
+
+		/* do not do fetch_multiple() of one */
+		if (list.nr == 1)
+			remote = remote_get(list.items[0].string);
 	} else if (argc == 0) {
 		/* No arguments -- use default remote */
 		remote = remote_get(NULL);
@@ -2261,7 +2265,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_multiple(&list, max_children);
 	}
 
-	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
+
+	/*
+	 * This is only needed after fetch_one(), which does not fetch
+	 * submodules by itself.
+	 *
+	 * When we fetch from multiple remotes, fetch_multiple() has
+	 * already updated submodules to grab commits necessary for
+	 * the fetched history from each remote, so there is no need
+	 * to fetch submodules from here.
+	 */
+	if (!result && remote && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct strvec options = STRVEC_INIT;
 		int max_children = max_jobs;
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 43dada8544..a301b56db8 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1125,4 +1125,31 @@ test_expect_success 'fetch --recurse-submodules updates name-conflicted, unpopul
 	)
 '
 
+test_expect_success 'fetch --all with --recurse-submodules' '
+	test_when_finished "rm -fr src_clone" &&
+	git clone --recurse-submodules src src_clone &&
+	(
+		cd src_clone &&
+		git config submodule.recurse true &&
+		git config fetch.parallel 0 &&
+		git fetch --all 2>../fetch-log
+	) &&
+	grep "^Fetching submodule sub$" fetch-log >fetch-subs &&
+	test_line_count = 1 fetch-subs
+'
+
+test_expect_success 'fetch --all with --recurse-submodules with multiple' '
+	test_when_finished "rm -fr src_clone" &&
+	git clone --recurse-submodules src src_clone &&
+	(
+		cd src_clone &&
+		git remote add secondary ../src &&
+		git config submodule.recurse true &&
+		git config fetch.parallel 0 &&
+		git fetch --all 2>../fetch-log
+	) &&
+	grep "Fetching submodule sub" fetch-log >fetch-subs &&
+	test_line_count = 2 fetch-subs
+'
+
 test_done
-- 
2.36.1-384-ga138d62aa5

