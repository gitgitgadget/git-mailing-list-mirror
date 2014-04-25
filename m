From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [PATCH] Revert "Stop starting pager recursively"
Date: Fri, 25 Apr 2014 16:10:49 -0400
Message-ID: <20140425201048.GB29904@logfs.org>
References: <20140421204622.GA9532@logfs.org>
 <20140425182928.GA29904@logfs.org>
 <vpqoazpdz1r.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 25 22:12:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdmTW-0008Dz-Le
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 22:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbaDYULq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Apr 2014 16:11:46 -0400
Received: from longford.logfs.org ([213.229.74.203]:43215 "EHLO
	longford.logfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbaDYULn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 16:11:43 -0400
Received: from joern by longford.logfs.org with local (Exim 4.72)
	(envelope-from <joern@logfs.org>)
	id 1WdmSP-00084b-7j; Fri, 25 Apr 2014 16:10:49 -0400
Content-Disposition: inline
In-Reply-To: <vpqoazpdz1r.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247111>

On Fri, 25 April 2014 20:49:52 +0200, Matthieu Moy wrote:
> J=C3=B6rn Engel <joern@logfs.org> writes:
> > On Mon, 21 April 2014 16:46:22 -0400, J=C3=B6rn Engel wrote:
> >>=20
> >> This reverts commit 88e8f908f2b0c56f9ccf8134d8ff9f689af9cc84.
> >>=20
> >> Caused a usability regression for me and foul language for my cowo=
rkers.
> >
> > Ping.
>=20
> How do you solve the problem that the commit you revert was solving? =
The
> commit you propose to revert says in its message:
>=20
>     git-column can be used as a pager for other git commands, somethi=
ng
>     like this:
>    =20
>         GIT_PAGER=3D"git -p column --mode=3D'dense color'" git -p bra=
nch
>    =20
>     The problem with this is that "git -p column" also has $GIT_PAGER=
 set so
>     the pager runs itself again as another pager. The end result is a=
n
>     infinite loop of forking.
>=20
> There's probably a solution, but you can't ignore the problem (or
> someone else will later try to solve the infinite loop and revert you=
r
> commit, and so on ...).

Disclaimer: I never looked at git internals before this regression
forced me to and am likely talking out of my arse.

One approach is "don't do that then".  Someone explicitly changed the
git pager to be git, which itself takes the git pager, etc.  That is
asking for infinite recursion and the original problem was that git
gave the user exactly what they asked for.

A second option is to add a --pager (or rather --no-pager) option to
the command line and allow the user to specify
    GIT_PAGER=3D"git --no-pager -p column --mode=3D'dense color'" git -=
p branch

A third option is to try to be smart and give the user what he wants,
not what he asked for.  If the pager happens to be git, unset
$GIT_PAGER, $PAGER and somehow disable core.pager.  Yeah, that will
turn nasty rather quickly.

A fourth option is to set an environment variable for the pager
process itself.  Disable paging similar to the original patch, but
make it conditional on we_are_the_pager(), not pager_in_use().

My preference is option four, but see disclaimer above.

J=C3=B6rn

--
I've never met a human being who would want to read 17,000 pages of
documentation, and if there was, I'd kill him to get him out of the
gene pool.
-- Joseph Costello
