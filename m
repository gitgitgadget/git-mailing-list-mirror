Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B02C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 23:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F0B20787
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 23:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbgDAX3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:29:12 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:47778 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbgDAX3L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 19:29:11 -0400
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1jJmnF-0001b6-Ex; Thu, 02 Apr 2020 00:29:09 +0100
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24197.9157.362143.972556@chiark.greenend.org.uk>
Date:   Thu, 2 Apr 2020 00:29:09 +0100
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, elbrus@debian.org,
        phillip.wood@dunelm.org.uk, alban.gruin@gmail.com,
        Johannes.Schindelin@gmx.de, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
In-Reply-To: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.  Thanks for looking at this.

Elijah Newren via GitGitGadget writes ("[PATCH] sequencer: honor GIT_REFLOG_ACTION"):
>     I'm not the best with getenv/setenv. The xstrdup() wrapping is
>     apparently necessary on mac and bsd. The xstrdup seems like it leaves us
>     with a memory leak, but since setenv(3) says to not alter or free it, I
>     think it's right. Anyone have any alternative suggestions?

I can try to help.  It's not entirely trivial.

The setenv interface is a wrapper around putenv.  putenv has had a
variety of different semantics.  Some of these sets of semantics
cannot be used to re-set the same environment variable without a
memory leak - and even figuring out what semantics you have would be
complex and tend to produce code which would fail in bad ways.
There's a short summary of the situation in Linux's putenv(3).

Would it be possible for git to arrange to set GIT_REFLOG_ACTION only
when it is invoking subprocesses ?  Otherwise it would update, and
look at, a global variable of its own.  (Or a parameter to relevant
functions if one doesn't like the action-at-a-distance effect of a
global.)

And, it seems to me that the reflog handling should be centralised.

> +	char *reflog_action = getenv("GIT_REFLOG_ACTION");
>  
>  	va_start(ap, fmt);
>  	strbuf_reset(&buf);
> -	strbuf_addstr(&buf, action_name(opts));
> +	strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));

Open coding this kind of thing at every site which needs to think
about the reflog actions will surely result in some of the instances
having bugs.

Writing a single function that contans this (or most of it) would
happily decouple all of its call sites from literally asking about
getenv("GIT_REFLOG_ACTION") thereby making it easier to do the
indirection-through-program-variables I suggest.

Having said that,

> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index 61b76f33019..927a4f4a4e4 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh

This test case convinces me that the patch has the right behaviour for
at least the case I care about :-).

Thanks,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
