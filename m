Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A0DC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CC92100A
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 19:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbhAYTGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 14:06:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53597 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731538AbhAYTFX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:05:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4362A10A845;
        Mon, 25 Jan 2021 14:04:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ub/tTk4hDYp3AvhgCkZQnOaQgEY=; b=Trmdwf
        zp5v8K0WpTfZs98C6y0f4W38iZBg1In28BrPOUb936e7k4elKZddreBGAi1e0rN8
        Kv6KhUGUoKBXWvUxMOaSzanLpcPFuCIALGgFzOAw0ZMT1tuE/Tn/gXYW4Rm2d+lQ
        PDGxQk0fEi+4EN0djWeu0UeaPh666QunBu9HU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hQFySevowQHuWEeb0LC54CwpwKnyTwpd
        Jbp+5e/0iqjJi8JW4VXZzN8hfceH6B+f4bDnfjBTlZcYDVaJGH+qXUB4GWsfNOE/
        EZVsEYvm9xxUT4dhLNxTAH5NyPerLqf0uE2qs2FwcPuWhxUErhaUiiPrGGKDyn2i
        J8iQeiok/0c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B12010A844;
        Mon, 25 Jan 2021 14:04:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7387010A83F;
        Mon, 25 Jan 2021 14:04:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev'
 files
References: <cover.1610129989.git.me@ttaylorr.com>
        <cover.1610576805.git.me@ttaylorr.com>
        <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
        <YAtXmie2kHNrcBwY@coredump.intra.peff.net>
        <YA8DlQwSzNZXq+AU@nand.local>
Date:   Mon, 25 Jan 2021 11:04:33 -0800
In-Reply-To: <YA8DlQwSzNZXq+AU@nand.local> (Taylor Blau's message of "Mon, 25
        Jan 2021 12:44:53 -0500")
Message-ID: <xmqqy2ggyh1a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A2A26F8-5F40-11EB-B099-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> Thinking out loud a bit: a .rev file means we're spending an extra map
>> per pack (but not a descriptor, since we close after mmap). And like the
>> .idx files (but unlike .pack file maps), we don't keep track of these
>> and try to close them when under memory pressure. I think that's
>> probably OK in terms of bytes. It may mean running up against operating
>> system number-of-mmap limits more quickly ...
>> ...
>> >  	if (ends_with(name, ".idx"))
>> >  		return 3;
>> > -	return 4;
>> > +	if (ends_with(name, ".rev"))
>> > +		return 4;
>> > +	return 5;
>> >  }
>>
>> Probably not super important, but: should the .idx file still come last
>> here? Simultaneous readers won't start using the pack until the .idx
>> file is present. We'd probably prefer they see the whole thing
>> atomically, than see a .idx missing its .rev (they won't ever produce a
>> wrong answer, but they'll generate the in-core revindex on the fly when
>> they don't need to).

At some point, we may want to 

 - introduce .idx version 3 that is more extensible, so that the
   reverse info is included in one of its chunks;

 - make the .rev data for all packs stored as a chunk in .midx, so
   we can first check with .midx and not open any .rev files.

either of which would reduce the numberfrom 30k down to 10k ;-)
