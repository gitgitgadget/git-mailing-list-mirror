Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CEC432BE
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 22:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26676056B
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 22:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbhH2Wnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 18:43:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59443 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbhH2Wnu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 18:43:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF30ADF096;
        Sun, 29 Aug 2021 18:42:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ktpcOKlFNVG1rvR7J049jCPgJ0gPHgJ+0iIL4O
        9TBN8=; b=nCIs1rg/raaucz6PSLgK8lZkVMo+/hq3qNBF1ciRH3nXiHKS6puqTS
        ersUzVGiyXw56j+6ONK4W64NyF1a+ofmbXYxLgEeml4YDa6MEwWGIzo/F0wbtJiO
        mP86p9tmlXAyb42gZT0jny2k1yOa/fBiVpSmAuWJPXH+wCA36MKBM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B45B4DF094;
        Sun, 29 Aug 2021 18:42:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3AC11DF093;
        Sun, 29 Aug 2021 18:42:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 00/25] multi-pack reachability bitmaps
References: <cover.1617991824.git.me@ttaylorr.com>
        <cover.1629821743.git.me@ttaylorr.com>
        <YSWOtNoxirDdmBXG@coredump.intra.peff.net>
        <YSWmhMID1hGs7Yp1@nand.local>
        <YSXy73lWKteiuY6s@coredump.intra.peff.net>
        <YSfiJmYMPPyEueUG@nand.local> <YSgGBxh24UAZR5X3@nand.local>
        <YSlZkMhD1vlc/48i@coredump.intra.peff.net>
Date:   Sun, 29 Aug 2021 15:42:56 -0700
In-Reply-To: <YSlZkMhD1vlc/48i@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 27 Aug 2021 17:30:56 -0400")
Message-ID: <xmqq8s0j98jz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74A74452-091A-11EC-A26A-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> The new test, specifically this snippet:
>> 
>>     git init repo &&
>>     test_when_finished "rm -fr repo" &&
>>     (
>>       cd repo &&
>>       test_commit base &&
>>       git repack -d
>>     ) &&
>> 
>>     nongit git multi-pack-index --object-dir=$(pwd)/repo/.git/objects write
>> 
>> will fail with GIT_TEST_DEFAULT_HASH=sha256, since the MIDX internals
>> settle on the hash size via `the_hash_algo` which doesn't respect the
>> hash algorithm used by the target repository.
>
> Yeah, I think this is a good example of the class of things that might
> fail: anything that requires the repo config to behave correctly.
>
> I do think the hash format is somewhat unusual here. Most of the changes
> to the on-disk files are reflected in the files themselves (e.g., pack
> index v2 is chosen by config at _write_ time, but readers can interpret
> the file stand-alone).
>
> There may be other config that could influence the writing of the midx,
> and we'd skip it in this kind of non-repo setup. An example here is
> repack.usedeltabaseoffset, which midx_repack() tries to respect.
> Ignoring that doesn't produce a nonsense result, but it doesn't follow
> what would happen if run from inside the repo.
>
> The other class of problems I'd expect is where part of the midx
> operation needs to look at other parts of the repo. Bitmap generation is
> an obvious one there, since we'd want to look at refs to find the
> reachable tips. Now obviously that's a new feature we're trying to
> introduce here, so it can't be an existing breakage. But it does make me
> wonder what other problems might be lurking.
>
> So I dunno. Even if it mostly works now, I'm not sure it's something
> that I'm all that happy about supporting going forward. It seems like a
> recipe for subtle bugs where the midx code calls into other library code
> that assumes that it can look at the repository struct.

I tend to agree that we should first disallow things that are not
what we know we definitely need, and the non-repo setup is something
we would want to punt on to make sure we have a solid support for
the mainstream usecase.

Thanks.
