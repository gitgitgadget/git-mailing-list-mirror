From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] completion: match ctags symbol names in grep patterns
Date: Fri, 21 Oct 2011 13:22:39 -0400
Message-ID: <20111021172239.GA22289@sigill.intra.peff.net>
References: <20111018044955.GA8976@sigill.intra.peff.net>
 <20111018050105.GC9008@sigill.intra.peff.net>
 <20111021132545.GA27385@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Oct 21 19:23:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHIoB-0003ed-UI
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 19:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662Ab1JURWn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Oct 2011 13:22:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38963
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346Ab1JURWm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 13:22:42 -0400
Received: (qmail 21679 invoked by uid 107); 21 Oct 2011 17:22:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Oct 2011 13:22:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2011 13:22:39 -0400
Content-Disposition: inline
In-Reply-To: <20111021132545.GA27385@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184069>

On Fri, Oct 21, 2011 at 03:25:45PM +0200, SZEDER G=C3=A1bor wrote:

> Interesting idea.  I reckon most of the time I do 'git grep' in order
> to find callsites of a function or usage of a global variable.  I
> usually do that by copy-pasting the symbol name, but this change coul=
d
> likely spare me that copy-paste.

Thanks. Glad somebody else finds it useful. :)

> > +_git_grep_ctag_match() {
>=20
> This is a helper function, therefore it should have two underscores a=
s
> prefix, i.e. __git_grep_ctag_match().  Single underscore prefixes are
> "reserved" for completion functions of the corresponding git command,
> i.e. if someone ever creates a git command or alias called
> 'grep_ctag_match', then 'git grep_ctag_match <TAB>' will invoke this
> function to offer possible completion words.

Good point. Will change.

> > +	case "$COMP_CWORD,$prev" in
>=20
> Depending on what is on the command line before the current word,
> $COMP_CWORD might have different value in Bash 3 and in Bash 4; see
> da48616f (bash: get --pretty=3Dm<tab> completion to work with bash v4=
,
> 2010-12-02).  Please use $cword instead.

Thanks, I was completely unaware of this issue.

> > +	2,*|*,-*)
> > +		test -r tags || return
>=20
> 1. This checks for the tags file in the current directory, so it woul=
d
>    only work at the top of the working tree, but not in any of the
>    subdirectories.

Yeah. I didn't want to spend a lot of effort looking up through the
repository directories for a 'tags' file. Especially for people who
aren't using ctags at all, and for whom that would just be unnecessary
work.

OTOH, it is triggered only when they try to complete a pattern, which i=
s
currently pointless. So maybe it's not worth worrying about existing
users, as they won't do this completion anyway.

> 2. The return in case of no tags file would cause file name
>    completion.  This is different from the current behavior, when the
>    completion script would offer refs.  Now, I don't think that refs
>    as grep pattern are any more useful than file names...  but neithe=
r
>    do I think that offering file names is an improvement over current
>    behavior.  Anyway, this is a side effect not mentioned in the
>    commit message.

Good point. Will fix.

> > +		COMPREPLY=3D( $(compgen -W "`_git_grep_ctag_match "$cur" tags`")=
 )
>=20
> 1. Nit: $() around _git_grep_ctag_match().
>    This would be the first backticks usage in the completion script.

=46unctionally irrelevant, I think, but style-wise, I agree it should
match the rest of the script.

> 2. When the completion script offers possible completion words, then
>    usually a space is appended, e.g. 'git grep --e<TAB>' would
>    complete to '--extended-regexp ', unless the offered option
>    requires an argument, e.g. 'git commit --m<TAB>' would complete to
>    '--message=3D'.  I think function names extracted from the tags fi=
le
>    should also get that trailing space.  No big deal, the easiest way
>    to do that is to pass the output of _git_grep_ctag_match() to
>    __gitcomp(), and it will take care of that.

Thanks, I had wanted to add the space at one point, but forgot about it
and got used to the current behavior. I agree adding it is better, and
it's nice that it's easy to do.

>    However, this change will make 'git grep <TAB>' offer 9868 possibl=
e
>    completion words in my git repository, which is quite a lot.

Hmm. I never thought of that as much, but after converting to use
__gitcomp, there is a noticeable delay. I guess it's the loop of printf=
s
in __gitcomp_1.

=2E..Ah, yes, reading your bd4139caa, it seems that is exactly the
problem.

>    I posted some completion optimizations recently, currently cooking
>    in pu, which make processing that many possible completion words
>    faster (sg/complete-refs, tip currently at 175901a5; the important
>    commit is bd4139ca (completion: optimize refs completion,
>    2011-10-15)).  To be able to use that optimization possible
>    completion words must be separated by a newline, but your
>    _git_grep_ctag_match() lists symbol names separated by a space.  I=
t
>    would be great if you could tweak _git_grep_ctag_match()'s awk
>    script to list newline-separated symbols, so that when both
>    branches are merged, then we could just change the __gitcomp() cal=
l
>    to __gitcomp_nl().

Easy enough (just drop the ORS setting).

Thanks very much for your review. I have a fix for the first patch in
the series, too, so I'll send a whole new series in a moment.

-Peff
