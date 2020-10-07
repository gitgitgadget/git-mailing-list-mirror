Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DD9C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFC82173E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hAEaPL3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgJGSup (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:50:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63806 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJGSup (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 14:50:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8B767F229;
        Wed,  7 Oct 2020 14:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Pd5JZtjhVzfQ87I54RqJKHmRE0=; b=hAEaPL
        3VN5dXU1PFp3lwnU51qGgOTgPOsZt77v6Orwhrk8zEHeNiTRL/kRxFZ1T2TLZX+u
        9I525Gh6NoHxXiY69oKX358tSqGXfof0bxqYamy2ZRWHxoFFF3w7LTimHZ6KWEoV
        J/jKe7IzD+PQo+NZ4U4POTzkgBsoSV78xBHy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HYVrYO9XUQtX10SlEFo2d1f+EAH75O3/
        fs+iXevT0Tv5bmc51Acx+fv/zWGIMuassKNLTIdICrgYhA1JeMf0FDLZlb1TVGa/
        WuOe6irPh7dgDm7C4fMjzPImLyNLHmkkx+CBzm91kPF8CEXlxTyjRP3VgB7ML888
        HSnog5UNNI0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF91C7F228;
        Wed,  7 Oct 2020 14:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65EE77F226;
        Wed,  7 Oct 2020 14:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] index-pack: restore "resolving deltas" progress meter
References: <20201007181708.GA222564@coredump.intra.peff.net>
        <20201007181923.GA1976631@coredump.intra.peff.net>
Date:   Wed, 07 Oct 2020 11:50:41 -0700
In-Reply-To: <20201007181923.GA1976631@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 7 Oct 2020 14:19:23 -0400")
Message-ID: <xmqqlfgh27lq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 002F7330-08CE-11EB-AB5B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit f08cbf60fe (index-pack: make quantum of work smaller, 2020-09-08)
> refactored the main loop in threaded_second_pass(), but also deleted the
> call to display_progress() at the top of the loop. This means that users
> typically see no progress at all during the delta resolution phase (and
> for large repositories, Git appears to hang).
>
> This looks like an accident that was unrelated to the intended change of
> that commit, since we continue to update nr_resolved_deltas in
> resolve_delta(). Let's restore the call to get that progress back.
>
> We'll also add a test that confirms we generate the expected progress.
> This isn't perfect, as it wouldn't catch a bug where progress was
> delayed to the end. That was probably possible to trigger when receiving
> a thin pack, because we'd eventually call display_progress() from
> fix_unresolved_deltas(), but only once after doing all the work.
> However, since our test case generates a complete pack, it reliably
> demonstrates this particular bug and its fix. And we can't do better
> without making the test racy.
>
> Signed-off-by: Jeff King <peff@peff.net>

Thanks.  Queued with Ack from jtan.

> ---
>  builtin/index-pack.c  | 4 ++++
>  t/t5302-pack-index.sh | 7 +++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 8da4031e72..0f05533902 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1028,6 +1028,10 @@ static void *threaded_second_pass(void *data)
>  		struct object_entry *child_obj;
>  		struct base_data *child;
>  
> +		counter_lock();
> +		display_progress(progress, nr_resolved_deltas);
> +		counter_unlock();
> +
>  		work_lock();
>  		if (list_empty(&work_head)) {
>  			/*
> diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> index c92e553a2f..7c9d687367 100755
> --- a/t/t5302-pack-index.sh
> +++ b/t/t5302-pack-index.sh
> @@ -277,4 +277,11 @@ test_expect_success 'index-pack --fsck-objects also warns upon missing tagger in
>  	grep "^warning:.* expected .tagger. line" err
>  '
>  
> +test_expect_success 'index-pack -v --stdin produces progress for both phases' '
> +	pack=$(git pack-objects --all pack </dev/null) &&
> +	GIT_PROGRESS_DELAY=0 git index-pack -v --stdin <pack-$pack.pack 2>err &&
> +	test_i18ngrep "Receiving objects" err &&
> +	test_i18ngrep "Resolving deltas" err
> +'
> +
>  test_done
