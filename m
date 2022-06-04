Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C475CCA480
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 09:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiFDJpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 05:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiFDJpV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 05:45:21 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2133F1B7B9
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 02:45:17 -0700 (PDT)
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="39492327"
Received: from unknown (HELO [10.28.4.153]) ([109.190.253.11])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 11:45:09 +0200
Message-ID: <2c6ee145-5116-25db-9fbf-bcffe67a9360@univ-lyon1.fr>
Date:   Sat, 4 Jun 2022 11:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/4] t6436: tests how merge behave when there is
 untracked file with the same content
Content-Language: en-US
To:     Jonathan Bressat <git.jonathan.bressat@gmail.com>
Cc:     "cogoni.guillaume@gmail.com" <cogoni.guillaume@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>,
        BRESSAT JONATHAN p1802864 <jonathan.bressat@etu.univ-lyon1.fr>
References: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
 <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
 <dfea1d98c15047428b1a11adbc002eef@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
In-Reply-To: <dfea1d98c15047428b1a11adbc002eef@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/22 21:55, Jonathan Bressat wrote:
> add test to show explicitly that merge doesn't overwrite untracked files
> or unstaged even when they have the same content than files int the
> merged commit

Nit: capital at the beginning of the sentence, period at the end.

"untracked files or unstaged" -> "untracked or unstaged files"

> +test_expect_success 'create branch A' '
> +	git reset --hard c0 &&
> +	git checkout -b A
> +'
> +
> +test_expect_success 'fastforward will not overwrite untracked file with the same content' '

Git usually spells fast-forward with a hyphen, not fastforward.

> +	test_when_finished "git branch -D B && git reset --hard c0 && git clean --force" &&
> +	git checkout -b B &&
> +	test_commit --no-tag "tracked" file "content" &&
> +	git checkout A &&
> +	echo content >file &&
> +	test_must_fail git merge B

Other tests in the same file test a bit more: the file mustn't be 
touched. It's a very important thing with Git: 99% of the times, when an 
operation fails, it fails before starting any change on-disk, as opposed 
to "I started messing up with your repo, I can't go further, go fix the 
mess yourself" ;-).

The way it's done is by creating a file with the content, using "cp" 
instead of "echo >" and "test_cmp" to check the content.

Other tests also check the absence of .git/MERGE_HEAD, which seems to be 
a sensible thing to do.

> +test_expect_success 'will not overwrite untracked file with the same content' '
> +	test_when_finished "git branch -D B && git reset --hard c0 && git clean --force" &&
> +	git checkout -b B &&
> +	test_commit --no-tag "tracked" file "content" fileB "content" &&
> +	git checkout A &&
> +	test_commit --no-tag "exA" fileA "content" &&
> +	echo content >file &&
> +	test_must_fail git merge B
> +'
> +
> +test_expect_success 'will not overwrite unstaged file with the same content' '
> +	test_when_finished "git branch -D B && git reset --hard c0 && git clean --force" &&
> +	test_commit --no-tag "unstaged" file "other" &&
> +	git checkout -b B &&
> +	test_commit --no-tag "staged" file "content" &&
> +	git checkout A &&
> +	echo content >file &&
> +	test_must_fail git merge B
> +'

As discussed IRL, I think two more cases should be tested:

- index matches commit being merged, but the worktree file doesn't
- worktree file doesn't match content, but index does

in both cases, I'd expect the old and the new behavior to abort the 
merge. Perhaps there are use-cases where one would expect a successful 
merge silently, but for rare corner-cases, it's safe to ask the user to 
fix the situation manually and too much magic can only confuse the user.

-- 
Matthieu Moy
https://matthieu-moy.fr/
