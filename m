From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [completion] Request: Include remote heads as push targets
Date: Sat, 23 Oct 2010 15:04:34 +0200
Message-ID: <20101023130434.GA29386@neumann>
References: <4CC05E4B.1010106@xiplink.com> <4CC06439.8040003@xiplink.com>
	<20101021191045.GC11759@burratino>
	<20101021210842.6545a661@montecarlo.grandprix.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 23 15:04:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9dmE-00061h-Ha
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 15:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab0JWNEo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 09:04:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:55699 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756743Ab0JWNEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 09:04:43 -0400
Received: from localhost6.localdomain6 (p5B130FFD.dip0.t-ipconnect.de [91.19.15.253])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MLC4r-1P9ukv1uPR-000IMZ; Sat, 23 Oct 2010 15:04:37 +0200
Content-Disposition: inline
In-Reply-To: <20101021210842.6545a661@montecarlo.grandprix.int>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:62W0eeWNSHggISKeMlqCiESwjcaFewxCjPU0h/4hVvo
 CYY67aekxhftA12GNl3F4AineivdA6QppUO9sCcnGE+GBZ3z9T
 6MDMiLMHMA9OYPc1xoWq3Dwix7UdPUonxKiJHds6LL/L7AykOt
 1YhxA2qRXTt+S8k/ODC95wl4+A7DPWm312YIkNDtSLLQ/jbGVx
 9DXWczi6WFE0EUG6R2IBA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159781>

Hi,


On Thu, Oct 21, 2010 at 09:08:42PM -0400, Peter van der Does wrote:
> On Thu, 21 Oct 2010 14:10:45 -0500
> Jonathan Nieder <jrnieder@gmail.com> wrote:
>=20
> > Marc Branchaud wrote:
> >=20
> > > Hmmm, perhaps this is really a bug.
> >=20
> > Compare:
> > http://thread.gmane.org/gmane.comp.version-control.git/159448

Yeah, it seems that the two issues are related.  I can confirm what
Marc saw, and below is a PoC patch to fix it.

> In the case of Marc's problem, it would be helpful to see what the
> result is in Bash 3.

On an oldish server with bash 3.2 it works as expected, i.e. I get
only the matching branches and tags from the remote repo.

(Sidenote: hm, offering _tags_ to _push to_?!  That doesn't seem quite
right at first sight.)


> > G=E1bor, would it be possible to summarize the problem with a simpl=
e
> > test case that could be used to get help on this from the (upstream
> > or distro-specific) bash maintainers?

Git's bash completion is not the first to suffer from changes in bash
4, and fortunately the bash-completion developers already provide a
solution for such issues.  Details below.

> As for G=E1bor find:
> The problem resides in Bash 4.

I agree.

> Bash 4 has a new set of characters that
> are defined as break up characters
> Thanks to Brain Gernhard:=20
> From the Bash 4.0 changelog:
> i.  The programmable completion code now uses the same set of
> characters as readline when breaking the command line into a list of
> words.
>=20
> As far as I can tell, from the Bash 4.0 source, these are the
> characters: " \t\n\"'@><=3D;|&(:"=20

Um, well, I suspect that there are other subtle differences between
bash 4 and 3 besides the change of word-breaking characters that
trigger this breakage.  In fact, the oldish server mentioned above
with bash 3.2 has the exact same characters in $COMP_WORDBREAKS, and
neither Marc's nor my issue occur there.

> In the completion script checks are performed if an option is given.
> The test includes the equal sign but the array with words does not th=
e
> equal sign. Example to clarify:
>=20
> local cur=3D"${COMP_WORDS[COMP_CWORD]}" dir=3D"$(__gitdir)"
> case "$cur" in
>   --whitespace=3D*)
>       __gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=3D}"
>       return
>       ;;
>=20
> If you execute:
> $ git am --whitespace=3D<tab><tab>
>=20
> The variable cur holds the equal sign and so the __gitcomp function i=
s
> never executed.

That's exactly what I observed.  This ${COMP_WORDS[COMP_CWORD]}
construct apparently is not the right way to find the word to complete
anymore, assuming you want your completion script to work with bash 4
and 3 as well.  Unfortunately, we use this construct all over the
place.

Now, the bash completion project has some functions that could be used
to circumvent these issues.  In particular, look at the description of
the _get_comp_words_by_ref() function here, especially at the -n
option:

http://git.debian.org/?p=3Dbash-completion/bash-completion.git;a=3Dblob=
;f=3Dbash_completion;h=3D589c2e5afe283d2e6d7628b683ae6714ab70d3d9;hb=3D=
HEAD#l371

That would allow us to remove characters from $COMP_WORDBREAKS on a
per-function basis, without influencing unrelated completion functions
within or outside of git completion, and in a way that works with bash
4 and 3 as well.

Here is a proof of concept patch to use that function instead of
${COMP_WORDS[COMP_CWORD]} in two places.  The second hunk fixes the
completion of pretty aliases for 'git log --pretty=3D'.  The first hunk
seems to fix Marc's issue with the completion of remotes after 'git
push origin HEAD:', but I haven't thought this one through (there's a
lot going on with scanning the previous words on the command line and
such, so it might actually break something else).  Both fixes seem to
work under bash 4 and 3.2.

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index f83f019..5608e9b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -551,7 +551,8 @@ __git_complete_revlist ()
 __git_complete_remote_or_refspec ()
 {
 	local cmd=3D"${COMP_WORDS[1]}"
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n ':' cur
 	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
 	while [ $c -lt $COMP_CWORD ]; do
 		i=3D"${COMP_WORDS[c]}"
@@ -1360,7 +1361,8 @@ _git_log ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n '=3D' cur
 	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
 	local merge=3D""
 	if [ -f "$g/MERGE_HEAD" ]; then

This patch assumes that you use fairly recent bash-completion, because
_get_comp_words_by_ref() was first included in bash-completion v1.2,
which was released just this summer.

However, git completion is currently a standalone completion script,
i.e. to use it you need only bash, git-completion.bash, and nothing
else.  If we start to use _get_comp_words_by_ref() directly, as in the
PoC patch above, then git completion will inherently depend on
bash-completion, too.  This could be considered as a regression.

Alternatively, we could just copy the necessary functions from
bash-completion to git-completion.bash (with the name changed, of
course, e.g. to __git_get_comp_words_by_ref()), keeping git completion
standalone but still getting the benefits of this function, and
getting these bash 4 vs. 3 issues fixed.

Thoughts?


Best,
G=E1bor
