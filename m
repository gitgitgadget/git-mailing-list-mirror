From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 00/13] bash prompt speedup
Date: Tue, 18 Jun 2013 04:16:53 +0200
Message-ID: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:17:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolU6-0004tl-TE
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab3FRCRX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:17:23 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:63074 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab3FRCRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:17:22 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MH3DS-1Ub45b0oMM-00DKrl; Tue, 18 Jun 2013 04:17:21 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
X-Provags-ID: V02:K0:AuMJoh0uDQ+uspz/+yCrOWaW9VgLdIDI2Sdl0ubFfa1
 ePXj/hpUqMwPFRzKeNWd9BoHIibnsyRAp7ZoLvRu7k/UXvaoQQ
 52YVRmv7r1gh15P5r8mJvK3IiVT08EDiIn8vNo5OuTkn+cublX
 BdUHRbxmPHfPSUDNLaE54bVkLH8Amc8vVdHaiPKDz3DBUePfUT
 eVfkK/yDEca8v/WB20PzO/S6F/3GrtenYGVhuuE9HHqElOvRyZ
 kXXe+xhBkLUEyAcfSqp8kJtbbJOimJwDk5kO7R1P4cW+utyykM
 EyRDN3vbnHvyhr/n2URYxYupxMxjiSK9nVuQKK2JdJPP4jlmvQ
 6VcemHxInyD377eYQf2FcmqT4JW6Zn1Gk1cmzgGrluFKa9HhA5
 cQZQ0eDDjHypQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228132>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Hi,

displaying the git-specific bash prompt on Windows/MinGW takes quite
long, long enough to be noticeable.  This is mainly caused by the
numerous fork()s and exec()s to create subshells and run git or other
commands, which are rather expensive on Windows.

This patch series eliminates many command substitutions and commands
in __git_ps1() from top to bottom by replacing them with bash builtins
or consolidating them.  A few timing results are shown in the log
message of patch 10.


SZEDER G=C3=A1bor (13):
  bash prompt: fix redirection coding style in tests
  bash prompt: fix here document indentation in interactive rebase test
  completion, bash prompt: move __gitdir() tests to completion test
    suite
  bash prompt: add a test for symbolic link symbolic refs
  bash prompt: return early from __git_ps1() when not in a git
    repository
  bash prompt: run 'git rev-parse --git-dir' directly instead of
    __gitdir()
  bash prompt: use bash builtins to find out rebase state
  bash prompt: use bash builtins to find out current branch
  bash prompt: use bash builtins to get detached HEAD abbrev. object
    name
  bash prompt: combine 'git rev-parse' executions
  bash prompt: use bash builtins to check stash state
  bash prompt: avoid command substitution when checking for untracked
    files
  bash prompt: avoid command substitution when finalizing gitstring

 contrib/completion/git-completion.bash |   2 -
 contrib/completion/git-prompt.sh       | 223 ++++++++++++-----------
 t/t9902-completion.sh                  | 134 ++++++++++++++
 t/t9903-bash-prompt.sh                 | 319 +++++++++++--------------=
--------
 4 files changed, 345 insertions(+), 333 deletions(-)

--=20
1.8.3.1.487.g8f4672d
