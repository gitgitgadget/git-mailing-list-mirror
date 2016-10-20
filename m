Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45FEF20229
	for <e@80x24.org>; Thu, 20 Oct 2016 20:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754366AbcJTULI (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 16:11:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64922 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753043AbcJTULF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 16:11:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68FF9472B1;
        Thu, 20 Oct 2016 16:11:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j6B9tFO9Iz3JnEQRHK1ERkvjBKg=; b=JV7w9k
        wVFOjJbiqeTNqJsJ0Chnbl5fOcwodRUmh4N7vTUPHeP8KozKN1yAKW7IFjWIMB9y
        hA6TBJ02zWt5yH20iquey4j++hAY+3hY61NZcpqKC81eZrV+Zna58IfBd9Mn7RTH
        5ZJE6vFYU7emNTc8uKy5niVqUP0gVojtbW7SE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UXD6FEE+hr6dxMkhHMct60k12h3H9Q5c
        ZhbCsVmv5tnrBJEJY8wR/1IFN6gxF0A9jR/BPV7EHiHNpBc4YchsaknDf5LM9ZJ3
        PDMZZ57pirloPFo62j7vO/hkGc/+51aN1eJcaZpRT3dHKfOYWe9eTBd4Ird5K/RW
        W3EQF2pj0Zk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EFF5472AF;
        Thu, 20 Oct 2016 16:11:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B22EA472AE;
        Thu, 20 Oct 2016 16:11:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 18/25] sequencer: do not try to commit when there were merge conflicts
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
        <cover.1476450940.git.johannes.schindelin@gmx.de>
        <38d5f853444f80c90713f7a6e4ef1f2382549b29.1476450940.git.johannes.schindelin@gmx.de>
Date:   Thu, 20 Oct 2016 13:11:01 -0700
In-Reply-To: <38d5f853444f80c90713f7a6e4ef1f2382549b29.1476450940.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 14 Oct 2016 15:18:31 +0200
        (CEST)")
Message-ID: <xmqqmvhyg4ru.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53C3EC9E-9701-11E6-828D-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The return value of do_recursive_merge() may be positive (indicating merge
> conflicts), or 0 (indicating success). It also may be negative, indicating
> a fatal error that requires us to abort.
>
> Now, if the return value indicates that there are merge conflicts, we
> should not try to commit those changes, of course.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index cbc3742..9ffc090 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -787,7 +787,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		res = allow;
>  		goto leave;
>  	}
> -	if (!opts->no_commit)
> +	if (!res && !opts->no_commit)
>  		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
>  				     opts, allow, opts->edit, 0, 0);

This by itself looks more like a bugfix than preparation for later
steps.  The only reason why it is not a bugfix is because there is
nothing in this function that makes res a non-zero value and reach
this if statement at this step.  We would have been caught by an 
"if (res) { ... rerere(); goto leave; }" or 
"if (allow < 0) { res = allow; goto leave; }" 
that appear before this part of the code.

So while it is not wrong per-se, I think this should be part of an
actual change that makes it possible for the control flow to reach
here with non-zero res.


