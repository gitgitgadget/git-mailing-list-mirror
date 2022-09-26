Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FEBC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiIZRnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiIZRnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:43:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E333E3ECC0
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:11:28 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FD8A1C5CE2;
        Mon, 26 Sep 2022 13:11:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DPgKIu/HHu4Eb2Ak/DHCXISAcPQlYojsxxH/03
        wMIP8=; b=yS2elqdWpiICZ2ZVrnGAl0B0WoIjBrfWFSg3GVBjWugHpUmkEN1P6N
        im1NxfZjzD0bw7LWgtmxVNpqbY0BcG3litZQM5DKhPnR6qLv/5ZQ53r2PfhHzA+h
        z+LTMmN9ZB4uNYPec9S4dF3f8lyq8kyDxsVkEKrVeSfmviiwCPZuA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82E731C5CE1;
        Mon, 26 Sep 2022 13:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 980FA1C5CDF;
        Mon, 26 Sep 2022 13:11:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 4/4] diff-lib: parallelize run_diff_files for submodules
References: <20220922232947.631309-1-calvinwan@google.com>
        <20220922232947.631309-5-calvinwan@google.com>
        <88b194d9-7c78-c12e-1c29-95f768db7772@gmail.com>
Date:   Mon, 26 Sep 2022 10:11:21 -0700
In-Reply-To: <88b194d9-7c78-c12e-1c29-95f768db7772@gmail.com> (Phillip Wood's
        message of "Sun, 25 Sep 2022 14:59:15 +0100")
Message-ID: <xmqqedvyqcw6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EE118D2-3DBE-11ED-AF98-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	if (!strcmp(k, "status.parallelsubmodules")) {
>> +		s->parallel_jobs_submodules = git_config_int(k, v);
>> +		if (s->parallel_jobs_submodules < 0)
>> +			die(_("status.parallelsubmodules cannot be negative"));
>
> What does a value of zero mean?

Good question.  I don't remember what the code in the patch I read
actually does, but I would imagine we would want to be able to say:

 - I do not trust the parallel mode yet, just use the single process
   method that we have always been using.

 - I do not know how many cores I have, just use a reasonable
   default parallelism.

 - I want to use N processes because I know better than auto-scaling
   based on num_cpus.

And the value of 1 would be a reasonable way to express the first
one, and 0 would be a reasonable thing to do for the second one.

>> -int run_diff_files(struct rev_info *revs, unsigned int option)
>> +int run_diff_files(struct rev_info *revs, unsigned int option, int parallel_jobs)
>
> Another possibility would be to add a member to struct diff_opts,

Yes, absolutely.  Somewhere that is reachable from rev_info
structure would be more appropriate.

Thanks.
