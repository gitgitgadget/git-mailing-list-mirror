From: m.skoric@web.de
Subject: Re: Bad URL passed to RA lay
Date: Wed, 14 Oct 2009 16:02:11 +0200
Organization: http://freemail.web.de/
Message-ID: <1955196477@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 16:05:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My4T9-0000tK-Ph
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 16:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933103AbZJNOCu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 10:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932983AbZJNOCu
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 10:02:50 -0400
Received: from fmmailgate09.web.de ([217.72.192.184]:36457 "EHLO
	fmmailgate09.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932979AbZJNOCt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 10:02:49 -0400
Received: from web.de 
	by fmmailgate09.web.de (Postfix) with SMTP id 8C6A22B338E1;
	Wed, 14 Oct 2009 16:02:11 +0200 (CEST)
Received: from [88.79.247.30] by freemailng2303.web.de with HTTP;
 Wed, 14 Oct 2009 16:02:11 +0200
X-Provags-Id: V01U2FsdGVkX1+8naD4NVrmuPS4AXQsE906KkpdZs9fCHm8qSmgzipuDPnHa
 QhRW4lHTy9KGYJv+mXQfwkDESZVqcY6ghGro7WOMHMDtgc5Z0I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130289>

> -----Urspr=FCngliche Nachricht-----
> Von: "Eric Wong" <normalperson@yhbt.net>
> Gesendet: 14.10.09 09:07:31
> An: m.skoric@web.de
> CC: git@vger.kernel.org
> Betreff: Re: Bad URL passed to RA lay


> m.skoric@web.de wrote:
> > Hi List,
> >=20
> > i have a problem with git-svn clone / fetch. I get following error
> > while doing one of previous command -> "Bad URL passed to RA lay" T=
his
> > happens because a branch doesn't exists in svn anymore and git want=
s
> > to retrieve data from it. Here is the complete error message
> >=20
> > Initializing parent: Abo-Uebernahme (Bug #994)@341
> > Found possible branch point: "quoted"..trunk =3D> "quoted"...Abo-Ue=
bernahme (Bug #994), 203
> > Found branch parent: (Abo-Uebernahme (Bug #994)@341) bb831869748c98=
bf97d105c5894ae65331c95c08
> > Bad URL passed to RA layer: Malformed URL for repository at /usr/bi=
n/git-svn line 4311
> >=20
> > git version 1.6.3.3
> >=20
> > Aynone else has this Problem?
>=20
> Hi,
>=20
> Unlikely, not many people use URIs as weird as yours :)

Ye, i know ;) This is really old stuff and we already changed them to m=
ore sane ones ;)

> The existing test case (t9118) we have was also inspired by you,
> on the same branch, even.
>=20
> > Can anyone help me?
>=20
> What exactly is the "quoted" you refer to?  That's not an actual bran=
ch
> name, is it?

ah brainfart.

This info is essential!

quoted =3D branches/dirk/Abo-Uebernahme... =3D> https...branches/Abo-Ue=
bernahme...


> Can you try it with v1.6.5?  You might need to edit your $GIT_CONFIG,
> but commit 5268f9edc3c86b07a64fcc2679e5ffe39be28d97 was the last
> fix for URI-escaping problems:

This is not a URI Escaping Problem. As i allready mentioned: I think it=
s a svn
problem and git can't handle that.

svn History:

r203 svn copy /trunk/ /branches/dirk/Abo..
r204 svn mv /branches/dirk/Abo..   /branches/Abo..
r341 svn mv /branches/Abo.. /branches/0944-Abo..

r203 branch was created from trunk.
r204 branch was moved from /branches/dirk/ to /branches
r341 branch was renamed to 0944-Abo

This is what git does.

>Initializing parent: refs/remote/Abo-Uebernahme (Bug #994)@341
>Found possible branch point: branches/Abo =3D> branches/dirk/Abo-Ueber=
nahme (Bug #994), 203
>Found branch parent: (Abo-Uebernahme (Bug #994)@341) bb831869748c98bf9=
7d105c5894ae65331c95c08
>Bad URL passed to RA layer: Malformed URL for repository at /usr/bin/g=
it-svn line 4311

I think the problem is that git doesn't like this kinda action.
branch -> do something with branch -> rename branch.

After some debugging i found something in git-svn

sub find_parent_branch
{
=2E..
	} elseif ($self->ra->trees_match($new_url, $r0, $self->full_url, $rev)=
)
	....
}

the trees_match sub doesn't do any error handling. if $self->full_url d=
oesn't
exits anymore this will fail, right?=20

I don't know if the followong piece of code in find_parent_branch works=
 like
you expect it!?

>unless (defined $paths) {
>	my $err_handler =3D $SVN::Error::handler;
>        $SVN::Error::handler =3D \&Git::SVN::Ra::skip_unknown_revs;
>        $self->ra->get_log([$self->{path}], $rev, $rev, 0, 1, 1,
>                                 sub { $paths =3D $_[0] });
>        $SVN::Error::handler =3D $err_handler;
>}
>return undef unless defined $paths;

Maybe its just a problem with renaming branches or something!?
My Perl knowledge is really limited, so its up to you my friend ;)

Majk

______________________________________________________
GRATIS f=FCr alle WEB.DE-Nutzer: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://movieflat.web.de
