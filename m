Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD60BC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB3A20637
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UWJThtCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCUSux (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:50:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60304 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCUSux (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:50:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 921DABE12E;
        Sat, 21 Mar 2020 14:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UdQjh3w6OAg3hcbecVQPgS/LtHc=; b=UWJTht
        CLhF2JDOEr1xES1MXEPmD9qFBVq93FDWloohFg8PnfemKtBxsl6jTw+vV2/qQvoM
        gH10Fr9iGUAdty08O2ivur6izQ1t0eWdR9KprAJRy+Xy78S9dj/ISIS3eJDNpgsV
        fkCGN8LMlHKtErP5ldagwWyc/DeV7Z7S1pPBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sJkGqLH1s2fAV5jhpkUa/ODk/TbAf+96
        rrIqufMcaZ9kAZkOPZ8YBaxM2s/JmOjyJ1zbMxjNe64vQofxS2tAnCwy854PuFzB
        wLqaLhJZnnXXWc/BM1nKESoLIdb90+wEAEYrPc6Rzw/gwXcuzz4CQtP3q0UP8J/k
        HcVeeQqZges=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89D24BE12D;
        Sat, 21 Mar 2020 14:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D434ABE128;
        Sat, 21 Mar 2020 14:50:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference when merging
References: <cover.1584762087.git.me@ttaylorr.com>
        <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
        <20200321050025.GA1438317@coredump.intra.peff.net>
        <20200321061141.GA30636@syl.local>
        <20200321070333.GB1441446@coredump.intra.peff.net>
Date:   Sat, 21 Mar 2020 11:50:47 -0700
In-Reply-To: <20200321070333.GB1441446@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 21 Mar 2020 03:03:33 -0400")
Message-ID: <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E169C21E-6BA4-11EA-85E9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So we weren't actually reading all of the commits even under the old
> code. We were just going into deref_tag(), seeing that the object is
> already parsed, and then quickly returning when we see that we already
> have an OBJ_COMMIT. I suspect most of your timing differences are mostly
> noise.

Noise that contributes largely to ~7% fluctuation?  That sounds big.

> I guess --input=stdin-commits is a good way to simulate that. Try this
> (assuming there's already a split-graph file with all of the commits in
> it):
>
>   git rev-parse HEAD >input
>   time git commit-graph write --input=stdin-commits --split=merge-all <input
> ...
> A more realistic case would probably be feeding a new small pack to
> --input=stdin-packs.

Makes sense.

> At any rate, I think there is a demonstrable speedup there. But
> moreover, I'm pretty sure this existing code is not doing what it
> expects:
>
>   /* only add commits if they still exist in the repo */
>   result = lookup_commit_reference_gently(ctx->r, &oid, 1);
>
> That won't look at the object database at all if the commit is already
> marked as parsed. And that parsing might have come from the commit graph
> itself, as our earlier attempts showed. So switching to a real
> has_object_file() call is an important _correctness_ fix, even leaving
> aside the speed improvements.

True. has_object_file() asks the question without even
lookup-replace flag set, so it would try to see if the object is
truly there (modulo the "pretended" ones are declared to exist via
the cached-object mechanism).

Do we need to worry about INFO_QUICK and SKIP_FETCH_OBJECT in this
codepath, by the way?
