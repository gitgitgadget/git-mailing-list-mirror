Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDCCC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 21:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348750AbiEPVxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 17:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbiEPVxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 17:53:06 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A729632EE2
        for <git@vger.kernel.org>; Mon, 16 May 2022 14:53:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84C661283FB;
        Mon, 16 May 2022 17:53:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vnlhBm5PqExZjmaUvwG4pvsFZngc1Q+jqsnekW
        x8zfU=; b=jJC2da3tfaHvQJpKKM7t1QIzBjSnbbDONbHGSVlhvjKxlQaCqRDogA
        C5cYE+2BxMz3ce5eVlzWtKl8QytYkBykyvVMUluX0FdWF35f8QhETHdoRET0wQE3
        FpvMvdsbVxuTjiqmLkVqn7KivYRMO1kzRnc+d3NsQ9BXc6lD8CrN8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 770DD1283FA;
        Mon, 16 May 2022 17:53:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B51011283F9;
        Mon, 16 May 2022 17:53:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Benedek Kozma <cyberbeni@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: [PATCH] fetch: do not run a redundant fetch from submodule
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
        <xmqqczgzdc1r.fsf@gitster.g>
        <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq1qxfbqtq.fsf@gitster.g>
        <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqpmkg8z58.fsf@gitster.g>
        <kl6l7d6ljrrg.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq4k1p2v40.fsf@gitster.g> <xmqqwnel1eqb.fsf@gitster.g>
Date:   Mon, 16 May 2022 14:53:02 -0700
In-Reply-To: <xmqqwnel1eqb.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        16 May 2022 12:04:12 -0700")
Message-ID: <xmqqczgd16wx.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FCB55A6-D562-11EC-94E4-CB998F0A682E-77302942!pb-smtp2.pobox.com
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

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So, here is a mixed thing that fixes the issue in two different
   ways, which makes it unsuitable to be the final patch.  Either
   "turning --all into a single fetch with optimizaiton" that is in
   the first hunk, or "don't do the final sweep unless doing a
   single fetch" that is in the second hunk, is sufficient to make
   the symptom disappear.  Of course, using them both does not break
   anything, but it somehow feels unsatisfactory, and makes readers
   feel that we should be able to do better.

   But the better thing being what Glen alluded to as "non-trivial
   not prohibitivey hard", I'll stop here.

 builtin/fetch.c                    |  6 +++++-
 t/t5617-clone-submodules-remote.sh | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed..359321e731 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2187,6 +2187,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		else if (argc > 1)
 			die(_("fetch --all does not make sense with refspecs"));
 		(void) for_each_remote(get_one_remote_for_fetch, &list);
+
+		/* no point doing fetch_multiple() of one */
+		if (list.nr == 1)
+			remote = remote_get(list.items[0].string);
 	} else if (argc == 0) {
 		/* No arguments -- use default remote */
 		remote = remote_get(NULL);
@@ -2261,7 +2265,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_multiple(&list, max_children);
 	}
 
-	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
+	if (!result && remote && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct strvec options = STRVEC_INIT;
 		int max_children = max_jobs;
 
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index ca8f80083a..8b6b482a39 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -72,6 +72,19 @@ test_expect_success 'clone with --single-branch' '
 	)
 '
 
+test_expect_success 'fetch --all with --recurse-submodules' '
+	test_when_finished "rm -fr super_clone" &&
+	git clone --recurse-submodules srv.bare super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.recurse true &&
+		git config fetch.parallel 0 &&
+		git fetch --all 2>../fetch-log
+	) &&
+	grep "Fetching sub" fetch-log >fetch-subs &&
+	test_line_count = 1 fetch-subs
+'
+
 # do basic partial clone from "srv.bare"
 # confirm partial clone was registered in the local config for super and sub.
 test_expect_success 'clone with --filter' '
-- 
2.36.1-379-g841af8e974

