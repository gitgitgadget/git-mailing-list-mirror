From: Mike Strauch <mike.strauch@hannonhill.com>
Subject: Re: Ignoring commits when merging
Date: Wed, 18 Aug 2010 14:08:20 -0400
Message-ID: <AANLkTi=MLE6WEmmDb6964-wX4f79ucpGU6SPieQK66ry@mail.gmail.com>
References: <AANLkTi=B9gsroJS_6SRqa2CLQOed2UguxN7KiFtFWL8t@mail.gmail.com>
	<20100818015947.GA19632@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 20:08:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oln3z-00062M-Bc
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 20:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab0HRSIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 14:08:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39306 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab0HRSIX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 14:08:23 -0400
Received: by bwz11 with SMTP id 11so435968bwz.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 11:08:22 -0700 (PDT)
Received: by 10.204.52.12 with SMTP id f12mr5694237bkg.212.1282154900433; Wed,
 18 Aug 2010 11:08:20 -0700 (PDT)
Received: by 10.204.83.72 with HTTP; Wed, 18 Aug 2010 11:08:20 -0700 (PDT)
In-Reply-To: <20100818015947.GA19632@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153869>

Jonathan,

Thanks for the info.  The scenario that I am in is most like the
"Writing a new bugfix" scenario you've described.  We have a
maintenance branch in which the majority of commits are bug fixes.  We
would then like to merge those bug fixes into our master branch.  The
difference being that there will occasionally be a commit in our
maintenance branch that we do not want to merge into our master branch
because it contains application version information which is only
relevant when we release something out of our maintenance branch.  So,
the tree looks like:

              Release

                   |
       ------- previous bug fixes --------- version info commit----
v1.0 --- bug fix commits --- X [maint]
      / =A0    =A0  =A0 =A0 =A0                       \ M1
--- o --------- ...
-------------------------------------------------------------------- N
[master]
               \                                      /
                -----------...--------- F [new feature branch]

You'll also notice I've included a new feature branch here to give
more of a big picture view of our setup.

So, what happens is this:

1. We fix some bugs in the maint branch (previous bug fixes)
2. We test those fixes
3. Merge the fixes back into master (M1)
4. Commit version information to maint branch (version info commit)
5. Release from maint branch (v1.0)
6. Start the process over from step 1 but with the version information
commit in the maint branch commit history.

So, in this scenario there is really only ever 1 commit that we don't
want to be merged into master from the maint branch.  This is not
always the case of course.  There could be some other commits in maint
branch that we don't want to merge back into master.  Anyway, if you
have any more feedback that would be great.  Either way, I'll have to
take a look at the man page you suggested.

Thanks again,

-Mike

On Tue, Aug 17, 2010 at 9:59 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> Mike Strauch wrote:
>
>> I'm fairly new to git and I'm trying to figure out the best way to
>> ignore certain commits when merging one branch into another.
>
> An interesting question. =A0The answer (as so often) depends on what
> you want to do. =A0"man 7 gitworkflows" might help.
>
> Below I will pretend you are trying to backport some changes to a mor=
e
> stable branch; others may chime in with other scenarios.
>
> First, a general hint: when using git and similar systems, it is
> generally best if each merged result is somehow "better" than all of
> its parents. =A0I will give an example below of what can go wrong if
> this invariant is violated.
>
> Merging to a maintenance branch
> -------------------------------
>
> Suppose given a history like this (1):
>
> =A0o --- v1.0 [maint]
> =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0feature --- feature --- bugfix --- bugfix [mas=
ter]
>
> Development has been happening on the "master" branch and now you
> want to merge back the relevant fixes to make a new point release,
> something like the following:
>
> [*] o --- v1.0 ------------------------------------ v1.1 [maint]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 master-only feature --- bugfix --- M [mas=
ter]
>
> =A0"a dangerous history"
>
> Let's consider what that would mean. =A0Someone builds some new
> work off of maint:
>
> =A0o --- v1.0 --- v1.1 --- o ... o --- A [someone]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /
>
> What happens when you pull the "someone" branch into master? =A0The
> relevant piece of history looks like this:
>
> =A0 =A0 =A0 =A0v1.1 --- o ... o --- A [someone]
> =A0 =A0 =A0 /
> =A0... M --- new development --- ... --- B [master]
>
> When you try to pull A into B, git runs a three-way merge to
> apply the changes from the someone branch after the branch point (M)
> on the master branch. =A0In particular, the changes from M to v1.1
> are pulled in. =A0The main change from M to v1.1 is to drop a
> bunch of features. =A0So by pulling from someone, you lose features
> on the master branch.
>
> So a merge like [*] that drops desirable changes is generally not
> a good idea.
>
> Cherry-picking to a maintenance branch
> --------------------------------------
>
> As a result, starting from a history like (1), there is only one
> choice: cherry-pick only the bugfixes, so the new features are not
> incorporated into the history of the maint branch.
>
> =A0$ git checkout maint
> =A0$ git cherry-pick bugfix1 bugfix2
>
> Afterwards, it is best to merge the maint branch into master, so
> later changes on the maint branch can be merged into master more
> easily. =A0Usually despite the duplicate changes will not result in
> conflicts.
>
> =A0$ git checkout master
> =A0$ git merge maint
> =A0$ git diff HEAD^
> =A0$ : looks good
> =A0$ git push public maint master
>
> If there are conflicts, no need to worry: make sure that "master"
> really includes all desirable changes from maint and merge with
> strategy ours instead.
>
> =A0$ git reset --merge
> =A0$ git merge -s ours maint
>
> Writing a new bugfix
> --------------------
>
> Suppose you have an idea for a new bugfix. =A0As discussed above, if
> you write it directly on top of master, when it is time to apply
> it to maint it will need cherry-picking. =A0If you base the patch
> on maint, you can avoid that:
>
> =A0$ git checkout -b bugfix maint
> =A0... hack hack hack ...
> =A0$ make test
> =A0$ : looks good
> =A0$ git checkout master
> =A0$ git merge bugfix
> =A0$ make test
> =A0$ git push public bugfix master
>
> =A0v1.1 [maint] --- X [bugfix]
> =A0 =A0 \ =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0o --- ... --- N [master]
>
>
> Once the patch gets enough testing from users of master, it is
> time to apply it to maint.
>
> =A0$ git checkout maint
> =A0$ git merge bugfix
> =A0$ make test
> =A0$ git checkout master
> =A0$ git merge maint
> =A0$ git push public maint master
>
> =A0v1.1 ----------- X [maint]
> =A0 =A0 \ =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0o --- ... --- N [master]
>
> One benefit of this approach is that during development, the patch
> is tested against the maintenance branch, which is incidentally
> probably where it is most important that it get testing.
>
> Hope that helps,
> Jonathan
>
