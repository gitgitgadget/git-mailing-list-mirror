Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEA9C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 18:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31D160FC3
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 18:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhKJSis convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 10 Nov 2021 13:38:48 -0500
Received: from elephants.elehost.com ([216.66.27.132]:18529 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhKJSir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 13:38:47 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AAIZtW7011748
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Nov 2021 13:35:55 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Glen Choo'" <chooglen@google.com>, <git@vger.kernel.org>
References: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com> <kl6lh7cjvpm3.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lh7cjvpm3.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: RE: [RFC] Branches with --recurse-submodules
Date:   Wed, 10 Nov 2021 13:35:49 -0500
Organization: Nexbridge Inc.
Message-ID: <000101d7d661$cbfa4fb0$63eeef10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDlN6LuBtE+8KJlFzsXRydDgnoDhAJi8ei9rc86YiA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 10, 2021 1:21 PM, Glen Choo wrote:
> I found some points that I should have given more attention to in the RFC. I'd
> appreciate any and all feedback :)
> 
> Glen Choo <chooglen@google.com> writes:
> 
> > In a superproject-submodule relationship there is some ambiguity in
> > what ‘checkout the branch `topic`’ should mean (does the submodule use
> > its topic branch, or the version recorded in the superproject’s gitlink?).
> > Our approach is to preserve existing semantics where reasonable - the
> > ref name refers to the superproject’s ref, just as it does without
> > --recurse-submodules.
> 
> Because a gitlink only contains a commit id, the submodule branch will use a
> plain commit id as the branch point. This gives the correct ref, but it gives no
> hints as to what the submodule branch should track.
> 
> The current thought process is to set up tracking using the ref name and the
> submodule's config. Thus, a more complete description of
> 
>   git branch --recurse-submodules topic origin/main
> 
> is something like:
> 
> * for each repository, create the 'topic' branch where each 'topic'
>   branch points to the version recorded in the superproject's
>   'origin/main'
> * for each repository, setup tracking for the 'topic' branch using the
>   repository's own 'origin/main' as the branch point
> 
> Note that there is no guarantee that a submodule's 'origin/main' points to
> the same commit as the superproject's 'origin/main', or if the submodule's
> 'origin/main' even exists.
> 
> If tracking information cannot be setup, we will still create the branch; we will
> only warn users when they run a command that requires tracking
> information e.g. fetch or push.
> 
> > === Switching _from_ a branch `topic`, i.e. `git {switch,checkout}`
> >
> > Check `topic` if each submodule’s worktree is clean (except for
> > gitlinks), and has one of the following checked out:
> >
> > * `topic`
> > * the commit id in the superproject gitlink
> >
> > This allows the user to switch with a dirty worktree (with respect to
> > the superproject). We consider this acceptable because the submodule
> > commits are tracked by the submodule branch. This is helpful when a
> > user needs to switch branches before they are ready to commit to the
> > superproject.
> 
> Note that this is how git switch with submodules already works - users can
> switch away from a dirty superproject worktree as long as the submodule
> worktrees are not dirty. However, without branches, this is perilous because
> a user could unintentionally switch away from their submodule WIP and have
> no easy way of recovering their work.
> 
> The proposed UX solves this by making the WIP tracked by a branch by
> default. If a user switches _away_ from their WIP 'topic' branch...
> 
> > === Switching _to_ a branch `topic`, i.e. `git {switch,checkout}
> > topic`
> >
> > Switch to `topic` in the superproject. Then in each submodule, switch to:
> >
> > * `topic`, if it exists
> > * Otherwise, the commit id in the superproject gitlink (and warn the
> >   user that HEAD is detached)
> >
> > If the submodule `topic` points to a different commit from the
> > superproject gitlink, this will leave the superproject with a dirty
> > worktree with respect to the gitlinks. This allows a user to recover
> > work if they had previously switched _away from_ "topic".
> 
> they can still recover their WIP state by switching _back_ to their WIP 'topic'
> branch.

While not mandatory, we use a practice as follows:
1. Clone the superproject
2. Update the submodules - checks out the commit referenced by the superproject and fetches all parent commits.
3. Fetch the main branch of each submodule.
4. If working on the submodule, use a branch, not a commit - typically off main.
5. The branches in the submodule "keep alive" any commits not referenced by the superproject.

We see HEAD moving in the submodule based on what is referenced in the superproject, but work is not lost because of a disconnected head.

What I could see as a possible improvement is to add the branch ref to the submodule ref file - not replacing the commit but adding to it. I do worry that there are unintended (unforeseen) side-effects that will result from this, however, including potential merge conflicts. Two people working on the same commit but different branches may mess the ref file, so not really a good idea.

So far, we have not lost any commits this way and it has worked for a very long time.

Just my musings.
-Randall

