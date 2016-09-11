Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CB7A1FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 23:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755059AbcIKXjs (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 19:39:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50550 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753130AbcIKXjr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 19:39:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBE8D3C141;
        Sun, 11 Sep 2016 19:39:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KQqD+fvPNF2jJZubyakmyqZTzQg=; b=iAGYtB
        6i0DsWO/dVFoPQFm3L2vPX4ojoxGXThqWqz4aCy1nz20bOycxcM7TWb28+8d4i+o
        rlySWg1+OE4M2BiXcK9msZ05wJJ/t/tZPBbV9nBRPdfR6jegDvAiIruc2Bffrm1y
        mHOSZT8HqRDj79qWHXZJN8Iogi/sYY/3icoZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DMIn3VRzjeIGBdFuMotvJ8RiCXybnEo9
        H6H+KT15q8CUlQBQ5Q1Swc8giPJLUnaOj2pOBp9KKMMIyd8A87AIYIvAlhtUv0pP
        wQUXdLgBZeTKyzEyn/+4VVtL3FT73T60MV5BT94dEEV2stgMFwzjzMqWUYuZc1+M
        hVWtMmYmD7k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B57F93C140;
        Sun, 11 Sep 2016 19:39:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F33F3C13F;
        Sun, 11 Sep 2016 19:39:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 20/25] sequencer: left-trim lines read from the script
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <09e05e7ac23164625f2076ff06d2b034101878da.1473590966.git.johannes.schindelin@gmx.de>
Date:   Sun, 11 Sep 2016 16:39:43 -0700
In-Reply-To: <09e05e7ac23164625f2076ff06d2b034101878da.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:55:45 +0200
        (CEST)")
Message-ID: <xmqqsht657ls.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0510886A-7879-11E6-BDFE-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Interactive rebase's scripts may be indented; we need to handle this
> case, too, now that we prepare the sequencer to process interactive
> rebases.

Hmph, have we ever given the sequencer instructions indented to the
user to edit?  I do not offhand see why we want to be lenient here,
especially only to the left.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 7953a05..5e5d113 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -875,6 +875,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  	char *end_of_object_name;
>  	int i, saved, status, padding;
>  
> +	/* left-trim */
> +	bol += strspn(bol, " \t");
> +
>  	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
>  		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
>  			item->command = i;
