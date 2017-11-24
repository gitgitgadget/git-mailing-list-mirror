Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F91A20954
	for <e@80x24.org>; Fri, 24 Nov 2017 06:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbdKXGrE (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 01:47:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50978 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751730AbdKXGrD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 01:47:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6CD7ACDFA;
        Fri, 24 Nov 2017 01:47:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MmkkCmHmPu5lBZVWPpYONvZgnT0=; b=udiLde
        dEa4wy1+1TdtXOQCdzbnlQ2E5YeDEVnHos018/ulosVv5WI3jj6pOdffVp0AWrGg
        QG35VFerff+ygrf+uhI96t+GEbTF5eYns7ftuIFMmx/aQAeegKD6E+E7e3KnskGc
        4qOeo1LrchV/OhtjdmmOeX1nxdaApUwM/YJFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m5hV28eO+2sFMtRO7t3fAhMchD9A1OXr
        YKI6uk7Yl0prow2wz7y+OkzSpcXNIeC82vSjLHZ6u8XlDBJanqPqVzTD/ySRR++w
        oFEGtsx3R68FRkfhSfRtTS5B7uD8/GhxUXbKy1xU1TzhKbCwL2y4yrCqIw/l65Nf
        8WBIsP6VzsM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9D0FACDF9;
        Fri, 24 Nov 2017 01:47:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CE56ACDF6;
        Fri, 24 Nov 2017 01:47:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/4] checkout: factor out functions to new lib file
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
        <20171122223020.2780-1-t.gummerer@gmail.com>
        <20171122223020.2780-2-t.gummerer@gmail.com>
Date:   Fri, 24 Nov 2017 15:47:01 +0900
In-Reply-To: <20171122223020.2780-2-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Wed, 22 Nov 2017 22:30:17 +0000")
Message-ID: <xmqqfu94npga.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46E9445C-D0E3-11E7-918A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Factor the functions out, so they can be re-used from other places.  In
> particular these functions will be re-used in builtin/worktree.c to make
> git worktree add dwim more.
>
> While there add some docs to the function.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  Makefile           |  1 +
>  builtin/checkout.c | 41 +----------------------------------------
>  checkout.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
>  checkout.h         | 13 +++++++++++++
>  4 files changed, 57 insertions(+), 40 deletions(-)
>  create mode 100644 checkout.c
>  create mode 100644 checkout.h
>
> diff --git a/Makefile b/Makefile
> index cd75985991..8d603c7443 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -757,6 +757,7 @@ LIB_OBJS += branch.o
>  LIB_OBJS += bulk-checkin.o
>  LIB_OBJS += bundle.o
>  LIB_OBJS += cache-tree.o
> +LIB_OBJS += checkout.o
>  LIB_OBJS += color.o
>  LIB_OBJS += column.o
>  LIB_OBJS += combine-diff.o
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index fc4f8fd2ea..9e1cfd10b3 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1,5 +1,6 @@
>  #include "builtin.h"
>  #include "config.h"
> +#include "checkout.h"
>  #include "lockfile.h"
>  #include "parse-options.h"
>  #include "refs.h"

With this, and also ...

> diff --git a/checkout.c b/checkout.c
> new file mode 100644
> index 0000000000..b0c744d37a
> --- /dev/null
> +++ b/checkout.c
> @@ -0,0 +1,42 @@
> +#include "cache.h"
> +#include "remote.h"

... with this, I sort of expected that builtin/checkout.c no longer
has to include "remote.h" but can now rely on the common helpers in
this new file to perform anything remote-related operation.  But it
seems that it is not the case (yet).

Just recording my observation for future reference, as we might also
want to move report_tracking(), etc., to this new file in the future.
