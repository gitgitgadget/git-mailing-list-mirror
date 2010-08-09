From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: 'git stash list' vs. non-default 'log.date' setting
Date: Mon, 9 Aug 2010 12:40:56 +0200
Message-ID: <20100809104056.GJ4612@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 12:41:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiPn3-0006iS-Dz
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 12:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115Ab0HIKlB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 06:41:01 -0400
Received: from francis.fzi.de ([141.21.7.5]:2275 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756092Ab0HIKlA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 06:41:00 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 9 Aug 2010 12:40:57 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 09 Aug 2010 10:40:57.0237 (UTC) FILETIME=[599BAC50:01CB37AF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152962>

Hi,


Commits 8f8f547 (Introduce new pretty formats %g[sdD] for reflog
information, 2009-10-19) and 391c53b (stash list: use new %g formats
instead of sed, 2009-10-19) (Thomas on Cc:) changed the way how the
output of 'git stash list' is generated.  I agree that avoiding a sed
invocation and respecting pager settings are good things (although I
also think that if you have so many stashes that you need a pager,
then you are doing something wrong).

However, these changes have some side-effects:

1) The output of 'git stash list' is affected by the 'log.date' config
   variable:

   $ git config --get log.date
   $ git stash list
   stash@{0}: On master: foo
   $ git config log.date iso8601
   $ git stash list
   stash@{2010-08-03 16:54:34 +0200}: On master: foo

   I would expect that stashes are always listed as stash@{num}, no
   matter what I have in 'log.date' (just like 'git reflog').  It
   takes up less screen space and is easier to remember.

2) The bash completion script expects that, too, because a non-default
   value for 'log.date' breaks the completion of 'git stash'
   subcommands with a stash argument:

   $ git stash apply <TAB>
   16                  stash@{2010-08-03  =20


=46ortunately, fixing 2) is a no-brainer:

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6756990..e3600d4 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2167,7 +2167,7 @@ _git_stash ()
 			COMPREPLY=3D()
 			;;
 		show,*|apply,*|drop,*|pop,*|branch,*)
-			__gitcomp "$(git --git-dir=3D"$(__gitdir)" stash list \
+			__gitcomp "$(git --git-dir=3D"$(__gitdir)" stash list --date=3Ddefa=
ult \
 					| sed -n -e 's/:.*//p')"
 			;;
 		*)

But what to do with 1)?  Of course, I would hate to use --date=3Ddefaul=
t
by 'git stash list' invocations, and, (again) of course, I don't want
to change my 'log.date' setting either.  Maybe changing the %gd (and
%gD) format specifiers to ignore 'log.date' altogether but still
respect --date=3D<whatever>?


Best,
G=E1bor
