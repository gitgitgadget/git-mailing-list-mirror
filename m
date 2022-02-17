Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60358C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 22:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbiBQWQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:16:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiBQWQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 17:16:52 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A11165C32
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:16:36 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 666681871DF;
        Thu, 17 Feb 2022 17:16:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CESjKiLbCfTbEHVO9qfh+IHNw9SdBV2aPRrDz+
        UQK2M=; b=QZONGdCFLQW/i8FxMPwI6OQcBq/eKfrN+Hdb8uE7v4+7FQUtuTi8lT
        t+JZWsSFR6C7p+tpmtSDbcdovFGBSe+YWfVyAnlI80oecLZcy/mY2bN/3WmnadD6
        cEtV/b2JJoXjGHle1l5t61PL6D4IHMlPR9ZrZUVl6lC0p7lLsPDbI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E8081871DE;
        Thu, 17 Feb 2022 17:16:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CAA191871DB;
        Thu, 17 Feb 2022 17:16:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/7] fetch: report errors when backfilling tags fails
References: <cover.1645102965.git.ps@pks.im>
        <bc1e396ae0ad380dffd7962cc223cc63e6facffe.1645102965.git.ps@pks.im>
Date:   Thu, 17 Feb 2022 14:16:32 -0800
In-Reply-To: <bc1e396ae0ad380dffd7962cc223cc63e6facffe.1645102965.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 17 Feb 2022 14:04:28 +0100")
Message-ID: <xmqqo8356svz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43EACE36-903F-11EC-950D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +static int backfill_tags(struct transport *transport,
> ...
>  }

The change to this function is quite straight-forward.

>  static int do_fetch(struct transport *transport,
> @@ -1632,8 +1634,16 @@ static int do_fetch(struct transport *transport,
>  		struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
>  
>  		find_non_local_tags(remote_refs, &tags_ref_map, &tail);
> -		if (tags_ref_map)
> -			backfill_tags(transport, tags_ref_map, &fetch_head, worktrees);
> +		if (tags_ref_map) {
> +			/*
> +			 * If backfilling of tags fails then we want to tell
> +			 * the user so, but we have to continue regardless to
> +			 * populate upstream information of the references we
> +			 * have already fetched above.
> +			 */

OK.  Unless atomic, using the available information on successfully
updated ones would be fine.  Perhaps under --atomic mode, a failure
to commit the ref transaction will also prevent the upstream
information from getting updated?  We'll see soon enough.

> +			if (backfill_tags(transport, tags_ref_map, &fetch_head, worktrees))
> +				retcode = 1;
> +		}

>  		free_refs(tags_ref_map);
>  	}
> diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
> index 6ffe2a5719..c057c49e80 100755
> --- a/t/t5503-tagfollow.sh
> +++ b/t/t5503-tagfollow.sh
> @@ -233,9 +233,7 @@ test_expect_success 'backfill failure causes command to fail' '
>  		done
>  	EOF
>  
> -	# Even though we fail to create refs/tags/tag1 the below command
> -	# unexpectedly succeeds.
> -	git -C clone5 fetch .. $B:refs/heads/something &&
> +	test_must_fail git -C clone5 fetch .. $B:refs/heads/something &&

OK.

>  	test $B = $(git -C clone5 rev-parse --verify refs/heads/something) &&
>  	test $S = $(git -C clone5 rev-parse --verify tag2) &&
>  	test_must_fail git -C clone5 rev-parse --verify tag1
