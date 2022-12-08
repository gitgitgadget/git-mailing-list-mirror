Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C04C4708D
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 01:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLHBQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 20:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLHBQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 20:16:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E86343
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 17:16:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EA31920436;
        Thu,  8 Dec 2022 01:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670462192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paU863rhudt4jtW2nj3ynder3JUVJ24t9AcBs3xeYi4=;
        b=SLeKCVJBtt6x9nmv6WKaYeh+YuFLzWjCkDJoZ2OF9miYhTs+wB8MjjVTlK7iZPTUdWaJP+
        FtlvsD/LEtIqYkSNtX/KWHyZtKBSxySYfVDlF/SF7hkuJ3oh21JWUy7TfFrC6qhwQQLM+9
        dNYxjQ2bwJCqeXcOoDX94QdFP2Iehwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670462192;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paU863rhudt4jtW2nj3ynder3JUVJ24t9AcBs3xeYi4=;
        b=S26Rw09S42WKg/+W9sIZ01/VbbX5JD0pGXAszM8qfXJAVEetrpjd0dI8zaYGay9MZIWjuv
        WhmrUzbBiYIt6rAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 99B722C141;
        Thu,  8 Dec 2022 01:16:32 +0000 (UTC)
Date:   Thu, 8 Dec 2022 02:16:31 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
Message-ID: <20221208011631.GH28810@kitsune.suse.cz>
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221208.86a63y9309.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2022 at 12:57:45AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Dec 07 2022, ZheNing Hu wrote:
> 
> > I would like to run git gc on my git server periodically, which should help
> > reduce storage space and optimize the read performance of the repository.
> > I know github, gitlab all have this process...
> >
> > But the concurrency between git gc and other git commands is holding
> > me back a bit.
> >
> > git-gc [1] docs say:
> >
> >     On the other hand, when git gc runs concurrently with another process,
> >     there is a risk of it deleting an object that the other process is using but
> >     hasn’t created a reference to. This may just cause the other process to
> >     fail or may corrupt the repository if the other process later adds
> > a reference
> >     to the deleted object.
> >
> > It seems that git gc is a dangerous operation that may cause data corruption
> > concurrently with other git commands.
> >
> > Then I read the contents of Github's blog [2], git gc ---cruft seems to be used
> > to keep those expiring unreachable objects in a cruft pack, but the blog says
> > github use some special "limbo" repository to keep the cruft pack for git data
> > recover. Well, a lot of the details here are pretty hard to understand for me :(
> >
> > However, on the other hand, my git server is still at v2.35, and --cruft was
> > introduced in v2.38, so I'm actually more curious about: how did the server
> > execute git gc correctly in the past? Do we need a repository level "big lock"
> > that blocks most/all other git operations? What should the behavior of users'
> > git clone/push be at this time? Report error that the git server is performing
> > git gc? Or just wait for git gc to complete?
> >
> > Thanks for any comments and help!
> >
> > [1]: https://git-scm.com/docs/git-gc
> > [2]: https://github.blog/2022-09-13-scaling-gits-garbage-collection/
> 
> Is this for a very large hosting site that's anywhere near GitHub,
> GitLab's etc. scale?
> 
> A "git gc" on a "live" repo is always racy in theory, but the odds that
> you'll run into data corrupting trouble tends to approach zero as you
> increase the gc.pruneExpire setting, with the default 2 weeks being more
> than enough for even the most paranoid user.

And that two weeks expiration applies to what, exactly?

For commits there is author date and commit date but many other objecs
won't have these I suppose. And the date when the object is pushed into
the repository is unrelated to these two, anyway.

> So, I think you probably don't need to worry about it. Other major
> hosting sites do run "git gc" on live repositories, but as always take
> backups etc.

Actually, it is a real problem. With <100 users and some scripting I got
unexplained repository corruptions which went away when gc was disabled.

YMMV

Bad locking design is always a landmine waiting to get triggered. If you
step carefully you might avoid it for some time.

Thanks

Michal
