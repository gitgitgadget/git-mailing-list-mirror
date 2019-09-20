Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238981F463
	for <e@80x24.org>; Fri, 20 Sep 2019 17:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfITRPa (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 13:15:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60595 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfITRPa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 13:15:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC5542EEBC;
        Fri, 20 Sep 2019 13:15:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZU80OV6YxiyDqtdkRsCWkhPTmX8=; b=KwhTD5
        LY0KLLAsRK6Gc6sb5jluMyMHPo66SNV4UCAgjgb8OYXkXeYcoN9hDZkcMqv8z16B
        Bbq4OAJNsF4sY3bhOd7xxKtkM3e5VKnKPS62U3jy1IOwg43KPbCAx4MDbt+6DuOx
        mZATq4BedlF+zwW/qfD91me8wpWXgUAe/4nX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qBKsyLbbwPB73Tta4KNSSgCJf6oOSYe4
        cof0H8Kd8AznxISokbdPsa14eEQqu99aOPi/GyrBVWiF8jqL3VwsdXy2QLlUL2Kp
        MfM+8Nq1IdPkp4LpO6qSoKOxqXuZtBWEK3YC2oDeKIRbeQG/QXUDA0q3ZKj8R/Sm
        obINVftgXT0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C331F2EEBB;
        Fri, 20 Sep 2019 13:15:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2208D2EEBA;
        Fri, 20 Sep 2019 13:15:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2] merge-recursive: symlink's descendants not in way
References: <https://public-inbox.org/git/20190917215040.132503-1-jonathantanmy@google.com/>
        <20190918202738.57273-1-jonathantanmy@google.com>
Date:   Fri, 20 Sep 2019 10:15:25 -0700
In-Reply-To: <20190918202738.57273-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 18 Sep 2019 13:27:38 -0700")
Message-ID: <xmqqzhiyvqhe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D678BFC-DBCA-11E9-BE07-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When the working tree has:
>  - bar (directory)
>  - bar/file (file)
>  - foo (symlink to .)
>
> (note that lstat() for "foo/bar" would tell us that it is a directory)
>
> and the user merges a commit that deletes the foo symlink and instead
> contains:
>  - bar (directory, as above)
>  - bar/file (file, as above)
>  - foo (directory)
>  - foo/bar (file)
>
> the merge should happen without requiring user intervention.

Thanks.  That clears my previous confusion.  It is clear that the
desired outcome is that bar/file will be merged with itself, foo
itself will resolve to "deleted", and foo/bar will be created.

> However, this does not happen.

OK.  We notice that we need to newly create foo/bar but we
incorrectly find that there is "foo/bar" already because of the
careless use of bare lstat(2) makes "bar" visible as if it were also
"foo/bar".  I wonder if the current code would be confused the same
way if the side branch added "foo/bar/file", or the confusion would
be even worse---it is not dir_in_way() and a different codepath
would be affected, no?

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 6b812d67e3..22a12cfeba 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -764,7 +764,8 @@ static int dir_in_way(struct index_state *istate, const char *path,
>  
>  	strbuf_release(&dirpath);
>  	return check_working_copy && !lstat(path, &st) && S_ISDIR(st.st_mode) &&
> -		!(empty_ok && is_empty_dir(path));
> +		!(empty_ok && is_empty_dir(path)) &&
> +		!has_symlink_leading_path(path, strlen(path));

As the new call is fairly heavyweight compared to everything else we
are doing, I think it is very sensible to have this at the end, like
this patch does.

Nicely done.  Thanks, will queue.
