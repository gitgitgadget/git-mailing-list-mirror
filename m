Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4D21F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 22:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfHPWRY (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 18:17:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54638 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfHPWRX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 18:17:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF44A1510C4;
        Fri, 16 Aug 2019 18:17:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p1aNIdvklRfUjN3IbDneBvMT4F0=; b=psppFO
        FquUABjl5zExAK/NEogzxvBN/yLcIcF/eCUxOaskfL6jhy1GAnZMJYXCrUGKQQv8
        tnnHnauKOZmxB5cQIvm4vXgCVcycQmvrG1//7qxxsd06z++KFjofuqaZqf7nfqEO
        gJLmqlBZMHOu9Hn66DgTfWc6XSCEO3blhurFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hf1/5/fzo7XfK8hlDrozdbnIBWC2hij6
        4ojnK+VOCI8hK9FFXttd2F5EgTHixbqtt8nGjFEwKa9Tg0FAKJf6GJKDClASwT+S
        nNwx3L8y1llkqkfi0WxEFgf4bHAsHcaB16285Y+/2jjQmnoGZy+TAMgX9Voh8PIN
        78jAK13g6jU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A719F1510C3;
        Fri, 16 Aug 2019 18:17:21 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DEED1510C0;
        Fri, 16 Aug 2019 18:17:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 21/24] merge-recursive: split internal fields into a separate struct
References: <20190726155258.28561-1-newren@gmail.com>
        <20190815214053.16594-1-newren@gmail.com>
        <20190815214053.16594-22-newren@gmail.com>
Date:   Fri, 16 Aug 2019 15:17:20 -0700
In-Reply-To: <20190815214053.16594-22-newren@gmail.com> (Elijah Newren's
        message of "Thu, 15 Aug 2019 14:40:50 -0700")
Message-ID: <xmqqblwozrf3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DAE1A02-C073-11E9-901F-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> merge_options has several internal fields that should not be set or read
> by external callers.  This just complicates the API.  Move them into an
> opaque merge_options_internal struct that is defined only in
> merge-recursive.c and keep these out of merge-recursive.h.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 186 ++++++++++++++++++++++++----------------------
>  merge-recursive.h |  17 ++---
>  2 files changed, 106 insertions(+), 97 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index b4334d0506..840b09f1dc 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3617,17 +3627,21 @@ static int merge_start(struct merge_options *opt, struct tree *he> ...
> -				       opt->needed_rename_limit, 0);
> +				       opt->priv->needed_rename_limit, 0);
> +	free(opt->priv);
> +	opt->priv = NULL;

This gets hit by Cocci.
