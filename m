Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF6EC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBB860EE9
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346278AbhIMSFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:05:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:46416 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235302AbhIMSFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 14:05:19 -0400
Received: (qmail 20768 invoked by uid 109); 13 Sep 2021 18:04:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Sep 2021 18:04:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12357 invoked by uid 111); 13 Sep 2021 18:04:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Sep 2021 14:04:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Sep 2021 14:04:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/4] difftool: use run_command() API in run_file_diff()
Message-ID: <YT+SkhLsfE/yIqhN@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
 <patch-v2-3.4-2b093bd71fc-20210913T033204Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-3.4-2b093bd71fc-20210913T033204Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 05:35:39AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change the run_file_diff() function to use the run_command() API
> directly, instead of invoking the run_command_v_opt_cd_env() wrapper.
> 
> This allows it, like run_dir_diff(), to use the "args" from "struct
> strvec", instead of the "const char **argv" passed into
> cmd_difftool(). This will be used in the subsequent commit to get rid
> of OPT_ARGUMENT() from cmd_difftool().

It also fixes the existing leak of its "args" strvec.

I like the general direction here of putting the child_process in the
parent. There's a few opportunities for further cleanup it opens, but
I'm happy whether you want to pursue them or not (I'm also happy to do
them as real patches on top myself, but don't want to de-rail your
series).

>  static int run_file_diff(int prompt, const char *prefix,
> -			 int argc, const char **argv)
> +			 struct child_process *child)
>  {
> -	struct strvec args = STRVEC_INIT;
>  	const char *env[] = {
>  		"GIT_PAGER=", "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL,
>  		NULL
>  	};
> -	int i;
>  
>  	if (prompt > 0)
>  		env[2] = "GIT_DIFFTOOL_PROMPT=true";
>  	else if (!prompt)
>  		env[2] = "GIT_DIFFTOOL_NO_PROMPT=true";

This "save a NULL in env where we might stick something in later" is
ugly. Now that we have a child_process, it might be nicer as:

  strvec_push(&env.args, "GIT_PAGER=");
  strvec_push(&env.args, "GIT_EXTERNAL_DIFF=git-difftool--helper");
  if (prompt > 0)
	strvec_push(&env.args, "GIT_DIFFTOOL_PROMPT=true");
  else if (!prompt)
	strvec_push(&env.args, "GIT_DIFFTOOL_NO_PROMPT=true");

> +	child->git_cmd = 1;
> +	child->dir = prefix;

These are the same in run_dir_diff(). We could do more of the shared
prep of the child_process in the caller. Likewise, we might want to pick
up run_dir_diff()'s no_stdin and clean_on_exit settings (and unsetting
use_shell, but I think that is already pointless; it defaults to false
in the first place, and git_cmd takes precedence over it anyway).

-Peff
