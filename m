Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B88C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 07:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A8B6113D
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 07:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbhKHHNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 02:13:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63496 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbhKHHNF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 02:13:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 821FE164188;
        Mon,  8 Nov 2021 02:10:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7aJoqx2ZGVirt13ZkNBC9toJ5A257vs0E4/ZOL
        n4Q+c=; b=SIOPjuPthzLokjMmpbFfMz83xk7Hs3k13LjaZdXTpXCYrEm2cm+XBb
        rgsNBPKSHEASPc0C36YIMYgICnS16ed0Qa+zGNS56ptsvAOgLb5eg7pkhViS2Vnv
        J5lcoOCWFuU5JAInHF/Iy4pb0iX67EHyMrLD4eipwsHzcwKFiciIc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7ADB9164187;
        Mon,  8 Nov 2021 02:10:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D86E1164186;
        Mon,  8 Nov 2021 02:10:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Birk Tjelmeland <git@birktj.no>, git@vger.kernel.org
Subject: Re: [PATCH] stash: show error message when lockfile is present
References: <20211107213012.6978-1-git@birktj.no>
        <YYiXw41upJfPS7l0@nand.local>
Date:   Sun, 07 Nov 2021 23:10:17 -0800
In-Reply-To: <YYiXw41upJfPS7l0@nand.local> (Taylor Blau's message of "Sun, 7
        Nov 2021 22:21:39 -0500")
Message-ID: <xmqqlf1zunqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE342C16-4062-11EC-80E6-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I wonder if there are callers of repo_refresh_and_write_index() that
> don't want any errors reported. Not having thought about it too hard
> (much less looked through any of these callers), I would expect that
> having the choice to either error() or die() is something worth keeping.
> But I do not know if there are callers which want neither.
> ...
>>  add-interactive.c | 4 ++--
>>  add-patch.c       | 4 ++--
>>  builtin/am.c      | 2 +-
>>  builtin/merge.c   | 4 ++--
>>  builtin/stash.c   | 6 +++---
>>  cache.h           | 4 ++--
>>  read-cache.c      | 3 ++-
>>  7 files changed, 14 insertions(+), 13 deletions(-)

I think most of the changes in this patch, other than the ones to
builtin/stash.c, are unwanted, and I suspect what you wondered above
may be the same thing.  Take for example this hunk:

diff --git a/builtin/stash.c b/builtin/stash.c
index a0ccc8654d..977fcc4e40 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -501,7 +501,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	const struct object_id *bases[1];
 
 	read_cache_preload(NULL);
-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
+	if (refresh_and_write_cache(REFRESH_QUIET, 0, LOCK_REPORT_ON_ERROR, 0))
 		return -1;
 
 	if (write_cache_as_tree(&c_tree, 0, NULL))

Telling the function to be quiet and at the same time be noisy on
only one particular kind of error sounds somewhat strange.  I do not
think of any reason why we should believe that failing to lock will
be the only special kind of failure to be of interest to the users.

I would think the "fix" should look more like this:

 	read_cache_preload(NULL);
	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
- 		return -1;
+ 		return error(_("failed to refresh the index"));

That is, tell the function that the caller will do the error
reporting (i.e. "QUIET") and do so.

Thanks.
