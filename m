From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: fix array indexing error after reverse history
	search
Date: Wed, 11 May 2011 00:14:30 +0200
Message-ID: <20110510221430.GM1377@goldbirke>
References: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <gsoc@spearce.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 00:14:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvCV-0007uk-Jg
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab1EJWOi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 18:14:38 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:58333 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1EJWOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 18:14:37 -0400
Received: from localhost6.localdomain6 (p5B130BE1.dip0.t-ipconnect.de [91.19.11.225])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LwVKN-1PfNRg0dDz-017sTZ; Wed, 11 May 2011 00:14:31 +0200
Content-Disposition: inline
In-Reply-To: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:1fyNZf51QZvP/BpwzoQc50/H8MnNgHLddnOH7Fe29mB
 lsjJV9rOEjaoC8CrtSvGQabXINuOZfUnQnIPkxJgAykAXrWHf9
 wRFr1PPNX6Jq67+j+t9OsSpG9W+6eP0PHa2C8EWgcaT35qCwRc
 BYxzpEeuJXu+mo6M1YQjKcSsa16W6mjA6xUXmQw/pPAyOm45dp
 w9ryIlxj8J/j50gAGNkCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173370>

In v1.7.4-rc0~11^2~2 (bash: get --pretty=3Dm<tab> completion to work
with bash v4, 2010-12-02) we started to use _get_comp_words_by_ref()
to access completion-related variables.  This function is usually
provided by the bash-completion package, but if it's not present when
git-completion.bash is loaded, then we use our simplified
re-implementation of that function.  We also provide a bare bones
_get_comp_words_by_ref() implementation that works with zsh.

Unfortunately (and interestingly!), since the recent commit da4902a
(completion: remove unnecessary _get_comp_words_by_ref() invocations,
2011-04-28) the same bug can be triggered in all of these three
implementations when doing reverse history search:

 - Hit ctrl-r to start reverse history search.
 - Search for a git command, e.g. by typing 'git '.
   The prompt will look like this: (reverse-i-search)`git ': git diff
 - Press TAB to attempt completion.

This will lead to an error like:

  $ bash: words: bad array subscript

The reason for this is that since commit da4902a we always tell
_get_comp_words_by_ref() to set the $prev variable in _git(), which
should contain the word preceeding the word containing the current
cursor position.  The value of this variable is assigned in all three
_get_comp_words_by_ref() implementations with something like

  prev=3D${COMP_WORDS[COMP_CWORD-1]}

However, in the above bug-triggering input the cursor is considered to
be at the very beginning of the command line, i.e. in the nullth word,
so the array index in the above line ends up to be -1, hence the
error.  In this case the only sensible value for $prev would be an
empty string, because there is no previous word on the command line.

The same applies to the _get_comp_words_by_ref() invocation in
_gitk(), too.

This patch fixes both of our _get_comp_words_by_ref() implementations
by assigning an empty string to $prev when there can't be any previous
word.  It also works around the bug in _get_comp_words_by_ref() from
the bash-completion package by not asking for the $prev variable at
all when there can't be any previous word.  In the latter case we
check the value of $COMP_CWORD; we usually refrain from using this
variable directly in completion functions because of the word
splitting changes introduced in bash v4 (see v1.7.4-rc0~11^2~2), but
in this case, i.e. at the nullth word the different word splitting
rules don't make a difference.

Noticed-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

On Tue, May 10, 2011 at 10:13:11PM +0200, Sverre Rabbelier wrote:
> This happens if I try use ctrl-shift-r (reverse-i-search) for the
> string `git commit -am "S`, resulting in the following:
>=20
> (reverse-i-search)`git commit -am "S': git commit -am "Set new Melang=
e
> version number to 2-0-20110501 in app.yaml.template."
>=20
> If I then hit tab, I get:
>=20
> $ bash: words: bad array subscriptversion number to 2-0-20110501 in
> app.yaml.template."

Nice catch, although I have no idea why anyone would attempt
completion at that point.


Best,
G=E1bor

 contrib/completion/git-completion.bash |   26 ++++++++++++++++++++++--=
--
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 00691fc..0b12c66 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -445,7 +445,11 @@ _get_comp_words_by_ref ()
 			cur=3D$cur_
 			;;
 		prev)
-			prev=3D${words_[$cword_-1]}
+			if [ "$cword_" =3D 0 ]; then
+				prev=3D""
+			else
+				prev=3D${words_[$cword_-1]}
+			fi
 			;;
 		words)
 			words=3D("${words_[@]}")
@@ -466,7 +470,11 @@ _get_comp_words_by_ref ()
 			cur=3D${COMP_WORDS[COMP_CWORD]}
 			;;
 		prev)
-			prev=3D${COMP_WORDS[COMP_CWORD-1]}
+			if [ "$COMP_CWORD" =3D 0 ]; then
+				prev=3D""
+			else
+				prev=3D${COMP_WORDS[COMP_CWORD-1]}
+			fi
 			;;
 		words)
 			words=3D("${COMP_WORDS[@]}")
@@ -2611,7 +2619,12 @@ _git ()
 	fi
=20
 	local cur words cword prev
-	_get_comp_words_by_ref -n =3D: cur words cword prev
+	if [ "$COMP_CWORD" =3D 0 ]; then
+		_get_comp_words_by_ref -n =3D: cur words cword
+		prev=3D""
+	else
+		_get_comp_words_by_ref -n =3D: cur words cword prev
+	fi
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
 		case "$i" in
@@ -2662,7 +2675,12 @@ _gitk ()
 	fi
=20
 	local cur words cword prev
-	_get_comp_words_by_ref -n =3D: cur words cword prev
+	if [ "$COMP_CWORD" =3D "0" ]; then
+		_get_comp_words_by_ref -n =3D: cur words cword
+		prev=3D""
+	else
+		_get_comp_words_by_ref -n =3D: cur words cword prev
+	fi
=20
 	__git_has_doubledash && return
=20
--=20
1.7.5.1.248.g2ba0c6
