Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E65C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 20:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1F4207BC
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 20:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DlUQRkpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHZUyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:54:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64279 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZUyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 16:54:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69C9CE8898;
        Wed, 26 Aug 2020 16:54:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZxLeDoIfNMdYxoBvmeIjgxK0GN8=; b=DlUQRk
        pvbLIjwIi3UWHlzCvMgAzxcqUm5ZmYhvDQaN0D5/we6+Tw3HEvka9kdrPZyuZkTX
        VLCBhLDg4nUCWhT128b2tQ78d+cLp7t+3S7u7tYAsSaBN0dJoWWRHr7qBB0diZ6w
        Y2ebB5h4BB/gpIi0PZyKSjc0+P9aNyZfkehSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jxzQFIwYcwhd3B2X+OmNdGgUHFmFbk60
        PysF1bTkZikk5SKz5i/WPa213xYoTXwdvtVnV4ozIx20pI8DGbF5IJFKhZ2DsW7r
        uvdyy3SIvDqZyb0MyTE/9/4JWud8esM9cyP3wv+FBx3ZQqndONagP0K7qxpNlfKg
        lzI+VAuwCBw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63175E8896;
        Wed, 26 Aug 2020 16:54:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AAF86E8895;
        Wed, 26 Aug 2020 16:54:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, peff@peff.net, sluongng@gmail.com
Subject: Re: [PATCH v2] builtin/repack.c: invalidate MIDX only when necessary
References: <20200825144515.GB7671@syl.lan>
        <87a3b7a5a2f091e2a23c163a7d86effbbbedfa3a.1598371475.git.me@ttaylorr.com>
        <a9997a0b-9ba9-4614-2081-fc74e4c2171a@gmail.com>
Date:   Wed, 26 Aug 2020 13:54:30 -0700
In-Reply-To: <a9997a0b-9ba9-4614-2081-fc74e4c2171a@gmail.com> (Derrick
        Stolee's message of "Wed, 26 Aug 2020 16:51:29 -0400")
Message-ID: <xmqq5z95unzt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57A18F56-E7DE-11EA-AC0A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 8/25/2020 12:04 PM, Taylor Blau wrote:
>> In 525e18c04b (midx: clear midx on repack, 2018-07-12), 'git repack'
>> learned to remove a multi-pack-index file if it added or removed a pack
>> from the object store.
>> 
>> This mechanism is a little over-eager, since it is only necessary to
>> drop a MIDX if 'git repack' removes a pack that the MIDX references.
>> Adding a pack outside of the MIDX does not require invalidating the
>> MIDX, and likewise for removing a pack the MIDX does not know about.
>> 
>> Teach 'git repack' to check for this by loading the MIDX, and checking
>> whether the to-be-removed pack is known to the MIDX. This requires a
>> slightly odd alternation to a test in t5319, which is explained with a
>> comment. A new test is added to show that the MIDX is left alone when
>> both packs known to it are marked as .keep, but two packs unknown to it
>> are removed and combined into one new pack.
>> 
>> Helped-by: Derrick Stolee <dstolee@microsoft.com>
>> Signed-off-by: Taylor Blau <me@ttaylorr.com>
>> ---
>> Range-diff against v1:
>
> I know this thread went in a new direction about pack-redundant and
> dashed-git, but this version looks good to me. I wanted to make sure
> it wasn't lost in the shuffle.

Very much appreciated.  I was wondering if I'll see a final reroll
or v2 already had all we wanted.

Thanks.
