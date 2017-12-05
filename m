Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF11C20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 19:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbdLETTH (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 14:19:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53883 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751066AbdLETTG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 14:19:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36942B620F;
        Tue,  5 Dec 2017 14:19:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+WJHlB16gAKASfXTebgo2LH3oso=; b=ZKNUBz
        TkkIJGkN66PeYqH3kMGeIlPDzKfb4C4PmOcMmeek7WEJboigkCKBv/U+Pa+mG2Dw
        QJt1nlipvsgOEdfCkkhPBKoN/Dl2IDo1X/MYcL1zpkWCNIiys5he1pYvBgzDzhDi
        J5W/JO3rzvAYSe1JUdZhrJ5pjStGkoHPkXxJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x0tSyJufZfX9Ydn/rHh93aM3ap4iRgVu
        aBDUQcCQ005CL7+7UGjlaFJRunzxmL5/ycHntWRlbTDmB06BEDEQF4yG/rf+saW7
        B2GXhk/NvV6Qtfjy/dHbbuShB6ggHkAi8pt/nbwu+neUGQTmqtcPoILJJWscuScc
        iEfhmfJXxx0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C394B620D;
        Tue,  5 Dec 2017 14:19:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95C95B620B;
        Tue,  5 Dec 2017 14:19:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] pathspec: only match across submodule boundaries when requested
References: <20171128232237.54453-1-bmwill@google.com>
        <20171205000734.69530-1-bmwill@google.com>
Date:   Tue, 05 Dec 2017 11:19:04 -0800
In-Reply-To: <20171205000734.69530-1-bmwill@google.com> (Brandon Williams's
        message of "Mon, 4 Dec 2017 16:07:34 -0800")
Message-ID: <xmqqo9ndhtjr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28FFDFF2-D9F1-11E7-89CC-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Commit 74ed43711fd (grep: enable recurse-submodules to work on <tree>
> objects, 2016-12-16) taught 'tree_entry_interesting()' to be able to
> match across submodule boundaries in the presence of wildcards.  This is
> done by performing literal matching up to the first wildcard and then
> punting to the submodule itself to perform more accurate pattern
> matching.  Instead of introducing a new flag to request this behavior,
> commit 74ed43711fd overloaded the already existing 'recursive' flag in
> 'struct pathspec' to request this behavior.
>
> This leads to a bug where whenever any other caller has the 'recursive'
> flag set as well as a pathspec with wildcards that all submodules will
> be indicated as matches.  One simple example of this is:
>
> 	git init repo
> 	cd repo
>
> 	git init submodule
> 	git -C submodule commit -m initial --allow-empty
>
> 	touch "[bracket]"
> 	git add "[bracket]"
> 	git commit -m bracket
> 	git add submodule
> 	git commit -m submodule
>
> 	git rev-list HEAD -- "[bracket]"
>
> Fix this by introducing the new flag 'recurse_submodules' in 'struct
> pathspec' and using this flag to determine if matches should be allowed
> to cross submodule boundaries.

Makes sense.

I initially misread the title

    "pathspec: only match across submodule boundaries when requested"

to be saying that the match happens only at the boundary, but that
"only" is not about where the match happens.

    "pathspec: match across submodule boundaries only when requested"

would have avoided such a confusion.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 5a6cfe6b4..3ca4ac80d 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1015,6 +1015,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		       prefix, argv + i);
>  	pathspec.max_depth = opt.max_depth;
>  	pathspec.recursive = 1;
> +	pathspec.recurse_submodules = !!recurse_submodules;

With the current code, recurse_submodules can only be 0 or 1 (the
only assignment is from the return value of git_config_bool()), so
the force-boolean !! is not strictly needed, but it may be a good
future-proofing measure.

Will queue; thanks.
