Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E49C1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 17:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfBURl5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 12:41:57 -0500
Received: from avasout04.plus.net ([212.159.14.19]:49861 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBURl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 12:41:57 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id wsM6gR5bAAOoywsM7gbp11; Thu, 21 Feb 2019 17:41:55 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=vaJtXVxTAAAA:8 a=pGLkceISAAAA:8 a=fQSkxHNNLfOiytYfSZAA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 1/1] worktree add: sanitize worktree names
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, hi-angel@yandex.ru, sunshine@sunshineco.com
References: <20190221110026.23135-1-pclouds@gmail.com>
 <20190221121943.19778-1-pclouds@gmail.com>
 <20190221121943.19778-2-pclouds@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6fe399f0-98ad-37e6-f4b1-3a3f6e4bce03@ramsayjones.plus.com>
Date:   Thu, 21 Feb 2019 17:41:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221121943.19778-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfObJzbX4RMOsVOZT7BRMpE56yysipu0DKo/YKzbzA+rF09OqPgOZgU6UNLvDXeyxyuw7YofSp0oEIBt3PH8rHHkprWm5SlmUz1+EngorjFnAtRZ5uz16
 MDJmzjukyf9EUw/Fc0Stp75fxAnC7MHlLjtjTkx0F9WObbhTpcZ1nDFJa/SW2uDTSfb9C6M4e28LKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21/02/2019 12:19, Nguyễn Thái Ngọc Duy wrote:
> Worktree names are based on $(basename $GIT_WORK_TREE). They aren't
> significant until 3a3b9d8cde (refs: new ref types to make per-worktree
> refs visible to all worktrees - 2018-10-21), where worktree name could
> be part of a refname and must follow refname rules.
> 
> Update 'worktree add' code to remove special characters to follow
> these rules. The code could replace chars with '-' more than
> necessary, but it keeps the code simple. In the future the user will
> be able to specify the worktree name by themselves if they're not
> happy with this dumb character substitution.
> 
> Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/worktree.c      | 51 ++++++++++++++++++++++++++++++++++++++++-
>  t/t2025-worktree-add.sh |  7 ++++++
>  2 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 3f9907fcc9..53e41db229 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -262,6 +262,50 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
>  	free_worktrees(worktrees);
>  }
>  
> +/*
> + * worktree name is part of refname and has to pass
> + * check_refname_component(). Remove unallowed characters to make it
> + * valid.
> + */
> +static void sanitize_worktree_name(struct strbuf *name)
> +{
> +	char *orig_name = xstrdup(name->buf);
> +	int i;
> +
> +	/*
> +	 * All special chars replaced with dashes. See
> +	 * check_refname_component() for reference.
> +	 * Note that .lock is also turned to -lock, removing its
> +	 * special status.
> +	 */
> +	for (i = 0; i < name->len; i++) {
> +		if (strchr(":?[]\\~ \t@{}*/.", name->buf[i]))
> +			name->buf[i] = '-';
> +	}
> +
> +	/* remove consecutive dashes, leading or trailing dashes */

Why? So, '[fred]' will be 'sanitized' to 'fred' (rather than '-fred-'),
which would increase the chance of a 'collision' with the 'fred'
worktree (not very likely, but still). Is that useful? How about
'x86_64-*-gnu' which now becomes 'x86_64-gnu'?
 
> +	for (i = 0; i < name->len; i++) {
> +		while (name->buf[i] == '-' &&
> +		       (i == 0 ||
> +			i == name->len - 1 ||
> +			(i < name->len - 1 && name->buf[i + 1] == '-')))
> +			strbuf_remove(name, i, 1);
> +	}
> +
> +	/*
> +	 * a worktree name of only special chars would be reduced to
> +	 * an empty string
> +	 */> +	if (name->len == 0)
> +		strbuf_addstr(name, "worktree");

If you didn't 'collapse' the name above, you could check for
an empty name at the top and wouldn't need this (presumably
an empty name would not be valid).

ATB,
Ramsay Jones
