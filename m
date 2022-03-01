Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F993C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 02:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiCACrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiCACrT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 21:47:19 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E253BFBD
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:46:40 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D64B8196B85;
        Mon, 28 Feb 2022 21:46:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=llIN3cQSvdcvQjTa6u2pgItafm9Nd8QG+LAiln
        5uK04=; b=hTXzP3Iwqm51mpZySDOnSJkpEKU1wIoiq0/AIyyXMEnv/wUI7hUnlc
        tgd3NxhLUUGqG+5GezxFMAE/TBzyxdOXpUdKcR8zl3LIGQB0IN3ljASco599Zfaq
        bnR3PtaDB/Jerv2uBh71jrRroU5cK+45Wd9nA6jhUzNQzkWamd0vA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF470196B84;
        Mon, 28 Feb 2022 21:46:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5943F196B83;
        Mon, 28 Feb 2022 21:46:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r?= =?utf-8?Q?=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH 06/13] submodule--helper: get remote names from any
 repository
References: <20220301000816.56177-1-chooglen@google.com>
        <20220301000816.56177-7-chooglen@google.com>
Date:   Mon, 28 Feb 2022 18:46:36 -0800
In-Reply-To: <20220301000816.56177-7-chooglen@google.com> (Glen Choo's message
        of "Mon, 28 Feb 2022 16:08:09 -0800")
Message-ID: <xmqqilsywfsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D085B144-9909-11EC-9E49-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> +	struct ref_store *store = get_main_ref_store(repo);
> +	int ignore_errno;
> +	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
> +						      NULL, &ignore_errno);

Given that 00/13 says this series is based on 715d08a9 (The eighth
batch, 2022-02-25), which includes 03bdcfcc (Merge branch
'ab/no-errno-from-resolve-ref-unsafe', 2022-02-11), I think the
above two lines are result of incorrect rebasing or something.

Have you compiled after you rebased?

It seems that after applying the band-aid below, t7406 seems to fail
for two of its tests, too, but if this were not even compiled, that
is to be expected X-<.




 builtin/submodule--helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git c/builtin/submodule--helper.c w/builtin/submodule--helper.c
index ea88f39fb4..21401ad99e 100644
--- c/builtin/submodule--helper.c
+++ w/builtin/submodule--helper.c
@@ -36,9 +36,7 @@ static char *repo_get_default_remote(struct repository *repo)
 	char *dest = NULL, *ret;
 	struct strbuf sb = STRBUF_INIT;
 	struct ref_store *store = get_main_ref_store(repo);
-	int ignore_errno;
-	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
-						      NULL, &ignore_errno);
+	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL, NULL);
 
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
