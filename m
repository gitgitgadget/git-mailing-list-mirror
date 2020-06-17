Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A452BC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803F02168B
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgFQU4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:56:23 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:56681 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgFQU4X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:56:23 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 49nHRR3c21z5tlC;
        Wed, 17 Jun 2020 22:56:19 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9CCB11CA0;
        Wed, 17 Jun 2020 22:56:18 +0200 (CEST)
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the
 main branch name
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1612660e-aa49-5d7f-d47e-34740e330eaa@kdbg.org>
Date:   Wed, 17 Jun 2020 22:56:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.20 um 14:50 schrieb Johannes Schindelin via GitGitGadget:
> @@ -451,10 +451,12 @@ static void fmt_merge_msg_title(struct strbuf *out,
>  			strbuf_addf(out, " of %s", srcs.items[i].string);
>  	}
>  
> -	if (!strcmp("master", current_branch))
> +	main_branch = git_main_branch_name();
> +	if (!strcmp(main_branch, current_branch))
>  		strbuf_addch(out, '\n');
>  	else
>  		strbuf_addf(out, " into %s\n", current_branch);
> +	free(main_branch);
>  }

Now that the removal of this special case is on the plate, I would
prefer that the phrase "into foo" is never appended instead of always
appended.

For me, it was a always more of a hindrance than a help. The story goes
like this: A branch that I'm working on was named "edit-box-fix"
yesterday, but today it was renamed to "layout-fix" because the scope
changed. I had merged a topic "rename-buttons" yesterday, and now I have
to go back and rename that "into edit-box-fix" thing! Argh! And tomorrow
I'm going to branch off yet another feature "optional-reset" from
today's state that will be merged into upstream soon; "Merge branch
'rename-buttons' into layout-fix" will read strange in a history that
ends in "Merge branch 'optional-reset'".

And I haven't even mentioned this horrid "into HEAD", which you get
during a rebase operation.

To be clear, the branch name in "Merge branch 'option-reset'" is very
important and invaluable. But the "into foo" part is mostly noise.

-- Hannes
