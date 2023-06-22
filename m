Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B460EB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 10:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjFVKNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 06:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFVKNT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 06:13:19 -0400
X-Greylist: delayed 707 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 03:13:18 PDT
Received: from out-47.mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F6DDD
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 03:13:17 -0700 (PDT)
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
 <20230602102533.876905-15-christian.couder@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
        t=1687428796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U623IlDd8LZfxNxaM96hZ+BABNDgWKjDaN941jhpHEo=;
        b=OAuPS+mymPIa7Mle6X09iXb0ckPaNDJ6f6iL911rewyTSmx4YioRzTo4d5pVuR4DSUswwH
        lJ2RGYabPy9mE28IeIH+lXh7lPJrwpTTlyBpWN9tRapGA68Fp1KM/LHwNXEei8NqWeYAgg
        gk4oT9xsqhGRoQLYNcnKKR5OQWjQtUs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Toon Claes <toon@iotcl.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 14/15] replay: add --contained to rebase contained
 branches
Date:   Thu, 22 Jun 2023 12:10:51 +0200
In-reply-to: <20230602102533.876905-15-christian.couder@gmail.com>
Message-ID: <87cz1nst1s.fsf@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
> index 439b2f92e7..6fcaa44ef2 100644
> --- a/Documentation/git-replay.txt
> +++ b/Documentation/git-replay.txt
> @@ -9,7 +9,7 @@ git-replay - Replay commits on a different base, without touching working tree
>  SYNOPSIS
>  --------
>  [verse]
> -'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
> +'git replay' ([--contained] --onto <newbase> | --advance <branch>)
> <revision-range>...

I'm not sure we need this, or at least not right now.
I've been testing with a repo having:

* a13d9c4 (another-feature) yet another commit
* c7afc2e (HEAD -> feature) third commit
* e95cecc second commit
* f141e77 first commit
| * 7bb62ac (main) later commit
| * 506cb0a another commit
|/
* e7acac6 initial commit

I tried both commands:

$ git replay --onto main main..feature main..another-feature
$ git replay --onto main --contained main..another-feature

and they both give the same result (especially with the commit following
up this one). What is the upside of having this --contained option?

Maybe it's better to defer this patch to a separate series.

And another question, in git-rebase(1) a similar option is called
--update-refs. Would you consider reusing that name here is a good idea
for consistency?

> diff --git a/builtin/replay.c b/builtin/replay.c
> index 4b64d15159..9b182eaa90 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -303,6 +306,10 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
>  		usage_with_options(replay_usage, replay_options);
>  	}
>
> +	if (advance_name && contained)
> +		die(_("options '%s' and '%s' cannot be used together"),
> +		    "--advance", "--contained");

Is there a technical issue why we don't support this? I don't really see
why we couldn't.

--
Toon
