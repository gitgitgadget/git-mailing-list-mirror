From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH 2/1] bash: eliminate dependency on bash_completion lib
Date: Tue, 7 Dec 2010 17:07:48 +0100
Message-ID: <20101207160747.GD1867@neumann>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
	<20101202091624.GB1771@burratino>
	<20101202091613.6ac8f816@MonteCarlo.grandprix.int>
	<20101202210207.GA4994@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 17:23:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ0Jt-0005vK-Gj
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 17:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593Ab0LGQXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 11:23:08 -0500
Received: from judith.fzi.de ([141.21.4.44]:42377 "EHLO judith.fzi.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab0LGQXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 11:23:07 -0500
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2010 11:23:06 EST
Received: from exchange.fzi.de ([141.21.7.5]) by judith.fzi.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 7 Dec 2010 17:07:48 +0100
Received: from localhost6.localdomain6 ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 7 Dec 2010 17:07:48 +0100
Content-Disposition: inline
In-Reply-To: <20101202210207.GA4994@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 07 Dec 2010 16:07:48.0246 (UTC) FILETIME=[E4402B60:01CB9628]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163083>

Hi Jonathan,

What is this patch based on?


Thanks,
G=E1bor


On Thu, Dec 02, 2010 at 03:02:07PM -0600, Jonathan Nieder wrote:
> Add a minimal implementation of _get_comp_words_by_ref,
> the routine used to work around bash 4.0's COMP_WORDS semantics.
>=20
> Based on bash-completion 2.x (commit bf763033, 2010-10-26) but
> tweaked for simplicity and to allow zsh to at least parse the
> code.
>=20
> Based-on-patch-by: Peter van der Does <peter@avirtualhome.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Peter van der Does wrote:
> > Jonathan Nieder <jrnieder@gmail.com> wrote:
>=20
> >>  2. Import the definition of _get_comp_words_by_ref from the
> >>     bash-completion lib and use it if ZSH_VERSION is unset.
> >>=20
> >>  3. Further refinements, if needed.
> >>=20
> >> What do you think?
> >
> > I like the idea and we should go with this solution.
> >=20
> > If by importing you mean using :
> > [CODE]. /git_bash_completion-functions[/CODE] in the
> > contrib/completion/git-completion.bash script, which would be the b=
est
> > solution imho. The question is where to place that the function fil=
e.
> [...]
> > It would have to include copying the functions file somewhere as we=
ll.
> >=20
> > Or we could use the method used now and include the functions in th=
e
> > git-completion.bash script.
>=20
> Sorry for the lack of clarity.  Here's what I meant.
>=20
>  contrib/completion/git-completion.bash |  125 ++++++++++++++++++++++=
++++++++++
>  1 files changed, 125 insertions(+), 0 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 0b0eb45..1743319 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -327,7 +327,102 @@ __gitcomp_1 ()
>  	done
>  }
> =20
> +# The following function is based on code from:
> +#
> +#   bash_completion - programmable completion functions for bash 3.2=
+
> +#
> +#   Copyright =A9 2006-2008, Ian Macdonald <ian@caliban.org>
> +#             =A9 2009-2010, Bash Completion Maintainers
> +#                     <bash-completion-devel@lists.alioth.debian.org=
>
> +#
> +#   This program is free software; you can redistribute it and/or mo=
dify
> +#   it under the terms of the GNU General Public License as publishe=
d by
> +#   the Free Software Foundation; either version 2, or (at your opti=
on)
> +#   any later version.
> +#
> +#   This program is distributed in the hope that it will be useful,
> +#   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#   GNU General Public License for more details.
> +#
> +#   You should have received a copy of the GNU General Public Licens=
e
> +#   along with this program; if not, write to the Free Software Foun=
dation,
> +#   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> +#
> +#   The latest version of this software can be obtained here:
> +#
> +#   http://bash-completion.alioth.debian.org/
> +#
> +#   RELEASE: 2.x
> +
> +# This function can be used to access a tokenized list of words
> +# on the command line:
> +#
> +#	__reassemble_comp_words_by_ref '=3D:'
> +#	if test "${words_[cword_-1]}" =3D -w
> +#	then
> +#		...
> +#	fi
> +#
> +# The argument should be a collection of characters from the list of
> +# word completion separators (COMP_WORDBREAKS) to treat as ordinary
> +# characters.
> +#
> +# This is roughly equivalent to locally setting COMP_WORDBREAKS to
> +# exclude those characters, but it does not clobber COMP_WORDBREAKS.
> +# The intent is for it to be used by commands like ssh that want to
> +# treat host:path as one token.
> +#
> +# Output: words_, cword_, cur_.
> +
> +__git_reassemble_comp_words_by_ref()
> +{
> +	local exclude i j first
> +	# Which word separators to exclude?
> +	exclude=3D"${1//[^$COMP_WORDBREAKS]}"
> +	cword_=3D$COMP_CWORD
> +	if [ -z "$exclude" ]; then
> +		words_=3D("${COMP_WORDS[@]}")
> +		return
> +	fi
> +	# List of word completion separators has shrunk;
> +	# re-assemble words to complete.
> +	for ((i=3D0, j=3D0; i < ${#COMP_WORDS[@]}; i++, j++)); do
> +		# Append each nonempty word consisting of just
> +		# word separator characters to the current word.
> +		first=3Dt
> +		while
> +			[ $i -gt 0 ] &&
> +			[ -n "${COMP_WORDS[$i]}" ] &&
> +			# word consists of excluded word separators
> +			[ "${COMP_WORDS[$i]//[^$exclude]}" =3D "${COMP_WORDS[$i]}" ]
> +		do
> +			# Attach to the previous token,
> +			# unless the previous token is the command name.
> +			if [ $j -ge 2 ] && [ -n "$first" ]; then
> +				((j--))
> +			fi
> +			first=3D
> +			words_[$j]=3D${words_[j]}${COMP_WORDS[i]}
> +			if [ $i =3D $COMP_CWORD ]; then
> +				cword_=3D$j
> +			fi
> +			if (($i < ${#COMP_WORDS[@]} - 1)); then
> +				((i++))
> +			else
> +				# Done.
> +				return
> +			fi
> +		done
> +		words_[$j]=3D${words_[j]}${COMP_WORDS[i]}
> +		if [ $i =3D $COMP_CWORD ]; then
> +			cword_=3D$j
> +		fi
> +	done
> +}
> +
>  if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
> +if [[ -n $ZSH_VERSION ]]; then
>  _get_comp_words_by_ref ()
>  {
>  	while [ $# -gt 0 ]; do
> @@ -352,6 +447,36 @@ _get_comp_words_by_ref ()
>  		shift
>  	done
>  }
> +else
> +_get_comp_words_by_ref ()
> +{
> +	local exclude cur_ cword_
> +	local words_=3D()
> +	if [ "$1" =3D "-n" ]; then
> +		exclude=3D$2
> +		shift 2
> +	fi
> +	__git_reassemble_comp_words_by_ref "$exclude"
> +	cur_=3D${words_[cword_]}
> +	while [ $# -gt 0 ]; do
> +		case "$1" in
> +		cur)
> +			cur=3D$cur_
> +			;;
> +		prev)
> +			prev=3D${words_[$cword_-1]}
> +			;;
> +		words)
> +			words=3D("${words_[@]}")
> +			;;
> +		cword)
> +			cword=3D$cword_
> +			;;
> +		esac
> +		shift
> +	done
> +}
> +fi
>  fi
> =20
>  # __gitcomp accepts 1, 2, 3, or 4 arguments
> --=20
> 1.7.2.3
>=20
