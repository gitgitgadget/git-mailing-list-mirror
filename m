From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sun, 6 May 2012 14:12:04 +0200
Message-ID: <20120506121204.GA5799@goldbirke>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
	<20120506111425.GJ2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 14:12:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR0KI-0007CD-Ic
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 14:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424Ab2EFMMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 08:12:09 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:65424 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab2EFMMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 08:12:08 -0400
Received: from localhost6.localdomain6 (p5B130CE2.dip0.t-ipconnect.de [91.19.12.226])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LwE4w-1S5bI01lok-017XK1; Sun, 06 May 2012 14:12:06 +0200
Content-Disposition: inline
In-Reply-To: <20120506111425.GJ2164@goldbirke>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:Yy1CdcSqELLL+Jt9hAxUiKti2JSIzsMtDLKZFD8bUg2
 aNPiHTakAhw30YyN2plt1Ye/2kvfizsa0YyzhkxKyPX/1FxYQn
 XfdfuMr6Pmr1Xl70LoN2TCAnuRqZqzlXUYwPHre8DnZNSPnVjK
 tLHEc0mmuLVnsGDSw+DqAnarrPcYKMjGXXIE3BDHknokPqqTQq
 Cfemosi/EdeNeFJ/orDilt636oJY1UZjQOa2ARa7T5ltFFHdpp
 t8OW9J3Up2AyE/mqm6zXCvTlVpvyJnFwgAqTaCU/Su2VmG6ouZ
 MAwmoCRcNo1tn58A9Wo3igml/QzSLUo4phmTMDLkCdB101EimJ
 wZs7gXIOgtpGahUewUiI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197171>

Hi,


On Sun, May 06, 2012 at 01:14:25PM +0200, SZEDER G=E1bor wrote:
> On Sat, May 05, 2012 at 05:23:20PM +0200, Felipe Contreras wrote:
> > +__git_func_wrap ()
> > +{
> > +	if [[ -n ${ZSH_VERSION-} ]]; then
> > +		emulate -L bash
> > +		setopt KSH_TYPESET
> > +
> > +		# workaround zsh's bug that leaves 'words' as a special
> > +		# variable in versions < 4.3.12
> > +		typeset -h words
> > +
> > +		# workaround zsh's bug that quotes spaces in the COMPREPLY
> > +		# array if IFS doesn't contain spaces.
> > +		typeset -h IFS
> > +	fi
> > +	local cur words cword prev
> > +	_get_comp_words_by_ref -n =3D: cur words cword prev
> > +	__git_func "$@"
> > +}
> > +
> > +_GIT_complete ()
> > +{
> > +	local name=3D"${2-$1}"
> > +	eval "$(typeset -f __git_func_wrap | sed -e "s/__git_func/_$name/=
")"
>=20
> Still don't like the subshell and sed here ...
>=20
> > +	complete -o bashdefault -o default -o nospace -F _${name}_wrap $1=
 2>/dev/null \
> > +		|| complete -o default -o nospace -F _${name}_wrap $1
> > +}
> > +
> > +_GIT_complete git
> > +_GIT_complete gitk
>=20
> ... because it adds delay when the completion script is loaded.  But =
I
> still don't have ideas how to avoid them.

Ok, I think I got it.  How about this on top of Felipe's patch?

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index f300b87d..8c18db92 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2688,19 +2688,19 @@ __git_func_wrap ()
 	fi
 	local cur words cword prev
 	_get_comp_words_by_ref -n =3D: cur words cword prev
-	__git_func "$@"
+	$1
 }
=20
 _GIT_complete ()
 {
-	local name=3D"${2-$1}"
-	eval "$(typeset -f __git_func_wrap | sed -e "s/__git_func/_$name/")"
-	complete -o bashdefault -o default -o nospace -F _${name}_wrap $1 2>/=
dev/null \
-		|| complete -o default -o nospace -F _${name}_wrap $1
+	local wrapper=3D"__git_wrap_$1"
+	eval "$wrapper () { __git_func_wrap $2 ; }"
+	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/n=
ull \
+		|| complete -o default -o nospace -F $wrapper $1
 }
=20
-_GIT_complete git
-_GIT_complete gitk
+_GIT_complete git _git
+_GIT_complete gitk _gitk
=20
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently


The point is that __git_func_wrap() is not a template function
processed by _GIT_complete() (or whatever we'll end up calling it)
anymore, but simply a wrapper function around existing completion
functions.  The name of the completion function to be invoked should
be given as argument.  _GIT_complete() then uses 'eval' to create
another wrapper function to invoke __git_func_wrap() with the name of
the desired completion function.  The name of this dynamically created
wrapper function is derived from the name of the command or alias,
i.e. for 'gf' it will be __git_wrap_gf().

The overhead of the additional function call is not even measureable,
while it would spare the overhead of fork()ing a subshell and
fork()+exec()ing 'sed' twice when loading the completion script and
then for each subsequent alias.


Best,
G=E1bor
