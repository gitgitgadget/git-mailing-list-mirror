Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC0DC47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 20:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD1C60E09
	for <git@archiver.kernel.org>; Sat, 29 May 2021 20:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhE2UjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 16:39:06 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:32919 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhE2UjF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 16:39:05 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ln5i1-000BNS-5c; Sat, 29 May 2021 21:37:26 +0100
Subject: Re: [PATCH v2 0/6] Unconvolutize push.default=simple
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <ad0751c3-654f-04d4-5ad1-c0aea91b46b8@iee.email>
Date:   Sat, 29 May 2021 21:37:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/05/2021 08:11, Felipe Contreras wrote:
> Tired of jumping through hoops trying to understand what the "simple"
> mode does, I decided to reorganize it up for good so it's crystal
> clear.
>
> There are no functional changes.
>
> Basically the simple mode pushes the current branch with the same name
> on the remote.
>
> Except... when there's no upstream branch configured with the same name.
>
> Now the code and the documentation are clear.

Not your problem, but I do note, as a general point, that we don't
explain the different variants of Triangular workflow anywhere [just two
mentions in gitrevisions.txt] (e.g. patch flow versus server-side
merges, etc.). 


Philip
>
> This is basically the same as v1, except I removed a bunch of patches which are now part of a
> different series. Also, I updated some commit messages with suggestions from Elijah Newren.
>
> The result of this series is in short this function:
>
> static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
> {
> 	if (!branch)
> 		die(_(message_detached_head_die), remote->name);
>
> 	if (!triangular) {
> 		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
> 			die(_("The current branch %s has no upstream branch.\n"
> 			    "To push the current branch and set the remote as upstream, use\n"
> 			    "\n"
> 			    "    git push --set-upstream %s %s\n"),
> 			    branch->name,
> 			    remote->name,
> 			    branch->name);
> 		if (branch->merge_nr != 1)
> 			die(_("The current branch %s has multiple upstream branches, "
> 			    "refusing to push."), branch->name);
>
> 		/* Additional safety */
> 		if (strcmp(branch->refname, branch->merge[0]->src))
> 			die_push_simple(branch, remote);
> 	}
> 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
> }
>
> Felipe Contreras (6):
>   push: hedge code of default=simple
>   push: move code to setup_push_simple()
>   push: reorganize setup_push_simple()
>   push: simplify setup_push_simple()
>   push: remove unused code in setup_push_upstream()
>   doc: push: explain default=simple correctly
>
>  Documentation/config/push.txt | 13 ++++++------
>  builtin/push.c                | 40 ++++++++++++++++++++++++-----------
>  2 files changed, 34 insertions(+), 19 deletions(-)
>
> Range-diff against v1:
>  1:  2856711eb3 !  1:  f1f42bda32 push: hedge code of default=simple
>     @@ Commit message
>          `simple` is the most important mode so move the relevant code to its own
>          function to make it easier to see what it's doing.
>      
>     +    Reviewed-by: Elijah Newren <newren@gmail.com>
>          Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>      
>       ## builtin/push.c ##
>  2:  33acb09e82 !  2:  bb6d810011 push: move code to setup_push_simple()
>     @@ Commit message
>      
>          The code is copied exactly as-is; no functional changes.
>      
>     +    Reviewed-by: Elijah Newren <newren@gmail.com>
>          Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>      
>       ## builtin/push.c ##
>  3:  de1b621b7e !  3:  d66a442fba push: reorganize setup_push_simple()
>     @@ Metadata
>       ## Commit message ##
>          push: reorganize setup_push_simple()
>      
>     -    Simply move the code around.
>     +    Simply move the code around and remove dead code. In particular the
>     +    'trivial' conditional is a no-op since that part of the code is the
>     +    !trivial leg of the conditional beforehand.
>      
>          No functional changes.
>      
>     +    Suggestions-by: Elijah Newren <newren@gmail.com>
>          Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>      
>       ## builtin/push.c ##
>  4:  83efcad143 !  4:  eaae6a826a push: simplify setup_push_simple()
>     @@ Metadata
>       ## Commit message ##
>          push: simplify setup_push_simple()
>      
>     -    branch->refname can never be different from branch->merge[0]->src.
>     +    There's a safety check to make sure branch->refname is not different
>     +    from branch->merge[0]->src, otherwise we die().
>      
>     +    Therefore we always push to branch->refname.
>     +
>     +    Suggestions-by: Elijah Newren <newren@gmail.com>
>          Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>      
>       ## builtin/push.c ##
>  5:  d7489e9545 =  5:  8d9ae5e552 push: remove unused code in setup_push_upstream()
>  6:  e693341403 <  -:  ---------- push: merge current and simple
>  7:  830a57c867 <  -:  ---------- push: remove redundant check
>  8:  d2dded5998 <  -:  ---------- push: fix Yoda condition
>  9:  7528738091 <  -:  ---------- push: remove trivial function
> 10:  1ae0546df6 <  -:  ---------- push: flip !triangular for centralized
> 11:  3acd42e385 !  6:  b35bdf14dc doc: push: explain default=simple correctly
>     @@ Metadata
>       ## Commit message ##
>          doc: push: explain default=simple correctly
>      
>     -    Now that the code has been unconvolutized and it's clear what it's
>     +    Now that the code has been simplified and it's clear what it's
>          actually doing, update the documentation to reflect that.
>      
>          Namely; the simple mode only barfs when working on a centralized

