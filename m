Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559FCEEAA78
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 22:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjINWAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINWAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 18:00:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86591BFA
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 15:00:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11A2B1C6E91;
        Thu, 14 Sep 2023 18:00:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=VINde1x+0IrcBYfdJFc8HGbVFUOACBjs+PYcv6
        UDLZw=; b=hFu1DvD57p1spDaFbX4vZ/pX+sAPoXRfWf9Dao66wp1eBRbA2wGBwi
        z7/q4HS+i6Rj9aOWioeKZAR2HqruInhe5nX/UGyJ2khKZhyJ+xtTsB9rmkRl0HDU
        LMWSVwHspZWM1giNeVmYoJ2ewixgOSI/bFHZaILrTBbL07voYlkbU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0766F1C6E90;
        Thu, 14 Sep 2023 18:00:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FCC11C6E8F;
        Thu, 14 Sep 2023 18:00:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Josip Sokcevic <sokcevic@google.com>
Subject: Re: [PATCH] cache: add fake_lstat()
In-Reply-To: <xmqqcyykig1l.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        14 Sep 2023 14:46:46 -0700")
References: <xmqqcyykig1l.fsf@gitster.g>
Date:   Thu, 14 Sep 2023 15:00:43 -0700
Message-ID: <xmqqr0n0h0tw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 271F9ABE-534A-11EE-8E3C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And your diff-lib change may look like this on top.  This one
unfortunately is completely untested, as I do not use macOS.

Reviewing, testing, and improving it is highly appreciated.

----- >8 ---------- >8 ---------- >8 -----
Subject: diff-lib: fix check_removed() when fsmonitor is active

`git diff-index` may return incorrect deleted entries when fsmonitor
is used in a repository with git submodules. This can be observed on
Mac machines, but it can affect all other supported platforms too.

If fsmonitor is used, `stat *st` is left uninitialied if cache_entry
has CE_FSMONITOR_VALID bit set.  But, there are three call sites
that rely on stat afterwards, which can result in incorrect results.

We can fill members of "struct stat" that matters well enough using
the information we have in "struct cache_entry" that fsmonitor told
us is up-to-date to solve this.

Helped-by: Josip Sokcevic <sokcevic@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c                   | 9 ++++++++-
 t/t7527-builtin-fsmonitor.sh | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git c/diff-lib.c w/diff-lib.c
index d8aa777a73..7799747a97 100644
--- c/diff-lib.c
+++ w/diff-lib.c
@@ -38,8 +38,15 @@
  */
 static int check_removed(const struct index_state *istate, const struct cache_entry *ce, struct stat *st)
 {
+	int stat_err;
+
 	assert(is_fsmonitor_refreshed(istate));
-	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
+
+	if (!(ce->ce_flags & CE_FSMONITOR_VALID))
+		stat_err = lstat(ce->name, st);
+	else
+		stat_err = fake_lstat(ce, st);
+	if (stat_err < 0) {
 		if (!is_missing_file_error(errno))
 			return -1;
 		return 1;
diff --git c/t/t7527-builtin-fsmonitor.sh w/t/t7527-builtin-fsmonitor.sh
index 0c241d6c14..78503158fd 100755
--- c/t/t7527-builtin-fsmonitor.sh
+++ w/t/t7527-builtin-fsmonitor.sh
@@ -809,6 +809,11 @@ my_match_and_clean () {
 		status --porcelain=v2 >actual.without &&
 	test_cmp actual.with actual.without &&
 
+	git -C super --no-optional-locks diff-index --name-status HEAD >actual.with &&
+	git -C super --no-optional-locks -c core.fsmonitor=false \
+		diff-index --name-status HEAD >actual.without &&
+	test_cmp actual.with actual.without &&
+
 	git -C super/dir_1/dir_2/sub reset --hard &&
 	git -C super/dir_1/dir_2/sub clean -d -f
 }
