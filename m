Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE91320899
	for <e@80x24.org>; Mon, 14 Aug 2017 18:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750936AbdHNS5y (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 14:57:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64716 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750753AbdHNS5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 14:57:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24E6F91958;
        Mon, 14 Aug 2017 14:57:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FBc8qbaADiVGDDb7uvN/pWI+458=; b=Cq+Ua0
        cUZKtx/q5mcElFgtuFk4q6JtB63wH/xgUc/50z0MSq3wEC++bP5ULCpsd+spDx7P
        dT58IG/AzfJpeJiOSeaPRPLDfQ1tuDVgK3vyQgIVAXH0o5K3I273/6fHStlp8Pzb
        gFmT9tSUrkrAQa31WhrPi+BO86YZweqMB9Tuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qaeLvbWUU0femKsY+Fke1lhzr/fetATE
        s+CiFUZxNRpYVMNsgrmDeai7zavaOueBbyx0yUqlv1+a8YUBFRHCjzBG5dDgqv3g
        u/PI6AViIVS1+QXmt36gXDXBMisFoBRjzdahlV45Gygw1lENPw/aGHTwGyaa4u65
        gmvVwUw26bo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C81091956;
        Mon, 14 Aug 2017 14:57:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7109391952;
        Mon, 14 Aug 2017 14:57:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        martin.koegler@chello.at,
        "Dr.-Ing. Christoph Cullmann" <cullmann@absint.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug with corruption on clone/fsck/... with large packs + 64-bit Windows, problem with usage of "long" datatype for sizes/offsets?
References: <1232852793.287524.1502435085656.JavaMail.zimbra@absint.com>
        <alpine.DEB.2.21.1.1708141802510.19382@virtualbox>
        <CAGZ79kaYi=mqw615ZHiNAbDdnnKLawzZDy3ecLYDVV=e7e5qbQ@mail.gmail.com>
Date:   Mon, 14 Aug 2017 11:57:51 -0700
In-Reply-To: <CAGZ79kaYi=mqw615ZHiNAbDdnnKLawzZDy3ecLYDVV=e7e5qbQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 14 Aug 2017 10:07:04 -0700")
Message-ID: <xmqqk226ugcw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79802DA6-8122-11E7-8DF8-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Aug 14, 2017 at 9:05 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Christoph,
>>
>> On Fri, 11 Aug 2017, Dr.-Ing. Christoph Cullmann wrote:
>>
>>> on Windows 64-bit, for a repository having a .pack file > 4GB I get
>>> during cloning:
>>
>> The reason is Git's source code that over-uses the `unsigned long`
>> datatype.
>>
>> In a nearby-thread, an underappreciated effort by Martin Koegler is
>> underway to get the ball rolling in getting it fixed. Maybe you can help
>> making Martin a lot more welcome on the Git mailing list, and maybe even
>> help getting his patches reviewed and integrated?
>
> 'nearby' as in [1] ;-)
>
> [1] https://public-inbox.org/git/1502527643-21944-1-git-send-email-martin@mail.zuhause/
>
> I had the impression the review is going well there?

I do not know if it is "going well", but I do not agree with the
"underappreciated" bit at all.  I find such a blanket statement
toxic and detrimental to the community.

It is true that many topics in flight are broken with a tree-wide
change that is presented as a single ball of wax.  Unlike the
ongoing "struct object_id" effort, which also is tree-wide but tries
to find a step-wise refinement to reduce its impact on other topics,
it is harder to integrate such a change.  But that does not have any
relation to how much the effort is appreciated.
