Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4131F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbcIAVFq (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:05:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60296 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753985AbcIAVFn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:05:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5484537BD9;
        Thu,  1 Sep 2016 14:47:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0gpYw7Oxchgo88/W6yXmpiSYw9A=; b=wUuYbc
        X77X8bkDR1lOyUMoaCzEvAEYxfK0AFVoB/J5YKzNckSxbgBNSxiyOK9HZtbYJ2mm
        OW7pI+Z+ani7BBTPhDsu2F/KterdBnz0u0OKOpUPiASfq/ZkxMwieBP9qv0jjI5R
        AmK63Xwl9m7fl7oepYGsve6gEQhhqz3/bKVP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G1x/goU4Qm/s7B27ZpqbwTY2Gv2J63SN
        w/1GIABpH9GSKk7R5MfWOLfdzSmU2tJ+qYO7yADi8tIe1H5/S4JqriMe+dPfKKPi
        vVpY0HSDxk/3CGeNvuoAKJzUZUmh5xPusJGPfDViNwlnlheJmVd6s9eAgLzIpnOL
        pZXW0NNSCSU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CABF37BD8;
        Thu,  1 Sep 2016 14:47:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7D3137BD7;
        Thu,  1 Sep 2016 14:47:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the todo file
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
        <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
        <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609011052260.129229@virtualbox>
Date:   Thu, 01 Sep 2016 11:47:37 -0700
In-Reply-To: <alpine.DEB.2.20.1609011052260.129229@virtualbox> (Johannes
        Schindelin's message of "Thu, 1 Sep 2016 11:37:43 +0200 (CEST)")
Message-ID: <xmqqeg53wj7a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EF4E8F8-7074-11E6-8C89-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> though).  The "one sequencer to rule them all" may even have to say
>> "now give name ':1' to the result of the previous operation" in one
>> step and in another later step have an instruction "merge ':1'".
>> When that happens, you cannot even pre-populate the commit object
>> when the sequencer reads the file, as the commit has not yet been
>> created at that point.
>
> These considerations are pretty hypothetical. I would even place a bet
> that we will *never* have ":1" as names, not if I have anything to say...
> ;-)

If you can always work with pre-existing commit, then you can
validate all object references that appear in the instructions
upfront.

I was sort of expecting that, when you do the preserve-merges mode
of "rebase -i", you would need to jump around, doing "we have
reconstructed the side branch on a new 'onto', let's give the result
this temporary name ':1', and then switch to the trunk (which would
call for 'reset <commit>' instruction) and merge that thing (which
would be 'merge :1' or perhaps called 'pick :1')", and at that point
you no longer validate the object references upfront.

If you do not have to have such a "mark this point" and a "refer to
that point we previously marked", then I agree that you should be
able to pre-validate and keep the result in the structure.
