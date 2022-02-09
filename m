Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9572C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 17:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbiBIRtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbiBIRtk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 12:49:40 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD19C05CB86
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 09:49:43 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 087CF18E27B;
        Wed,  9 Feb 2022 12:49:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HWSOE7T2opAP3RAixtgkA3jJTY1JzZVuQ/5Pje
        i4qtQ=; b=SLbuL/M7prpNDtxbo6pF0euHokYu5ZDnZ3rOrwnyvS2clYxltN/9ZJ
        b35pXJj3ktE14YcQ0wunHEBgLhB3ZqOXWN/Ql73GTwSa5wz8fHlk2iuIsXwgjKd9
        mBW5fApi8UouAiF8AEBx59ef9WWBKZh0/Rzjdn6AzXLNFIEtym77A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3C2118E27A;
        Wed,  9 Feb 2022 12:49:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1387C18E277;
        Wed,  9 Feb 2022 12:49:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        allred.sean@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 3/6] config: add repo_config_set_worktree_gently()
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
        <cf9e86fe3a403d0ceaff9fdf484a9bf6b07799ac.1644269583.git.gitgitgadget@gmail.com>
        <xmqqv8xpato3.fsf@gitster.g>
        <ab6021a8-cbb9-3261-8e08-bb4a83287473@gmail.com>
Date:   Wed, 09 Feb 2022 09:49:36 -0800
In-Reply-To: <ab6021a8-cbb9-3261-8e08-bb4a83287473@gmail.com> (Derrick
        Stolee's message of "Tue, 8 Feb 2022 21:27:16 -0500")
Message-ID: <xmqqzgn07wwf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A67BD858-89D0-11EC-8FD5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 2/8/2022 5:18 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> ...
>>> @@ -3181,14 +3196,28 @@ void git_config_set_multivar_in_file(const char *config_filename,
>>>  int git_config_set_multivar_gently(const char *key, const char *value,
>>>  				   const char *value_pattern, unsigned flags)
>>>  {
>>> -	return git_config_set_multivar_in_file_gently(NULL, key, value, value_pattern,
>>> -						      flags);
>>> +	return repo_config_set_multivar_gently(the_repository, key, value,
>>> +					       value_pattern, flags);
>>> +}
>> 
>> Is this an unrelated "morally no-op" change?
>
> This one is to match the pattern of how "git_*" methods should
> depend on their "repo_*" counterparts (with "the_repository" inserted
> properly). So, it's part of the standard process for creating these
> "repo_*" variants.

If only one of repo_config_set_multivar_gently() and
git_config_set_multivar_gently() existed and we were completing the
pair, then I would understand the explanation, but the title says
that it is adding repo_config_set_worktree_gently(), which is not,
and that is where the "unrelated" comes from.

It needs to be a separate preparatory step to add
repo_config_set_multivar_gently() before we add
repo_config_set_worktree_gently(), perhaps?

A bit higher level question is if the public part of "config-set"
API functions should gain an "easy" (in the sense of curl_easy_* set
of API functions) API to allow the callers to say "I do not care to
find out if per-worktree configuration is in use, or this particular
variable is meant to be per-worktree, just set it to this value".

On this question, I am of two minds.  As certain variables (like
core.sparseCheckout) should always be per-worktree just like certain
refs (like HEAD) should always be per-worktree, I can understand the
viewpoint that the callers _ought_ to know and explicitly say that
they want to get/set in the per-worktree configuration file, but at
the same time, I would think the callers should not have to care.
So, I dunno.

Thanks.
