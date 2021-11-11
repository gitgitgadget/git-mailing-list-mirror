Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8812C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 20:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AFE61002
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 20:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhKKU1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:27:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57136 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhKKU1h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 15:27:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CD97F22F2;
        Thu, 11 Nov 2021 15:24:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cJYdQFoxPb+8c43Ihy4aLxR+lUIfLmlDOPiT2U
        qNXqU=; b=cJt7gmo3Pu2PKnufnNoCX/dVfnbVC2yph7xdXOHnIgeBZIlKZ3iWN4
        mXfM+sel23wEjIhVO2kD+jJ9jacK15gAVPfv4zPTp0yYUa1jim3xS9StPCzXlD2T
        aPT8o1nUbx4W3aWhzZlTQTYBcs7D6G7vtsIk/CAabjzg/iakIPyYM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41EDCF22F1;
        Thu, 11 Nov 2021 15:24:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1AFFF22F0;
        Thu, 11 Nov 2021 15:24:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 2/3] config: introduce repo_config_set* functions
References: <20211111171643.13805-1-chooglen@google.com>
        <20211111171643.13805-3-chooglen@google.com>
Date:   Thu, 11 Nov 2021 12:24:45 -0800
In-Reply-To: <20211111171643.13805-3-chooglen@google.com> (Glen Choo's message
        of "Thu, 11 Nov 2021 09:16:42 -0800")
Message-ID: <xmqq7ddel9te.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69A75284-432D-11EC-8EA9-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> We have git_config_set() that sets a config value for the_repository's
> config file, and repo_config_get* that reads config values from a struct
> repository. Thus, it seems reasonable to have to have
> repo_git_config_set() that can set values for a config file of a struct
> repository.
>
> Implement repo_config_set() and repo_config_set_gently(), which
> take struct repository. However, unlike other instances where struct
> repository is added to a repo_* function, this patch does not change the
> implementations of git_config_set() or git_config_set_gently(); those
> functions use the_repository much deeper in their call chain through
> git_pathdup(). Mark this inconsistency as NEEDSWORK.

Being able to only affect "config" in the_repository->gitdir is less
flexible than being able to affect "config" in repo->gitdir for any
repository is good.  Do we need a similar thing for repo->commondir
as well?

> +/*
> + * Sets a config value in a repository.
> + */
> +int repo_config_set_gently(struct repository *r, const char *key,
> +			   const char *value)
> +{
> +	int ret;
> +	char *path;
> +
> +	path = repo_git_path(r, "config");
> +	ret = git_config_set_in_file_gently(path, key, value);
> +	free(path);
> +	return ret;
> +}
> +
> +void repo_config_set(struct repository *r, const char *key, const char *value)
> +{
> +	char *path;
> +
> +	path = repo_git_path(r, "config");
> +	git_config_set_in_file(path, key, value);
> +	free(path);
> +}

Many questions:

 - What do these do for an existing key?  Add another value?
   Replace existing one?  If the latter, what do we plan to do with
   multi-valued keys?

 - Don't we need an interface to remove, rename, etc.?

 - If we call repo_config_set(repo, "key", "value") and then call
   repo_git_config_string(repo, "key", &value) on the same
   repository, do we read the value back or do we give a stale
   value?

 - A change like this should make existing config_set() that only
   works on the_repository into a thin wrapper, e.g.

	void git_config_set(const char *keyu, const char **value)
	{
		repo_config_set(the_repository, key, value);
	}

   But that is not happening here.  What prevents us from doing so?

Thanks.
