Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65311EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 18:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjGESM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGESM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 14:12:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6476170B
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 11:12:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 155291A3250;
        Wed,  5 Jul 2023 14:12:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dacNUVuo6Wndb3Gfp7OrpnarBHrxfxphdaT4CC
        IIwuM=; b=BcaVaN/bVJyHbLroqeZfWxVxdQNxfWMn2az41fcUvU7N9ZJZKiwYh0
        1Bby20P7wi7gABx5Y2DNIuStZDB/CucwdPytoK+WTQaakdtF8n2EvJ7oNxLwtoC6
        3sZcXtqorDMr0BwZNJwGy66jW++KK8qfpcB7bncCwo2uF3hqQQhs4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BD6C1A324F;
        Wed,  5 Jul 2023 14:12:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6156C1A324E;
        Wed,  5 Jul 2023 14:12:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230705060812.2865188-1-christian.couder@gmail.com>
        <20230705060812.2865188-6-christian.couder@gmail.com>
Date:   Wed, 05 Jul 2023 11:12:23 -0700
In-Reply-To: <20230705060812.2865188-6-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 5 Jul 2023 08:08:09 +0200")
Message-ID: <xmqqcz161b3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DF69798-1B5F-11EE-BA93-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +--filter=<filter-spec>::
> +	Remove objects matching the filter specification from the
> +	resulting packfile and put them into a separate packfile. Note
> +	that objects used in the working directory are not filtered
> +	out. So for the split to fully work, it's best to perform it
> +	in a bare repo and to use the `-a` and `-d` options along with
> +	this option.  See linkgit:git-rev-list[1] for valid
> +	`<filter-spec>` forms.

After running the command with this option once, we will have two
packfiles, one with objects that match and the other with objects
that do not match the filter spec.  Then what is the next step for
the user of this feature?  Moving the former to a slower storage
was cited as a motivation for the feature, but can the user tell
which one of these two packfiles is the one that consists of the
filtered out objects?  If there is no mechansim to do so, shouldn't
we have one to make this feature more usable?

At the level of "pack-objects" command, we report the new packfiles
so that the user does not have to take "ls .git/objects/pack" before
and after the operation to compare and learn which ones are new.
I do not think "repack" that is a Porcelain should do such a
reporting on its standard output, but that means either the feature
should probably be done at the plumbing level (i.e. "pack-objects"),
or the marking of the new packfiles needs to be done in a way that
tools can later find them out, e.g. on the filesystem, similar to
the way ".keep" marker tells which ones are not to be repacked, etc.
