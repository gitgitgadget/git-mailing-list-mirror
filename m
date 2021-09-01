Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475E4C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DC661027
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 16:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245236AbhIAQSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 12:18:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54816 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbhIAQSB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 12:18:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B194214E8FF;
        Wed,  1 Sep 2021 12:17:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=biWmlO2ycWoFGr0ckko5jE73XcGg6IIl+emV7A
        A5No8=; b=CWyjvtXOUxWt7PoFIt2GZXQBOBTcONqYglbsXfuVTBHiHsEq4xg8dq
        lLi1J/oBKyz8FOW7G7CHMGigi2K5DOYHK6lbRqU5wxJtacGzQFGOwsB9Uw0LRMIs
        Jcna+liN/Ieve+FqJatKwXVPHBbdQtFvMBJXY0yl13Jpu4KYtVBqQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA6C514E8FE;
        Wed,  1 Sep 2021 12:17:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F1B6D14E8FB;
        Wed,  1 Sep 2021 12:17:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 04/15] scalar: 'register' sets recommended config and
 starts maintenance
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <3786f4c597fffc13f638efd26875dcb257d54ab4.1630359290.git.gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 09:16:59 -0700
In-Reply-To: <3786f4c597fffc13f638efd26875dcb257d54ab4.1630359290.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 30 Aug 2021
        21:34:39 +0000")
Message-ID: <xmqq5yvks22s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09B13496-0B40-11EC-8A18-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void setup_enlistment_directory(int argc, const char **argv,
> +				       const char * const *usagestr,
> +				       const struct option *options,
> +				       struct strbuf *enlistment_root)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	char *root;
> +	int enlistment_found = 0;
> +
> +	if (startup_info->have_repository)
> +		BUG("gitdir already set up?!?");
> +
> +	if (argc > 1)
> +		usage_with_options(usagestr, options);
> +
> +	/* find the worktree, determine its corresponding root */
> +	if (argc == 1)
> +		strbuf_add_absolute_path(&path, argv[0]);
> +	else if (strbuf_getcwd(&path) < 0)
> +		die(_("need a working directory"));
> +
> +	strbuf_trim_trailing_dir_sep(&path);
> +	do {
> +		const size_t len = path.len;
> +
> +		/* check if currently in enlistment root with src/ workdir */
> +		strbuf_addstr(&path, "/src/.git");
> +		if (is_git_directory(path.buf)) {
> +			strbuf_strip_suffix(&path, "/.git");
> +
> +			if (enlistment_root)
> +				strbuf_add(enlistment_root, path.buf, len);
> +
> +			enlistment_found = 1;
> +			break;
> +		}

This special casing of "normally the top of the working tree is
enlisted, but if the repository is called src/, then we enslist
one level up" is a bit of eyesore because

 (1) it is unclear why such a directory with 'src/' subdirectory is
     so special, and

 (2) it fails to serve those who has the same need but named their
     source subdirectory differently (like 'source/').

"The design decisions we made are all part of being opinionated" can
all explain it away, but at least we should let the users know where
the opinionated choices scalar makes want to lead them to, and this
"src/" stuff needs a bit of clarification.  Perhaps a documentation
will be added in later steps?

> +	for (i = 0; config[i].key; i++) {
> +		if (git_config_get_string(config[i].key, &value)) {
> +			trace2_data_string("scalar", the_repository, config[i].key, "created");
> +			if (git_config_set_gently(config[i].key,
> +						  config[i].value) < 0)
> +				return error(_("could not configure %s=%s"),
> +					     config[i].key, config[i].value);
> +		} else {
> +			trace2_data_string("scalar", the_repository, config[i].key, "exists");
> +			free(value);
> +		}

I wonder if we should have a table of configuration variables and
their default values.  The above code implements a skewed "we only
avoid overriding what is explicitly configured".  A variable that
the user left unconfigured because the user found its default
satisfactory will be overridden, and if the value scalar wants to
use happens to be the default value, we leave an explicit
configuration to that default value in the resulting configuration
file.

But I think the above is the best we can do without such a central
registry of configuration variables.
