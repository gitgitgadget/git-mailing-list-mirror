Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A68DC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DF123444
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbhATUhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 15:37:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56460 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733052AbhATU1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 15:27:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B13A94B81;
        Wed, 20 Jan 2021 15:26:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=RRrnxYo6kF1ME1KyXTu1yPYC6Sc=; b=fsuu7XJshbTrH5KE1332
        ypKjY5mle5tNY9eDzDmvLRBDZeUwrN1UdX/Gs4psaM/kS9ACWHtSENBp5N0cRiEh
        ovVzWATmnzh6yQMswXsb+QfuWV7H3//2awqwdUqgFn4XWMj2vE+TOo2EjCXEn5c4
        PfRs6hqcU5Mu1lacnedr/v8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=CjvRKCcnloa/mPSPmOheR4ae9VN06jBThWz6nQB428oiUZ
        z70bV3c5HdfaDRIUq0sdpK2gZGrJCpSQspvRFSjIVIYAeGxuOfIywYQk/91kNKWx
        cEYt4Ck6GEo8iQa2UIC+t/P0f6KR4j/+l61hb5obmhfi6e4FiFvDlt/3SMF2M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31C4A94B80;
        Wed, 20 Jan 2021 15:26:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9939994B7F;
        Wed, 20 Jan 2021 15:26:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Subject: Re: [PATCH v5 1/3] ls_files.c: bugfix for --deleted and --modified
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <ec9464f6094f111bc7b6dc1dc07ecc9997d366d4.1611037846.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 12:26:21 -0800
Message-ID: <xmqqlfcnfj82.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2FDA562-5B5D-11EB-87FE-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> This situation may occur in the original code: lstat() failed
> but we use `&st` to feed ie_modified() later.
>
> Therefore, we can directly execute show_ce without the judgment of
> ie_modified() when lstat() has failed.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---

Thanks.  A few comments:

 * The error_errno() line is not indented correctly; I'll fix it up
   while queuing, but it would conflict with 2/3 as you'll be moving
   that line around.

 * When we say "error", we do not even know if the thing got removed
   or modified at all, so it is somewhat strange to report it as
   such (the path may be intact and the only issue may be that we
   cannot read the containing directory).  It is equally strange not
   to say anything on the path, and between the two, there isn't
   clearly a more correct answer.  What you implemented here does
   not change the traditional behaviour of reporting it as
   deleted/modified to "alert" the user, which I think is good.

 * The logic for modified entry looks a bit duplicated.  I wonder if
   the one at the end of this message reads better.  Renaming err to
   stat_err is optional, but I think the name makes it clear why it
   is sensible that these two places use the variable as a sign that
   the path was deleted and/or modified.

>  			err = lstat(fullname.buf, &st);
> +			if (err) {
> +				if (errno != ENOENT && errno != ENOTDIR)
> +				    error_errno("cannot lstat '%s'", fullname.buf);
> +				if (show_deleted)
> +					show_ce(repo, dir, ce, fullname.buf, tag_removed);
> +				if (show_modified)
> +					show_ce(repo, dir, ce, fullname.buf, tag_modified);
> +			} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
>  				show_ce(repo, dir, ce, fullname.buf, tag_modified);


			stat_err = lstat(...);
			if (stat_err && (errno != ENOENT && errno != ENOTDIR))
				error_errno("cannot lstat '%s'", fullname.buf);

			if (show_deleted && stat_err)
				show_ce(..., tag_removed);
			if (show_modified &&
			    (stat_err || ie_modified(..., &st, 0)))
				show_ce(..., tag_modified);

