From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 00/16] bash prompt speedup
Date: Mon, 24 Jun 2013 18:39:10 +0200
Message-ID: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:42:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9qU-00024C-8u
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab3FXQmU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:42:20 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:54710 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab3FXQmS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:42:18 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0LywZI-1UDZoP1et6-014FIU; Mon, 24 Jun 2013 18:42:17 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
X-Provags-ID: V02:K0:69aawcpvzCwt2nFNFbkJAgQPgQgAM3RbskOxOAAZEX5
 k2VQgqT252gg04nbLShQTT0i3b5lYrFrqDqnC3nDjvlHiRE0pa
 qF5ZEKEbEVGUnJZGNL7hY7Xhb5YICTj1fyfpEnG8FxazFV1d+L
 BAl/Js/09zep58ZCEJrIg3XKm4ivYFt3neXAAlPV3EI5NhOBKN
 vHp63K5cSLvHk0YRvD7yjjtSj6bquf2AO2vrUljJ8X7rfK2/Ke
 BivvnPgS4ZSYDkWbMuSfwWQuPz709+jGUjxg6OnuyaKiJFOJyw
 C9nNl5Wnl22ou1/TzruqJUXAeItjY7F7xeUbItoL3+35YaLOyq
 hUt/pNwo1M2jCELupuAfViNj6gyGF2AHhWc0/1oiJGx9n+TVGg
 nKyDPkFahGt6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228851>

Hi,

displaying the git-specific bash prompt on Windows/MinGW takes quite
long, long enough to be noticeable.  This is mainly caused by the
numerous fork()s and exec()s to create subshells and run git or other
commands, which are rather expensive on Windows.

This patch series eliminates many command substitutions and command
executions in __git_ps1() from top to bottom by replacing them with
bash builtins or consolidating them.  A few timing results are shown
in the log message of the last patch.

Changes since v2 [1]:

 - The detached HEAD abbreviated object name is now unique and
   respects core.abbrev; see patches 5 and 11, replacing v2's patch 9.
   (This is why I asked the detached HEAD before root commit thing
   yesterday.) =20
 - Patches 12 and 16 are new.
 - Incorporated Peff's suggestion about using the 'write_script'
   helper into patch 2.
 - Incorporated Eric's typofix.
 - Rephrased a few commit messages.

It applies on top of current master; 2847cae8 (prompt: squelch error
output from cat, 2013-06-14) graduated recently.

This patch series will conflict with Eduardo's work on refactoring the
colorizing function, and the conflict is not trivial.  Although there
are still some open questions left with that series (using tput, zsh
tests), those won't affect the conflicts between the two patch series.
So, for the convenience of our maintainer, I picked up Eduardo's
series, took the liberty to apply a fixup commit on top with my
suggestions from [2], merged the two series, and published the result
at:

  https://github.com/szeder/git.git bash-prompt-speedup-and-color-refac=
torization

Eduardo, could you please also check that my conflict resolution is
correct?  Thanks.


Best,
G=C3=A1bor


[1] - http://thread.gmane.org/gmane.comp.version-control.git/228132
[2] - http://article.gmane.org/gmane.comp.version-control.git/228707


SZEDER G=C3=A1bor (16):
  bash prompt: fix redirection coding style in tests
  bash prompt: use 'write_script' helper in interactive rebase test
  completion, bash prompt: move __gitdir() tests to completion test
    suite
  bash prompt: add a test for symbolic link symbolic refs
  bash prompt: print unique detached HEAD abbreviated object name
  bash prompt: return early from __git_ps1() when not in a git
    repository
  bash prompt: run 'git rev-parse --git-dir' directly instead of
    __gitdir()
  bash prompt: use bash builtins to find out rebase state
  bash prompt: use bash builtins to find out current branch
  bash prompt: combine 'git rev-parse' executions in the main code path
  bash prompt: combine 'git rev-parse' for detached head
  bash prompt: use bash builtins to check for unborn branch for dirty
    state
  bash prompt: use bash builtins to check stash state
  bash prompt: avoid command substitution when checking for untracked
    files
  bash prompt: avoid command substitution when finalizing gitstring
  bash prompt: mention that PROMPT_COMMAND mode is faster

 contrib/completion/git-completion.bash |   2 -
 contrib/completion/git-prompt.sh       | 241 ++++++++++++------------
 t/t9902-completion.sh                  | 134 ++++++++++++++
 t/t9903-bash-prompt.sh                 | 323 +++++++++++--------------=
--------
 4 files changed, 367 insertions(+), 333 deletions(-)

--=20
1.8.3.1.599.g4459181
