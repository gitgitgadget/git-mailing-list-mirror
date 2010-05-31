From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Simplifying work across multiple projects (while tracking
 relationships among commit histories)
Date: Mon, 31 May 2010 03:56:27 -0500
Message-ID: <20100531085627.GA2094@progeny.tock>
References: <AANLkTimC0SoVAG-2xByZFFitl2KNlAhYlAw5fN_XqriT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>
To: Yang Zhang <yanghatespam@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 10:56:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ0nd-0003hD-Jc
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 10:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab0EaI4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 04:56:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43205 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847Ab0EaI4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 04:56:38 -0400
Received: by iwn6 with SMTP id 6so439027iwn.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QjAV0RRbzW07QQbBkipNTc2WZO/bxpU03QHeW9SIx4k=;
        b=xcsI9eL8+NoF7KkMIFI9HCSOLetiH56YfNtG8Cbb3b7XDfEEJB/j80JggkwjLERE9D
         uu0hFRTmLWCEdrfXwUjxb2NrTjWrk2AlDMXJ+G+EI4greYrAwVHehSCLCV6YgkB2TPFY
         BQOPGjgJ3DqlaYA4RCwzF3e2Qtr1K8WVCOkyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MsTd3rcoalCDga9Wtjb0TdcUI8kQiRLD3IDaJzN6E9/hVTRNDy7BMibXIMYweY76Lu
         5aKZ0V7bUnQ5aJ0czZmtLlDIkJk8cQLSQd12uXLcYcRvF1IcQ4cU9C7q3sed0R/BXS1W
         8ciU/R7x11Ws8x51LJ7cm8b+YIIYsXzh1/kxw=
Received: by 10.231.150.18 with SMTP id w18mr5355001ibv.43.1275296197635;
        Mon, 31 May 2010 01:56:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm25315802ibg.15.2010.05.31.01.56.35
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 31 May 2010 01:56:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimC0SoVAG-2xByZFFitl2KNlAhYlAw5fN_XqriT@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148035>

Hi Yang,

Yang Zhang wrote:

> We're
> developing a large system consisting of several components (libraries=
,
> servers, applications, etc.).
[...]
> For now, we'll probably just have some simple scripts that basically
> do 'for i in $projects' loops for pulls, pushes, commits, etc.
> However, this loses a lot of information that should be tracked about
> the version/dependency information among the projects -- information
> that at the same time we're not interested in manually tracking. We'r=
e
> currently thinking of having a simple system that is initially set up
> with a dependency graph among projects, e.g.:
>=20
>   a: no dependencies
>   b: depends on a
>=20
> and whenever a commit is made to a project with dependencies (b), the
> commit (perhaps in the commit message) contains a reference to the
> particular versions of the dependent project(s) (a) that were checked
> out.

It sounds to me like submodules would be a better approach.  Because
it fits my great love of complaining (and I would like to hear what
solutions you come up with, if any), let me try to go through the
problems you would run into.

I am not a submodule developer or heavy user, so please check anything
I say before relying on it.

1. Suppose you are working on the program frobber and you notice it
   contains a usable sub-component veryfastregexp.  So you make a new
   repository for it, make sure it builds on its own, and publish.
   As always when starting a new project, there is a question of how
   much early history to preserve.  Probably best to start with a
   single commit, and provide a separate branch with
   =E2=80=98filter-branch --subdirectory-filter=E2=80=99 output if you =
are feeling
   generous.

   In frobber, you remove the copy of veryfastregexp, add it back
   with =E2=80=98git submodule add git://someserver/path/to/veryfastreg=
exp=E2=80=99,
   commit, and publish.

    - New clones must use =E2=80=98git clone --recursive=E2=80=99.  How=
 do you
      advertise this?

    - Existing clones must use =E2=80=98git submodule update --init=E2=80=
=99 after
      they pull.  In fact, it seems to me it=E2=80=99s not a bad idea t=
o
      always use =E2=80=98git submodule update --init --recursive=E2=80=
=99 after each
      pull.  How do you advertise this?

    - Incoming patches that touch both veryfastregexp and frobber
      have to be split into separate patches for the two projects.
      How?

    - Pull requests are even worse (or just as bad, depending on
      how you solved the previous problem).

2. Some people like to use the latest stable version of all components
   they use, while other people like to avoid change wherever
   possible.  I=E2=80=99ll consider the latter sort of person in a mome=
nt.

   The developers of frobber want to use the latest version on the
   master branch for all components.  So they try the following:

	git submodule foreach '
		git checkout master &&
		git pull &&
		git submodule update --init --recursive
	'

   This checks out a branch tracking the upstream master branch
   for each submodule.

   Next they run =E2=80=98git add -u=E2=80=99 to mention all the update=
d submodule
   versions, test to make sure everything=E2=80=99s okay, and commit.

    - This does not bring sub-submodules to the latest version at the
      same time.  If the frobber developers wanted to do that, they
      might try

	git submodule foreach --recursive '
		git checkout master &&
		git pull &&
		git submodule update --init --recursive
	'

      Then they run =E2=80=98git add -u=E2=80=99, test, and run =E2=80=98=
git commit=E2=80=99.  But
      the editor informs them that submodules have unstaged changes.
      What happened, what are the consequences for others using this
      project, and can this be avoided?

      I=E2=80=99ll return to this in a moment.

3. Some people never upgrade until forced to.

   The veryfastregexp library is a resounding success, picked up
   by other people in the company, and rapidly developed.  After a
   particularly painful upgrade, the developers of frobber have a turn
   for the conservative.  From now on, their policy is =E2=80=9Cnecessa=
ry
   fixes only=E2=80=9D.  So they would like to maintain their own branc=
h and
   cherry-pick from master.

   They put in a request for privileges to commit to their own branch,
   and wait.  In the meantime, an important fix comes up.  So they
   do the only thing they can do: publish a fork of veryfastregexp,
   update .gitmodules to point to it, run =E2=80=98git add -u=E2=80=99 =
to register
   the version they are using, test, commit, and push.

   New clones made with =E2=80=98git clone --recursive=E2=80=99 will us=
e the
   project-specific version of veryfastregexp.

    - Users with existing clones must update the URL with
      =E2=80=98git remote set-url origin <new url>=E2=80=99 from the su=
bmodule
      or =E2=80=98git submodule sync=E2=80=99; otherwise, the next time=
 they run
      =E2=80=98git submodule update=E2=80=99 there will be an =E2=80=98=
unable to checkout=E2=80=99
      error.  How do you advertise this?

    - Suppose a frobber developer tries the following from the
      frobber repository:

	cd veryfastregexp && git cherry-pick important-fix

      runs =E2=80=98git add -u=E2=80=99 from the toplevel, tests, commi=
ts, and
      pushes the result.  Of course, an important step is missing: he
      forgot to push to the veryfastregexp-frobber repository! =20
      Anyone who tries to pull this change and run =E2=80=98git submodu=
le
      update=E2=80=99 will find the commit object missing and be unable=
 to
      check out the new revision.

      An update hook could have prevented this, since from the
      server side it is obvious which objects a new clone will have
      access to.  Where can one find such a hook?

   The frobber developers=E2=80=99 request for a branch in the veryfast=
regexp
   repository is granted.  So they switch .gitmodules back again
   and keep the submodule pointed to the for-frobber branch, updating
   as needed.

    - Now the old recipe

	git submodule foreach --recursive '
		git checkout master &&
		git pull &&
		git submodule update --init --recursive
	'

     does not work for them anymore, since this would switch
     the frobber branch back.  What should they do to adjust?
     How can they make it easy for new people on their team to
     get started, too?

4. The developers who want all components to be aggressively updated
   (see #2 above) need to do something similar.  They first switch all
   components to point to repositories with branches they own, and
   then run aggressively-update, where aggressively-update is a
   script something like

	#!/bin/sh
	git reset --keep upstream/master &&
	git submodule foreach aggressively-update &&
	git add -u &&
	make test &&
	git commit -v &&
	git push -f origin master

   - Can this be modified to pick up new submodules?

Thoughts welcome.
Jonathan
