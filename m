Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999841F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 09:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJKQtj (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 12:49:39 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:42877 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeJKQti (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 12:49:38 -0400
Received: from [192.168.2.201] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id AXBXgyXUiVlGZAXBXgSUy0; Thu, 11 Oct 2018 10:23:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539249792;
        bh=BdBJEv4sQ1orY26rbrdEeoXTMUXCtsgEIlgw6n0aIEY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dthgENIsy/NSj0wS7LfOeRvEYVpd73VKdT3EtzVMhJN5HSxMJogV4KOYL5aPIcFaK
         hwUk7i9XPVVIpuyHbRl2Ju4uTnJCvqKEHja+JvKKfBEuqbv4w47IWpMPGMdSDOeN0+
         VYA4Rdy+MIOvMsJGBWoWi/jUvX1wvz+nv4Olovlw=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=PTeFIYmOIKF4yK0wqroA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revert & cherry-pick: run git gc --auto
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20181010193557.19052-1-avarab@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <20f33df8-7ba8-af26-e0c8-16152345c85b@talktalk.net>
Date:   Thu, 11 Oct 2018 10:23:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181010193557.19052-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKs0ppNZMq4VsxyKLpDHQDemJr770IfG9SRuj19pQC5pGZ9DxS0azqyYvsHfjfe2CifQ9q9kW41erydnODky+ZoRgws42GFHW6TPJEQW8rM7SWwbh3WZ
 GeAj0a3+vrPDF/sHTLFnNmRv4DlNAgUHgq2CFbCDLtCNDzFe+/lLoeFyCJe2SAcy+tMl/mF1Y623eG0vU4ZjPHZdOPQhciIJzWY7FMFntf6AhX7I1R90634U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 10/10/2018 20:35, Ævar Arnfjörð Bjarmason wrote:
> Expand on the work started in 095c741edd ("commit: run git gc --auto
> just before the post-commit hook", 2018-02-28) to run "gc --auto" in
> more commands where new objects can be created.
> 
> The notably missing commands are now "rebase" and "stash". Both are
> being rewritten in C, so any use of "gc --auto" there can wait for
> that.

If cherry-pick, revert or 'rebase -i' edit the commit message then they
fork 'git commit' so gc --auto will be run there anyway. I wonder if it
would be better to call 'gc --auto' from sequencer.c at the end of a
string of successful picks, that would cover cherry-pick, 'rebase -iu'
and revert. With 'rebase -i' it might be nice to avoid calling 'gc
--auto' until the very end, rather than every time we stop for an edit
but that is probably more trouble than it is worth.

Best Wishes

Phillip

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> After reading the "Users are encouraged to run this task..." paragraph
> in the git-gc manpage I was wondering if due to gc --auto all over the
> place now (including recently in git-commit with a patch of mine) if
> we shouldn't change that advice.
> 
> I'm meaning to send some doc changes to git-gc.txt, but in the
> meantime let's address this low-hanging fruit of running gc --auto
> when we revert or cherry-pick commits, which can like git-commit
> create a significant amount of loose objects.
> 
>  builtin/revert.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 9a66720cfc..1b20902910 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -209,6 +209,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>  {
>  	struct replay_opts opts = REPLAY_OPTS_INIT;
>  	int res;
> +	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
>  
>  	if (isatty(0))
>  		opts.edit = 1;
> @@ -217,6 +218,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>  	res = run_sequencer(argc, argv, &opts);
>  	if (res < 0)
>  		die(_("revert failed"));
> +	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>  	return res;
>  }
>  
> @@ -224,11 +226,13 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>  {
>  	struct replay_opts opts = REPLAY_OPTS_INIT;
>  	int res;
> +	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
>  
>  	opts.action = REPLAY_PICK;
>  	sequencer_init_config(&opts);
>  	res = run_sequencer(argc, argv, &opts);
>  	if (res < 0)
>  		die(_("cherry-pick failed"));
> +	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>  	return res;
>  }
> 

