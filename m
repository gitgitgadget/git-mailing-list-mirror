From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH 2/1] bash: eliminate dependency on bash_completion lib
Date: Fri, 3 Dec 2010 00:40:53 +0100
Message-ID: <20101202234053.GB3577@neumann>
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
X-From: git-owner@vger.kernel.org Fri Dec 03 00:41:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POIm1-0003jg-Jt
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 00:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144Ab0LBXlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 18:41:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:54875 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757651Ab0LBXlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 18:41:07 -0500
Received: from localhost6.localdomain6 (p5B130C9F.dip0.t-ipconnect.de [91.19.12.159])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0M3u5q-1OYG753ZUA-00rbPg; Fri, 03 Dec 2010 00:40:54 +0100
Content-Disposition: inline
In-Reply-To: <20101202210207.GA4994@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:QpH9Q2s0XTKdVqLOoV9wpKlsNz2axdwS5xCEALGDzMx
 VhsCaBnKwiTD9nOK5okTgP5hkVZ0OMXxevu4JOGu3/N8MCCj/R
 dlHzkDcdbMqIVGq0h0YmDC7wxNMAx1u7jm3WXeHjTKln2Azyza
 iiYRlvx6lhJDCBMOLXwF1xMnbGJ9531GJerw6hEF83Q2T2rfom
 E4vL/S9fWmZ5FVOL7h+og==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162753>

Hi,


On Thu, Dec 02, 2010 at 03:02:07PM -0600, Jonathan Nieder wrote:
> Add a minimal implementation of _get_comp_words_by_ref,
> the routine used to work around bash 4.0's COMP_WORDS semantics.

Some extension:

Bash's programmable completion provides the COMP_WORDS array variable,
which holds the individual words in the current command line.  In Bash
versions prior to v4 "words are split on shell metacharacters as the
shell parser would separate them" (quote from bash v3.2.48's man
page).  This behavior has changed with Bash v4, and the command line
"is split into words as readline would split it, using COMP_WORDBREAKS
as" "the set of characters that the readline library treats as word
separators" (quote from bash v4's man page).

Since COMP_WORDBREAKS contains the characters : and =3D by default, thi=
s
behavior change in Bash also affects git's completion script.  For
example, when using Bash v4 the completion script can't provide
possible options for a command line argument (e.g. git log
--pretty=3D<TAB><TAB> lists files, but it should list possible log
formats).


I would really, _really_ like to have the above text in the commit
message (either in yours or in Peter's), because it took me weeks to
figure this out ;)  Not that it was that difficult, but when I
discovered this issue more than a month ago, "unfortunately" I
remembered a similar issue (db8a9ff, bash completion: Resolve git show
ref:path<tab> losing ref: portion, 2008-07-15), and it got me
sidetracked really really  badly.

(I'm still wondering what Bash v3.x was doing with COMP_WORDBREAKS,
though...)

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

I haven't tried to understand the code yet, but noticed the following
two nits while glancing it over.

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

__git_reassemble_comp_words_by_ref?

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

This should be ${ZSH_VERSION-} to keep 'set -u' environments happy.

=20
