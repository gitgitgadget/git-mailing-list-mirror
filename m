Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E841AC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 15:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiGUPsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiGUPs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 11:48:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5739288E2C
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:47:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC9731A9461;
        Thu, 21 Jul 2022 11:47:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RtmrBo51I/DdYt3+LhzJN+BCE5pNx79giqpPR5
        2ZVUk=; b=snWwn1JEeFgOrjWzbCc+OdhhsNDtHz296V+BdUzqw4QpgO7SCtjGBT
        HICjtCxSq1sReOK59bvSStezXLV/aJvVUFjLLJJoa+oYBgm8QAb2laRPLsajR6PG
        L83MVffipNPBF5h+2Cmq+EF+lqaGtnJGAIzmcZuTR6VgiTL2PUzDg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4B941A9460;
        Thu, 21 Jul 2022 11:47:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 807051A945F;
        Thu, 21 Jul 2022 11:47:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/7] merge-ort-wrappers: make printed message match
 the one from recursive
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <e39b2e15ece14ba2b1118ae95e0d90ed60589b41.1658391391.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 08:47:35 -0700
In-Reply-To: <e39b2e15ece14ba2b1118ae95e0d90ed60589b41.1658391391.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 21 Jul 2022
        08:16:25 +0000")
Message-ID: <xmqqsfmulb6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 716AC618-090C-11ED-9A44-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	if (head && repo_index_has_changes(opt->repo, head, &sb)) {
> -		fprintf(stderr, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> +		struct strbuf err = STRBUF_INIT;
> +		strbuf_addstr(&err, "error: ");
> +		strbuf_addf(&err, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
>  		    sb.buf);
> +		strbuf_addch(&err, '\n');
> +		fputs(err.buf, stderr);
> +		strbuf_release(&err);

Makes me wonder why this is not a mere

	error(_("Your local chagnes ... by merge:\n  %s"), sb.buf);

that reuses the exact string.  The err() function in merge-recursive.c 
is strangely complex (and probably buggy---if it is not buffering
output, it adds "error: " prefix to opt->obuf before calling vaddf
to add the message, and then sends that to error() to give it
another "error: " prefix), but all the above does is to send a
message to standard error stream.

>  		strbuf_release(&sb);
>  		return -1;
>  	}
