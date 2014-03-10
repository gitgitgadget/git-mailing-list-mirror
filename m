From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Mon, 10 Mar 2014 21:32:47 +0100
Message-ID: <20140310203245.GB5345@sandbox-ub>
References: <5314BFA5.2030807@web.de>
 <1393878866.7891.22.camel@Naugrim>
 <53176951.7000201@web.de>
 <1394069128.7891.29.camel@Naugrim>
 <5318D101.9050305@web.de>
 <1394136925.7891.31.camel@Naugrim>
 <5318DFDD.4060006@web.de>
 <1394144428.7891.33.camel@Naugrim>
 <531A4FA3.3040007@web.de>
 <1394442486.7891.45.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 21:33:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6sf-00027Q-UT
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 21:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbaCJUc5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2014 16:32:57 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.95]:48644 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbaCJUc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 16:32:56 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WN6sS-0000u0-Rr; Mon, 10 Mar 2014 21:32:49 +0100
Content-Disposition: inline
In-Reply-To: <1394442486.7891.45.camel@Naugrim>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243812>

On Mon, Mar 10, 2014 at 10:08:06AM +0100, Henri GEIST wrote:
> Le samedi 08 mars 2014 =E0 00:00 +0100, Jens Lehmann a =E9crit :
> > Am 06.03.2014 23:20, schrieb Henri GEIST:
> > >> What is the use case you are trying to solve and why can that
> > >> not be handled by adding "subsubmodule" inside "submodule"?
> > >=20
> > > The problem is access rights.
> > >=20
> > > Imagine you have 2 people Pierre and Paul.
> > > Each with different access write on the server.
> > > Pierre has full access on every things.
> > > Paul has full access on superproject and subsubmodule but no read=
/write
> > > access to submodule only execution on the directory.
> >=20
> > Ok, I think I'm slowly beginning to understand your setup.
> >=20
> > > I want all user to get every things they are allowed to have with=
 the
> > > command 'git submodule update --init --recursive'.
> > > Then as Paul can not clone submodule he can not get subsubmodule
> > > recursively through it.
> >=20
> > Sure, that's how it should work. Paul could only work on a branch
> > where "submodule" is an empty directory containing "subsubmodule",
> > as he doesn't have the rights to clone "submodule".
>=20
> I will not redundantly create a branch for each user on the server.
> When users clone the server it already create a special branch for th=
em
> 'master' which track 'origin/master'. And if each user have its own b=
ranch
> on the server it will completely defeat the goal of the server "colla=
boration".
> And transform the git server in simple rsync server.

I do not think that is what Jens was suggesting. It does not matter in
which branch they work, they can directly use master if you like. What
he was suggesting is that they create their repository structure like
this:

git clone git@somewhere.net:superproject.git
cd superproject/submodule
git clone git@somehwere.net:subsubmodule.git
cd subsubmodule
=2E.. work, commit, work, commit ...

The same applies for the superproject. Now only someone with access to
the submodule has to update the registered sha1 once the work is pushed
to submodule.

> > > And I need superproject to add also submodule/subsubmodule.
> >=20
> > No. Never let the same file/directory be tracked by two git
> > repositories at the same time. Give Paul a branch to work on
> > where "submodule" is just an empty directory, and everything
> > will be fine. Or move "subsubmodule" outside of "submodule"
> > (and let a symbolic link point to the new location if the
> > path cannot be easily changed). Would that work for you?
>=20
> If I use symbolic links it will just as gitlink enable to use the
> same subsubmodule clone by more than one superproject but with two
> major problems :
>   - symbolic links do not work under Windows and some of my users do
>     not even know something else could exist.
>   - symbolic links will not store the SHA-1 of the subsubmodule.
>     And a 'git status' in the repository containing the symbolic link
>     will say nothing about subsubmodule state.

Here you are also missing something. What Jens was suggesting was that
you move your subsubmodule directly underneath the superproject and fro=
m
the old location you create a link to the new location for a quick
transition. But you can also change all paths in your project to point
to the new location. But in the new location you will have subsubmodule
registered as a submodule only that it is now directly linked (as
submodule) from the superproject instead of the submodule.

> I think where we diverge is in the way we are looking gitlinks.
> Where you see a hierarchic tree, I see a web.
> And I use gitlinks just like multiplatform symbolic links storing
> the SHA-1 of there destination and pointing exclusively on git reposi=
tories.

Well but the problem with a web is that it will introduce a lot of
problems that need to be solved. Some repository has to have the
authority about a file (or link). If you have a file in multiple
repositories overlayed how do you know who is in charge and when?

There is a reason why it is designed like this: simplicity. I currently
do not see how your web idea can be simple without introducing a lot of
user interface questions.

Cheers Heiko
