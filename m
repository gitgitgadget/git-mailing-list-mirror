Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7FBC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE03D2220B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgLGHpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 02:45:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56703 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGHpl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 02:45:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABCFB8514A;
        Mon,  7 Dec 2020 02:44:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RhnicbKwz8SLNmbaje+K1ETh0mc=; b=iR//hW
        0qwIf0vdexWiDSbuztBRSLK5ymbgM1K1mxrwXkXT/6V/VXyf6NrVPF1pv6GnqYMz
        E6u7mw9dajRHaV/xhIZYvwKLr+suZkOwzrAY7iVe/gSS1ipOd1flKQHyjf5MEm3z
        ZEx77V5NHBulDEmaP2cQjJKAe+dE64w6l9I6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DlbKvXDqIAfYf+zlWJV4WSA+K1gQuLMv
        +EC8FVNwhOitgxCXSFOsrqoy1dgeqMm++r/edIwzfNkD4i8Yhp40aQyI/G/L2ImH
        3CPmTKlvRYV4zMpBgIrfhvr5ARO6JiBr2JSqscVaeG4fGv69dRW6WSSmw1p7PX+f
        QU9gYUjH98k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A34F785149;
        Mon,  7 Dec 2020 02:44:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D86B85148;
        Mon,  7 Dec 2020 02:44:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] Documentation/Makefile: conditionally include
 doc.dep
References: <a8e1bc9d-ce6c-d065-5a20-fee15967364d@ramsayjones.plus.com>
Date:   Sun, 06 Dec 2020 23:44:58 -0800
In-Reply-To: <a8e1bc9d-ce6c-d065-5a20-fee15967364d@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 7 Dec 2020 00:31:43 +0000")
Message-ID: <xmqq360icb5x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B5CB00C-3860-11EB-A29F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Notice that, since the 'doc.dep' file does not exist, make takes the
> time (about 8s) to generate several files in order to create the doc.dep
> include file. (If an 'include' file is missing, but a target for the
> said file is present in the Makefile, make will execute that target
> and, if that file now exists, throw away all its internal data and
> re-read and re-parse the Makefile). Having spent the time to include
> the 'doc.dep' file, the 'clean' target immediately deletes those files.
>
> In order to eliminate such wasted effort, use the value of the internal
> $(MAKECMDGOALS) variable to only '-include doc.dep' when the target is
> not 'clean'. (This drops the time down to 12.364s, on my laptop, giving
> an improvement of 47.02%).

Nicely explained.  It might be worth saying

    ... the clean target immediately deletes those files.  The rules
    and definitions of doc.dep however does not affect what 'clean'
    target removes otherwise, so we can do without all this.

The last paragraph made me wonder what should happen for 'distclean'
etc., but luckily there is only 'clean' in Documentation/Makefile ;-)

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  Documentation/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 80d1908a44..652d57a1b6 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -286,7 +286,9 @@ doc.dep : $(docdep_prereqs) $(wildcard *.txt) $(wildcard config/*.txt) build-doc
>  	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
>  	mv $@+ $@
>  
> +ifneq ($(MAKECMDGOALS),clean)
>  -include doc.dep
> +endif
>  
>  cmds_txt = cmds-ancillaryinterrogators.txt \
>  	cmds-ancillarymanipulators.txt \
