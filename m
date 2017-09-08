Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB6720286
	for <e@80x24.org>; Fri,  8 Sep 2017 01:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbdIHBfT (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 21:35:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64442 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751973AbdIHBfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 21:35:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ACF6193D83;
        Thu,  7 Sep 2017 21:35:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bf9ZeyJw9AtwudDt0+FXzzaKafs=; b=bL90kU
        3O/hKh1JQReboijXRKfJdTTD26ct0+K9jeiY99VuKnMImqkOGgny4kD5sEM/E1qS
        K95N5MLWs8Sy92P9MZNrzLoo9IikNCMyaRLxXMDgZl3WW2tNinHYDU/fOjrdDOru
        I3M77Yp3WASDM/K5uquWAyIFAwq8qYsZeOra0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=asFkaoSsTf/VFptukRahtOehqa6WmOLu
        KWw/tb4GoGB38Pv7Cpq3zPdz0L0F/xpYBuXoHw6Dx5s746ViocvcNMnF5GvJra8A
        /TAhNbXJ815Hk6GLCL1gHcdf9ry7duYfpP8LX+FwT9sEv3biKW6s2/1fgqrt0Ws8
        At/DFhVeeNc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9932693D81;
        Thu,  7 Sep 2017 21:35:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE2B793D7F;
        Thu,  7 Sep 2017 21:35:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ross Kabus <rkabus@aerotech.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit-tree: don't append a newline with -F
References: <20170907144111.7488-1-rkabus@aerotech.com>
Date:   Fri, 08 Sep 2017 10:35:15 +0900
In-Reply-To: <20170907144111.7488-1-rkabus@aerotech.com> (Ross Kabus's message
        of "Thu, 7 Sep 2017 10:41:11 -0400")
Message-ID: <xmqqa8260y7g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7D09044-9435-11E7-A3EC-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ross Kabus <rkabus@aerotech.com> writes:

> This change makes it such that commit-tree -F never appends a newline
> character to the supplied commit message (either from file or stdin).
>
> Previously, commit-tree -F would always append a newline character to
> the text brought in from file or stdin.

This is not correct.  The command adds a missing newline only when
the input ended in an incompete line.

I'd rephrase the whole thing like this:

    commit-tree: do not complete line in -F input

    "git commit-tree -F <file>", unlike "cat <file> | git
    commit-tree" (i.e. feeding the same contents from the standard
    input), added a missing final newline when the input ended in an
    incomplete line.

    Correct this inconsistency by leaving the incomplete line as-is,
    as erring on the side of not touching the input is preferrable
    and expected for a plumbing command like "commit-tree".

if I were doing this patch.

Thanks.

> Signed-off-by: Ross Kabus <rkabus@aerotech.com>
> ---
>  builtin/commit-tree.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
> index 19e898fa4..2177251e2 100644
> --- a/builtin/commit-tree.c
> +++ b/builtin/commit-tree.c
> @@ -102,7 +102,6 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
>  			if (fd && close(fd))
>  				die_errno("git commit-tree: failed to close '%s'",
>  					  argv[i]);
> -			strbuf_complete_line(&buffer);
>  			continue;
>  		}
