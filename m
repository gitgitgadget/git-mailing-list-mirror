From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/3] git-svn-externals PoC (in a sh script)
Date: Fri, 29 Aug 2008 02:29:27 -0700
Message-ID: <20080829092927.GA7500@yp-box.dyndns.org>
References: <60381eeb0808281702q3dc7543enff2b35ebbcc80d08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Eddy =?utf-8?B?UGV0cmnImW9y?= <eddy.petrisor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 11:30:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ0JN-0002ND-SP
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 11:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbYH2J33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 05:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbYH2J33
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 05:29:29 -0400
Received: from hand.yhbt.net ([66.150.188.102]:58950 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956AbYH2J32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 05:29:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BB07E2DC01B;
	Fri, 29 Aug 2008 02:29:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <60381eeb0808281702q3dc7543enff2b35ebbcc80d08@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Eddy Petrișor <eddy.petrisor@gmail.com> wrote:
> Hello,

Hi Eddy,

> I have started a while back working on support for svn:externals
> support for git-svn, but since I'm not that satisfied with the current
> status of the patch, I haven't modified git-svn itself and just left
> the sh script I made as a PoC as it was.
> 
> There's still work to be done to it, but I the current version is
> functional enough to be probably found useful by more people than
> myself.

Cool.

I definitely like the separate script approach.  Not sure if you read my
posts, your PoC seems inline with my thoughts on handling externals be
seen here:

http://article.gmane.org/gmane.comp.version-control.git/91283
http://article.gmane.org/gmane.comp.version-control.git/91293

> Current status follows:
> 
>     Current functionality:
>      - fetches all the externals of an already svn-fetched repo
>      - support for svn:externals refresh
>      - if the location of the external has changed, the current working
>        copy will be placed aside and a new directory will be created
>        instead
>      - if the remote URI is the same (maybe a verison bump, there will
>        be a 'git svn rebase'
>      - remove support (useful for testing purposes or clean restarts)
>      - avoid zombie externals at all costs - in some repos empty
>        svn:externals might exist; svn ignores such externals, so git should
>        do the same
> 
>     TODO:
>      - take into account the revision of an external, if it exists
>      - do not do deep svn cloning, to avoid legthy operations, just pull HEAD
>        (this actually needs changes in git-svn itself)

git svn clone -r<latest_revision_number> URL should work if you extract
the revision number easily.  Specifying "-rHEAD" will only work if the
branch of the external you're tracking was the last modified revision in
the repository, so it's not very useful.  "svn log" seems to have the
same semantics as git-svn as far as -rHEAD being useful or not...

>      - use/create shallow copies to git svn repos (one revision should be enough
>        for most externals)
>      - use submodules for externals

I'm not sure if mapping submodules to externals is a good idea
because externals don't require exact revisions and submodules do.
There's also an issue I was just made aware of two days ago with
submodules and git-svn that I haven't had time to work on.

Another user also privately reported a bug to me about git-svn having
trouble dcommitting when using submodules.  I've attached the test case
here in case you have any thoughts on how to handle this (I think the
easiest would be to ignore submodules on dcommit entirely).

> Any comments are welcome.

Also some small portability issues: "grep -q" is definitely unportable
in my experience.  There are probably some more that I am missing my eye
at this time of night...

-- 
Eric Wong

--7AUc2qLy4jB3hD7Z
Content-Type: application/x-sh
Content-Disposition: attachment; filename="t9126-git-svn-submodule.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A# Copyright (c) 2008 Eric Wong=0A=0Atest_description=3D'git-svn=
 submodule'=0A=0A. ./lib-git-svn.sh=0A=0Atest_expect_success 'setup repo' '=
svn co "$svnrepo" svnfoo'=0A=0Atest_expect_success 'add files to svn repo' =
'=0A	touch svnfoo/foo.txt=0A	(cd svnfoo && svn add * && svn commit -m "test=
 commit")=0A	'=0A=0Atest_expect_success 'git-svn clone the svn repo' '=0A	g=
it-svn clone "$svnrepo" gitfoo=0A	'=0A=0Atest_expect_success 'create a git =
repo to include as a submodule' '=0A	mkdir git_to_include=0A	(=0A		cd git_t=
o_include &&=0A		git init && =0A		echo "This is another file" > another.txt=
 &&=0A		git add another.txt &&=0A		git commit -a -m "Adding file to submodu=
le" &&=0A		git log=0A	)=0A	'=0A=0Atest_expect_success 'add the submodule' '=
=0A	(=0A		cd gitfoo &&=0A		git submodule add "$remove_trash"/git_to_include=
 \=0A		  git_as_submodule &&=0A		git commit -a -m "Adding submodule"=0A	)=
=0A	'=0A=0Atest_expect_success 'try to rebase and commit' '=0A	( cd gitfoo =
&& git svn rebase && git svn dcommit )=0A	'=0A=0Atest_done=0A
--7AUc2qLy4jB3hD7Z--
