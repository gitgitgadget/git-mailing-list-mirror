Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 810CB1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeADTMx (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:12:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55404 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeADTMw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:12:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62C0CCAFE1;
        Thu,  4 Jan 2018 14:12:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sMxCpfQ0XILJbj2bdUVvJn2ckBw=; b=nH2s8i
        I69oOc2sZ/zigqaLoGEUJT2Ljb40oOgnLJvM3bQXdy6WDFW5qAQICt/rYfAeNtmH
        THBu72HqGpzEfFBZvfIvEMzoD6Ijk7hY+Gjt9rifkl0G8bKPEWlKRg1RcWNRCBjC
        XuUg9hD+idSJ+fRFSt7f6tAzodWNKIkeNIDJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LcCDN22g0DrOR0TbXrZSDVg/uIPK7t0R
        XBhbDMmR1yxcorPfsGHOFDfgW1TiLfeGb2fRf8UwIi2HQZhP5chWK6AuRxIlOQPK
        fQkpfesQJpUR3WTA3GRf+Olw5u8KSNMOFzidn01dXPf4O/T3lf3uJVit4Bl1SJnI
        xzO9OcNgYQc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A922CAFE0;
        Thu,  4 Jan 2018 14:12:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB625CAFDF;
        Thu,  4 Jan 2018 14:12:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 2/3] prune: fix pruning with multiple worktrees and split index
References: <20171210212202.28231-1-t.gummerer@gmail.com>
        <20171217225122.28941-1-t.gummerer@gmail.com>
        <20171217225122.28941-3-t.gummerer@gmail.com>
        <20171218181913.GB147973@google.com> <20180103221849.GC2641@hank>
Date:   Thu, 04 Jan 2018 11:12:50 -0800
In-Reply-To: <20180103221849.GC2641@hank> (Thomas Gummerer's message of "Wed,
        3 Jan 2018 22:18:49 +0000")
Message-ID: <xmqqwp0xe8ul.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4299875C-F183-11E7-AD7F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> [sorry for the late reply.  I was on Christmas holidays until today
> and am still catching up on the mailing list.  It will probably take
> me untill the weekend to send a re-roll]
>
> On 12/18, Brandon Williams wrote:
>> On 12/17, Thomas Gummerer wrote:
>> > be489d02d2 ("revision.c: --indexed-objects add objects from all
>> > worktrees", 2017-08-23) made sure that pruning takes objects from all
>> > worktrees into account.
>> > 
>> > It did that by reading the index of every worktree and adding the
>> > necessary index objects to the set of pending objects.  The index is
>> > read by read_index_from.  As mentioned in the previous commit,
>> > read_index_from depends on the CWD for the location of the split index,
>> 
>> As I mentioned before this doesn't actually depend on the CWD but
>> rather the per-worktree gitdir.
>
> Right, will fix.

Thanks.
