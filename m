Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C995BC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C87A23B77
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgLILYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:24:36 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:53370 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbgLILYV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 06:24:21 -0500
Date:   Wed, 09 Dec 2020 11:22:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1607512968;
        bh=7RSF8F3MgJ2OknW0fxM3eIikhj1JJWEV16pk9DqyucM=;
        h=Date:To:From:Reply-To:Subject:From;
        b=YlGLUGGWcd9GsS2Y1JnfVilbZ/X+eFReyS78dfOJWfaGtni+MZ5t4YBACxGq6swG/
         MwO0s1LLeTQhKn1A+wK3e+SVC6Rwo749B84y/lflZz0FyXNg3tnB+B7cGOGx1cPYig
         qycwZIwMiVB1pBXTqHz4AoTaHkrssP4MTiiPVN2Y=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Ron <ronazek@protonmail.com>
Reply-To: Ron <ronazek@protonmail.com>
Subject: Single-Branch Clone: Ability to set a branch for tracking (--track, --set-upstream-to) inoptimally relies on whether it's specified in git config as a branch that's fetchable by default, or if still intended/required, git-fetch should do automatically.
Message-ID: <xoWsK8vD1iBr_SU-gfZyXyXd-wujLXIngtcwq5PJsT12_69lNHV1Q_6pYfkzr7XeRwhfnmg1h9uVwmsBZgVmRIAYGf14m08_i6hluKPK6rQ=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

$ git clone --single-branch --no-tags --origin upstream https://github.com/=
microsoft/vscode.git
Receiving objects: 100% (958326/958326), 287.26 MiB | 12.07 MiB/s, done.
Resolving deltas: 100% (679324/679324), done.
$ cd vscode
(master)$ git checkout -b LocalAddNewPipeline --track upstream/add-new-pipe=
line
fatal: 'upstream/add-new-pipeline' is not a commit and a branch 'LocalAddNe=
wPipeline' cannot be created from it
(master)$ git fetch upstream +refs/heads/add-new-pipeline:refs/remotes/upst=
ream/add-new-pipeline -v
From https://github.com/microsoft/vscode
* [new branch]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 add-new-pipeline -> upstream/add-new-pipeline
(master)$ git branch -a
* master
remotes/upstream/HEAD -> upstream/master
remotes/upstream/add-new-pipeline
remotes/upstream/master
(master)$ git checkout -b LocalAddNewPipeline --track upstream/add-new-pipe=
line
fatal: Cannot setup tracking information; starting point 'upstream/add-new-=
pipeline' is not a branch.
(master)*$ git status
On branch master
Your branch is up to date with 'upstream/master'.

Changes to be committed:
(use "git restore --staged <file>..." to unstage)
modified:=C2=A0=C2=A0 .devcontainer/cache/build-cache-image.sh
modified:=C2=A0=C2=A0 .devcontainer/devcontainer.json
..
modified:=C2=A0=C2=A0 test/smoke/src/areas/workbench/localization.test.ts
modified:=C2=A0=C2=A0 yarn.lock


What did you expect to happen? (Expected behavior)

The new branch to be created with the proper tracking information.


What happened instead? (Actual behavior)

Firstly, tracking information still can't be set even though we apparently =
successfully fetched and stored the previously uncloned remote tracking bra=
nch add-new-pipeline.

And secondly, if the tracking branch has any changes in comparison to the c=
urrent HEAD (master), git-checkout will terminate in a broken unclean way, =
affecting the worktree and index, writing to it and staging the changes.



Anything else you want to add:

Point one: Git-checkout broken termination is repeatable across different r=
epos and in the same one after doing git reset --hard

Point two: Same error message while using --track with git-branch, but it t=
erminates cleanly, not affecting worktree or index.

Point three: Even creating just the branch with git-branch, and trying to -=
-set-upstream-to doesn't work either, same error, clean exit.

Point four: This tracking error only happens when cloning with --single-bra=
nch. While the first error about the branch add-new-pipeline not exiting (b=
eing a commit (consistency? says "branch" in other errors)) is expected whe=
n there no information about it anywhere locally except the single default =
(master) branch in this case. However this now is unexpected because IMO we=
 gave git everything it needs to know to create the tracking information by=
 fetching with a refspec and creating the remote tracking branch, something=
 else is either not being done right under the hood or perhaps git-fetch fo=
rgets to do a step that git-clone would do without --single-branch, which -=
-track seem to rely on, why can't it just see and use the remote-tracking b=
ranch like git-branch -a -v can.

Point five: There's a rumor about there being an artificial limitation of n=
ot being able to use a branch as a tracking branch if it's not specified in=
 git config --local remote.upstream.fetch, which I tested and it turned out=
 to be exactly how this is worked around, by specifying the remote-tracking=
 branch specific refspec in git config --local remote.upstream.fetch,  isn'=
t this perhasp what git-fetch should actually do as well when trying to get=
 a previously uncloned branch.

Point six: However instead of rushing and accepting a workaround, I wanted =
to entertain that this should be considered a bug or a room for improvement=
, requiring the use of manual config file edits to me doesn't seem like a o=
ptimal official normal workflow but as a rather temporary workaround, even =
tho I'm not new to config file manipulation at all and don't have a persona=
l problem with it, plus considering the further points below why I think th=
is is a sort of artificial limitation that I don't understand the sense of =
right now.

Point seven: Tracking information benefits are also used by other git progr=
ams, not just git-fetch, so why should the tracking rely on the refspec set=
 in remote.upstream.fetch anyway, we're not even using git-fetch when using=
 --track in the first place already. There could be another parameter for t=
racking if necessary at all, and git fetch would write it and report about =
it with a warning.

Point eight: Git-fetch could later have a message in such --single-branch c=
ases, "Fetching previously uncloned branch" or "Fetching new remote-trackin=
g branch", and configuring whatever it has to, to make tracking work right,=
 if fetch would still need to be part of this at all.

Point nine: Though, sorry for not pointing this out earlier, my reason for =
fetching with refspec was because without it, git-fetch would only fetch in=
to FETCH_HEAD, and trying to use --track in git-checkout would return this =
error: fatal: ambiguous argument 'upstream/add-new-pipeline': unknown revis=
ion or path not in the working tree.

Point ten: In that case from point nine, one can do a new branch without tr=
acking and do git merge FETCH_HEAD, but then again you can't use --set-upst=
ream-to as mentioned earlier, and you can't use --track FETCH_HEAD either, =
saying: fatal: Cannot setup tracking information; starting point 'FETCH_HEA=
D' is not a branch. Even tho FETCH_HEAD has all the info IMO, --track isn't=
 designed to parse it, but it could right, or would still need refspec to a=
void potentially guessing anything?

Point eleven: --single-branch to me does not means as a single branch forev=
er, but only to clone the default branch initially ... the way git-fetch an=
d --track currently behave somehow indicates they weren't intended for the =
repo to add new previously uncloned branches ... makes me think what really=
 was the intention behind --single-branch in the very beginning, hopefully =
not like this.

Point twelve: Side thing, Docs and git messages don't mention the fact that=
 when --track is used in either git-checkout or git-branch it's not just ab=
out setting tracking or upstream, but also basing the new local branch on i=
t instead of the HEAD. It should because the "track" term it-self does not =
convey this fact in any way, even tho it's obvious to a seasoned user, but =
it still fells subtle, you can keep going and not notice the behavior. I gu=
ess that's why the --track option is considered critical and we get an appr=
opriately fatal error if we don't specify it. Before I realized this my ori=
ginal idea if it were only about tracking, git-checkout or git-branch could=
 have created the local branch without it and output a warning to set it up=
 later with --set-upstream-to, however that option doesn't have the same co=
nvenience setting the worktree to be based off that specified branch(commit=
), which is why I'm not seeing --track functionality as redundant or "old" =
as I heard others say, however --set-upstream-to correctly shouldn't do tha=
t and I think it makes perfect sense the way it works right now.

Point thirteen: There's only 12 days of Christmas, sorry. Happy holidays :)

PS: There is ofcourse a chance I could have missed or forgot to mention som=
ething during this rather exhaustive drilling, hopefully not something othe=
rwise very obvious.


[System Info]
git version:
git version 2.29.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-56-generic #62-Ubuntu SMP Mon Nov 23 19:20:19 UTC 2020 x=
86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31

Sent with ProtonMail Secure Email.
