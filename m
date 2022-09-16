Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406FDC6FA86
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 20:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiIPULv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiIPULs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 16:11:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4C2AB1BA
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 13:11:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 034161490CD;
        Fri, 16 Sep 2022 16:11:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QAm5hHElhRnsRrwqhL8H45VZWPC+SAa7VmJHSi
        7ZEA4=; b=sz96RfGr8t5l60X/XdbEUG7Rt8I1jttgzoFr1P9LWfb0wJL7GuGwKD
        YGMtm7dszfw8u7psOs+a+h+dq6OWlFKCwaJ0+JsW/tBqaSz2LoLtXuGt7bo22kO7
        xFBqZKC3LpBE3VdioS8WmL6sqWOByDFjNubxKemYzdvEJoJFB3B+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED0D21490CC;
        Fri, 16 Sep 2022 16:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5ADA11490CB;
        Fri, 16 Sep 2022 16:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v7 2/6] fsmonitor: relocate socket file if .git
 directory is remote
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
        <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
        <075340bd2a713905d8bee4f53765dcbcba9a17c4.1663358014.git.gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 13:11:42 -0700
In-Reply-To: <075340bd2a713905d8bee4f53765dcbcba9a17c4.1663358014.git.gitgitgadget@gmail.com>
        (Eric DeCosta via GitGitGadget's message of "Fri, 16 Sep 2022 19:53:30
        +0000")
Message-ID: <xmqqy1ujf5a9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C86BDEA4-35FB-11ED-B6D6-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +const char *fsmonitor_ipc__get_path(struct repository *r)
> +{
> +	static const char *ipc_path;
> +	SHA_CTX sha1ctx;
> +	char *sock_dir;
> +	struct strbuf ipc_file = STRBUF_INIT;
> +	unsigned char hash[SHA_DIGEST_LENGTH];
> +
> +	if (ipc_path)
> +		return ipc_path;
> +
> +	if (!r)
> +		r = the_repository;

I'd prefer not to see this "NULL means the_repository".  It would be
a different story if the caller does not necessarily have a ready
access to the_repository, but it is a global, so the caller can pass
the_repository and be more explicit.  Giving two ways to the caller
to express same thing is not a good idea.

Thanks.

