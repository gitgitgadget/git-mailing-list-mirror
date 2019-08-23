Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E851F461
	for <e@80x24.org>; Fri, 23 Aug 2019 03:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404099AbfHWDNd (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 23:13:33 -0400
Received: from forward500o.mail.yandex.net ([37.140.190.195]:48865 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389039AbfHWDNd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Aug 2019 23:13:33 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Aug 2019 23:13:30 EDT
Received: from mxback4q.mail.yandex.net (mxback4q.mail.yandex.net [IPv6:2a02:6b8:c0e:6d:0:640:ed15:d2bd])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id E1EBE605CD;
        Fri, 23 Aug 2019 06:06:24 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback4q.mail.yandex.net (nwsmtp/Yandex) with ESMTP id TWrOYDOSpF-6OU8Soaw;
        Fri, 23 Aug 2019 06:06:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1566529584;
        bh=hyARK7PRylZiTk/POipcqq/gGiCcCD76Rfi3rKykiUA=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=pQbO3UuPKdl0Bd9cNWdpn1fbdXwrRyuFso5zf8dnxpcdLLICdtPig7QWy8wz+Dsf3
         7PKAcrQQP0/08E0jv35cTb4rIcJju2O/sS1IrQVWPuvnlqAdtJhFx9zYslFsl8b+ui
         u8Mg1bL/mr5Zja3Wm5Txiecup6VpIYEoPik2URdI=
Authentication-Results: mxback4q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-74bb1214b343.qloud-c.yandex.net with HTTP;
        Fri, 23 Aug 2019 06:06:24 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Aaron Miller <aaronkmiller@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CALSvhyZUphJ4+Vb5MD-KS9OV7DOK6ahwvfBdg0JiNWbT7GxzWA@mail.gmail.com>
References: <CALSvhyb7Td-ugzze9cSLXRjF78w=zE5=3yuMFZVeuXsCWLSjHg@mail.gmail.com>
         <3442071566267276@iva5-049509bcc5d6.qloud-c.yandex.net> <CALSvhyZUphJ4+Vb5MD-KS9OV7DOK6ahwvfBdg0JiNWbT7GxzWA@mail.gmail.com>
Subject: Re: git-p4: Clone p4 path with bidirectional integrations
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 22 Aug 2019 23:06:24 -0400
Message-Id: <2393271566529584@vla1-74bb1214b343.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron,

20.08.2019, 19:46, "Aaron Miller" <aaronkmiller@gmail.com>:
>>  Also, just FYI, as far as I know, git-p4 doesn't create "merge" commits,
>>  so bidirectional integrations won't look different from ordinary commits in git commit graph.
>
> Ah, I didn't realize that, thank you. Perhaps I should just sync each
> branch separately then, ignoring branch mappings entirely and be done
> with it.

You could do it this way too.
But this way your branches will be completely independent.
However, with --detect-branches, you'll preserve the information on which branch was branched off at which point.
(it's useful for release branches or feature branches; but not really for main and testing branching model)

> I was hoping to generate a commit graph that properly represents
> integrations as merge commits because our Perforce branches are quite
> large. Storing diffs of integrations rather than discrete commits
> would result in a much smaller Git repository for us. There are
> *quite* a lot of integration commits.
Not sure if there'll be a big difference in terms of Git repository size.
Git is quite efficient with its delta compression and pack files.

> I wonder how hard it would be to modify git-p4 to use merge commits? I
> will take a look at the source.
It's somewhere around importChanges() and commit(), I suppose.
It seems simple on git side (just specify additional parents when creating a commit using "merge" keyword for git fast-import),
but may be more complicated on Perforce side (to find the parent(s)).

> I'm somewhat surprised that's not the
> case to begin with though? Maybe someone else can chime in on why
> merge commits aren't used.
Yeah, it comes as a bad surprise.
One reason I can think of is bi-directional interaction between Perforce and Git -- perhaps some information is lost during submit to P4 and then reimport back to Git.
It might also get tricky during import of changelists that span several branches (shouldn't probably be considered a merge though).

>>  This might not be just because of bidirectional integrations per se.
>
> I should have mentioned - there were no P4 branch mappings defined for
> the depot paths in the test case I shared (maybe that's obvious).
Well, you had git-p4.branchList defined, which is enough for --detect-branches logic to kick in.

>>  One way to filter out troublesome P4 branch mappings is to set git-p4.branchUser to a particular user.
>>  But most likely, this won't help you because different people created different branch mappings over time.
>
> I was thinking I could set git-p4.branchUser to a user that hasn't
> created any branches at all and then define branch mappings I care
> about in git-p4.branchList.
Yeah, it's a good idea. (I did the same)
As far as I remember, you can even use a non-existing user for git-p4.branchUser.

>>  I recreated those merge commits manually (well, in a bash script) using `git replace --graft <commit> <parent1> <parent2>` followed by `git filter-branch --tag-name-filter cat -- --all` to make grafts permanent.
>>
>>  (`git filter-branch` is only needed once in the very end after all `git replace` manipulations are done)
>>  It's perhaps better to teach git-p4 to produce merge commits, but a bash script was a low-tech low-risk option for me.
>>
>>  Also, beware that git-p4 doesn't handle branch-into-non-empty directory properly.
>>  If I remember correctly, something like
>>  `p4 copy //depot/branchA/... //depot/branchB/... ; p4 submit; p4 copy //depot/branchC/... //depot/branchB/...; p4 submit`
>>  will result in branchB having _both_ branchA and branchC contents in git.
>>  `git filter-branch` or `git rebase` are your friends to workaround this.
>>  (or better fix git-p4, of course)
Another suggestion: after import into git is done, it might be useful to cross-check tips of git branches against tips of corresponding Perforce branches.
(some files may exist in git when they are deleted from Perforce due to the aforementioned branch-into-non-empty directory issue)

> These are great tips, thanks! Maybe what I will do is sync each branch
> separately with no branch mappings, then use this technique to create
> merge commits for the initial branch creation commits only and not
> worry about any other integrations.
If commits for integrations have consistent commit messages,
you might be able to get merge commits using `git replace` cheaper than by modifying git-p4 itself (which can't rely on commit messages).


-- 
Andrey.

