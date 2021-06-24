Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84602C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C1D613D3
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhFXOYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:24:17 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:64386 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFXOYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 10:24:16 -0400
Received: from host-78-147-180-220.as13285.net ([78.147.180.220] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lwQEs-0000Df-6K; Thu, 24 Jun 2021 15:21:55 +0100
Subject: Re: [PATCH 1/2] doc: pull: explain what is a fast-forward
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?V=c3=adt_Ondruch?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
Date:   Thu, 24 Jun 2021 15:21:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621175234.1079004-2-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/06/2021 18:52, Felipe Contreras wrote:
> We want users to know what is a fast-forward in order to understand the
> default warning.
>
> Let's expand the explanation in order to cover both the simple, and the
> complex cases with as much detail as possible.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-pull.txt | 41 ++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 5c3fb67c01..142df1c4a1 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -41,16 +41,41 @@ Assume the following history exists and the current branch is
>  ------------
>  	  A---B---C master on origin
>  	 /
> -    D---E---F---G master
> +    D---E master
>  	^
>  	origin/master in your repository
>  ------------
>  
>  Then "`git pull`" will fetch and replay the changes from the remote
>  `master` branch since it diverged from the local `master` (i.e., `E`)
> -until its current commit (`C`) on top of `master` and record the
> -result in a new commit along with the names of the two parent commits
> -and a log message from the user describing the changes.
> +until its current commit (`C`) on top of `master`.
> +
> +After the remote changes have been synchronized, the local `master` will
> +be fast-forwarded to the same commit as the remote one, therefore

Perhaps s/be fast-forwarded/have been 'fast-forward'ed/ ?
I.E. we highlight the term "fast-forward" (the purpose of the patch) and
we hint at the underlying mechanism of simply moving the branch pointer.

> +creating a linear history.
> +
> +------------
> +    D---E---A---B---C master, origin/master
> +------------
> +
> +However, a non-fast-forward case looks very different:
> +
> +------------
> +	  A---B---C origin/master
> +	 /
> +    D---E---F---G master
> +------------
> +
> +If there are additional changes in the local `master`, it's
> +not possible to fast-forward, so a decision must be made how to
> +synchronize the local, and remote brances.
> +
> +In these situations `git pull` will warn you about your possible
> +options, which are either merge (`--no-rebase`), or rebase (`--rebase`).
> +However, by default it will continue doing a merge.
> +
> +A merge will create a new commit with two parent commits (`G` and `C`)
> +and a log message describing the changes, which you can edit.
>  
>  ------------
>  	  A---B---C origin/master
> @@ -58,8 +83,11 @@ and a log message from the user describing the changes.
>      D---E---F---G---H master
>  ------------
>  
> +Once the merge commit is created (`H`), your local `master` branch has
> +incorporated the changes of the remote `master` branch.
> +
>  See linkgit:git-merge[1] for details, including how conflicts
> -are presented and handled.
> +are presented and handled, and also linkgit:git-rebase[1].
>  
>  In Git 1.7.0 or later, to cancel a conflicting merge, use
>  `git reset --merge`.  *Warning*: In older versions of Git, running 'git pull'
> @@ -248,7 +276,8 @@ version.
>  
>  SEE ALSO
>  --------
> -linkgit:git-fetch[1], linkgit:git-merge[1], linkgit:git-config[1]
> +linkgit:git-fetch[1], linkgit:git-merge[1], linkgit:git-rebase[1],
> +linkgit:git-config[1]
>  
>  GIT
>  ---

