From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: broken bash completion
Date: Sat, 5 May 2012 14:13:19 +0200
Message-ID: <20120505121319.GG2164@goldbirke>
References: <4FA14016.8050503@rolf.leggewie.biz>
	<20120504233213.GF2164@goldbirke>
	<4FA4AB86.8020108@rolf.leggewie.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rolf Leggewie <foss@rolf.leggewie.biz>
X-From: git-owner@vger.kernel.org Sat May 05 14:13:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQdrg-0001Fz-Rl
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 14:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355Ab2EEMN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 08:13:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:61780 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab2EEMN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 08:13:27 -0400
Received: from localhost6.localdomain6 (p5B130A62.dip0.t-ipconnect.de [91.19.10.98])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LuHCt-1RzfHR1QMp-011BLE; Sat, 05 May 2012 14:13:22 +0200
Content-Disposition: inline
In-Reply-To: <4FA4AB86.8020108@rolf.leggewie.biz>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:DGH+cO2cSgfGw3B9ru9LbPNBykPei6N2GhjbCm+/SOA
 0grqiRzTgDF32Lx/vx8PfSvALKqZpPO9wabM9Zlxm/vzmNn/VP
 mFTZ3c+Yl2cfu8uRINmjAfZYFuEpdLtobUJD3ND7JN1e7wnH5A
 8Na4CJCTSqqfyt/kgsCOykm9RYCxUTUxS3qJr1Fx7LRSBNzhuI
 UM3xWoRjpIf2hq4MTXkype7Noq5F3Fe0tjUhzQ4f8xEpUccODw
 TabsW++x2Wvxs04FZ3zoHMLb9rIa/p7U/bbsXVYNY7k++oVoxY
 VUZe+mUIhUBmRotLhl9//FNG6BCGR77i2g2IVw1PaQ4FXaHxIU
 JOdA4MByWjuIxFDeyZQk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197108>

Hi Rolf,


On Sat, May 05, 2012 at 12:24:38PM +0800, Rolf Leggewie wrote:
> After all is said and done, though, the bash-completion remains
> inconsistent and thus broken.  It's great that your life is
> currently more convenient but in the end you are relying on broken
> behaviour.

Well, git's completion script is consistent with itself: whenever
there is no matching subcommand, option, parameter for an option, or
ref, it falls back to filename completion.  I wouldn't consider this
behavior as broken.

> Affected commands:
> git log
> git diff
> git whatchanged
> git branch (why offer tags OR files here at all)

While files and tags make no sense for 'git branch' itself, completing
them can be helpful to construct the name of a new branch.  I did the
following at dayjob just the other day:

# there are route_calculation.c and .h files in that project, and
# there were some nasty bugs in there
$ git branch ro<TAB>
# which gave me
$ git branch route_calculation.
# just deleted the '.' and completed the new branch name by hand
$ git branch route_calculation_fixes


Anyway, I see two ways to fix this if we want to be anal, but none of
them is actually applicable:

- When registering _git() as the completion function for the git
  command, we specify some options to tell Bash to do filename
  completion when we can't find any matches to the word to be
  completed.  Recent Bash versions provide the 'compopt' builtin to
  allow modifying completion options for the currently executed
  completion.  We could do a 'compopt +o bashdefault +o default'
  to disable the filename completion fallback wherever we deem it
  inappropriate.

  'compopt' was introduced in Bash 4.0, but unfortunately msysgit
  still includes an older version, so this is a no go.

- We don't specify the options to ask Bash to fall back to filename
  completion when registering _git(). This will disable filename
  completion for the whole git completion script, so we must roll our
  own helper functions to do filename completion, which we would
  invoke wherever filename completion is explicitly desired.

  This should work on any Bash version, but would inherently include
  some fork()+exec()s, adding significant delays especially on
  msysgit.

> Unaffected programs, i.e. working correctly:
> git commit
> [...]

You haven't tried it hard enough ;)

$ git commit --fixup=3De<TAB>
editor.c       entry.c        environment.c  exec_cmd.c     exec_cmd.o
editor.o       entry.o        environment.o  exec_cmd.h    =20

although at that point only a commit is accepted.

> Some consistency would be great.  In a perfect world bash-completion
> ought to work on all possible completion targets but at the same
> time it should exclude all that make no sense, too.  Neither of the
> two seems to be currently the case.

Yeah, in that perfect world 'git rm <TAB>', 'git bisect -- <TAB>', and
'git log -- <TAB>' whould offer only tracked files, 'git (add|commit)
<TAB>' only modified or untracked files, and 'git diff <TAB>' would
read your mind to find out whether you want to diff a ref or a file,
etc. etc.

But you miss an important point here: users expect the completion to
be pretty fast, because delays are quite noticeable and annoying while
typing a command.  So there's a trade-off between correctness and
usability.  Unfortunately, in the real world all that filtering costs
a great deal, so git's completion script does that only if it can be
done cheaply (e.g. 'git rebase --<TAB>' won't offer you '--abort' and
'--continue' if you're not in the middle of an ongoing rebase).  And
as pointed out above, something might be nonsense for a command, but
still be useful for the user.


Best,
G=E1bor
