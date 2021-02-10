Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214B5C433E9
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFD264E8A
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhBJQdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:33:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60568 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhBJQcL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 11:32:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37283113BBE;
        Wed, 10 Feb 2021 11:31:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JPU56W70hTZsbWWnGO0f8rCp/vE=; b=vc+QGe
        HzheHjQAn8uOqwDsCFOLASLOyldMF4o27FD6p880k9pgR3T8DsGbMHPcWTxAAPY6
        wf1sIopixmhsTErimYKa9BRWQRMo+YjdrxvGeYwXRgAF79zx/hYLK4lT04BgPqr3
        mm9akteYZ/2KrE75eOEeIxI3jqJwu/MkDiO6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h5eS6vwgGyS1YBe3Xct6zDRbbkLEu/Wx
        cwCUUmy6ePB7oyyQ8FTQfe/5mZBHki3SwY6QNGucU4I45tSvuoP3MRddkp1dksvu
        Mp9ECC6qJa0Xk+ujjedwDylrzPma323H38/3iDZdp1L7wg0+QbNDgVQ5YaL+M79G
        46oTDR6hCiA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C438113BBD;
        Wed, 10 Feb 2021 11:31:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 65440113BBC;
        Wed, 10 Feb 2021 11:31:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] rev-list --disk-usage
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
        <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
        <xmqqh7mkycno.fsf@gitster.c.googlers.com>
        <YCOu70m5SKU7L4CS@coredump.intra.peff.net>
Date:   Wed, 10 Feb 2021 08:31:08 -0800
In-Reply-To: <YCOu70m5SKU7L4CS@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 10 Feb 2021 05:01:19 -0500")
Message-ID: <xmqq1rdn51gz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62219A8A-6BBD-11EB-BC3C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But in practice, we've found this kind of naive --disk-usage useful for
> answering questions like:
>
>   - do I need all of these objects? Comparing "rev-list --disk-usage
>     --objects --all", "rev-list --disk-usage --objects --all --reflog",
>     and "du objects/pack/*.pack" will tell you if a prune/repack might
>     help, and whether expiring reflogs makes a difference.
>
>   - the size of the shared alternates repo for a set of forks has
>     jumped. Comparing "rev-list --disk-usage --objects --remotes=$base
>     --not --remotes=$fork" will tell you what's reachable from a fork
>     but not from the base (we use "refs/remotes/$id/*" to keep track of
>     fork refs in our alternates repo). This can be junk like somebody
>     forking git/git and then uploading a bunch of pirated video files.
>     :)
>
>   - likewise, the size of cloning a single repo may jump. Comparing
>     "rev-list --disk-usage --objects HEAD..$branch" for each branch
>     might show that one branch is an outlier (e.g., because somebody
>     accidentally committed a bunch of build artifacts).
>
> In those kinds of cases, it's not usually "oh, this version is twice as
> big as this other one". It's more like "wow, this branch is 100x as big
> as the other branches", and little decisions like delta direction are
> just noise. I imagine that in those cases the uncompressed object sizes
> would probably produce similar patterns and answers. But it's actually
> faster to produce the on-disk sizes. :)

Thanks.

I kind of feel sad to have a nice write-up like this only in the
list archive.  Is there a section in our documentation set to keep
collection of such a real-life use cases?  Perhaps the examples
section of manpages is the closest thing, but it looks a bit too
narrowly scoped for the example section of "rev-list" manpage.

THanks.

