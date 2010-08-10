From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: workflow for working on feature branches and incrementally 
	incorporating "master" changes
Date: Wed, 11 Aug 2010 08:32:19 +1000
Message-ID: <AANLkTimd1z746ptjJmu_Ytqep1VwR7Hrr6bC4b6kw72w@mail.gmail.com>
References: <AANLkTi=h2MbSKmQk9p6w44WORAa8XzkpF0nBXKOgJ4T1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 00:32:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OixNE-0006BA-Nw
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 00:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024Ab0HJWcb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 18:32:31 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36255 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757936Ab0HJWcU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 18:32:20 -0400
Received: by qwh6 with SMTP id 6so8696464qwh.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XmTd4bDzOQpjwZqCqLRJ4T+hsg/7KSwILVwjB0ukVcg=;
        b=xMM3CrJ+j8GhQpxIVDVymogeKYPRryWTt7cofXoslvyrl6s754U9dBOCfOIGMaYKJa
         le6dBFZPtw+DR9j31qtKb8WZ4NNDsxV6Jv3/tQyw4ecI4Phr0SqXRYXjU1hIKZhdV+mr
         zLAG9McjQ5MtHDyEFkpHmhs6ovRWY5afN7DV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DyKks8KrZILLfKQX22ddpLT3vW2/Yuy5sMwTuhB1llanlarYbhQVu8PaTJQj7UYx8c
         Dq1+92j9AtzhWhFjTu9rcB2Xh+ppUYBs8rsTOTUKqvkclCu8UupQ2rdtu25WrTpmwc8u
         XtRA7XPfIC0GEnFPsVZJ2agc6t8ZHKp3o+KG0=
Received: by 10.224.86.224 with SMTP id t32mr10077995qal.263.1281479539633; 
	Tue, 10 Aug 2010 15:32:19 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Tue, 10 Aug 2010 15:32:19 -0700 (PDT)
In-Reply-To: <AANLkTi=h2MbSKmQk9p6w44WORAa8XzkpF0nBXKOgJ4T1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153168>

I'll describe the workflow that works very well for me.

I use a single branch, working, as a working branch. I NEVER publish
the tip of this branch. Rather, it always contains my working tree
which consists of:

- a base, which is a merge of:
   - completed work I have yet to publish
   - the upstream branch, as pulled at some previous time
   - fixes from other people that have yet to be integrated into the up=
stream
- a linear series of one or more commits that I am currently working on
- the tip, or HEAD of the working branch.

Here are some typical workflows:

- pull from upstream:

   - fetch the upstream (git fetch upstream)
   - checkout the branch tracking the BASE of my working branch (git
checkout working-base)
   - merge with the upstream (git merge upstream/master)
   - rebase the linear bit of my work on that (git rebase working-base =
working)

- isolate some work as a fix to some upstream build tag (BUILD-XXXX)
  - fetch tags from upstream (git fetch upstream refs/tags/*:refs/tags/=
*)
  - create a new branch for the topic (git branch topic HEAD)
  - create a new base branch for the topic (git branch topic-base HEAD~=
N)
  - rebase the topic onto the BUILD-XXX tag (git rebase --onto
BUILD-XXX topic-base topic && git branch -f topic-base BUILD-XXX)
  - merge the topic into the base of my working branch (git checkout
working-base && git merge topic)
  - rebase the remainder of the working branch onto the updated
working-base (git rebase working-base working)

- patch a previously isolated topic with the top commit from the workin=
g branch
  - create a temporary branch for the fix ( git branch -f topic-fix
HEAD && git rebase --onto topic HEAD~1 topic-fix)
  - update the topic ( git checkout topic && git merge --ff-only
topic-fix && git branch -d topic-fix)
  - merge the topic back into the base of my working tree ( git
checkout working-base && git merge topic && git rebase working-base
working)

- publish a topic
  - git tag topic-XXX topic && git branch -f topic-base topic-XXX &&
git push public topic-XXXX

- integrate a tag someone else has published into my base
  - git checkout working-base && git merge other-topic-XXX && git
rebase working-base working

This way of working has some very nice properties:

* the base of my working branch (working-base) contains all my
_dependencies_, that is:
   * the upstream branch
   * my finished, but un-integrated work
   * other people's finished but un-integrated work

* integrating dependencies is done the same way, irrespective of where
they come from, e.g.:

   git checkout working-base && git merge dependency && git rebase
working-base working

* the base of my branch is a  merge hell, but I don't care, because it
is built from well known, relatively stable dependencies - I can throw
it away and rebuild it any time relatively easily.

* my working tree remains stable - it always contains stuff I have
recently worked on, or stuff I want

* my topic branches remain clean and uncluttered with merges, so I can
release them to others without dragging unwanted stuff along

* merges tend to be trivial, since they are based on stable work.
rebases are usually easy, because they are used only used on a
relatvely small amount on unpublished, unstable work

This only downside to the workflow is the complexity of using an extra
branch (working-base) to track the base of the working branch. If you
forget to update it, you can accidentally do some stupid things (which
can be fixed by using the info in git reflog).

In fact, this workflow is so useful to me, that I believe it needs its
own git porcelain to assist with the management. I am, in fact,
developing two commands to do just this: git base and git work.

git base manages the base of the branch (using a reference called
refs/bases/<branch>) while git work helps to manage the workflow of
maintaining the base of the branch. With these two (as yet unpublished
commands), the workflows above become as simple as:

 * initialise the base: git base set upstream/master
 * sync with upsteam: git work merge upstream/master
 * merge with some dependency: git work merge dependency-XXXX
 * create a new topic from recent work: git work create topic HEAD~N BU=
ILD-XXX
 * update an existing topic with recent work: git work update topic HEA=
D~N
 * rebase onto a clean base: git work rebase BUILD-XXX
 * visualize just the current work: gitk $(git work)  (which expands
as gitk $(git base)..working or gitk refs/bases/working..working)
 etc.

I hope to have time to release some feature stable contributions in a
week or two...stay tuned.

Regards,

jon.


On Wed, Aug 11, 2010 at 6:20 AM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> If you're working on a feature branch by yourself, what is a good
> workflow for keeping the branch in up-to-date with "master" as you're
> developing on the feature branch or is this unnecessary? Should you
> just wait until you want to officially integrate the feature branch
> into the "master"?
>
> We were doing:
>
> commit to local feature branch
> push to remote feature branch
> ... repeat....
> rebase from master (occasionally)
> push to remote
>
> but at this point the branches have diverged.
>
> We're coming at this from SVN, so we might just be thinking about thi=
s
> the wrong way.
>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
