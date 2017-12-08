Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CBC71FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 21:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbdLHVPW (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 16:15:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54614 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752209AbdLHVPV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 16:15:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBE92AD26F;
        Fri,  8 Dec 2017 16:15:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C+dVbynC6btPT2Ai9BaFKNmecwg=; b=kTISwR
        3NlcTejt1hJC2bVFTl4HudF2qtlnMX0Ilxv5ZXsGU/9iho8dghgWWe0kMtZMGREC
        My3D0gCFweapMXzmRUByqRP2KIRYwGzbXwxtERx4pXj1OrLWoX9msD9EFYuByYDg
        5fdL3btWgKFK1QGfbb2KfTZ5WvCFcX5ll3vA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FlgywhAmA366YCECDZgjf/A8NFm8SGh2
        xuy/zN/LMcBxyruoWARPKZgYKS59TTnOGYWkEGw6J6P0IAA6F2TxppspjDjRLMUL
        JXbE2VMnK9jHIE0WnHEFz0zMT2rD167p3jquCr3jBH94zbTz/WFbi3wAC1Ara2nk
        KSR6kz4kCtY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3544AD26D;
        Fri,  8 Dec 2017 16:15:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 325C5AD26B;
        Fri,  8 Dec 2017 16:15:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
References: <20171208002447.20261-1-sbeller@google.com>
        <20171208002447.20261-2-sbeller@google.com>
        <xmqq1sk5b6rx.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbE9ePfxdD+rxp=P_jZwv4RPiVSbhdpjEf48dAMsKWYrQ@mail.gmail.com>
Date:   Fri, 08 Dec 2017 13:15:19 -0800
In-Reply-To: <CAGZ79kbE9ePfxdD+rxp=P_jZwv4RPiVSbhdpjEf48dAMsKWYrQ@mail.gmail.com>
        (Stefan Beller's message of "Fri, 8 Dec 2017 13:11:32 -0800")
Message-ID: <xmqqefo47wgo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E56BD2AA-DC5C-11E7-A351-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> +
>>> +             if ((DIFF_FILE_VALID(p->one) &&
>>> +                  oidset_contains(options->blobfind, &p->one->oid)) ||
>>> +                 (DIFF_FILE_VALID(p->two) &&
>>> +                  oidset_contains(options->blobfind, &p->two->oid))) {
>>
>> Shouldn't this make sure that !DIFF_PAIR_UNMERGED(p) before looking
>> at the sides of the pair?  I think an unmerged pair is queued with
>> filespecs whose modes are cleared, but we should not be relying on
>> that---I think we even had bugs we fixed by introducing an explicit
>> is_unmerged field to the filepair struct.
>
> I am not sure I follow. IIUC 'unmerged' only ever happens in the
> index when there are multiple stages for one path (represented in the
> working tree with diff markers). Aren't we supposed to find such
> an unmerged blob as well (despite wrong mode, but the oid ought to fit)?

I think diff_unmerged() records "this path is unmerged" without
giving any object name to either side, so you do not get to compare
(or even look at) p->{one,two}->oid with anything.  That is why I
think checking p->one and p->two like the above code, without making
sure that you are looking at a pair that is not unmerged, is wrong.

