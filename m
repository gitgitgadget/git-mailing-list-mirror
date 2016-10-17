Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21C781F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 22:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933019AbcJQWdH (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 18:33:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50023 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932163AbcJQWdG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 18:33:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A726466E6;
        Mon, 17 Oct 2016 18:33:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=1pW7sBDnA/rPS6Y8CzG7HBTtDpc=; b=YdK4utvHqfzQqeHzZ4n/
        Ov0c6YGDUQEE5LHuW8K3cNxbgj2ruUQO51stlLl8Ga1A9efJtCIMbNDpm66yoJ8f
        Olnw+4PxX5Rrzwi1Y/RZwivrwD5Y7bYsEN/8C/6OPIIDaNGhOgJ9xEt3wjVUZ3Vq
        MMqVQmPMHGsaBD0mA7QsmtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=izjP2wjoC8WagKT3n9ocvBH7fvqjts94SvqUmBmH7FsQHy
        3/rtvbj+tLKSMl0068OYDEzVYuqHeutn5jBAWoaJ4a3dphGzSFzsVAGPHAxEPniz
        aXmJKRIWljgwlqPec3FgQQKghOJBsrKqzzJxg+b7k7yG/rFpUr8WBOIl3b3Hw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4054D466E5;
        Mon, 17 Oct 2016 18:33:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69119466E3;
        Mon, 17 Oct 2016 18:33:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 08/25] sequencer: completely revamp the "todo" script parsing
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
        <cover.1476450940.git.johannes.schindelin@gmx.de>
        <a5f5d784fcacc16555237b9750380d612387d0cb.1476450940.git.johannes.schindelin@gmx.de>
Date:   Mon, 17 Oct 2016 15:33:02 -0700
Message-ID: <xmqqfunusj1d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB4BCA1C-94B9-11E6-9FE9-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> -	for (i = 1; *p; i++) {
> +	for (i = 1; *p; i++, p = next_p) {
>  		char *eol = strchrnul(p, '\n');
> -		commit = parse_insn_line(p, eol, opts);
> -		if (!commit)
> -			return error(_("Could not parse line %d."), i);
> -		next = commit_list_append(commit, next);
> -		p = *eol ? eol + 1 : eol;
> +
> +		next_p = *eol ? eol + 1 /* strip LF */ : eol;

This one was explained as "skip LF" in the previous round, and that
is more correct than "strip", I think.  The +1 here is not done to
"strip" the LF out of the end result, but to "skip" one to move to
the beginning of the next line.

The one in v3 08/25 decremented the pointer to denote the end of the
line with the explicit purpose of not including the CR in the end
result, which was explained as "skip CR", but it was stripping CR.
Correcting that explanation to "strip" was a right fix and I think
your v4 09/25 still has it, which is good.

Other than this unnecessary change since the previous round, I
didn't spot a difference in this step, which was already good.

Thanks.


