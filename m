Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2859C20986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbcJDVtt (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:49:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50892 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750842AbcJDVts (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:49:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D38C43750;
        Tue,  4 Oct 2016 17:49:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vxxP6ybZW/t149oxRjpnZhzojQo=; b=jkqmle
        1mn5E3dJer2Ndm6Q0oyLl9QCORg4nKbjvqXrc+WvYgWJRmnNweUnxgqcxVslZ/MF
        exzYgsmob979TJlYDfW0EQoZ+mGRBFwxtAF+dOnczqyYUAfWUS2iB3MEzEuqwCOM
        eAeeFgInE/N445lykj0ZAA4+dGipw67gvWCAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R3c6AyA0QHs5wpT+GQ4J1YRCIbaaROjK
        I+8pk56gq3TWFSiqwyyyK4f1te8t74iui/qlHCAqB/GXNeXhcdBOmQuWOynZGqo1
        AnnVZ8sZZ3ae312uiFb0xOAnPR7k9vLxTNdIITv/yiDbOLV6oIKgJu0a5sVJoFD6
        3AWBHn5kMa0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 761F24374F;
        Tue,  4 Oct 2016 17:49:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F05984374E;
        Tue,  4 Oct 2016 17:49:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 12/18] alternates: use a separate scratch space
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
        <20161003203551.tmqp5rll6nqkewxz@sigill.intra.peff.net>
        <xmqqk2dnssz9.fsf@gitster.mtv.corp.google.com>
        <20161004213241.ihzkl7cohliavydg@sigill.intra.peff.net>
Date:   Tue, 04 Oct 2016 14:49:45 -0700
In-Reply-To: <20161004213241.ihzkl7cohliavydg@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 4 Oct 2016 17:32:41 -0400")
Message-ID: <xmqq7f9nss1y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77B031C6-8A7C-11E6-B5C7-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 04, 2016 at 02:29:46PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >  extern struct alternate_object_database {
>> >  	struct alternate_object_database *next;
>> > +
>> >  	char *name;
>> > -	char base[FLEX_ARRAY]; /* more */
>> > +	char *scratch;
>> > +
>> > +	char path[FLEX_ARRAY];
>> >  } *alt_odb_list;
>> 
>> It is not wrong per-se, but I am a bit surprised to see that the
>> code keeps FLEX_ARRAY _and_ uses a separate malloc'ed area pointed
>> at by the scratch pointer.
>
> Yeah, there's really no reason "path" could not become a non-flex
> buffer. I mostly left it there out of inertia. If you have a preference,
> I'm happy to change it.

My preference, before reaching the end of the series, actually was
to overallocate just once and point with *scratch into path[] beyond
the end of the fixed "where is the object directory?" string.

Of course, that would not mesh very well with the plan this series
had after this step to use strbuf for keeping scratch ;-)  And the
end result looks fine to me.

Thanks.

