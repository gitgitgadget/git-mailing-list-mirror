From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] bash: add helper function to get config variables
	for completion
Date: Thu, 21 Oct 2010 00:29:50 +0200
Message-ID: <20101020222949.GA1767@neumann>
References: <20101014085538.GB838@neumann>
	<1287046727-22509-1-git-send-email-szeder@ira.uka.de>
	<20101014171507.GA17550@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 00:30:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8hAV-00049u-Fz
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 00:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab0JTW3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 18:29:54 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:51493 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab0JTW3y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 18:29:54 -0400
Received: from localhost6.localdomain6 (p5B130998.dip0.t-ipconnect.de [91.19.9.152])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LviIO-1OadW70OuC-017mvG; Thu, 21 Oct 2010 00:29:51 +0200
Content-Disposition: inline
In-Reply-To: <20101014171507.GA17550@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:AXfsVHUW4JwtRBMYYi/Rju70yKIKaKdRwKk2lzqzA1l
 6rIlzHfJV+jrHWBd6sxbDZRUdhKnL9tweaSnbMbMQinLRvi9+R
 M80h1by5xOKE/oz07X5aXb2FIPJgtVMB2Z/4yYp3QcmHibeZ8C
 LFh4iQtEtpQYE8wEK0Wj6S4mZPChsbQjUB8A13PM5xs4UvvIIV
 vCqOdMP+0nEowVzyi87Mg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159446>

Hi Jonathan,


On Thu, Oct 14, 2010 at 12:15:07PM -0500, Jonathan Nieder wrote:
> SZEDER G=E1bor wrote:
>=20
> > Currently there are three completion functions that perform similar
> > queries to 'git config' to get config variable names.
>=20
> Good point.
>=20
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -451,10 +451,7 @@ __git_remotes ()
> >  		echo ${i#$d/remotes/}
> >  	done
> >  	[ "$ngoff" ] && shopt -u nullglob
> > -	for i in $(git --git-dir=3D"$d" config --get-regexp 'remote\..*\.=
url' 2>/dev/null); do
> > -		i=3D"${i#remote.}"
> > -		echo "${i/.url*/}"
> > -	done
> > +	__git_get_config_variables "remote" "url"
> >  }
>=20
> Ok, so __git_get_config_variables $category $var means something like
>=20
> 	git config --get-regexp '$category[.].*[.]$var' |
> 	cut -d. -f2

Almost.  Considering the current invocations of
__git_get_config_variables() introduced in this patch, yes, they do
the same.  But "cut -d. -f2" will behave differently when $category
contains a dot, or when neither $category nor $var contain a dot, but
the config variable contains more than two (does git have any such
config variables?).

> > @@ -750,14 +747,16 @@ __git_compute_porcelain_commands ()
> >  	: ${__git_porcelain_commands:=3D$(__git_list_porcelain_commands)}
> >  }
> > =20
> > -__git_aliases ()
> > +# returns all config variables within a given section with an opti=
onal
> > +# suffix, with both the section name and the suffix removed
> > +__git_get_config_variables ()
> >  {
> > -	local i IFS=3D$'\n'
> > -	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "ali=
as\..*" 2>/dev/null); do
> > +	local section=3D"$1" suffix=3D"${2-}" i IFS=3D$'\n'
> > +	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "$se=
ction\..*${suffix:+\.$suffix}" 2>/dev/null); do
>=20
> Would it be possible to shorten this line?  e.g.
>=20
> 	for i in $(
> 		git --git-dir=3D"$(__gitdir)" ...
> 	); do
>=20
> or
>=20
> 	while read -r setting
> 	do
> 		...
> 	done < <(
> 		git --git-dir=3D"$(__gitdir)" ...
> 	)
>=20
> or
>=20
> 	local ... IFS=3D$'\n'
> 	set -- $(git ... )
> 	for i do
> 		...
> 	done

Well, yes, of course.  But the original line was already too long, and
neither of your proposals in itself would make it short enough to fit
80 characters.  Besides, the latter two changes the loop itself, not
just what the body of the loop does and what it is looping on.

Maybe we could just split the line in two in the middle, like=20

	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp \
		$section\..*${suffix:+\.$suffix}" 2>/dev/null); do

Still doesn't look pretty, but maybe a bit better.


Best,
G=E1bor
