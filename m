Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE22DC5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B3822201
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CCobqb/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgKLSXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 13:23:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59194 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgKLSXV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 13:23:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3557F0AF5;
        Thu, 12 Nov 2020 13:23:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2+cma+UkLG5p
        Y9gk0toj6J8xYhg=; b=CCobqb/1cCr71KMyn8BF/rQmRfh7ThVE5GYfF0x/TMhz
        mI9M+tNvxTa0Gp0Ku5r9QXyiBKFZPbce0dxFfhazkV4KC17AgI9WMmrgIV1ZPYrM
        79EFyoBLKZ8PdxpbisHFm5bpAGuZMC/vMcqk5sybnriRzXWZgsOOJ670MLbm+qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aZ3PNJ
        dfyCRAndFXls9IDqeAtfIFLGmgrXWaEBIzd5uKvEq9n1siLNVQwEGvTPcOKZC2Kx
        E+0yj4Q7opfNGtP6TnCJPHQ/evP74aZ/tqDD7dz8Yt30LROE9/Z7/gFWvccWG5e/
        U9Mbm3NPiQ3Ob01qDfBqHTpe3pwM/e/Flcu70=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B92AF0AF4;
        Thu, 12 Nov 2020 13:23:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C1293F0AF2;
        Thu, 12 Nov 2020 13:23:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] bisect: loosen halfway() check for a large number of
 commits
References: <20201022103806.26680-1-szeder.dev@gmail.com>
        <20201112161938.20494-1-szeder.dev@gmail.com>
Date:   Thu, 12 Nov 2020 10:23:13 -0800
In-Reply-To: <20201112161938.20494-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 12 Nov 2020 17:19:38 +0100")
Message-ID: <xmqqft5ejuy6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 20FE09FC-2514-11EB-8CA4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> So let's loosen the check in the halfway() helper to consider commits
> within about 0.1% of the exact halfway point as halfway as well, and
> rename the function to approx_halfway() accordingly.  This will allow
> us to return early on a bigger good-bad range, even when there is no
> commit exactly at the halfway point, thereby reducing the runtime of
> the first command above considerably, from ~15s to 4.901s.

The optimization presented with this change would probably offer
more merge commits to be tested than a single-parent commit than the
original algorithm, simply because merges are inspected first before
single-parent commits so have better chance to be picked as "good
enough" among commits with similar goodness.

  Side note: This is merely an observation---I do not know if it is
  a good thing, a bad thing, or a neutral thing, but it would likely
  affect the end-user experience.

The optimization presented here gives probably more than enough
improvement, but it just occured to me when writing the entry to
explain the topic in the What's cooking report:

     "git bisect start/next" in a large span of history spends a lot of
     time trying to come up with exactly the half-way point; this can be
     optimized by stopping when we see a commit that is close enough to
     the half-way point.

The realization is that the optimization naturally will be affected
by the order the commits are visited.  If a commit that is close
enough to the half-way point happens to be visited earlier, it would
help terminate our search early.  And do_find_bisection() search
counts all merge commits before any commit on the linear ancestry
chain can be counted to optimize counting of commits on the linear
ancestry chain, which are expected to exist more than merge commits.

By sorting the "list" to somehow encourage commits near the half-way
appear early on it, we may raise the likelyhood that we'd find
good-enough commit early and terminate, no?  Perhaps sort by the
(absolute) distance between the committer timestamp of individual
commit and its median value, or something?

Thanks.
