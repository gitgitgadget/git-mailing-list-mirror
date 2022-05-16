Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E868C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbiEPSZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiEPSZM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:25:12 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3143E31935
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:25:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5101212E1DC;
        Mon, 16 May 2022 14:25:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kKSHdlT9Y9bqKdejwzum1iEf1x04fPX0YDVFRL
        G25wc=; b=byEEWEBe3k/nMcQ6k9BiCQlAuD9NtX1njf1xG2q/+5vS0Y3Gkd2Gs+
        s1MG7z7L5MJ1/khE28C1SQSNuCY3jL7Y6gwZLTbZpY7SlfXd8zRhgqxEUSOcqS8d
        M+oiKmNnSBfWFdGr81QtsxBjFUxtA8r1HPq81lYZ/opngSlLi7mhU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA18512E1DA;
        Mon, 16 May 2022 14:25:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B520F12E1D8;
        Mon, 16 May 2022 14:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Subject: Re: Bugreport - submodules are fetched twice in some cases
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
        <xmqqczgzdc1r.fsf@gitster.g>
        <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq1qxfbqtq.fsf@gitster.g>
        <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqpmkg8z58.fsf@gitster.g>
        <kl6l7d6ljrrg.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 16 May 2022 11:25:03 -0700
In-Reply-To: <kl6l7d6ljrrg.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 16 May 2022 10:45:23 -0700")
Message-ID: <xmqq4k1p2v40.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82537C86-D545-11EC-A85B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I don't think we are in the ideal scenario because we only snapshot when
> we fetch without "--all":
>
>   cmd_fetch() > *fetch_one()* > do_fetch() > backfill_tags() >
>     fetch_and_consume_refs() > store_updated_refs() >
>     check_for_new_submodule_commits()
>
> In the ideal scenario, it would be something like:
>
>   cmd_fetch() >
>     TODO_snapshot_old_refs(), fetch_[one|multiple](),
>     TODO_register_new_refs()
>
> It looks non-trivial enough that I don't think I'll try to fix this
> soon, but it does not look prohibitively hard.

It matches my gut feeling.

>> Provided if we have the "make sure everything needed in the
>> submodule is fetched by inspecting the range of commits we fetch for
>> a superproject" working correctly for a single remote, an
>> alternative approach is to run "git fetch --recurse-submodules" for
>> each remote separately, without the "parent" process doing anything
>> in the submodule (i.e. you earlier counted R+1 fetches, but instead,
>> we make R fetches in the submodule.  It is less than ideal but it
>> may be easier to implement).
>>
>> Thoughts?
>
> The +1 fetch is redundant, so it's probably good to get rid of it
> anyway.

Sounds sensible.  It should be a single-liner, i.e.

 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/builtin/fetch.c w/builtin/fetch.c
index eeee5ac8f1..be61c390c1 100644
--- i/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -2262,7 +2262,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_multiple(&list, max_children);
 	}
 
-	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
+	if (!result && remote && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct strvec options = STRVEC_INIT;
 		int max_children = max_jobs;
 
