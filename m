Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDF8C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC5A60FE6
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbhIAMOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:14:44 -0400
Received: from mail.vivaldi.com ([31.209.137.20]:54770 "EHLO mail.vivaldi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241021AbhIAMOn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 08:14:43 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Sep 2021 08:14:43 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.vivaldi.com (Postfix) with ESMTP id 6EB361F823C
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vivaldi.com; h=
        mime-version:content-transfer-encoding:references:in-reply-to
        :date:date:subject:subject:from:from:message-id:content-type
        :content-type:received:received; s=2019; t=1630497898; bh=fmBQnB
        qHDuXviHoH8MgvmlVD7GgMBynay6fPv5+FK4Y=; b=laPeqSiX5MDgcM3DUBucqc
        dAm/HAOIVILfYIS47hg7PBP6JvVxw55eSiJi/Tkwts6EN7npoRxyLdIzkzNyPSJo
        NrFScS02aTDgt+hJv7qWbtcJP9XOwRd0t7bcXHLJd2EApK2y4gaXdwhJi9DYGY/l
        qx5as5LMLTqMvGycnhLQp8jKpUNxc1m1aDxBTuOnLJkt6bEAqxgbq9ELCAvuJ18d
        5cqscvGUeEYKvMTZeSaJXwcbpmHBS7ADFAJUCjiVg5FDnRb2xVS5Fb8sHTXBUQIZ
        lKsEh8+wr9tjxeJjfUTqnEDiDItEPKYhI8rqlxuhaz9q8uBYlOiDRGBqb8vLHKMw
        ==
X-Virus-Scanned: Debian amavisd-new at vivaldi.com
Received: from mail.vivaldi.com ([127.0.0.1])
        by localhost (mail.vivaldi.com [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gD1WIywhN9BG for <git@vger.kernel.org>;
        Wed,  1 Sep 2021 12:04:58 +0000 (UTC)
Received: from localhost (ti0182q160-1614.bb.online.no [212.251.169.97])
        by mail.vivaldi.com (Postfix) with ESMTPSA id 1EEF41F8270
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 12:04:58 +0000 (UTC)
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1630496467881.2030439049.4247253551@vivaldi.com>
From:   "Yngve N. Pettersen" <yngve@vivaldi.com>
To:     git@vger.kernel.org
Subject: Re: Git error message "Server does not allow request for
 unadvertised object"
Date:   Wed, 01 Sep 2021 12:04:56 +0000
In-Reply-To: <op.0qiwhxykpvqxoc@rowan.vivaldi>
References: <op.0qiwhxykpvqxoc@rowan.vivaldi>
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again,

AFAICT I have not seen any updates about this problem since my previous 
email a year ago.

 From my side, I've just noticed a separate aspect of this issue.

I have noticed a lot of failures related to a specific commit that was a 
unadvertised, and on one of the machines throwing this error, Git did 
report the repos and paths involved in triggering the error.

In this case, the commit DO exists in the repo specified by gitmodules on 
the branch where the submodule commit is referenced. However, it does NOT 
exist in the repo referenced by the currently checked out branch!

In more detail, for a currently checked out branch "foo", a submodule with 
URL "repo1.git" is specified for path "submodule/mysub" and commit 
"f0012345".

On branch "bar" of this top repo, the "submodule/mysub" is specified with 
the URL "repo2.git", which is a fork of "repo1.git", and is specifying 
commit "ba598765", which does not exist in "repo1.git"

When a fetch is done in the checkout of the "foo" branch, the new branch 
"bar" is fetched, and Git sees the submodule commit "ba598765" specified 
for "submodule/mysub", and decides to fetch it. However, it tries to fetch 
it from "repo1.git", NOT "repo2.git", which is what is specified for that 
path on the "bar" branch.

The result is a fatal error for the fetch, causing the automatic build job 
to fail, even if the "ba598765" commit is not necessary for the current 
build job's checkout.

I've also added a server-side git hook to validate the primary submodule's 
commit references, where most errors are likely to occur, but that is not 
able to prevent the kind of fetch failures described above, since the 
reference IS correct on the branch for which it is committed.

As mentioned earlier, IMO this should not be a fatal error when fetching, 
at most it should be a warning. Additionally, as illustrated by the above 
example, when performing fetches for submodules the fetch operation should 
use the URL specified on the branch, not the one specified in the local 
checkout.



On Sunday, 6 September, 2020 14:47:47 (+02:00), Yngve N. Pettersen wrote:

 > Hello again,
 >
 > I wondered what is happening about this issue?
 >
 > This continues to cause problems, especially now that Mac is using Git 
2.21 (without AFAICT any way to revert to 2.17).
 >
 > The most recent case was last night, after a Work In Progress branch 
(that is, it was not used by any production code) in a submodule was 
pushed, but updates for at least one of the submodules wasn't pushed. Three 
different Mac autobuild jobs broke because of this error and had to be 
restarted.
 >
 >
 > On Mon, 18 May 2020 11:20:57 +0200, Yngve N. Pettersen 
<yngve@vivaldi.com> wrote:
 >
 > > Hello all,
 > >
 > > A while back I reported an issue to the Windows Git project 
<https://github.com/git-for-windows/git/issues/2218> that I observed in Git 
for Windows 2.21.
 > >
 > > The error message "Server does not allow request for unadvertised 
object" is reported when a commit updating a submodule pointer points to a 
commit that does not exist in the repository for that submodule, even if 
later commits in the branch points to a commit that do exist in the 
submodule repo.
 > >
 > > This circumstance can easily occur if a developer (e.g)
 > >
 > > * interactively rebases a branch "foo" in the submodule (e.g to 
integrate commits from another branch before a larger rebase)
 > > * commits the resulting submodule pointer "A" in the branch to the 
parent repo
 > > * then do further rebasing in the submodule, e.g to move up on top of 
the "bar" branch
 > > * commits that pointer "B" to the parent repo
 > > * forgets to squash the history in the parent repo
 > > * pushes the updated submodule "foo" branch to the online repo. (NOTE: 
"B" is pushed, not "A")
 > > * pushes the parent module branch to its online repo
 > >
 > > When the parent repo is pulled by another developer, or an autobuild 
system, the fetch operation fails with the message "Server does not allow 
request for unadvertised object". A second fetch will complete 
successfully.
 > >
 > > IMO this kind of check should only happen if a commit with pointer to 
a missing submodule is actively checked out. At most the above message 
should be a warning, not a fatal error.
 > >
 > > For manual fetch operations this is mostly a nuisance, but for 
autobuilders this breaks the update operation, and the entire build 
operation fails. That is unacceptable behavior in an automatic system 
(errors if it breaks the checkout, yes; issues that are not relevant to the 
actual checkout, no).
 > >
 > > This issue prevents upgrading past 2.17 (since 2.18 and 2.19 had other 
blocking issues, and 2.20 apparently introduced this issue). I have not 
tested 2.22+ since I have not noticed any changelog messages that seem 
related.
 > >
 > > A test case can be found in issue 2218, linked above.
 > >
 > > For reference, we do have a server-side git hook that verifies that 
submodule pointers for the production branch is correct and exists in the 
submodule's repo, and also is on branches that follows certain naming 
conventions.
 > >
 > >
 > > As an aside, I think this kind of error message would be have been 
better suited as either a client-side push check, to prevent pushes of 
references to such missing commits (Smartgit seems to have something like 
it, but I think it only checks for the current branch in the submodule, not 
all submodule reference commits). Alternatively, there could be a check of 
this server-side.
 > >
 > >
 > > Related to this, but not as problematic, just irritating, and also 
seen in 2.17, is a message "warning: Submodule in commit deadbee at path: 
'(NULL)' collides with a submodule named the same. Skipping it." I think it 
is related to recreating a git modules file on a different branch.
 > >
 >
 >
-- 
Sincerely,
Yngve N. Pettersen
Vivaldi Technologies AS
