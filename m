Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9CDC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 21:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE9061175
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 21:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhITVbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 17:31:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55495 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhITV3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 17:29:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 482FBEFA07;
        Mon, 20 Sep 2021 17:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=dD48K1/m8n25l5zUgyNaXewvT3tErdOhFehyR1pQ7u4=; b=MCfA
        fk7gjE7qabp74iyxpQNyRK3zaIZ3/IQzFMlv6G0Zi8gEM5nEzGl041imOailpC9q
        Qlk5H/iWafxX4IyyvBnYOnn3hwB2y7pXlSA3cFdz1lFcVDLP1HdnayGjlFKEUytq
        zu+eHDcsQOisOU7sjUVSvY903d5hYa+PrmAS6aE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F7D2EFA06;
        Mon, 20 Sep 2021 17:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B033EFA05;
        Mon, 20 Sep 2021 17:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v2 2/8] submodule--helper: get remote names from any
 repository
References: <20210907115932.36068-1-raykar.ath@gmail.com>
        <20210916103241.62376-1-raykar.ath@gmail.com>
        <20210916103241.62376-3-raykar.ath@gmail.com>
Date:   Mon, 20 Sep 2021 14:28:10 -0700
Message-ID: <xmqqczp39bth.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A81D6F28-1A59-11EC-8A29-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> +static char *get_default_remote_submodule(const char *module_path)
> +{
> +	const char *refname;
> +	const struct submodule *sub;
> +	struct repository subrepo;
> +
> +	refname = refs_resolve_ref_unsafe(get_submodule_ref_store(module_path),
> +					  "HEAD", 0, NULL, NULL);
> +	sub = submodule_from_path(the_repository, null_oid(), module_path);
> +	repo_submodule_init(&subrepo, the_repository, sub);
> +	return repo_get_default_remote(&subrepo, refname);
> +}

This call (and I think there is another call in this file) to
repo_submodule_init() is affected by what Jonathan's 8eb8dcf9
(repository: support unabsorbed in repo_submodule_init, 2021-09-09)
wants to do, namely to lose "struct submodule sub" as a parameter
and instead take the path to the module and the treeish name as
parameters to repo_submodule_init().

I _think_ I resolved the conflict correctly, but please double check
the result when it is pushed out later today, both of you.

Thanks.
