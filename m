Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B961AC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 14:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiEXOCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 10:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbiEXOCb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 10:02:31 -0400
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [IPv6:2001:19f0:5:727:1e84:17da:7c52:5ab4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502C62CC3
        for <git@vger.kernel.org>; Tue, 24 May 2022 07:02:30 -0700 (PDT)
Received: from kevinolos.kevinlocke.name (unknown [69.145.56.143])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 4EA602E7836D;
        Tue, 24 May 2022 14:02:28 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id F1E28130035B; Tue, 24 May 2022 08:02:15 -0600 (MDT)
Date:   Tue, 24 May 2022 08:02:15 -0600
From:   Kevin Locke <kevin@kevinlocke.name>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] setup: don't die if realpath(3) fails on getcwd(3)
Message-ID: <YozlZ9DPrRLPBTBP@kevinlocke.name>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
 <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
 <1580ad10-43f6-bc73-901a-b65b1aea73ff@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580ad10-43f6-bc73-901a-b65b1aea73ff@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2022-05-23 at 14:57 -0400, Derrick Stolee wrote:
> On 5/21/22 9:53 AM, Kevin Locke wrote:
> > +		free((char*)tmp_original_cwd);
> 
> Hm. I'm never a fan of this casting, but it existed before. It's
> because tmp_original_cwd is exposed globally in cache.h, which
> is _really widely_. However, there are only two uses: setup.c,
> which defines it, and common-main.c, which initializes it during
> process startup.
> 
> The following diff could apply before your commit, removing this
> use of "const char *", but maybe it doesn't fit normal Git
> coding guidelines (putting the extern directly in a *.c file):
> 
> --- >8 ---
> 
> diff --git a/cache.h b/cache.h
> index aaf334e2aa4..ce9cd6fa3f0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1797,7 +1797,6 @@ struct startup_info {
>  	const char *original_cwd;
>  };
>  extern struct startup_info *startup_info;
> -extern const char *tmp_original_cwd;
>  
>  /* merge.c */
>  struct commit_list;
> diff --git a/common-main.c b/common-main.c
> index 29fb7452f8a..e472258b83b 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -23,6 +23,8 @@ static void restore_sigpipe_to_default(void)
>  	signal(SIGPIPE, SIG_DFL);
>  }
>  
> +extern char *tmp_original_cwd;
> +
>  int main(int argc, const char **argv)
>  {
>  	int result;
> diff --git a/setup.c b/setup.c
> index 04ce33cdcd4..86986317490 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -12,7 +12,7 @@ static int work_tree_config_is_bogus;
>  
>  static struct startup_info the_startup_info;
>  struct startup_info *startup_info = &the_startup_info;
> -const char *tmp_original_cwd;
> +char *tmp_original_cwd;
>  
>  /*
>   * The input parameter must contain an absolute path, and it must already be
> @@ -459,7 +459,7 @@ static void setup_original_cwd(void)
>  
>  	/* Normalize the directory */
>  	strbuf_realpath(&tmp, tmp_original_cwd, 1);
> -	free((char*)tmp_original_cwd);
> +	free(tmp_original_cwd);
>  	tmp_original_cwd = NULL;
>  	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
>  
> --- >8 ---

This approach seems reasonable to me, as does casting to free().  It's
not clear to me which is preferable in this case.  How to balance the
trade-offs between exposing const interfaces, limiting (internal)
interfaces to headers, and avoiding casts might be worth discussing
and documenting a matter of project coding style.  `grep -rF 'free(('`
lists about 100 casts to free, suggesting the discussion may be
worthwhile.  Introducing a free_const() macro could be another option
to consider.

>> +		tmp_original_cwd = NULL;
>> +		startup_info->original_cwd = strbuf_detach(&tmp, NULL);
>> +	} else {
>> +		trace_printf("realpath(cwd) failed: %s\n", strerror(errno));
> 
> It could also be helpful to include a trace2 output, since
> most modern tracing uses that mechanism:
> 
> 		trace2_data_string("setup", the_repository,
> 				   "realpath-path", tmp_original_cwd);
> 		trace2_data_string("setup", the_repository,
> 				   "realpath-failure", strerror(errno));
> 
> But this is also unlikely to be necessary. We can instruct
> a user to rerun their command with GIT_TRACE=1 if we see
> this error in the wild.

That's a great idea.  I hadn't realized the difference between the
trace_* and trace2_* APIs until investigating as a result of your
suggestion.  Trace2 seems preferable for many reasons.  I'll send an
updated patch shortly.

Thanks for the review and feedback Stolee!

Cheers,
Kevin
