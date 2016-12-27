Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B4A200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756140AbcL0TOF (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:14:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63677 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756119AbcL0TN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 14:13:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B91159B63;
        Tue, 27 Dec 2016 14:13:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=zrG/3O1Equ3uBwWgmFnfU9wSs9E=; b=d2pO9gNDg0VkAc0wj1rd
        OYvdjqmvOxNI3MofFqkbElqz1jbpsccqKcCvS8kNV5rK+gxIaDYnVuZSP/xCtcfN
        p1BRbpMYH8R8qMcBXer0q+TzFWYKM17taXqCfBRrHuTO864v3gXP26ZOyfVZdeRR
        hwbJO8osDP/udw1DGUdscbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=UO2KPa6JFXQUy/deQgloSXHAc+bGG8a1Tbd+N58R4uLt8q
        tWmLmtlrAKzCgI2uyOVuuqhRbZgke+ceQeCOxUBn7hqfZwFiyxNGRqxXezqPe3/g
        pf4YpHPw/J3uOBx0vXAilXagd2JQfe8FmAnNQ0QSjxAcfH65CyMo61kRdIa6c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61FE659B62;
        Tue, 27 Dec 2016 14:13:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D461559B61;
        Tue, 27 Dec 2016 14:13:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 21/21] Documentation/git-update-index: explain splitIndex.*
Date:   Tue, 27 Dec 2016 11:13:02 -0800
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-22-chriscool@tuxfamily.org>
Message-ID: <xmqq8tr19ocs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D48C618-CC68-11E6-BA7B-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>  --split-index::
>  --no-split-index::
> -	Enable or disable split index mode. If enabled, the index is
> -	split into two files, $GIT_DIR/index and $GIT_DIR/sharedindex.<SHA-1>.
> -	Changes are accumulated in $GIT_DIR/index while the shared
> -	index file contains all index entries stays unchanged. If
> -	split-index mode is already enabled and `--split-index` is
> -	given again, all changes in $GIT_DIR/index are pushed back to
> -	the shared index file. This mode is designed for very large
> -	indexes that take a significant amount of time to read or write.
> +	Enable or disable split index mode. If split-index mode is
> +	already enabled and `--split-index` is given again, all
> +	changes in $GIT_DIR/index are pushed back to the shared index
> +	file.

In the world after this series that introduced the percentage-based
auto consolidation, it smells strange, or even illogical, that index
is un-split after doing this:

    $ git update-index --split-index
    $ git update-index --split-index

Before this series, it may have been a quick and dirty way to force
consolidating the split index without totally disabling the feature,
i.e. it would have looked more like

    $ git update-index --split-index
    ... work work work to accumulate more modifications
    ... consolidate into one --- there was no other way than
    ... disabling it temporarily
    $ git update-index --no-split-index
    ... but the user likes the feature so re-enable it.
    $ git update-index --split-index

which I guess is where this strange behaviour comes from.

It may be something we need to fix to unconfuse the end-users after
this series lands.  Even though "first disable and then re-enable"
takes two commands (as opposed to one), it is far more logical.  And
the percentage-based auto consolidation feature is meant to reduce
the need for manual consolidation, so it probably makes sense to
remove this illogical feature.

> @@ -394,6 +390,31 @@ Although this bit looks similar to assume-unchanged bit, its goal is
>  different from assume-unchanged bit's. Skip-worktree also takes
>  precedence over assume-unchanged bit when both are set.
>  
> +Split index
> +-----------
> +
> +This mode is designed for very large indexes that take a significant
> +amount of time to read or write.

This is not a new problem, but it probably is incorrect to say "to
read or write".  It saves time by not rewriting the whole thing but
instead write out only the updated bits.  You'd still read the whole
thing while populating the in-core index from the disk, and if
anything, you'd probably spend _more_ cycles because you'd essentially
be reading the base and then reading the delta to apply on top.

> +To avoid deleting a shared index file that is still used, its mtime is
> +updated to the current time everytime a new split index based on the
> +shared index file is either created or read from.


The same comment on the mention of "mtime" in another patch applies
here as well.

