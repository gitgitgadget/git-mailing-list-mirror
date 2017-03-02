Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98971F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 21:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdCBVL5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 16:11:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62750 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751101AbdCBVL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 16:11:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAD038592B;
        Thu,  2 Mar 2017 16:11:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t6GuxGZkIX1lvcTfrqoF+jeCs7Y=; b=tcKbXf
        hww0MbEnrme7DZWoNMz7jxeVem9hLhedrnrXTnNkXbZNi6uU0uG7IFgwZTxgyVbh
        PaoIaIqDvU/ZvOW5FqehIREKL+0O9BadnCpf39EpfMtC6HxMEkDM4SMjcW+dNBOe
        sU42JxPgpn0O1EvQSFxMtalf+t8kBFm+QTXss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tF5taJRIeUYFhOUbNe9GJPww5qfid782
        uDbXGA5NbUseKwPQlJIoTYNcDAnw/s73awNQSrgu+cEPtPk15yk0szEvPGvRVZJZ
        NX21eZ8AWQAaeyh9rpptkVTGttF2s6CLdXleAXQumD1E+CwBCh+mkZaNSAj/0L0M
        nsPgy4rnyQs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3F608592A;
        Thu,  2 Mar 2017 16:11:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F32E985929;
        Thu,  2 Mar 2017 16:11:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/5] A series of performance enhancements in the memihash and name-cache area
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
        <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
Date:   Thu, 02 Mar 2017 13:11:47 -0800
In-Reply-To: <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 15 Feb 2017 09:27:53 -0500")
Message-ID: <xmqqfuivbcz0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9738D24-FF8C-11E6-BE98-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 2/14/2017 5:03 PM, Jeff King wrote:
>> On Tue, Feb 14, 2017 at 12:31:46PM +0100, Johannes Schindelin wrote:
>>
>>> On Windows, calls to memihash() and maintaining the istate.name_hash and
>>> istate.dir_hash HashMaps take significant time on very large
>>> repositories. This series of changes reduces the overall time taken for
>>> various operations by reducing the number calls to memihash(), moving
>>> some of them into multi-threaded code, and etc.
>>>
>>> Note: one commenter in https://github.com/git-for-windows/git/pull/964
>>> pointed out that memihash() only handles ASCII correctly. That is true.
>>> And fixing this is outside the purview of this patch series.
>> Out of curiosity, do you have numbers? Bonus points if the speedup can
>> be shown via a t/perf script.
>>
>> We have a read-cache perf-test already, but I suspect you'd want
>> something more like "git status" or "ls-files -o" that calls into
>> read_directory().
>
> I have some informal numbers in a spreadsheet.  I was seeing
> a 8-9% speed up on a status on my gigantic repo.
>
> I'll try to put together a before/after perf-test to better
> demonstrate this.

Ping?  I do not think there is anything wrong with the changes from
correctness point of view, but as the series is about performance,
it somewhat feels pointless to merge to 'next' without mentioning
the actual numbers.  

It might be sufficient to mention the rough numbers in the log
messages, if additions to t/perf/ are too cumbersome to arrange.


