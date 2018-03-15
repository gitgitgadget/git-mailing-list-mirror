Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A29D1FAE2
	for <e@80x24.org>; Thu, 15 Mar 2018 10:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeCOK7o (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 06:59:44 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:31980 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeCOK7m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 06:59:42 -0400
Received: from [192.168.2.201] ([89.242.187.47])
        by smtp.talktalk.net with SMTP
        id wQblebawWwheawQblen7xF; Thu, 15 Mar 2018 10:59:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521111581;
        bh=wM/ogOuqNam+wrFD7eXDR1Vsogd6tqT7K5IQ5U4PzQg=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=jnlMj/akxVpMMBDosxn04mFlZxV7hyBubkBRGnFSh6uDQyLolR5+R1TjpV7zAVOwp
         RpYk4q7Z3ruGRksyBH8OJhyBd5G3dTAbmgLM8O0CxxH68HK7BKxMbuVlBK5E4LloM2
         bu5AOcgfyLpOoQrZ/A2LsfO1zuwVcRAYeFYwVA88=
X-Originating-IP: [89.242.187.47]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=xTMdeSjPtcrjTRwaJcecEQ==:117
 a=xTMdeSjPtcrjTRwaJcecEQ==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=8GUbQiSPW9k0AZ_q4rkA:9 a=LqW658veKl8rARbW:21 a=r23gPk-VvyGDiyG7:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] rebase --root -k: fix when root commit is empty
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180314111127.14217-1-phillip.wood@talktalk.net>
 <20180314111127.14217-2-phillip.wood@talktalk.net>
Message-ID: <e17efcc9-63c2-5c88-e74b-c9205e42d6ad@talktalk.net>
Date:   Thu, 15 Mar 2018 10:59:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314111127.14217-2-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO2cfBmqtv6XnQQ1xLAy6eWeqGgqvheXLilGWhjvbzo5SCI6lOU7DWR9MKV4yqhLF+pln7bl6eCtSb1TJ+zheU80/By5JIxzHTxK+8sJVe+0cGsL1bov
 4qkYKIdGyZD8e1fNciKrxqkwhz7Ixp0HCA8ftsbenNlwP7mtPH50wDVxpZQoQRCuT487Zfs6LZ0nWo2VKsZA8EBRBZFfvZGI5adPeRT/1HOR5ygd7O7TXkhT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/03/18 11:11, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When the root commit was empty it was being pruned by the
> --cherry-pick option passed to rev-parse. This is because when --onto
> is omitted rebase creates an empty commit (which it later amends) for
> the new root commit.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  git-rebase--interactive.sh | 7 ++++++-
>  git-rebase.sh              | 1 +
>  t/t3428-rebase-signoff.sh  | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 4ea54fc1c4..3ad74fc57c 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -894,7 +894,12 @@ then
>  	revisions=$upstream...$orig_head
>  	shortrevisions=$shortupstream..$shorthead
>  else
> -	revisions=$onto...$orig_head
> +	if test -n "$squash_onto"
> +	then
> +		revisions=$orig_head
> +	else
> +		revisions=$onto...$orig_head
> +	fi
>  	shortrevisions=$shorthead
>  fi
>  if test t != "$preserve_merges"

On reflection I'm not sure this is the best way to fix the problem. This
is a specific instance of a wider problem where rebase -k does not
preserve empty commits if there is an empty commit upstream (see
t3421:rebase -i --keep-empty keeps empty even if already in upstream). I
think the way to solve it is to get two lists of revs, the first with
--cherry-pick and the second without and use all the commits from the
first list and the empty ones from the second. I'll have a look and send
a reroll.

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 40301756be..30b8eaf489 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -61,6 +61,7 @@ $(gettext 'Resolve all conflicts manually, mark them as resolved with
>  You can instead skip this commit: run "git rebase --skip".
>  To abort and get back to the state before "git rebase", run "git rebase --abort".')
>  "
> +squash_onto=
>  unset onto
>  unset restrict_revision
>  cmd=
> diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
> index 2ff7f534e3..90ca6636d5 100755
> --- a/t/t3428-rebase-signoff.sh
> +++ b/t/t3428-rebase-signoff.sh
> @@ -59,7 +59,7 @@ test_expect_success 'rebase --exec --signoff adds a sign-off line' '
>  	test_cmp expected-signed actual
>  '
>  
> -test_expect_failure 'rebase --root --signoff adds a sign-off line' '
> +test_expect_success 'rebase --root --signoff adds a sign-off line' '
>  	git commit --amend -m "first" &&
>  	git rebase --root --keep-empty --signoff &&
>  	git cat-file commit HEAD^ | sed -e "1,/^\$/d" >actual &&
> 

