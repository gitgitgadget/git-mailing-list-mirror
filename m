From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 00/19] Bash prompt speedup
Date: Wed,  9 May 2012 02:44:31 +0200
Message-ID: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:45:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv24-0004mn-Ig
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399Ab2EIApQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:45:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:61121 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab2EIApN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:45:13 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0M6t73-1SFSLP1uGT-00xGd3; Wed, 09 May 2012 02:45:06 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
X-Provags-ID: V02:K0:ZNx4GNliqHOnyH685E6P5rn4XxJ29C7XxD8p3tKfx2+
 BBv90cDRvzG3zoK9KrYKYaRsVLpUqZcXLxUsy+4YKUkPvbhti6
 r6t6j/OeELQOXOwv/rupsQseEia9taiYU8Ua+hpvLqmXZ+m7uS
 q+VKhdCdMXu4jA+BYYDv0PVuUi+q1CXOTzBNEbdmMosV7wLr42
 uH2U+6U61s8P8NQlYyqrYXxhm2wGT82iZiIjg22IOhj2jzMYbG
 wn3SAVwHPpACuMv/2tTgPzNBoafxBdcHE+EAEKEu5R5folL9lr
 dDlW/wjFEqw7JKdxBFa9PHc8D5So55UbYVKqHb86mkpAks8VIk
 2hN6NGz1o0CyywiEgt06attek4v3q2GO5U8yPz9ewcAAz+izMf
 ef9c8TIV1N06g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197432>

Hi,

It was pointed out about a year ago that displaying the git-specific ba=
sh
prompt on Windows/MinGW takes quite long, long enough to be noticeable.
And indeed, while in a subdirectory of a repository and stash indicator
enabled and my laptop running from battery I get this:

  $ time prompt=3D$(__git_ps1)

  real    0m0.412s
  user    0m0.048s
  sys     0m0.210s

This is mainly caused by the numerous fork()s and exec()s to create
subshells and run git commands, which are rather expensive on Windows.

This patch series eliminates many command substitutions and git command=
s
from __git_ps1() by reorganizing code or replacing them with bash
builtins.  This speeds up the prompt immensely: now I get the same prom=
pt
as above in about 10ms(!).  Timing results are shown in the log message=
 of
patch 19.

Unfortunately, to achive this users have to change their configuration,=
 in
particular change their $PS1 and $PROMPT_COMMAND (see patch 19) and sho=
uld
enable the discovery of git repositories across filesystem boundaries (=
see
patch 10).

There are two RFC patches in there (9 and 18), please have a look.


Here's an outline of the series:

=46irst, a couple of tests for the bash prompt, to lessen the chance th=
at I
break something ;)  These are basically the same patches that I sent ou=
t a
while ago in [1], the only noteworthy change is that I renamed the help=
er
library to lib-bash.sh (from lib-completion.sh), because all it does is=
 to
run tests under bash and there is nothing completion-specific in there.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/195587/focu=
s=3D195711

  [PATCH 01/19] tests: move code to run tests under bash into a helper =
library
  [PATCH 02/19] tests: add tests for the bash prompt functions in the c=
ompletion script

The next four patches contain a couple of fixes and cleanups:

  [PATCH 03/19] completion: use __gitdir() in _git_log()
  [PATCH 04/19] completion: respect $GIT_DIR
  [PATCH 05/19] bash prompt: don't show the prompt when .git/HEAD is un=
readable
  [PATCH 06/19] bash prompt: return early from __git_ps1() when not in =
a git repository

These four make __gitdir() faster, so they'll benefit not only the
bash prompt but completing refs, aliases, config variables, etc., too.

  [PATCH 07/19] completion: make __gitdir() store repository path in $_=
_git_dir
  [PATCH 08/19] completion: use $__git_dir instead of $(__gitdir)
  [RFC PATCH 09/19] completion: platform-specific helper function to ge=
t physical path
  [PATCH 10/19] completion: use bash builtins to search for repository

These three make the main codepath in __git_ps1() faster by eliminating=
 a
couple of command substitutions and git commands.

  [PATCH 11/19] bash prompt: use bash builtins to find out current bran=
ch
  [PATCH 12/19] bash prompt: use bash builtins to check whether inside =
git dir
  [PATCH 13/19] bash prompt: check whether inside the worktree only whe=
n necessary

Eliminate some more command substitutions and git commands that are not
necessarily run for every prompt:

  [PATCH 14/19] bash prompt: use bash builtins to find out current bran=
ch during rebase
  [PATCH 15/19] bash prompt: use bash builtins to get detached HEAD abb=
rev. object name
  [PATCH 16/19] bash prompt: display stash and upstream state even insi=
de the repository
  [PATCH 17/19] bash prompt: use bash builtins to check stash state
  [RFC PATCH 18/19] bash prompt: avoid command substitution when checki=
ng for untracked files

And finally get rid of the command substitution used to include the git
prompt in $PS1:

  [PATCH 19/19] bash prompt: alternative git prompt without command sub=
stitution

Enjoy.


Best,
G=C3=A1bor


SZEDER G=C3=A1bor (19):
  tests: move code to run tests under bash into a helper library
  tests: add tests for the bash prompt functions in the completion
    script
  completion: use __gitdir() in _git_log()
  completion: respect $GIT_DIR
  bash prompt: don't show the prompt when .git/HEAD is unreadable
  bash prompt: return early from __git_ps1() when not in a git
    repository
  completion: make __gitdir() store repository path in $__git_dir
  completion: use $__git_dir instead of $(__gitdir)
  completion: platform-specific helper function to get physical path
  completion: use bash builtins to search for repository
  bash prompt: use bash builtins to find out current branch
  bash prompt: use bash builtins to check whether inside git dir
  bash prompt: check whether inside the worktree only when necessary
  bash prompt: use bash builtins to find out current branch during
    rebase
  bash prompt: use bash builtins to get detached HEAD abbrev. object
    name
  bash prompt: display stash and upstream state even inside the
    repository
  bash prompt: use bash builtins to check stash state
  bash prompt: avoid command substitution when checking for untracked
    files
  bash prompt: alternative git prompt without command substitution

 contrib/completion/git-completion.bash | 315 ++++++++++-------
 t/lib-bash.sh                          |  18 +
 t/t9902-completion.sh                  |  14 +-
 t/t9903-bash-prompt.sh                 | 593 +++++++++++++++++++++++++=
++++++++
 4 files changed, 815 insertions(+), 125 deletions(-)
 create mode 100644 t/lib-bash.sh
 create mode 100755 t/t9903-bash-prompt.sh

--=20
1.7.10.1.541.gb1be298
