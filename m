From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH/RFC] Introduce git submodule add|update --attach
Date: Fri, 3 Jan 2014 00:42:35 +0100
Message-ID: <CALas-ihAkUGOZsmWRHN7fG+5D0OnpWmSNtrMH2mwNm51gcYdRw@mail.gmail.com>
References: <1388368184-18418-1-git-send-email-ceztko@gmail.com> <xmqqppoap2qb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 00:43:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyrun-0003tU-DV
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 00:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbaABXm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 18:42:57 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:40229 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbaABXm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 18:42:56 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so15139128oag.26
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 15:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HhiCYWB/5vWvnPg0OPhwdCQym/3wdrxgFYCAdEcXQ40=;
        b=nyuj1yIEgGxExWUvP+8uEnDzj7G+980Cjmz+GYIrQIkR9ja4AFxYzQl/lpbCqPlO2W
         O+wLgR95zNXcawhZlVtITxBiAjxEp/xc2XfziwMR00V9yori01sheMQ7TW4QPZ6TwdeD
         uIal/xOZx0D+/3RFMxlPd6/C5Fe5co2B7T0d6whE+4pP8RmQ8udYGMmjCCXjV+1xTmeK
         FkoxOaDh8iGF87A1ByyMSPtQljgKIKC0lCTVG60+XYxUxDKATvWDC9ZltfGQ52Cgmp1O
         Q5Ls4t13DD8Qe5ApLafClJSsY83akiCa+EBvdOvBTyDoUuzjlaVoX3ylt4b3ZjFyXPIL
         jGog==
X-Received: by 10.60.123.19 with SMTP id lw19mr1633405oeb.24.1388706175660;
 Thu, 02 Jan 2014 15:42:55 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Thu, 2 Jan 2014 15:42:35 -0800 (PST)
In-Reply-To: <xmqqppoap2qb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239894>

2014/1/2 Junio C Hamano <gitster@pobox.com>:
> Francesco Pretto <ceztko@gmail.com> writes:
>
>> by default "git submodule" performs its add or update operations on a detached
>> HEAD. This works well when using an existing full-fledged/indipendent project as
>> the submodule, as there's less frequent need to update it or commit back
>> changes. When the submodule is actually a large portion of shareable code
>> between  different projects, and the superproject needs to track very closely
>> the evolution of the submodule (or the other way around), I feel more confortable
>> to reattach the HEAD of the submodule with an existing branch.
>
> I may be missing some fundamental assumption in your mind when you
> did this change, but in a workflow where somebody wants submodule
> checkout to be on branches (as opposed to detached), wouldn't it
> make more sense not to detach in the first place, rather than
> introducing yet another option to "re-attach"?  The documentation of
> "submodule update" seems to say that its "merge" and "rebase" modes
> do not detach in the first place (and it alludes to "--checkout" but
> it is unclear what it does purely from the documentation, as "git
> submodule --help" does not even list it as one of the options).
>

Thanks for commenting: because of more checking I just spotted some
unuseful code in my patch in cmd_add() function. In short: it seems to
me "git submodule update" doesn't allow to work with attached an HEAD
(unless it is *manually* attached, as I regularly do). My feeling is
the documentation of "merge", "rebase" update commands is inaccurate
and doesn't really reflect what happen when adding a submodule with
"add" or cloning it for the first time with "update". You can look at
the following conditionals in the current code in git-submodule.sh:

## cmd_add()
case "$branch" in
'') git checkout -f -q ;;
?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
esac

## cmd_update()
# Is this something we just cloned?
case ";$cloned_modules;" in
    *";$name;"*)
    # then there is no local change to integrate
    update_module= ;;
esac

This means that the "add" command will always checkout an *attached*
HEAD but at the first clone of a different user the checkout will
resolve in "git checkout <sha1>", always producing a *detached* HEAD
and resulting in inconsistent HEAD state between who added the
submodule with "add" and who cloned it with "update". Subsequent
"merge" or "rebase" operations won't change this fact, the HEAD will
remain detached. The following test case confirms this, unless I did
something wrong:

-----------------------------------------------------------------
parentdir=$(pwd -P)
submodurl1=$(pwd -P)/repo1
submodurl2=$(pwd -P)/repo2
repourl=$(pwd -P)/repo

# Create repo to be added with submodules
cd $parentdir
mkdir repo
cd repo
git init
git config receive.denyCurrentBranch ignore
echo a >a
git add a
git commit -m "repo commit 1"

# Create repo repo1 to be used as submodule
cd $parentdir
mkdir repo1
cd repo1
git init
git config receive.denyCurrentBranch ignore
echo a >a
git add a
git commit -m "repo1 commit 1"

# Create repo repo2 to be used as submodule
cd $parentdir
mkdir repo2
cd repo2
git init
git config receive.denyCurrentBranch ignore
echo a >a
git add a
git commit -m "repo2 commit 1"

# Clone repo to test "git submodule update"
cd $parentdir
git clone "$repourl" repoclone

#
## Adding submodule with update "rebase", not specifying a <branch>
#

cd $parentdir/repo
git submodule add "$submodurl1" submod1
git config -f .gitmodules submodule.submod1.ignore all
git config -f .gitmodules submodule.submod1.update rebase
git commit -m "Added submodule"
###### repo/submod1 has an attached HEAD ######

cd $parentdir/repoclone
git pull
git submodule init
git submodule update
###### repoclone/submod1 has a detached HEAD --> note the inconsistency ######

#
## Adding submodule with update "rebase", specifying a <branch>
#
cd $parentdir/repo
git submodule add --branch master "$submodurl2" submod2
git config -f .gitmodules submodule.submod2.ignore all
git config -f .gitmodules submodule.submod2.update rebase
git add .
git commit -m "Added submodule"
###### repo/submod2 has a attached HEAD ######

cd $parentdir/repoclone
git pull
git submodule init
git submodule update --remote
###### repoclone/submod2 has a detached HEAD --> note the inconsistency ######

#
## Adding something to submod2 and test update "rebase" on repoclone
#

cd $parentdir/repo1
echo b >b
git add b
git commit -m "repo1 commit 2"

cd $parentdir/repoclone
git submodule update --remote
###### repoclone/submod1 has still a detached HEAD ######
-----------------------------------------------------------------


> And if there is a good reason why detaching to update and then
> (perhaps after verifying the result or cleaning it up?  I dunno what
> the expected use case is, so I am purely guessing) attaching the
> result to a specific branch in separate steps, does it make sense to
> give "--attach" option to "update" in the first place?  That makes
> the whole thing into a single step, not giving the user a chance to
> do anything in between, which I am guessing is the whole point of
> your not using the existing "do not detach, work on a branch" modes.
>

1) The "--attach" option in the "add" git submodule command is my
contribution to have the "attached" behavior by default for cloning
users, because it's not possible to obtain it by just setting the
update command to "merge" or "rebase";
2) The "--attach" and "--detach" switches for the "update" command are
needed just to override in the command line the setting of
"submodule.<module>.attach" (or its absence of value). Of course not
many users will need to use these switche. The others will just use
the provided "submodule.<module>.attach" value and issue "git update"
(or "git init", when needed to update properties).

Concluding, my point is that at the current state submodules in git
seem to be flawed because of the inconsistent HEAD state between "add"
and "update" users. With my patch applied the attached HEAD behavior
would be fully supported. At some point "git submodule add" (without
the "--attached" switch) could be also modified to produce a detached
HEAD by default, removing any remaining inconsistency.
