Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31DF8203BD
	for <e@80x24.org>; Wed, 26 Oct 2016 21:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933756AbcJZVPi (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 17:15:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55695 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933283AbcJZVPh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 17:15:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB4CA49C43;
        Wed, 26 Oct 2016 17:15:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mgbMaLz/VSiN4Cs1QqXxfg1c5wc=; b=g8St4N
        b+oPRSNq8ZfgtSrcX2QuCDWStXgCld3kC4SQUQkR0gl71xkASnXEuoewxh9EcMb4
        fMAUnsrHdlR+RhlIQ6Zt1gNbadujki1KBimf4yiy+ofTWWV5pJDgIlSwP1Gpok5Y
        /GnGbcsdp54of1Kyd/FfeuoETeAsfa7woFqGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kDGidL/wif/y3EAEr25iquXiOodidhz6
        O01XAJfHfO+Uk70ZAHBer4oEZKx0klneD17aIDnbIBqTRiXITo/WQwGsgDfqumrA
        YnYyA8bo9G09G5B251bXLJv0VdpEVZQ+39IaANx4RF06eNXczQt9Cdi5RqBe9dAN
        QUBX/TZ1N8o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A574749C3F;
        Wed, 26 Oct 2016 17:15:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18BBE49C3E;
        Wed, 26 Oct 2016 17:15:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-1-gitster@pobox.com>
        <20161025181621.4201-3-gitster@pobox.com>
        <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
        <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
        <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
        <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
        <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net>
Date:   Wed, 26 Oct 2016 14:15:33 -0700
In-Reply-To: <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 26 Oct 2016 16:17:21 -0400")
Message-ID: <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55C2325C-9BC1-11E6-BD7B-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 26, 2016 at 10:52:41AM -0700, Junio C Hamano wrote:
>
>> > I actually wonder if it is worth carrying around the O_NOATIME hack at
>> > all.
>> 
>> Yes, I share the thought.  We no longer have too many loose objects
>> to matter.
>> 
>> I do not mind flipping the order, but I'd prefer to cook the result
>> even longer.  I am tempted to suggest we take two step route:
>> 
>>  - ship 2.11 with the "atime has been there and we won't regress it"
>>    shape, while cooking the "cloexec is semantically more
>>    important" version in 'next' during the feature freeze
>> 
>>  - immediately after 2.11 merge it to 'master' for 2.12 to make sure
>>    there is no fallout.
>
> That sounds reasonable, though I'd consider jumping straight to "NOATIME
> is not worth it; drop it" as the patch for post-2.11.

That endgame is fine by me too.  Thanks for a sanity-check.
