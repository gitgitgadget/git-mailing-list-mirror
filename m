Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EF2C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 12:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5AE208DB
	for <git@archiver.kernel.org>; Fri,  8 May 2020 12:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEHMHy convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 8 May 2020 08:07:54 -0400
Received: from elephants.elehost.com ([216.66.27.132]:27838 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgEHMHy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 08:07:54 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 048C7n4s063839
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 May 2020 08:07:50 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Alexander Mills'" <alexander.d.mills@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com> <06da01d624c7$acb17090$061451b0$@nexbridge.com> <CA+KyZp7Ur3kW3qrCe3hOz16gA9y_B7rSGin62=eKMjCCqLsR4w@mail.gmail.com> <CA+KyZp7emY12sy6QdGBJ5T9e135VCfjeqTy9u_FWh+FA1d-uFg@mail.gmail.com>
In-Reply-To: <CA+KyZp7emY12sy6QdGBJ5T9e135VCfjeqTy9u_FWh+FA1d-uFg@mail.gmail.com>
Subject: RE: check if one branch contains another branch
Date:   Fri, 8 May 2020 08:07:43 -0400
Message-ID: <070601d62531$4a95ba00$dfc12e00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKqYtZUUutFRLKWsEN64q/0APyDsgG7hWW/AwdtWaUCkya79Ka661sg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 7, 2020 9:01 PM, Alexander Mills Wrote:
> git branch -d foo   # safe delete
> 
> the above doesn't seem to work if you squash commits into an integration
> branch, I will get something like:
> 
> ========================================================
>  git branch -d CP-10-master
> warning: deleting branch 'CP-10-master' that has been merged to
>          'refs/remotes/origin/CP-10-master', but not yet merged to HEAD.
> Deleted branch CP-10-master (was faeb801).
> ==========================================================
> 
> 
> If a branch gets squashed into another, how does merge-base do it's thing,
> since it's not a fast-forward merge etc?
> I assume that it's not possible, for example this script shows that if  git merge
> --squash is used, git doesn't know that the unsquashed branch is already
> merged:
> 

Correct. That is what I pointed out in my first response.

> ==========================================================
> 
> #!/bin/bash
> 
> set -e
> 
> git checkout master
> git branch -D delete-me-1 || echo
> git branch -D delete-me-2 || echo
> 
> git checkout -b delete-me-1
> git checkout -b delete-me-2
> git commit --allow-empty -am "first new one"
> git commit --allow-empty -am "second new one"
> git commit --allow-empty -am "third new one"
> git checkout delete-me-1
> git merge --squash delete-me-2  ### compare without squash
> 
> if git merge-base --is-ancestor delete-me-2 delete-me-1; then
>   echo 'delete-me-1 is an ancestor of delete-me-2'
> else
>   echo 'not an ancestor'
> fi
> ========================================================
> 
> that will print "not an ancestor" if  --squash is used..

Also correct.

> 
> -alex
> 
> 
> 
> 
> On Thu, May 7, 2020 at 4:37 PM Alexander Mills
> <alexander.d.mills@gmail.com> wrote:
> >
> > I assume that:
> >
> > git branch -d  xxx
> >
> > will prevent a delete if the current branch doesn't contain xxx..
> > I don't want to have to checkout  origin/dev in order to run that
> > command, that's one part of the problem
> >
> >
> > On Thu, May 7, 2020 at 4:31 PM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> > >
> > > On May 7, 2020 6:59 PM Alexander Mills, Wrote:
> > > > To: git@vger.kernel.org
> > > > Subject: check if one branch contains another branch
> > > >
> > > > I am looking for a command:
> > > >
> > > > 1>  if branch x contains branch y
> > > >
> > > > right now all I can find is
> > > >
> > > > 2> if current branch contains commit y
> > > >
> > > > can someone please accomplish #1 ?
> > > > Crazy hard to find an answer to #1 online.
> > > > The user case is to delete old local branches by comparing them
> > > > with the remote integration branch.
> > > >
> > > > more info if needed:
> > > > https://stackoverflow.com/questions/61669056/how-to-determine-if-
> > > > integration-branch-contains-feature-branch
> > >
> > > Looking at this slightly differently, if you try to delete a branch, git branch
> -d feature-branch, and the branch has not been merged, then the delete will
> fail. A simple way of looking at it is if the HEAD of the branch has no
> successor commits then it is not merged (not 100% decisive, but git branch -d
> is). It is not really that a branch has been merged, but that a commit has
> successors, meaning that it has been merged. However, unless you are using
> GitLab, a git merge --squash will not answer your question even if the branch
> was merged.
> > >
> > > A better way of looking at this is in terms of Pull (GitHub, BitBucket) or
> Merge (GitLab) requests. Has there been a Pull Request for a branch and has
> the branch been closed? Meaning that when you do a git fetch --prune, your
> merged/deleted branches go away unless you are on that branch. Looking at
> the Pull Request history is much more useful in determining whether a branch
> has been integrated into a main development branch or production branch in
> a GitFlow process.
> > >
> > > It is a different way of looking at the problem, but IMHO, a more
> representative way when taking developers and deployment into account.

As I indicated, this may be more appropriate to do what you want to do on the upstream enterprise git server rather than on your local clone.

