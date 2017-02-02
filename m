Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469451FAAD
	for <e@80x24.org>; Thu,  2 Feb 2017 12:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbdBBMho (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 07:37:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53040 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751463AbdBBMhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 07:37:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAAE863620;
        Thu,  2 Feb 2017 07:37:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=0cBPhG66DLpTpa4ys0V7ReD5P3s=; b=NbLgCs
        2UC5XNYHToPSyhNUbqISIrh2/qXivmvSchV7Lac2crvp2ft6me8RpEg9/p9RIG5X
        oHC4+ul4MtotzqkJ2r6BtDiW+pe8Z8h4xbrGfbMghkNqe21TXAtqIjlHDsQjWC6y
        p37FScXoZpYzd/0QPcbMKJTA17Md+D/gcWgko=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A27BD6361F;
        Thu,  2 Feb 2017 07:37:41 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16CB36361D;
        Thu,  2 Feb 2017 07:37:41 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: init --separate-git-dir does not set core.worktree
In-Reply-To: <CACsJy8AZUBt76ZocS2JEr9FP_8Obv8L911AvZxE_sww3qXB7qw@mail.gmail.com>
References: <87h94d8cwi.fsf@kyleam.com> <CACsJy8AZUBt76ZocS2JEr9FP_8Obv8L911AvZxE_sww3qXB7qw@mail.gmail.com>
Date:   Thu, 02 Feb 2017 07:37:40 -0500
Message-ID: <87efzg7oq3.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 631A12FA-E944-11E6-B9C2-A7617B1B28F4-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=0cBPhG66DLpTpa4ys0V7ReD5P3s=; b=Uc/xKzoqP9385KWBo5PJyg7Vu/v4432C/VtP8Lkmg5kqQ2oq3sV9LI7jGiPDN9kQy6KmBAPlAgv+nJZaX9MDuXAK2/P0iXnUpZMjVT81/S8a7ZITZhpdvVje1XYLgcDDIlQxJRsGrWZgKU9ckKARpZXKSRpZzb9dX4NJH3e4AuU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 2, 2017 at 10:55 AM, Kyle Meyer <kyle@kyleam.com> wrote:
>>
>> As of 6311cfaf9 (init: do not set unnecessary core.worktree,
>> 2016-09-25), "git init --separate-git-dir" no longer sets core.worktree
>> (test below).  Based on the commit message and the corresponding thread
>> [1], I don't think this change in behavior was intentional, but I wasn't
>> able to understand things well enough to attempt a patch.
>
> I'm missing some context. Why does --separate-git-dir have to set
> core.worktree? What fails for you exactly?

Sorry for not providing enough information.  I haven't run into a
failure.

In Magit, we need to determine the top-level of the working tree from
COMMIT_EDITMSG.  Right now that logic [*1*] looks something like this:

 * COMMIT_EDITMSG in .git/modules/<module>/: set working tree to the
   output of "git rev-parse --show-toplevel"

 * COMMIT_EDITMSG in .git/worktrees/<wtree>/: set working tree to the
   path in .git/worktrees/<wtree>/gitdir, minus the trailing "/.git"

 * COMMIT_EDITMSG in .git: set working tree to the parent directory

This fails for a repo set up with --separate-git-dir [*2*], where the
last step will go out into an unrelated repo.  If core.worktree was set
and "git rev-parse --show-toplevel" returned the working tree like it
did for submodules, things would work.

Of course, the issue above isn't a reason that --separate-git-dir should
set core.worktree, but the submodule behavior is why we were wondering
if it should.  And so I was going to ask here whether core.worktree
should be set, but then I confused myself into thinking 6311cfaf9
unintentionally changed this behavior.


[*1*] This is done by magit-toplevel:
      https://github.com/magit/magit/blob/e34f4e8eb00f292e8c475489fa7caa286857a421/lisp/magit-git.el#L400

[*2*] https://github.com/magit/magit/issues/2955
      https://github.com/magit/magit/issues/2981
