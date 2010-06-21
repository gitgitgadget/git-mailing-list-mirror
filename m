From: Joshua Shrader <jshrader83@gmail.com>
Subject: Re: SVN migration
Date: Mon, 21 Jun 2010 17:12:24 -0400
Message-ID: <AANLkTinUc5z66Yk13ZKgHU113nRuAcl3HyC3eXAJAE6j@mail.gmail.com>
References: <4C1957EF.6070504@gnatter.net>
	<7B0F34CE-9C9F-4FC3-AD96-8B1B8DD4359B@gmail.com>
	<4C19FA07.9010603@gnatter.net>
	<4C1A4CF6.9080300@gnatter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Michalske <smichalske@gmail.com>, git@vger.kernel.org
To: William Hall <will@gnatter.net>
X-From: git-owner@vger.kernel.org Mon Jun 21 23:12:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQoIB-0001MP-LK
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 23:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758484Ab0FUVM0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jun 2010 17:12:26 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59834 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758371Ab0FUVMZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jun 2010 17:12:25 -0400
Received: by vws3 with SMTP id 3so1518386vws.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7y7yRQWdNRJ+zfK0OYJgkqXTNvS6dW8poiAXYx5QyGA=;
        b=nZcwKVIm7JLH/3Gd+9lMgsXrcN5x1RijUhuBZ4lDkAtNhVWgWiW5smRfmlsnI7Z9pW
         f6Pm6zqgcC88vfpeLlXiOVKvXiVndiFFl8doSSOdh7Hn6knijosuTzuAcaUUHI95bve0
         5tPSViCRqQaFj8H81YXI+rQqftiJBF+o89j2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IuXRMo//l6y1je0s9umIlPXcCx/NLZB8xUMCU4CuZRIVYvjFIjJIrFqLyMaJnm/Gt+
         Wdj+IJbbemD3iMOfhKxOJYhTrcNF9PpXRF7olC8jTZMhrWMHbzb1dmwlKE3TKpHG5Nv6
         OB+nT+eWQpl1Lytq8eTQUzvBMuz9fpye2HRW0=
Received: by 10.220.172.198 with SMTP id m6mr2538366vcz.79.1277154744934; Mon, 
	21 Jun 2010 14:12:24 -0700 (PDT)
Received: by 10.220.106.198 with HTTP; Mon, 21 Jun 2010 14:12:24 -0700 (PDT)
In-Reply-To: <4C1A4CF6.9080300@gnatter.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149440>

In Jon Loeliger's "Version Control with Git", Chapter 16, he describes
a similar situation in which there is a Subversion repository, and at
least a couple users that want to be using Git.  He proposes a single
"gatekeeper" git repository, what you refer to as a bridge, which is
the only interface to subversion.  After git svn cloneing the
subversion repo (with --prefix=3Dsvn/), all the branches are then pushe=
d
to a bare repository (git push ../svn-bare.git
'refs/remotes/svn/*:refs/heads/svn/*', and other git users are told to
clone this repo, which now contains local branches of all the svn
remotes.  Then, to merge back to subversion, in the gatekeeper repo,
you do

git checkout svn/trunk (or other branch - this is checking out a
detached head as svn/trunk is a remote)
git merge --no-ff new-feature
git svn dcommit

This results in a merge commit on a detached head, and then the
modified commit (after the git-svn-id line is added) is put on the
real svn/trunk branch.  The commit on the detached head is "worse than
redundant.  Using it for anything else eventually results in
conflicts.  So, just forget about that commit.  If you haven't put it
on a branch in the first place, it's that much easier to forget" (Jon
Loeliger).

I haven't tried this yet, but I'm in a similar situation in that I'm
trying to convince my project to convert to using Git.  We're going to
use this gatekeeper approach for a while, and allow users to migrate
over at their own discretion.  Then hopefully, if there's not too much
resistance, we'll get rid of the subversion repo entirely.

If there's a problem with this workflow, I'd love to hear about it.
I'm only in the middle of setting this up, but hopefully I should know
if it works by the end of the week.

On Thu, Jun 17, 2010 at 12:27 PM, William Hall <will@gnatter.net> wrote=
:
> I'm going to answer my own post, I *think* I have something that work=
s -
> please check if I'm doing anything idiotic.
>
> Just to recap: trying to convince my company to move from svn to git,=
 and
> they have agreed to try one project using git as long as all commits =
find
> their way to the svn repo as well.
>
> So I have a standard bare git repo serving the developers, a git/svn
> "bridge" repo that performs bi-directional updates to and from svn an=
d the
> bare git repo.
>
> Ok, here's what I've done
>
> Create bridge
> -------------
> $ git svn init -s file:///path_to_svn /path_to_git_svn_bridge/
> $ cd /path_to_git_svn_bridge
> $ git svn fetch --authors-file=3D/tmp/authors.map
>
> Configure bare repo
> -------------------------------
> create bare repo that developers will use
> $ git init --shared=3Dall --bare /path_to_git_repo.git
>
> configure bridge
> ----------------
> $ git remote add -f -m master origin /path_to_git_repo.git
> $ git push origin master
> $ git branch --set-upstream master origin/master
>
> this branch will be used to perform svn rebases and fetches
> $ git checkout -t -b svn svn/trunk
>
>
> Workflow
> --------
> Developer A clones from /path_to_git_repo.git, does some work, commit=
s and
> pushes back to origin
>
> Now, in the bridge repo, fetch changes from origin (where developer A
> pushed)
> $ git checkout master
> $ git pull
>
> Replay all changes manually, in order, onto svn branch
> $ git checkout svn
> $ git rev-list --reverse heads/master@{1}..heads/master | while read =
rev; do
> =A0 =A0 =A0 =A0git cherry-pick -n $rev
> =A0done
>
> Create one commit for all changes and synchronise with svn
> $ git commit -am "cherry pick merge"
> $ git svn rebase
> $ git svn dcommit
>
> Now merge in anything picked up from svn, plus the rebased final comm=
it
> $ git checkout master
> $ git merge svn
>
> Send back to bare repo (at least the final merge commit)
> $ git push
>
> It seems to handle changes and preserves linear history on both sides=
 ok.
> Can anyone see anything obviously wrong with this approach?
>
> thanks,
>
> Will
>
>
>
>
>
>
> William Hall wrote:
>> Thanks Steven,
>>
>> The noMetadata option will prevent me from doing anything other than=
 a
>> one-shot import, which is not what I want. I need to somehow devise =
a
>> workflow that allows me bidirectional push/pull between an svn repo =
and a
>> remote git repo.
>>
>>
>>
>> Steven Michalske wrote:
>>> On Jun 16, 2010, at 4:02 PM, William Hall wrote:
>>>
>>>> The issue is the dcommit operation from the bridge. The rebase par=
t of
>>>> this re-writes the commit messages to include the SVN commit-ids w=
hich is
>>>> nice, but screws up the push/pulls between the bridge and the bare=
 repo.
>>>
>>> Look into svn.noMetadata configuration option. =A0It will prevent y=
ou from
>>> rebuilding the svn to git bridge if something seriously goes wrong,=
 but it
>>> prevents the messages from changing.
>>>
>>> svn-remote.<name>.noMetadata
>>> This gets rid of the git-svn-id: lines at the end of every commit.
>>> If you lose your .git/svn/git-svn/.rev_db file, git svn will not be=
 able
>>> to rebuild it and you won't be able to fetch again, either. This is=
 fine for
>>> one-shot imports.
>>> The git svn log command will not work on repositories using this, e=
ither.
>>> Using this conflicts with the useSvmProps option for (hopefully) ob=
vious
>>> reasons
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
> William Hall wrote:
>>
>> Thanks Steven,
>>
>> The noMetadata option will prevent me from doing anything other than=
 a
>> one-shot import, which is not what I want. I need to somehow devise =
a
>> workflow that allows me bidirectional push/pull between an svn repo =
and a
>> remote git repo.
>>
>>
>>
>> Steven Michalske wrote:
>>>
>>> On Jun 16, 2010, at 4:02 PM, William Hall wrote:
>>>
>>>> The issue is the dcommit operation from the bridge. The rebase par=
t of
>>>> this re-writes the commit messages to include the SVN commit-ids w=
hich is
>>>> nice, but screws up the push/pulls between the bridge and the bare=
 repo.
>>>
>>> Look into svn.noMetadata configuration option. =A0It will prevent y=
ou from
>>> rebuilding the svn to git bridge if something seriously goes wrong,=
 but it
>>> prevents the messages from changing.
>>>
>>> svn-remote.<name>.noMetadata
>>> This gets rid of the git-svn-id: lines at the end of every commit.
>>> If you lose your .git/svn/git-svn/.rev_db file, git svn will not be=
 able
>>> to rebuild it and you won't be able to fetch again, either. This is=
 fine for
>>> one-shot imports.
>>> The git svn log command will not work on repositories using this, e=
ither.
>>> Using this conflicts with the useSvmProps option for (hopefully) ob=
vious
>>> reasons
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
