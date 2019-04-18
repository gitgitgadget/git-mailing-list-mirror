Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9EB520248
	for <e@80x24.org>; Thu, 18 Apr 2019 14:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389279AbfDRObe (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 10:31:34 -0400
Received: from siwi.pair.com ([209.68.5.199]:34821 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388097AbfDRObe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 10:31:34 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 138213F484C;
        Thu, 18 Apr 2019 10:31:32 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:e120:4cef:6b87:913e] (unknown [IPv6:2001:4898:8010:0:ca56:4cef:6b87:913e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B6CF03F412C;
        Thu, 18 Apr 2019 10:31:31 -0400 (EDT)
Subject: Re: [PATCH 01/11] Start to implement a built-in version of `git add
 --interactive`
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.170.git.gitgitgadget@gmail.com>
 <12978dc248a2cd07c90559691b8a2add84f45394.1554917868.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3149b9ba-2f5a-46ce-ad89-4105ec217795@jeffhostetler.com>
Date:   Thu, 18 Apr 2019 10:31:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <12978dc248a2cd07c90559691b8a2add84f45394.1554917868.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/10/2019 1:37 PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This is hardly the first conversion of a Git command that is implemented
> as a script to a built-in. So far, the most successful strategy for such
> conversions has been to add a built-in helper and call that for more and
> more functionality from the script, as more and more parts are
> converted.
> 
> With the interactive add, we choose a different strategy. The sole
> reason for this is that on Windows (where such a conversion has the most
> benefits in terms of speed and robustness) we face the very specific
> problem that a `system()` call in Perl seems to close `stdin` in the
> parent process when the spawned process consumes even one character from
> `stdin`. And that just does not work for us here, as it would stop the
> main loop as soon as any interactive command was performed by the
> helper. Which is almost all of the commands in `git add -i`.
> 
> It is almost as if Perl told us once again that it does not want us to
> use it on Windows.
> 
> Instead, we follow the opposite route where we start with a bare-bones
> version of the built-in interactive add, guarded by the new
> `add.interactive.useBuiltin` config variable, and then add more and more
> functionality to it, until it is feature complete.
> 
> At this point, the built-in version of `git add -i` only states that it
> cannot do anything yet ;-)
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   Documentation/config/add.txt |  5 +++++
>   Makefile                     |  1 +
>   add-interactive.c            | 13 +++++++++++++
>   add-interactive.h            | 10 ++++++++++
>   builtin/add.c                | 16 +++++++++++++++-
>   t/README                     |  4 ++++
>   6 files changed, 48 insertions(+), 1 deletion(-)
>   create mode 100644 add-interactive.c
>   create mode 100644 add-interactive.h
> 
> diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
> index 4d753f006e..c9f748f81c 100644
> --- a/Documentation/config/add.txt
> +++ b/Documentation/config/add.txt
> @@ -5,3 +5,8 @@ add.ignore-errors (deprecated)::
>   	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
>   	as it does not follow the usual naming convention for configuration
>   	variables.
> +
> +add.interactive.useBuiltin::
> +	[EXPERIMENTAL] Set to `true` to use the experimental built-in
> +	implementation of the interactive version of linkgit:git-add[1]
> +	instead of the Perl script version. Is `false` by default.
> diff --git a/Makefile b/Makefile
> index c5240942f2..18e656a32f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -848,6 +848,7 @@ LIB_H = $(shell $(FIND) . \
>   	-name '*.h' -print)
>   
>   LIB_OBJS += abspath.o
> +LIB_OBJS += add-interactive.o
>   LIB_OBJS += advice.o
>   LIB_OBJS += alias.o
>   LIB_OBJS += alloc.o
> diff --git a/add-interactive.c b/add-interactive.c
> new file mode 100644
> index 0000000000..540bf185d8
> --- /dev/null
> +++ b/add-interactive.c
> @@ -0,0 +1,13 @@
> +#include "cache.h"
> +#include "add-interactive.h"
> +#include "config.h"
> +
> +int add_i_config(const char *var, const char *value, void *cb)
> +{
> +	return git_default_config(var, value, cb);
> +}
[...]
> diff --git a/builtin/add.c b/builtin/add.c
> index db2dfa4350..5a32a755c8 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
[...]
> +static int use_builtin_add_i;
[...]
> @@ -319,7 +324,12 @@ static int add_config(const char *var, const char *value, void *cb)
>   		ignore_add_errors = git_config_bool(var, value);
>   		return 0;
>   	}
> -	return git_default_config(var, value, cb);
> +	if (!strcmp(var, "add.interactive.usebuiltin")) {
> +		use_builtin_add_i = git_config_bool(var, value);
> +		return 0;
> +	}
> +
> +	return add_i_config(var, value, cb);
 >   }

Something about this split between add_config() in this file
and add_i_config() in add-interactive.c bothers me.  I'm not
saying it is wrong, but it bothers me.

Perhaps it is that we moved the call to git_default_config()
to add-interactive.c -- so correct behavior of the non-interactive
case depends on add-interactive.c to do the right thing.

Also, since we can't control the order of observed the k/v pairs,
we can't do "if (use_builtin_add_i) return add_i_config(...);"
And that wouldn't allow both versions to pickup a common config
setting (in their own static variables).

Currently, neither function looks at any other k/v pairs, so
this is a bit of a moot point, but I'm wondering if this should
look like this:

     int add_config(...)
     {
         // give add-interactive.c a chance to look at k/v pair, but
         // do not short-cut because we don't know yet whether we
         // will be interactive or not yet.
         (void)add_i_config(...);

         ...ignore_add_errors...
         ...use_builtin_add_i...

         return git_default_config(...);
     }

     int add_i_config(...)
     {
         return 0;
     }

or just inline everything here in add_config() and be done with it.


Jeff

