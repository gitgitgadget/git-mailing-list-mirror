Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0101F461
	for <e@80x24.org>; Tue, 20 Aug 2019 02:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfHTCOn (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 22:14:43 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:40998 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729071AbfHTCOl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Aug 2019 22:14:41 -0400
Received: from mxback17g.mail.yandex.net (mxback17g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:317])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 5A2DE9401D2;
        Tue, 20 Aug 2019 05:14:37 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback17g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mgyqM913yn-EaiemfEX;
        Tue, 20 Aug 2019 05:14:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1566267276;
        bh=OobatThUo0WHMtKN+9nhKuq/0kiUxliyFEwsuag4leE=;
        h=Message-Id:Subject:In-Reply-To:Date:References:To:From;
        b=EyH7VouWCVfiqvIXDAX8/SlM3jkoZnDYe1vz9LtTRuk/RL1bW9QvdpO+uqjxH+mBS
         m+auXxA4133gXQMGklVNFrDgyIVufv4F4BjDhqMtNXBKGRMSliN8BbCKVrr16C+WmG
         Ibfebk8nNZwWoAB4MJC910zck+JgP9PBHWQOuTSY=
Authentication-Results: mxback17g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva5-049509bcc5d6.qloud-c.yandex.net with HTTP;
        Tue, 20 Aug 2019 05:14:36 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Aaron Miller <aaronkmiller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CALSvhyb7Td-ugzze9cSLXRjF78w=zE5=3yuMFZVeuXsCWLSjHg@mail.gmail.com>
References: <CALSvhyb7Td-ugzze9cSLXRjF78w=zE5=3yuMFZVeuXsCWLSjHg@mail.gmail.com>
Subject: Re: git-p4: Clone p4 path with bidirectional integrations
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 19 Aug 2019 22:14:36 -0400
Message-Id: <3442071566267276@iva5-049509bcc5d6.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


19.08.2019, 13:30, "Aaron Miller" <aaronkmiller@gmail.com>:
> Hi all,
>
> Is it possible to `git p4 clone --detect-branches` from a Perforce
> path which contains bidirectional integrations?

Yes, but it would require some manual work most likely.

First of all, git-p4 should normally take only one direction from bidirectional integrations on its own.
Do you see "p4 branch <branchABC> defines a mapping from <path1> to <path2>, but there exists another mapping from <path2> to <path1> already!"?
If you do, it means that git-p4 will ignore <branchABC> mapping.

Also, just FYI, as far as I know, git-p4 doesn't create "merge" commits,
so bidirectional integrations won't look different from ordinary commits in git commit graph.

> I've tried a bunch of things to get this to work, but here's an
> example which hopefully illustrates what I'm trying to accomplish
> and the issue I'm having.
>
> Perforce setup, assuming PWD is mapped to //depot/... in your client spec:
>
>   1. mkdir -p testing/master
>   2. touch testing/master/test1 && p4 add testing/master/test1 && p4 submit
>   3. p4 integrate //depot/testing/master/...
> //depot/testing/staging/... && p4 submit
>   3. touch testing/staging/test2 && p4 add testing/staging/test2 && p4 submit
>   4. p4 integrate //depot/testing/staging/...
> //depot/testing/master/... && p4 submit
>
> Now try to clone with git-p4:
>
>   1. git init p4_git_test && cd p4_git_test
>   2. git config git-p4.branchList master:staging
>   3. git config --add git-p4.branchList staging:master
>   4. git p4 clone //depot/testing/...@all --detect-branches .
>
> You end up with a failure like:
>
>   Importing from //depot/testing/...@all into .
>   Reinitialized existing Git repository in /home/amiller/p4_git_test/.git/
>   Importing revision 1205832 (25%)

Uh-oh, 5M commits!
But given that it fails at 25% instead of 1%,
you've got some luck. :)

>       Importing new branch testing/master
>
>       Resuming with change 1205832
>   fatal: ambiguous argument 'refs/remotes/p4/testing/staging': unknown
> revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>   Command failed: ['git', 'rev-list', '--reverse', '--no-merges',
> 'refs/remotes/p4/testing/staging']

This might not be just because of bidirectional integrations per se.
This error may happen if, say, there's a P4 branch mapping from staging to master,
but master was actually created before staging.
git-p4 tries to find a "parent branch" for master, but it doesn't exist yet,
so git-p4 fails in an ugly way.


One way to filter out troublesome P4 branch mappings is to set git-p4.branchUser to a particular user.
But most likely, this won't help you because different people created different branch mappings over time.

Unfortunately, there's _no_ git-p4.branchRegexp config option,
but it's fairly straightforward to implement -- patches welcome! ;)
(getBranchMapping() needs to apply a regex to branch names before doing anything serious with them)


The other option is to manually set git-p4.branchList for all your branch pairs like
git config --add git-p4.branchList staging:master
git config --add git-p4.branchList master:branchA
git config --add git-p4.branchList master:branchB
...
(or by manually editing .git/config)
Note, that you can't have master:staging together with staging:master,
otherwise you'll likely run into the same problem as before.

This might be simple or quite tedious depending on the history and branching strategies of your repositories.
It may be as easy as just dropping some p4 branch mappings.
However, one of the repositories I had to deal with had almost random branching strategy (with most integrations done without predefined branch mappings),
so I had to spend quite some time to trace the history and figure out which branches make the most sense in git.
(Revision Graph in p4v was very helpful for figuring branching history out)


As I said, git-p4 doesn't create merge commits in git (or I can't see how to make them),
so for repositories with simple/short history,
I recreated those merge commits manually (well, in a bash script) using `git replace --graft <commit> <parent1> <parent2>` followed by `git filter-branch --tag-name-filter cat -- --all` to make grafts permanent.
(`git filter-branch` is only needed once in the very end after all `git replace` manipulations are done)
It's perhaps better to teach git-p4 to produce merge commits, but a bash script was a low-tech low-risk option for me.

Also, beware that git-p4 doesn't handle branch-into-non-empty directory properly.
If I remember correctly, something like
`p4 copy //depot/branchA/... //depot/branchB/... ; p4 submit; p4 copy //depot/branchC/... //depot/branchB/...; p4 submit`
will result in branchB having _both_ branchA and branchC contents in git.
`git filter-branch` or `git rebase` are your friends to workaround this.
(or better fix git-p4, of course)

> I'm using Git 2.22.1.
>
> Thanks,
> Aaron

Hope this help,
Andrey.

