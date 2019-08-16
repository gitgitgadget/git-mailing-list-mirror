Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5EB91F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 16:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfHPQvp (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 12:51:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62427 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfHPQvo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA83C7CDE1;
        Fri, 16 Aug 2019 12:51:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4fq7E6RFAxpHIso8A19hAdXdIr4=; b=q6NL0q
        ZGcVsl6W/5Db/miNciXoprzuLmKEUFIpfKL+T2ck0QCbljG1ECnR0MCPbFsEz3bd
        RrR8divCul15AeWgjfzwvSTHf/ifzSnofGYByssps80+zf8qAizxs1o9BtlT8GOg
        BEk+uzU4BKmuDJkhmQGrmAbup6nZghDhpRmS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dPANAFV6UHaseC30uVwNpr6XPJQxikMV
        naTr9jONbJxyr7X3e/PP76RiZCEIwjJpoXDWIgAG3SagDKGWMp/3Byg0lTXzoqSy
        5Rzh+9z7ecX/gIgjMKJ5A4STrdOXIzWtANl4cK6kSDUZfpp6sWUHRyjtMQ0KjKLh
        1B/H7jwykWg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2BE67CDDF;
        Fri, 16 Aug 2019 12:51:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 187E07CDDB;
        Fri, 16 Aug 2019 12:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG?: xdl_merge surprisingly does not recognize content conflict
References: <20190815220303.17209-1-newren@gmail.com>
Date:   Fri, 16 Aug 2019 09:51:37 -0700
In-Reply-To: <20190815220303.17209-1-newren@gmail.com> (Elijah Newren's
        message of "Thu, 15 Aug 2019 15:03:03 -0700")
Message-ID: <xmqqh86h12au.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E5D1384-C046-11E9-8B5E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Now, a manual merge of these files gives no conflicts, which surprises me:
>
>   $ git merge-file ours base theirs; echo $?
>   0

Indeed that is surprising.

> -- 8< --
> Subject: checkout: remove duplicate code
>
> Both commit a7256debd4b6 ("checkout.txt: note about losing staged
> changes with --merge", 2019-03-19) from nd/checkout-m-doc-update and
> commit 6eff409e8a76 ("checkout: prevent losing staged changes with
> --merge", 2019-03-22) from nd/checkout-m were included in git.git
> despite the fact that the latter was meant to be v2 of the former.
> The merge of these two topics resulted in a redundant chunk of code;
> remove it.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

The latter half that you remove cannot be reached, because the first
half would have already died after checking the same condition, so
we were doing the same repo-index-has-changes check twice when there
is no change; in other words, we were lucky that this accidental dup
did not cause any real damange.

Thanks for spotting.  Will apply.
