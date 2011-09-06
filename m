From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] Make use of git status when autocompleting git add,
	rm, checkout --, and reset HEAD
Date: Tue, 6 Sep 2011 19:43:24 +0200
Message-ID: <20110906174324.GA8211@goldbirke>
References: <1314740583-14567-1-git-send-email-panduwana@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Ron Panduwana <panduwana@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 19:43:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0zgS-000357-AQ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 19:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab1IFRnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Sep 2011 13:43:35 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:65206 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab1IFRnd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 13:43:33 -0400
Received: from localhost6.localdomain6 (p5B130C1C.dip0.t-ipconnect.de [91.19.12.28])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0La0Mr-1RSvtg0c0L-00lZ5l; Tue, 06 Sep 2011 19:43:25 +0200
Content-Disposition: inline
In-Reply-To: <1314740583-14567-1-git-send-email-panduwana@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:d4Blmx2rHzYOiyFN01sMFsmUMHtrMAC2iuLSpDC6u14
 iRxwyxl2nHGjDo0ZX2Rogef/ZJIKmrNNbcDJNWELV9mIQx8T8Y
 qWUEZp1YKXHQYnSKQHyC7uA29me75FIILtlC+WhZgCoHHG8DVL
 XET4MTPFvYoFWhxb/X4tf/YtniXCFn89hjuUkV5e/90JFi5XPj
 IIDre6iV/xAFT3RirX8RlNr1Vrov4fggGCFfs0FjyiY1lXwkyb
 BYhpw4VBhiVULmITgkd0RRXoVBgHAQzB4FidH7o4EukzifiJfh
 1Fk8IcJGI3W3EEDOr+EPeBscErvKxIIYlX1oWEul7XuJK7tP/3
 YjnNdDvLOn2M/Tb4Ob4k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180818>

Hi,


On Wed, Aug 31, 2011 at 04:43:03AM +0700, Ron Panduwana wrote:
> Signed-off-by: Ron Panduwana <panduwana@gmail.com>

I agree with Junio that some explanation would be necessary here.

I'm not sure this change is in general a good idea.  I can imagine
that it would be useful for e.g. java projects, where you are forced
to have deep directory structures, but it will surely cause surprises
and confusion for users who trained their fingers to quickly enter
long paths with a few keystrokes and completion.  Furthermore, it
seems to cause considerable performance penalty, because it will fork
three processes and a subshell to connect them with a pipe for such a
"simple" thing as file name completion.  And one of those processes is
git status, which alone can take a while, especially for large
repositories, and as a side effect it refreshes the index (but that is
probably harmless).

> ---
>=20
> On Fri, Aug 19, 2011 at 5:10 PM, Thomas Rast <trast@student.ethz.ch> =
wrote:
> > Some thoughts:
> >
> > * running git-status for . has some issues: it doesn't work in the
> > =C2=A0case of
> >
> > =C2=A0 =C2=A0cd subdir
> > =C2=A0 =C2=A0git add ../some/file[TAB]
> >
> > =C2=A0It's also inefficient if you are at the top level and
> >
> > =C2=A0 =C2=A0git add path/to/file/a/few/levels/down[TAB]
> >
> > =C2=A0since it wouldn't actually have to look for untracked files i=
n the
> > =C2=A0entire repo.
>=20
> Fixed by running git-status for $cur if $cur is a directory. Otherwis=
e run on .

That won't do.  Imaginge you want to add ../some/file, and therefore
you do 'git add ../so<TAB>'.  In this case $cur will hold '../so',
which is not a directory (or at least not the directory you are
looking for).

> > * -uall is not required unless you are looking for untracked files.
> > =C2=A0 For the other commands you could speed up completion by pass=
ing
> > =C2=A0 -uno instead.
>=20
> Fixed by adding second parameter to __git_files_having_status
>=20
>=20
>  contrib/completion/git-completion.bash |   84 ++++++++++++++++++++--=
---------
>  1 files changed, 54 insertions(+), 30 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 8648a36..9d44501 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1010,6 +1010,16 @@ __git_has_doubledash ()
>  	return 1
>  }
>=20
> +# __git_files_having_status requires 2 arguments
> +__git_files_having_status ()
> +{
> +    local dir=3D"."
> +    if [ -d "$cur" ]; then
> +        dir=3D"$cur"
> +    fi

Please use tabs for indentation.

> +	echo "$(git status $2 -s "$dir" 2>/dev/null | egrep "^$1" | cut -c4=
-)"

Echoing a command substitution is unnecessary.

> +}
> +
>  __git_whitespacelist=3D"nowarn warn error error-all fix"
>=20
>  _git_am ()
> @@ -1058,17 +1068,17 @@ _git_apply ()
>=20
>  _git_add ()
>  {
> -	__git_has_doubledash && return
> -
> -	case "$cur" in
> -	--*)
> -		__gitcomp "
> -			--interactive --refresh --patch --update --dry-run
> -			--ignore-errors --intent-to-add
> -			"
> -		return
> -	esac
> -	COMPREPLY=3D()
> +	if ! __git_has_doubledash; then
> +		case "$cur" in
> +		--*)
> +			__gitcomp "
> +				--interactive --refresh --patch --update --dry-run
> +				--ignore-errors --intent-to-add
> +				"
> +			return
> +		esac
> +	fi
> +	__gitcomp "$(__git_files_having_status "(.[MAU]|UD|\?\?)" -uall)"

Please do this and the others the other way around, as you did in
_git_checkout(), i.e.

	if __git_has_doubledash ; then
		__gitcomp "$(__git_files_having_status ...)"
		return
	fi

	case "$cur" in
	[...]

This will make the patch shorter and easier to review, it won't
increase the indentation unnecesarily, and it will be friendlier to
the users running 'git blame' in the future.

>  }
>=20
>  _git_archive ()
> @@ -1171,7 +1181,12 @@ _git_bundle ()
>=20
>  _git_checkout ()
>  {
> -	__git_has_doubledash && return
> +	if __git_has_doubledash; then
> +		if [[ ${words[2]} =3D "--" ]]; then
> +			__gitcomp "$(__git_files_having_status ".[MD]" -uno)"
> +		fi
> +		return
> +	fi
>=20
>  	case "$cur" in
>  	--conflict=3D*)
> @@ -1469,7 +1484,7 @@ _git_help ()
>  	__gitcomp "$__git_all_commands $(__git_aliases)
>  		attributes cli core-tutorial cvs-migration
>  		diffcore gitk glossary hooks ignore modules
> -		namespaces repository-layout tutorial tutorial-2
> +		repository-layout tutorial tutorial-2

That's an independent change; I don't think you want to remove
namespaces here.

>  		workflows
>  		"
>  }
> @@ -2313,14 +2328,18 @@ _git_replace ()
>=20
>  _git_reset ()
>  {
> -	__git_has_doubledash && return
> -
> -	case "$cur" in
> -	--*)
> -		__gitcomp "--merge --mixed --hard --soft --patch"
> +	if ! __git_has_doubledash; then
> +		case "$cur" in
> +		--*)
> +			__gitcomp "--merge --mixed --hard --soft --patch"
> +			return
> +			;;
> +		esac
> +	fi
> +	if [[ ${words[2]} =3D "HEAD" ]]; then
> +		__gitcomp "$(__git_files_having_status "[ADM]." -uno)"
>  		return
> -		;;
> -	esac
> +	fi
>  	__gitcomp "$(__git_refs)"
>  }
>=20
> @@ -2337,15 +2356,20 @@ _git_revert ()
>=20
>  _git_rm ()
>  {
> -	__git_has_doubledash && return
> -
> -	case "$cur" in
> -	--*)
> -		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
> -		return
> -		;;
> -	esac
> -	COMPREPLY=3D()
> +	if ! __git_has_doubledash; then
> +		case "$cur" in
> +		--*)
> +			__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
> +			return
> +			;;
> +		esac
> +	fi
> +	# check if --cached was specified
> +	if [ "$(__git_find_on_cmdline "--cached")" ]; then
> +		COMPREPLY=3D()
> +	else
> +		__gitcomp "$(__git_files_having_status "(.D|DU|UA)" -uno)"

'git rm' can be used to delete any tracked files, but this limits
completion to only those files that are already deleted from the work
tree or are unmerged.

> +	fi
>  }
>=20
>  _git_shortlog ()
> @@ -2640,7 +2664,6 @@ _git ()
>  			--exec-path
>  			--html-path
>  			--work-tree=3D
> -			--namespace=3D

Independent change.

>  			--help
>  			"
>  			;;
> @@ -2737,3 +2760,4 @@ else
>  		shopt "$@"
>  	}
>  fi
> +

Superfluous new line.



Best,
G=E1bor
