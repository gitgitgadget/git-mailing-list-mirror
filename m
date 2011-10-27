From: Jonas Berlin <xkr47@outerspace.dyndns.org>
Subject: Re: [PATCH v2] completion: fix issue with process substitution not
  working on Git for Windows
Date: Thu, 27 Oct 2011 13:27:54 +0300
Message-ID: <20111027132754.1503b98b@outerspace.dyndns.org>
References: <CAJzBP5QYKOf4OUMm4vfVay=b7F_fHJf40JgzDAZZa7p0fxLpyA@mail.gmail.com>
	<1319656389-9515-1-git-send-email-stefan.naewe@gmail.com>
	<20111027090530.GA23424@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Naewe <stefan.naewe@gmail.com>, spearce@spearce.org,
	git@vger.kernel.org, gitster@pobox.com
To: SZEDER =?ISO-8859-1?B?R+Fib3I=?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 27 12:36:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJNJf-0007IJ-Me
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 12:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab1J0KgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 06:36:00 -0400
Received: from mx.slashbox.net ([213.250.117.195]:38442 "EHLO mx.slashbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab1J0KgA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 06:36:00 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Oct 2011 06:35:59 EDT
Received: from outerspace.dyndns.org (cs78186190.pp.htv.fi [62.78.186.190])
	by mx.slashbox.net (Postfix) with ESMTPSA id EA01F1C029A;
	Thu, 27 Oct 2011 13:27:57 +0300 (EEST)
In-Reply-To: <20111027090530.GA23424@goldbirke>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184291>

On Thu, 27 Oct 2011 11:05:30 +0200
SZEDER G=E1bor <szeder@ira.uka.de> wrote:

> On Wed, Oct 26, 2011 at 09:13:09PM +0200, Stefan Naewe wrote:
> > Git for Windows comes with a bash that doesn't support process subs=
titution.
> > It issues the following error when using git-completion.bash with
> > GIT_PS1_SHOWUPSTREAM set:
> >=20
> > $ export GIT_PS1_SHOWUPSTREAM=3D1
> > sh.exe": cannot make pipe for process substitution: Function not im=
plemented
> > sh.exe": cannot make pipe for process substitution: Function not im=
plemented
> > sh.exe": <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.=
showupstream)$' 2>/dev/null | tr '\0\n' '\n '): ambiguous redirect
> >=20
> > Replace the process substitution with a 'here string'.
> >=20
> > Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/contrib/completion/git-completion.bash b/contrib/compl=
etion/git-completion.bash
> > index 8648a36..0b3d47e 100755
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -110,6 +110,7 @@ __git_ps1_show_upstream ()
> >  	local upstream=3Dgit legacy=3D"" verbose=3D""
> > =20
> >  	# get some config options from git-config
> > +	output=3D"$(git config -z --get-regexp '^(svn-remote\..*\.url|bas=
h\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
> >  	while read key value; do
> >  		case "$key" in
> >  		bash.showupstream)
> > @@ -125,7 +126,7 @@ __git_ps1_show_upstream ()
> >  			upstream=3Dsvn+git # default upstream is SVN if available, else=
 git
> >  			;;
> >  		esac
> > -	done < <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.=
showupstream)$' 2>/dev/null | tr '\0\n' '\n ')
> > +	done <<< "$output"
>=20
> The $output variable is not declared as local and therefore it leaks
> into the environment.  But instead of declaring it local, why not
> eliminate it altogether, and use the "$(git config ....)" command
> substitution as here string?

Wouldn't this work:

	git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$=
' 2>/dev/null | tr '\0\n' '\n ' | \
	while read key value; do
		...
	done

- xkr47
