Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62A02022D
	for <e@80x24.org>; Fri, 24 Feb 2017 01:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbdBXBVr (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 20:21:47 -0500
Received: from avasout01.plus.net ([84.93.230.227]:59462 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdBXBVr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 20:21:47 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id oRMj1u00122aPyA01RMkPe; Fri, 24 Feb 2017 01:21:45 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=IItyMknG c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=f1xUXf_OSEo9bSzRencA:9 a=QEXdDO2ut3YA:10
 a=nJcEw6yWrPvoIXZ49MH8:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 10/15] update submodules: add submodule_move_head
To:     Stefan Beller <sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
 <20170223225735.10994-11-sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <7e920dd5-3638-57d9-0ca1-3f8aed4d700b@ramsayjones.plus.com>
Date:   Fri, 24 Feb 2017 01:21:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170223225735.10994-11-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/02/17 22:57, Stefan Beller wrote:
> In later patches we introduce the options and flag for commands
> that modify the working directory, e.g. git-checkout.
> 
> This piece of code will be used universally for
> all these working tree modifications as it
> * supports dry run to answer the question:
>   "Is it safe to change the submodule to this new state?"
>   e.g. is it overwriting untracked files or are there local
>   changes that would be overwritten?
> * supports a force flag that can be used for resetting
>   the tree.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  submodule.h |   7 ++++
>  2 files changed, 142 insertions(+)
> 
> diff --git a/submodule.c b/submodule.c
> index 0b2596e88a..a2cf8c9376 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1239,6 +1239,141 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>  	return ret;
>  }
>  
> +static int submodule_has_dirty_index(const struct submodule *sub)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "diff-index", "--quiet", \
> +					"--cached", "HEAD", NULL);
> +	cp.no_stdin = 1;
> +	cp.no_stdout = 1;
> +	cp.dir = sub->path;
> +	if (start_command(&cp))
> +		die("could not recurse into submodule '%s'", sub->path);
> +
> +	return finish_command(&cp);
> +}
> +
> +void submodule_reset_index(const char *path)

I was just about to send a patch against the previous series
(in pu branch last night), but since you have sent another
version ...

In the last series this was called 'submodule_clean_index()'
and, since it is a file-local symbol, should be marked with
static. I haven't applied these patches to check, but the
interdiff in the cover letter leads me to believe that this
will also apply to the renamed function.

[The patch subject was also slightly different.]

ATB,
Ramsay Jones

