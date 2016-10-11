Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57C71F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 18:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754411AbcJKS4W (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 14:56:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60733 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754272AbcJKSyu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 14:54:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C20F8447FE;
        Tue, 11 Oct 2016 14:54:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SsEgk8egeSn3OtFrPH++Hb6DjpA=; b=hv68JG
        gOGJCGtmf3k/DBlzCznphlie571SGVvOS3JHZkLYbJvf+4EY+TI1+ukFVWebzd05
        TVg2EjnS7Wq0H8F0mRKYoomfNXBhj/8DLxCaLAQ/s/smczPmHVKzfyzed2S/NcHa
        F8634wrm8z+aiIjX23nK/WxhvEjNWevSmwv4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VWBPPxLO7AhWXTCnmk2nqL8J8QzZlLdG
        kF1vcZqmaApnQuS4cIAb4yCsB9jcEAf5AAZwZvmTGmRy3km6V0yp74gnsMr9/nVW
        rR6pDd8K+7VfZ5G3BTlg6FVcAPtOLj5WPqy/Ez2kFhrSZXXxBN/K2OQ6vxv7VgUO
        6C+x99ilx84=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAA00447FD;
        Tue, 11 Oct 2016 14:54:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35C2C447FC;
        Tue, 11 Oct 2016 14:54:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 08/25] sequencer: strip CR from the todo script
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <5a639610c09bf1dacc8143603f321a8ea23cd270.1476120229.git.johannes.schindelin@gmx.de>
Date:   Tue, 11 Oct 2016 11:54:47 -0700
In-Reply-To: <5a639610c09bf1dacc8143603f321a8ea23cd270.1476120229.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 10 Oct 2016 19:25:11 +0200
        (CEST)")
Message-ID: <xmqq60oyaf7s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F6C842E-8FE4-11E6-8803-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is not unheard of that editors on Windows write CR/LF even if the
> file originally had only LF. This is particularly awkward for exec lines
> of a rebase -i todo sheet. Take for example the insn "exec echo": The
> shell script parser splits at the LF and leaves the CR attached to
> "echo", which leads to the unknown command "echo\r".
>
> Work around that by stripping CR when reading the todo commands, as we
> already do for LF.
>
> This happens to fix t9903.14 and .15 in MSYS1 environments (with the
> rebase--helper patches based on this patch series): the todo script
> constructed in such a setup contains CR/LF thanks to MSYS1 runtime's
> cleverness.
>
> Based on a report and a patch by Johannes Sixt.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 678fdf3..cee7e50 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -774,6 +774,9 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
>  
>  		next_p = *eol ? eol + 1 /* skip LF */ : eol;
>  
> +		if (p != eol && eol[-1] == '\r')
> +			eol--; /* skip Carriage Return */

micronit: s/skip/strip/ ;-)

> +
>  		item = append_new_todo(todo_list);
>  		item->offset_in_buf = p - todo_list->buf.buf;
>  		if (parse_insn_line(item, p, eol)) {
