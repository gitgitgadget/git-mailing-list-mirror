From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: RFC: Making submodules "track" branches
Date: Mon, 7 Jun 2010 23:29:07 +0000
Message-ID: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 01:29:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLlkn-0002z8-RL
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 01:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab0FGX3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 19:29:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36790 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab0FGX3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 19:29:08 -0400
Received: by iwn37 with SMTP id 37so3968420iwn.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=L2gpudhbjYJtfBchukNHTKGN5Pm7bO07kXIyrGERWrQ=;
        b=BVVOrboj4ifYDLxgyzLFt1gtzobExHcs676Ni9rlxBXSfBgDyBfM7NmNPW4CrI7K63
         5iW5AkTnn2F9Ct539GVU/qBDdn+sL/qgjFyw0wnrN2G6cQ92ODdZM4Vp5OB6rN6fCqwm
         6bKAj79c5u2v8B1hEBOnq6FfDXANgg535dVCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=IT5cuWt8kyukq94dQQ8VKKSvYNz/BvQZjS7/FIXqB6p2QJlPJlF3i5zRSTDTJn16L3
         zkWx219uftrnD5Nam9+9556uzyH2mfASaSAnLkWmMRVWy8MxGd0y2O3vZj4kJx42zr9p
         yiq5x9aR1ZSlYL6o03RsPvqkmIFEt9xFkLmsM=
Received: by 10.231.169.145 with SMTP id z17mr5807775iby.3.1275953347332; Mon, 
	07 Jun 2010 16:29:07 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 7 Jun 2010 16:29:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148633>

On Fri, May 21, 2010 at 16:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> Add a $toplevel variable accessible to `git submodule foreach`, it
> contains the absolute path of the top level directory (where
> .gitmodules is).
>
> This makes it possible to e.g. read data in .gitmodules from within
> foreach commands. I'm using this to configure the branch names I want
> to track for each submodule:
>
> =C2=A0 =C2=A0git submodule foreach 'git checkout $(git config --file =
$toplevel/.gitmodules submodule.$name.branch) && git pull'
>
> For a little history: This patch is borne out of my continuing fight
> of trying to have Git track the branches of submodules, not just thei=
r
> commits.
>
> Obviously that's not how they work (they only track commits), but I'm
> just interested in being able to do:
>
> =C2=A0 =C2=A0git submodule foreach 'git pull'
>
> Of course that won't work because the submodule is in a disconnected
> head, so I first have to connect it, but connect it *to what*.
>
> For a while I was happy with this because as fate had it, it just so
> happened to do what I meant:
>
> =C2=A0 =C2=A0git submodule foreach 'git checkout $(git describe --all=
 --always) && git pull'
>
> But then that broke down, if there's a tag and a branch the tag will
> win out, and I can't git pull a branch:
>
> =C2=A0 =C2=A0$ git branch -a
> =C2=A0 =C2=A0* master
> =C2=A0 =C2=A0 =C2=A0remotes/origin/HEAD -> origin/master
> =C2=A0 =C2=A0 =C2=A0remotes/origin/master
> =C2=A0 =C2=A0$ git tag -l
> =C2=A0 =C2=A0release-0.0.6
> =C2=A0 =C2=A0$ git describe --always --all
> =C2=A0 =C2=A0release-0.0.6
>
> So I figured that I might as well start tracking the branches I want
> in .gitmodules itself:
>
> =C2=A0 =C2=A0[submodule "yaml-mode"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D yaml-mode
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D git://github.com/yoshiki/yaml-mode=
=2Egit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0branch =3D master
>
> So now I can just do (as stated above):
>
> =C2=A0 =C2=A0git submodule foreach 'git checkout $(git config --file =
$toplevel/.gitmodules submodule.$name.branch) && git pull'
>
> Maybe there's a less painful way to do *that* (I'd love to hear about
> it). But regardless of that I think it's a good idea to be able to
> know what the top-level is from git submodule foreach.

This patch is getting merged to next as per the June 2 What's cooking
in Git post.

But I wonder how evil it would be to expand this this idea to allow
the porcelain to track branches instead of commits at the porcelain
level.

That /could/ work like this. The tree format would be exactly the
same, i.e. bound to a specific commit:

    $ git ls-tree HEAD | grep subthing
    160000 commit 37469ca3fae264e790e4daac0fa8f2ddf8039c93  subthing

*But*, the user could add some new submodule.*.* config key/values
that specify what branch the module should track and whether 'git
pull' on the master project should also pull new changes (from the
'newstuff' branch) into the submodule:

    [submodule "subthing"]
        path =3D subthing
        url =3D git://github.com/avar/subthing.git
        branch =3D newstuff
        update-on-pull =3D true

Coupled with .gitignore this would allow for SVN-like externals that
always track the latest version of upstream, but it'd all be done on
the porcelain side.

The checked out copy wouldn't match the commit in the tree, but the
user could still git add && git commit it to record the new commit in
the master repository history.

The lack of this ability seems to be a fairly common complaint about
submodules in Git, that you always have to do something in the parent
project to update the submodules, even if you don't care about
specific revisions, or the ability to roll back.

I couldn't find a prior discussion of this on the list, maybe this has
been beaten to death already.
