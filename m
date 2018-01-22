Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13A31F576
	for <e@80x24.org>; Mon, 22 Jan 2018 06:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeAVGOr (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 01:14:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64908 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeAVGOp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 01:14:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 047B6BC9CF;
        Mon, 22 Jan 2018 01:14:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JGxqG98ocTXZ580gIswWPdbyTR4=; b=ShkBWp
        zcJX9TRXbRb+L3KkdYfCO2/Um6yAcEcplo3GKseWzQLBiTY484s1Z+3aLjlpKVy6
        +V3YT6SmVPL7+sZG3TyFmacs6+N5tS0t70Ir9GJHo6+Wxbmws1aa+NyCIvahRvxb
        Wxu5CTYgWCYSTOP335KhX/1sHcq8qXZjH4vJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FHrt8+/QiFedqb7Je8YtCj2b7a81hLWa
        DmH7+8M/wVHjjtQGvRTFTRActcsYxwPo5yTFg1MQ7eMXNiJ5T28zm2hBBBJQJfai
        G2jwtNb2LRShr3laIVrm1tPWQ0NbWMzQSn1Z6Hg8+T0itDbOBvku9wjSyYAPg9Yp
        WtC7C6jRTDc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0E50BC9CE;
        Mon, 22 Jan 2018 01:14:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 633E6BC9CD;
        Mon, 22 Jan 2018 01:14:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for other repos
References: <20171217225122.28941-1-t.gummerer@gmail.com>
        <20180107223015.17720-1-t.gummerer@gmail.com>
        <20180107223015.17720-2-t.gummerer@gmail.com>
        <xmqq1silpl4g.fsf@gitster.mtv.corp.google.com>
        <20180120115819.GR2641@hank>
Date:   Sun, 21 Jan 2018 22:14:43 -0800
In-Reply-To: <20180120115819.GR2641@hank> (Thomas Gummerer's message of "Sat,
        20 Jan 2018 11:58:19 +0000")
Message-ID: <xmqqpo62mncc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A32A0CE-FF3B-11E7-95AD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 01/19, Junio C Hamano wrote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>> 
>> > read_cache_from() defaults to using the gitdir of the_repository.  As it
>> > is mostly a convenience macro, having to pass get_git_dir() for every
>> > call seems overkill, and if necessary users can have more control by
>> > using read_index_from().
>> 
>> This was a bit painful change, given that some changes in flight do
>> add new callsites to read_index_from() and they got the function
>> changed under their feet.
>
> Sorry about that.  Is there any way to make such a change less painful
> in the future?

One way is to do for read_index_from() what you did for the existing
users of read_cache_from().  Introduce a _new_ helper that will not
be known for any existing topics in flight, and use that to make the
existing API a thin wrapper around it.

I _think_ I got it right with evil merge, so unless this fix needs
to be delayed for extended period of time for whatever reason while
any more new callers of the function appears (which is unlikely), we
should be OK ;-)

Thanks.
