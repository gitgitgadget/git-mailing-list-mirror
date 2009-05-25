From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: partial checkouts
Date: Mon, 25 May 2009 10:51:31 -0400
Message-ID: <20090525145131.GG6295@yugib.highrise.ca>
References: <1D6034426110564DA0DEA9EE9793B38357BE874673@NBE-MBX01.americas.swk.pri> <20090525141200.GF6295@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Chani <chanika@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 17:00:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8bfU-0006Ys-RF
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 17:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbZEYPAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 11:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbZEYPAi
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 11:00:38 -0400
Received: from oak.highrise.ca ([70.38.99.169]:60198 "EHLO oak.highrise.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbZEYPAi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 11:00:38 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2009 11:00:38 EDT
Received: from localhost (localhost [127.0.0.1])
	by oak.highrise.ca (Postfix) with ESMTP id 54819AC428;
	Mon, 25 May 2009 10:51:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <32541b130905241245m7139c766v73f6fe2aeda1fcf9@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119936>

If all you're looking for is a "single set of read-only docs" conglomer=
ation of
all the KDE submodules projects documentation so you can translate them=
, what
about using "archive"?  Since archive takes a "tree-ish", and work on r=
emote
upload-pack servers (if it's enabled), you can get an un-versioned "rem=
ote
partial checkout" with something like do things like:
	git archive --format=3Dtar --prefix=3Dgit/Documentation/ --remote=3Dgi=
t://repo.or.cz/git.git HEAD:Documentation | tar tf - | head
	git archive --format=3Dtar --prefix=3D/opt/git/share/man/ --remote=3Dg=
it://repo.or.cz/git.git man | tar tf -



So, this could be simply scripted to give you a repo with *all* modules=
 docs/ inside a single repo...
	for m in $MODULES
	do
		git archive --format=3Dtar --prefix=3D"$m/$DOCDIR/" --remote=3D$REMOT=
E_BASE/$m $BRANCH:$DOCDIR | tar xf -
		git add $m/$DOCDIR
		git commit $m/$DOCDIR -m "$m: Automatic import"
	done

Do that in a central location an dlet translators pull that...  Everyth=
ings
"duplicated", but git's object store will help out there...  You loose =
the
history of the original docs, but for translations, you you're not tran=
slating
the history anyways, your'e translation the docs at a point in time...

Or just dump all thd docs in a .gitignore'd subdirctory and have transl=
ators
run a script to update them.

a.


> On Sat, May 23, 2009 at 8:26 PM, Chani <chanika@gmail.com> wrote:
> > On May 23, 2009 16:34:53 Johan Herland wrote:
> >> On Saturday 23 May 2009, Chani wrote:
> >> > I'm kinda wondering if there'd be a way to use git-filter-branch=
 to make
> >> > a repo that only tracks the doc/ folder for a module - but I've =
no idea
> >> > whether it'd have to be recreated from scratch every time someon=
e changes
> >> > something in the real repo's doc/
> >> >
> >> > can anyone think of a less ugly solution?
> >> > what are the chances of git supporting this kind of partial chec=
kout
> >> > someday?
=20
> Here's something that might work. =A0Write a script that runs on a
> server somewhere. =A0It checks out all of the git-managed KDE
> components, including documentation (it's okay to do this from one
> place, right?). =A0Then it loops through all the documentation
> subdirectories and splits them out into individual projects/branches
> with 'git subtree split'.
>=20
> You could then make a new project, kde-docs for example, that pulls
> those new doc projects back together into a single project, using 'gi=
t
> subtree merge'.
>=20
> People could then checkout the single kde-docs project and get all
> the docs, then make changes and push them back upstream to you. =A0As
> far as the average person is concerned, this is probably even easier
> than svn:externals - they don't have to remember to commit in each
> subdirectory separately, as git-subtree rips it all apart later. =A0A=
lso
> note that *end users* never have to operate the git subtree command;
> all that happens behind the scenes on your server.
>=20
> Later, you use 'git subtree split' to rip it apart back into the
> individual projects, and 'git subtree merge' those back into their
> original git repositories.
>=20
> Since git-subtree is my own little toy and it's designed for exactly
> this kind of workflow, I'd be happy to help you debug a script for
> this if you like. =A0Probably I'll learn something.
>=20
> Disclaimer: git-subtree hasn't been used by too many people yet and w=
e
> may end up finding some bugs.
>=20
> Have fun,
>=20
> Avery
>=20
