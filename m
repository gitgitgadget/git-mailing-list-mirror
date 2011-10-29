From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCHv2 3/3] completion: match ctags symbol names in grep
	patterns
Date: Sat, 29 Oct 2011 14:47:55 +0200
Message-ID: <20111029124755.GE2345@goldbirke>
References: <20111021172239.GA22289@sigill.intra.peff.net>
	<20111021173021.GC24417@sigill.intra.peff.net>
	<20111023212928.GG22551@goldbirke>
	<20111028060517.GA3993@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 29 14:48:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RK8L2-0004lO-TY
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 14:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565Ab1J2MsF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Oct 2011 08:48:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:60528 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225Ab1J2MsD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2011 08:48:03 -0400
Received: from localhost6.localdomain6 (p5B13001C.dip0.t-ipconnect.de [91.19.0.28])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0M1XmT-1QzrNt0zij-00tVR1; Sat, 29 Oct 2011 14:47:56 +0200
Content-Disposition: inline
In-Reply-To: <20111028060517.GA3993@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:UUGZEweb6x4GgCqIywqsTmo4TQAAbY4GICSb2X9Qnjh
 rlTI1/9t2hAitA0AOR4mzb/BflOhLa7MZk5rruDRiBXsn3rPdm
 9fTsk9uqPsIj/ZiNpLGSFl1g3Cw/p785uf16+6bCYbzwT/BSxw
 KnwXYAGiPWmJ88wuXolO8vOG6tBvvw+a8xadalWe1xe4SRvnMd
 ELc1wFh36xofXsV6IfvUL+7Q/drUDV77/D1UDYV2bTsjPho6zJ
 zMlRXHLoDxxUat+GpksPhKwQnD6ukCE4JmQjaCA7DLdWtMEn/P
 sK0ESX9qaojWSaiQ7Xeu3ynx3W49/D2j2wCmaNts3SUH+ia/tu
 8tfA7089l8ZyZRJHYuSU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184453>

Hi,


On Thu, Oct 27, 2011 at 11:05:20PM -0700, Jeff King wrote:
> On Sun, Oct 23, 2011 at 11:29:28PM +0200, SZEDER G=E1bor wrote:
>=20
> > On Fri, Oct 21, 2011 at 01:30:21PM -0400, Jeff King wrote:
> > > This incorporates the suggestions from G=E1bor's review, with one
> > > exception: it still looks only in the current directory for the "=
tags"
> > > files. I think that might have some performance implications, so =
I'd
> > > rather add it separately, if at all.
> >=20
> > I agree that scanning through a whole working tree for tags files
> > would cost too much.  But I think that a tags file at the top of th=
e
> > working tree is common enough to be supported, and checking its
> > existence is fairly cheap.
>=20
> Actually, it's not too expensive. Asking git for the top of the worki=
ng
> tree means it has to traverse up to there anyway. So the trick is jus=
t
> doing our search without invoking too many external tools which would
> cause unnecessary forks.
>=20
> The patch is below, but I'm still not sure it's a good idea.
>=20
> Grep only looks in the current subdirectory for matches.

Unless the user explicitly specifies the path(s)...  But that comes at
the end of the command line, so the completion script could have no
idea about it at the time of 'git grep <TAB>'.

> > So how about something like this for the case arm? (I didn't actual=
ly
> > tested it.)
> >=20
> > 		local tagsfile
> > 		if test -r tags; then
> > 			tagsfile=3Dtags
> > 		else
> > 			local dir=3D"$(__gitdir)"
>=20
> You don't want __gitdir here, but rather "git rev-parse --show-cdup".

Oh, yes, indeed.

But there was a point in using __gitdir() here: it respects the
--git-dir=3D option.  Which brings up the question: what
should 'git --git-dir=3D/some/where/.git grep <TAB>' offer?

So in the end I agree that it's not a good idea.

> > Btw, there is a bug in the case statement: 'git --no-pager grep <TA=
B>'
> > offers refs instead of symbols, because $cword is not 2 and $prev
> > doesn't start with a dash.  But it's not worse than the current
> > behavior, so I don't think this bug is a show-stopper for the patch=
=2E
>=20
> Yeah. The intent of the "$cword is 2" thing is to know that we are th=
e
> first non-option argument. Arguably, _get_comp_words_by_ref should
> somehow tell us which position we are completing relative to the actu=
al
> command name.

_get_comp_words_by_ref() is a general completion function, the purpose
of which is to provide a bash-version-independent equivalent of
$COMP_WORDS and $COMP_CWORD by working around the different word
splitting rules.  It doesn't know about git and its commands at all.

But there is the while loop in _git() that looks for the git command
(among other things) on the command line, which could store the index
of the command name in $words in a variable.  This variable could then
be used in that case statement (and probably in a couple of other
places, too).


Best,
G=E1bor


> ---
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index af283cb..b0ed657 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1429,6 +1429,39 @@ _git_gitk ()
>  	_gitk
>  }
> =20
> +__git_cdup_dirs() {
> +	local prefix=3D$(git rev-parse --show-cdup 2>/dev/null)
> +	local oldifs=3D$IFS
> +	local dots
> +	local i
> +	IFS=3D/
> +	for i in $prefix; do
> +		dots=3D$dots../
> +		echo "$dots"
> +	done
> +	IFS=3D$oldifs
> +}

No need for $oldifs here; do a local IFS=3D/ instead, and then it just
goes out of scope when returning from the function.

> +
> +__git_find_in_cdup_one() {
> +	local dir=3D$1; shift
> +	for i in "$@"; do
> +		if test -r "$dir$i"; then
> +			echo "$dir$i"
> +			return 0
> +		fi
> +	done
> +	return 1
> +}
> +
> +__git_find_in_cdup() {
> +	__git_find_in_cdup_one "" "$@" && return
> +
> +	local dir
> +	for dir in $(__git_cdup_dirs); do
> +		__git_find_in_cdup_one "$dir" "$@" && return
> +	done
> +}
> +
>  __git_match_ctag() {
>  	awk "/^${1////\\/}/ { print \$1 }" "$2"
>  }
> @@ -1457,8 +1490,9 @@ _git_grep ()
> =20
>  	case "$cword,$prev" in
>  	2,*|*,-*)
> -		if test -r tags; then
> -			__gitcomp "$(__git_match_ctag "$cur" tags)"
> +		local tags=3D$(__git_find_in_cdup tags)
> +		if test -n "$tags"; then
> +			__gitcomp "$(__git_match_ctag "$cur" "$tags")"
>  			return
>  		fi
>  		;;
