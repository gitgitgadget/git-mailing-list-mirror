Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9300AC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 02:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D6D6191A
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 02:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhCVClO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 22:41:14 -0400
Received: from smtp5.ctinetworks.com ([205.166.61.198]:49662 "EHLO
        smtp5.ctinetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCVClH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 22:41:07 -0400
Received: from localhost (unknown [117.193.8.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: enometh@meer.net)
        by smtp5.ctinetworks.com (Postfix) with ESMTPSA id DDC1C1636CF;
        Sun, 21 Mar 2021 22:40:59 -0400 (EDT)
Date:   Mon, 22 Mar 2021 08:10:43 +0530 (IST)
Message-Id: <20210322.081043.1437207928602570397.enometh@meer.net>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
From:   Madhu <enometh@meer.net>
In-Reply-To: <xmqq1rc89nk7.fsf@gitster.g>
References: <20210321.175821.1385189088303987287.enometh@meer.net>
        <xmqq1rc89nk7.fsf@gitster.g>
X-Mailer: Mew version 6.8 on Emacs 28.0
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ctinetworks-Information: Please contact the ISP for more information
X-ctinetworks-MailScanner-ID: DDC1C1636CF.A78A3
X-ctinetworks-VirusCheck: Found to be clean
X-ctinetworks-SpamCheck: 
X-ctinetworks-Watermark: 1617244865.34572@SkYJJuhb7zmsXkrj4fseIQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*  Junio C Hamano <gitster@pobox.com> <xmqq1rc89nk7.fsf@gitster.g>
Wrote on Sun, 21 Mar 2021 14:58:16 -0700
> Madhu <enometh@meer.net> writes:
>> If the .git/config file is a symlink (as is the case of a .git created
>> by the contrib/workdir/git-new-workdir script) then the filemode tests
>> fail, and the filemode is reset to be false.  To avoid this only munge
>> core.filemode if .git/config is a regular file.
>
> Hmph, what's the sequence of events?  You let "git new-workdir" to
> create a cheap copy of a working tree and then?  When new-workdir
> returns, you already have a functional working tree with .git/
> directory (in which there are many symbolic links).  So who wants or
> needs to run "git init" there in the directory in the first place?

In this case it was part of a script which created commits from
tarballs.  If there was no .git git-init would create it. If there
was, and it should ov harmlessly "re-initialized" it (whatever that
means)

> Is the problem being solved that running an unnecessary "git init"
> in an already initialized repository does an unnecessary filemode
> check?

Yes the problem could have be avoided by not calling git-init in an
existing repository.  But the docs say that if there is a .git
directory, it would "reinitialize it".  Re-initialization was not
expected to change the filemode incorrectly.

git-new-workdir is extremly useful in this case. With no overhead I
can create a .git without doing a checkout. Then i can move the .git
into a directory where the tarball has been unpacked - do a "git add
-A -f", "git commit" I expect the commit to have the exact contents of
the tarball. and by paying attention to commit info and dates i have a
commit-sha1 reproducible history which can be created anywhere.

If the filemode is being changed in .git/config without my knowledge
all further commits in the repo are affected future tarball imports
are corrupted.

I was using this extensively to track changes to point releases and
the impact is serious (personally) and I have a lot of useless
repositories which I have been tracking for over a year whose
histories are not commit-sha reproducible.

> If that is the case, I am not sure if asking "is it a symlink?" to
> avoid the filemode trustability check is a good approach.  At that
> point in the code you are patching, we have already determined if we
> are running the "git init" in an already initialized repository
> (i.e. "reinit"), so shouldn't we be basing the decision on it
> instead?

> I see that in a later part of the same function, we test if the
> filesystem supports symbolic links but do so only when we are
> running "git init" afresh.  Perhaps the filemode trustability check
> and the config-set to record core.filemode should all be moved there
> inside the "if (!reinit)" block.
>
> All of the above assumes that the problem being solved is about what
> happens when "git init" is run in an already functioning working
> tree.  If I misread what problem you are trying to solve, then none
> of what I suggested in the above may apply.

I think you have understood the problem.  At present But doing the
filemode trustability check on .git/config assumes it is a regular
file anyway if it is to work at all.  My suggestion in the patch only
enforces that assumption explicitly.
