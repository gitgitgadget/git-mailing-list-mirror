Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A8E1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 19:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbcHaTKS (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 15:10:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61320 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752637AbcHaTKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 15:10:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4968A3738B;
        Wed, 31 Aug 2016 15:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NJ4oLLkrPztO
        W1H49kQwXv2OQv4=; b=osBOVyH6Dn8TCdVTizww4kSK4/UWZBUCh+8j3stDUMXo
        ZzsKV6nMgv1IOozIUBmzIgKxI55wBcy+w4KDlyju55WkwRI63mwOX5PjtayZbGWr
        MTfALbvKa1DhGb/6NNdcctHZUCdS9GWAkCHe5Bu7t/zWH3ja1iwaHRMgJIi6KXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YL+3uu
        rorHmJTR5zKmDWOCADye8D8nOmFPV4v5BbwEkJnJhFqMRRWd39yVTPqOVJ1I8E5H
        R8IXuG8I0QqrZvKfgDP+b3xcjOgNZMmOFohI4XwuheEiJauFrFVQ6i0ob6ECsFCP
        iq8cn4FRaMPNkZTcJzySS+zAbJ4xtNCPogfE4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FDC737389;
        Wed, 31 Aug 2016 15:10:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79C5F37388;
        Wed, 31 Aug 2016 15:10:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the todo file
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
        <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
Date:   Wed, 31 Aug 2016 12:10:13 -0700
In-Reply-To: <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 31 Aug 2016 20:37:53
 +0200")
Message-ID: <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8C9806A6-6FAE-11E6-A6CC-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> diff --git a/sequencer.c b/sequencer.c
>> index 06759d4..3398774 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -709,6 +709,8 @@ static int read_and_refresh_cache(struct replay_op=
ts *opts)
>>  struct todo_item {
>>  	enum todo_command command;
>>  	struct commit *commit;
>> +	const char *arg;
>> +	int arg_len;
>
> Why 'arg', and not 'oneline', or 'subject'?
> I'm not saying it is bad name.

I am not sure what the "commit" field of type "struct commit *" is
for.  It is not needed until it is the commit's turn to be picked or
reverted; if we end up stopping in the middle, parsing the commit
object for later steps will end up being wasted effort.

Also, when the sequencer becomes one sequencer to rule them all, the
command set may contain something that does not even mention any
commit at all (think: exec).

So I am not sure if we want a parsed commit there (I would not
object if we kept the texual object name read from the file,
though).  The "one sequencer to rule them all" may even have to say
"now give name ':1' to the result of the previous operation" in one
step and in another later step have an instruction "merge ':1'".
When that happens, you cannot even pre-populate the commit object
when the sequencer reads the file, as the commit has not yet been
created at that point.


