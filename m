Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEBCEED622
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 18:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbjIOS4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbjIOSzc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 14:55:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89ECB3
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:54:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8806A1A008B;
        Fri, 15 Sep 2023 14:54:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=+n/rSg40oqSQ7O8dqcJBf+2bVNvI/s30kf+I/z
        5LwzI=; b=bvQuU682XlITOJhos9rDF8d9oEEDp6nqLUuLCEtaC9trOfhV3axjHr
        f40+Nold3pl998Lw2/MGDaac2de1ddPtwX/SWl2BZRMbyUPsTgoS0TC1qO/8Cdyc
        /kq4yMAm8aB3/2Ew0k50tPNLfIlfuHWm0ApACueLr2qnx1egS5/TY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 812991A008A;
        Fri, 15 Sep 2023 14:54:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F331A1A0087;
        Fri, 15 Sep 2023 14:54:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v3] revision: add `--ignore-missing-links` user option
In-Reply-To: <20230915083415.263187-1-knayak@gitlab.com> (Karthik Nayak's
        message of "Fri, 15 Sep 2023 10:34:15 +0200")
References: <20230912155820.136111-1-karthik.188@gmail.com>
        <20230915083415.263187-1-knayak@gitlab.com>
Date:   Fri, 15 Sep 2023 11:54:09 -0700
Message-ID: <xmqqfs3fe08e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41BFD55A-53F9-11EE-9254-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The revision backend is used by multiple porcelain commands such as
> git-rev-list(1) and git-log(1). The backend currently supports ignoring
> missing links by setting the `ignore_missing_links` bit. This allows the
> revision walk to skip any objects links which are missing. Expose this
> bit via an `--ignore-missing-links` user option.

Given the above "we merely surface a feature that already exists and
supported to be used by the end users from the command line" claim ...

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index ff715d6918..5239d83c76 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -266,7 +266,8 @@ static int finish_object(struct object *obj, const char *name UNUSED,
>  {
>  	struct rev_list_info *info = cb_data;
>  	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
> -		finish_object__ma(obj);
> +		if (!info->revs->ignore_missing_links)
> +			finish_object__ma(obj);
>  		return 1;
>  	}

... this hunk is a bit unexpected.  As a low-level plumbing command,
shouldn't it be left to the user who gives --ignore-missing-links
from their command line to specify how the missing "obj" here should
be dealt with by giving the "--missing=<foo>" option?  While giving
"allow-promisor" may not make much sense, "--missing=allow-any" may
of course make sense (it is the same as hardcoding the decision not
to call finish_object__ma() at all), and so may "--missing=print".

Stepping back a bit, with "--missing=print", is this change still
needed?  The missing objects discovered will be shown at the end,
with the setting, no?

Thanks.

