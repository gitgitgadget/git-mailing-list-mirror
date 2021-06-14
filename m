Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F09C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 05:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34158613C0
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 05:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhFNFL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 01:11:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65199 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhFNFLW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 01:11:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F2C1133EDC;
        Mon, 14 Jun 2021 01:09:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wx+H+YiwtMrOLyO27cDXDAGPIJzz9pN9b30SeI
        O9FZQ=; b=DY6faqqMbbpiH1mkL4B7ICvQ6z0v+BPrJYHemZnXy5loTVEyn/QYvv
        ABTckAPPMjRG5w/iYZT2s6v4HrcD7wHEMlgWFynB5S9/fSgGDhF85O/B7AdB3osE
        zlhuM5ZHOrtoH9ulsD76jbEGmFK5Lzay7DYOAtgU1a0kzARq3tzb0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D5D9133EDB;
        Mon, 14 Jun 2021 01:09:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3144133EDA;
        Mon, 14 Jun 2021 01:09:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] introduce submodule.superprojectGitDir cache
References: <20210611225428.1208973-1-emilyshaffer@google.com>
        <20210611225428.1208973-3-emilyshaffer@google.com>
Date:   Mon, 14 Jun 2021 14:09:15 +0900
In-Reply-To: <20210611225428.1208973-3-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 11 Jun 2021 15:54:26 -0700")
Message-ID: <xmqqzgvtxcas.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB7F2A4A-CCCE-11EB-8115-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Teach submodules a reference to their superproject's gitdir. This allows
> us to A) know that we're running from a submodule, and B) have a
> shortcut to the superproject's vitals, for example, configs.
>
> By using a relative path instead of an absolute path, we can move the
> superproject directory around on the filesystem without breaking the
> submodule's cache.

As the function this new thing is added assumes the modern layout of
having submodule "repository" in .git/modules/* of the repository of
the superproject, it is rather easy to move the whole thing together,
so recording it as relative path is all the more important.

Can a submodule repository be bound to two or more superproject at
the same time?  "We assume no, and we will forbid such a layout, and
that is why we can afford to make submodules aware of their
superprojects" is a totally acceptable answer, but it would make it
easier to follow the reasoning behind a design change like this
series does if such an assumption is recorded somewhere.

> +	git_config_set_in_file(p, "submodule.superprojectGitdir",
> +			       relative_path(absolute_path(get_git_dir()),
> +					     path, &sb));
> +

OK, so even when the superproject is used as a submodule of somebody
else, we could get to the top of its working tree, because (1) the
submodule we are currently working in can find out where the gitdir
of the superproject is, and (2) in that gitdir, which is very likely
different from the ".git/" subdirectory of the working tree of the
superproject (instead, it would be a directory in ".git/modules/" of
its superproject), we could find the core.worktree configuration to
reach the working tree of the superproject.

OK, makes sense.

Thanks.
