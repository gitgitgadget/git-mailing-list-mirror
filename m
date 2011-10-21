From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 3/3] completion: match ctags symbol names in grep patterns
Date: Fri, 21 Oct 2011 15:25:45 +0200
Message-ID: <20111021132545.GA27385@goldbirke>
References: <20111018044955.GA8976@sigill.intra.peff.net>
	<20111018050105.GC9008@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 21 15:25:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHF6h-0002h8-ND
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 15:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab1JUNZv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Oct 2011 09:25:51 -0400
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:9128 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab1JUNZu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 09:25:50 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 21 Oct
 2011 15:26:39 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 21 Oct
 2011 15:25:45 +0200
Content-Disposition: inline
In-Reply-To: <20111018050105.GC9008@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184060>

Hi,


On Tue, Oct 18, 2011 at 01:01:05AM -0400, Jeff King wrote:
> A common thing to grep for is the name of a symbol. This
> patch teaches the completion for "git grep" to look in
> a 'tags' file, if present, to complete a pattern. For
> example, in git.git:
>=20
>   $ make tags
>   $ git grep get_sha1<Tab><Tab>
>   get_sha1                 get_sha1_oneline
>   get_sha1_1               get_sha1_with_context
>   get_sha1_basic           get_sha1_with_context_1
>   get_sha1_hex             get_sha1_with_mode
>   get_sha1_hex_segment     get_sha1_with_mode_1
>   get_sha1_mb
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It's debatable whether this belongs in the generic completion code, a=
s
> it really only works if your project uses ctags. But I find it to be =
a
> huge timesaver for finding callsites of functions

Interesting idea.  I reckon most of the time I do 'git grep' in order
to find callsites of a function or usage of a global variable.  I
usually do that by copy-pasting the symbol name, but this change could
likely spare me that copy-paste.

>  contrib/completion/git-completion.bash |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 8648a36..f4ab13d 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1432,6 +1432,10 @@ _git_gitk ()
>  	_gitk
>  }
> =20
> +_git_grep_ctag_match() {

This is a helper function, therefore it should have two underscores as
prefix, i.e. __git_grep_ctag_match().  Single underscore prefixes are
"reserved" for completion functions of the corresponding git command,
i.e. if someone ever creates a git command or alias called
'grep_ctag_match', then 'git grep_ctag_match <TAB>' will invoke this
function to offer possible completion words.

> +	awk -v ORS=3D' ' "/^${1////\\/}/ { print \$1 }" "$2"
> +}
> +
>  _git_grep ()
>  {
>  	__git_has_doubledash && return
> @@ -1454,6 +1458,13 @@ _git_grep ()
>  		;;
>  	esac
> =20
> +	case "$COMP_CWORD,$prev" in

Depending on what is on the command line before the current word,
$COMP_CWORD might have different value in Bash 3 and in Bash 4; see
da48616f (bash: get --pretty=3Dm<tab> completion to work with bash v4,
2010-12-02).  Please use $cword instead.

> +	2,*|*,-*)
> +		test -r tags || return

1. This checks for the tags file in the current directory, so it would
   only work at the top of the working tree, but not in any of the
   subdirectories.

2. The return in case of no tags file would cause file name
   completion.  This is different from the current behavior, when the
   completion script would offer refs.  Now, I don't think that refs
   as grep pattern are any more useful than file names...  but neither
   do I think that offering file names is an improvement over current
   behavior.  Anyway, this is a side effect not mentioned in the
   commit message.

> +		COMPREPLY=3D( $(compgen -W "`_git_grep_ctag_match "$cur" tags`") )

1. Nit: $() around _git_grep_ctag_match().
   This would be the first backticks usage in the completion script.

2. When the completion script offers possible completion words, then
   usually a space is appended, e.g. 'git grep --e<TAB>' would
   complete to '--extended-regexp ', unless the offered option
   requires an argument, e.g. 'git commit --m<TAB>' would complete to
   '--message=3D'.  I think function names extracted from the tags file
   should also get that trailing space.  No big deal, the easiest way
   to do that is to pass the output of _git_grep_ctag_match() to
   __gitcomp(), and it will take care of that.

   However, this change will make 'git grep <TAB>' offer 9868 possible
   completion words in my git repository, which is quite a lot.  I
   posted some completion optimizations recently, currently cooking in
   pu, which make processing that many possible completion words
   faster (sg/complete-refs, tip currently at 175901a5; the important
   commit is bd4139ca (completion: optimize refs completion,
   2011-10-15)).  To be able to use that optimization possible
   completion words must be separated by a newline, but your
   _git_grep_ctag_match() lists symbol names separated by a space.  It
   would be great if you could tweak _git_grep_ctag_match()'s awk
   script to list newline-separated symbols, so that when both
   branches are merged, then we could just change the __gitcomp() call
   to __gitcomp_nl().


Best,
G=E1bor
