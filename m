Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EFCC1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 18:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939409AbdAISSw (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 13:18:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55947 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S939374AbdAISSv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 13:18:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4541A5D0A6;
        Mon,  9 Jan 2017 13:18:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Il7EWbnPqLUqxuiov7kT7YQvgkM=; b=e8Ldel
        Lcb6hfVTyTd/J5txFl5FmKpw787mn4o7eRpBkKDCxJUpx1mujQ3VTQPHR2zC6qAC
        Pr93ONyW+nomelvsDfG0GUfJcIji2MU/EjxhBhFeKITZtK9uH6iTaUQPM2S8OyVW
        6GRprje/aRtqPPfCxKLqNf+QIHeVOriaYUQHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lr5qPQ47AaGbQPBk93j0wiDioRnNuIEQ
        8SDfrqXsSQa8x81prZ+3sua3vcO8D219c60K2ADjdzehxlM3jpG1Ra9SAr6Z5u4k
        iTLxq96f1G4Rs1Qu/+DqCeC1y1BtqrwIgQ51o24mi0HUmCVd7m+fFBnpM/96so+T
        Bxg0Jm4dLxs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BE015D0A5;
        Mon,  9 Jan 2017 13:18:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 769015D0A3;
        Mon,  9 Jan 2017 13:18:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v5 0/5] road to reentrant real_path
References: <20170103190923.11882-1-bmwill@google.com>
        <20170104220124.145808-1-bmwill@google.com>
        <xmqqpojy1c49.fsf@gitster.mtv.corp.google.com>
        <20170109180418.GB62878@google.com>
Date:   Mon, 09 Jan 2017 10:18:46 -0800
In-Reply-To: <20170109180418.GB62878@google.com> (Brandon Williams's message
        of "Mon, 9 Jan 2017 10:04:18 -0800")
Message-ID: <xmqqzij0t7uh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1156E682-D698-11E6-927A-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> How does this relate to the 5-patch real_path: series that has been
>> on 'next' since last year?
>
> The only difference should be in the first patch of the series which
> handles the #define a bit differently due to the discussion that
> happened last week.
>
> Here is the interdiff between v5 and 'origin/bw/realpath-wo-chdir':

Then can you make that an incremental patch (or two) with its own
log message instead?  It (or they) would look and smell like a
bugfix patch that follows up a change that has already landed.  As
you know, we won't eject and replace patches that are already in
'next' during a development cycle.

Thanks.

>
> diff --git a/abspath.c b/abspath.c
> index 1d56f5ed9..fce40fddc 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -62,7 +62,9 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
>  }
>  
>  /* We allow "recursive" symbolic links. Only within reason, though. */
> -#define MAXSYMLINKS 5
> +#ifndef MAXSYMLINKS
> +#define MAXSYMLINKS 32
> +#endif
>  
>  /*
>   * Return the real path (i.e., absolute path, with symlinks resolved
> @@ -139,6 +141,8 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  			strbuf_reset(&symlink);
>  
>  			if (num_symlinks++ > MAXSYMLINKS) {
> +				errno = ELOOP;
> +
>  				if (die_on_error)
>  					die("More than %d nested symlinks "
>  					    "on path '%s'", MAXSYMLINKS, path);
