Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B63A215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 21:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932675AbcJLVpI (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 17:45:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61101 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756056AbcJLVo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 17:44:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D54045898;
        Wed, 12 Oct 2016 17:44:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9SWQU+OLZrl4tXAzrQr7/gzQpwc=; b=xFHHKj
        ZqS2gKgOfOAKcAOYRUs6n9K3SPcpkSZ3S/0s+F69VHr3hk7l1+xmuE+Jgy58krXH
        y9lRDbDQOG2r30O7/u6QVItNgn1Eh7wDFT7pezs+YgloTF4clNVWwTJSt8d2efDK
        zZKt7uEjLBRVErd3pQwO/19atSL6o6w5aZptc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vxenUlfIbwT2XkS59fwE2pAIvsIb0R4g
        dQuTFF3435q/xAdcGIzNObjDTjHkEkiunhSxaShqKB92zQL3vHvyx2Z0Jkg/V1CP
        1digmp6YDlA7iKsrdJ+4ngnlHsQwGOn9PdZURA00iDNg9SG4q+tKlsIErsA+jYJM
        ab9q6S8jcjM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9534645897;
        Wed, 12 Oct 2016 17:44:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0DDD345894;
        Wed, 12 Oct 2016 17:44:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
References: <20161011235951.8358-1-sbeller@google.com>
        <xmqqh98h2r5t.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaQGs_3dhd-yEzaq=CRXGQhbMuN_7FdFY=FeKZ4scmMeQ@mail.gmail.com>
Date:   Wed, 12 Oct 2016 14:44:56 -0700
In-Reply-To: <CAGZ79kaQGs_3dhd-yEzaq=CRXGQhbMuN_7FdFY=FeKZ4scmMeQ@mail.gmail.com>
        (Stefan Beller's message of "Wed, 12 Oct 2016 14:39:17 -0700")
Message-ID: <xmqq4m4h2qef.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EC77A16-90C5-11E6-A301-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Oct 12, 2016 at 2:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> This version adds the actual thread safety,
>>> that is promised in the documentation, however it doesn't add any optimization,
>>> i.e. it's a single global lock. But as we do not expect contention, that is fine.
>>
>> Because we have to start _somewhere_, I agree it is a good approach
>> to first try the simplest implementation and then optimize later,
>> but is it an agreed consensus that we do not expect contention?
>
> I agree on that. Did you mean this is obvious to the reader?

I meant to say that "But as we do not expect" sounded like a
justification for the approach based on an unwarranted assumption
that is not even the list concensus.  I do not think it is obvious
to the reader that there is no need to worry about contention.

It all is outside the log message, so as long as readers understand
what we meant from this discussion, that is OK.

