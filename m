From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 11/16] bash prompt: combine 'git rev-parse' for detached head
Date: Mon, 24 Jun 2013 18:39:21 +0200
Message-ID: <1372091966-19315-12-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:44:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9sg-0003v5-Ks
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab3FXQoi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:44:38 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:50909 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab3FXQoi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:44:38 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0M940H-1Uz6Lz0Gar-00CAL2; Mon, 24 Jun 2013 18:44:30 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:yt2uztZF8MDFEO9PUW/W+ki65+p5inejnz9oqS/a30T
 PTki6D0H78TgEDEN/5hnEPc/AkHcn2Cps/ocA2hYGzleFGFZEi
 yN1v/agP1Mljo3G8D+sVX8sv/vlpvM0V4b617QndfvOBcJCp1A
 YvoR7RH1F5sUlm20g81GGM4GCOygq9R4QTeJOYjjopdMFeIqTa
 6/iC5QCqHfpI/TYnmuv7noPYKwb8OoLcj4Oe5mZoyXjTz8JqQA
 2vzD5jxqlxiA3p+GSK5UDC7MH+R9JdG1+UUkdROThqJ01t5MEX
 aRDqMrdmHX6TjucKHniEiTAFClhunaQVkZ3zhravqDxBjwQN8W
 UF5rMYxQ8XQZWUxpG1zLsRagpA8tlY/TlCETcYygxkv85QkL1e
 nb4G7DJU+j+cA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228863>

When describing a detached HEAD according to the $GIT_PS1_DESCRIBE
environment variable fails, __git_ps1() now runs the '$(git rev-parse
--short HEAD)' command substitution to get the abbreviated detached
HEAD commit object name.  This imposes the overhead of fork()ing a
subshell and fork()+exec()ing a git process.

Avoid this overhead by combining this command substitution with the
"main" 'git rev-parse' execution for getting the path to the .git
directory & co.  This means that we'll look for the abbreviated commit
object name even when it's not necessary, because we're on a branch or
the detached HEAD can be described.  It doesn't matter, however,
because once 'git rev-parse' is up and running to fulfill all those
other queries, the additional overhead of looking for the abbreviated
commit object name is not measurable because it's lost in the noise.

There is a caveat, however, when we are on an unborn branch, because
in that case HEAD doesn't point to a valid commit, hence the query for
the abbreviated commit object name fails.  Therefore, '--short HEAD'
must be the last options to 'git rev-parse' in order to get all the
other necessary information for the prompt even on an unborn branch.
=46urthermore, in that case, and in that case only, 'git rev-parse'
doesn't output the last line containing the abbreviated commit object
name, obviously, so we have to take care to only parse it if 'git
rev-parse' exited without any error.

Although there are tests already excercising __git_ps1() on unborn
branches, they all do so implicitly.  Add a test that checks this
explicitly.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 16 ++++++++++++----
 t/t9903-bash-prompt.sh           |  8 ++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 7d226251..88d6121d 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -311,8 +311,12 @@ __git_ps1 ()
 		;;
 	esac
=20
-	local repo_info=3D"$(git rev-parse --git-dir --is-inside-git-dir \
-		--is-bare-repository --is-inside-work-tree 2>/dev/null)"
+	local repo_info rev_parse_exit_code
+	repo_info=3D"$(git rev-parse --git-dir --is-inside-git-dir \
+		--is-bare-repository --is-inside-work-tree \
+		--short HEAD 2>/dev/null)"
+	rev_parse_exit_code=3D"$?"
+
 	if [ -z "$repo_info" ]; then
 		if [ $pcmode =3D yes ]; then
 			#In PC mode PS1 always needs to be set
@@ -321,6 +325,11 @@ __git_ps1 ()
 		return
 	fi
=20
+	local short_sha
+	if [ "$rev_parse_exit_code" =3D "0" ]; then
+		short_sha=3D"${repo_info##*$'\n'}"
+		repo_info=3D"${repo_info%$'\n'*}"
+	fi
 	local inside_worktree=3D"${repo_info##*$'\n'}"
 	repo_info=3D"${repo_info%$'\n'*}"
 	local bare_repo=3D"${repo_info##*$'\n'}"
@@ -392,8 +401,7 @@ __git_ps1 ()
 					git describe --tags --exact-match HEAD ;;
 				esac 2>/dev/null)" ||
=20
-				b=3D"$(git rev-parse --short HEAD 2>/dev/null)..." ||
-				b=3D"unknown"
+				b=3D"$short_sha..."
 				b=3D"($b)"
 			fi
 		fi
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 0d53aa6d..b9895c79 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -49,6 +49,14 @@ test_expect_success SYMLINKS 'prompt - branch name -=
 symlink symref' '
 	test_cmp expected "$actual"
 '
=20
+test_expect_success 'prompt - unborn branch' '
+	printf " (unborn)" >expected &&
+	git checkout --orphan unborn &&
+	test_when_finished "git checkout master" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success 'prompt - detached head' '
 	printf " ((%s...))" $(git log -1 --format=3D"%h" --abbrev=3D13 b1^) >=
expected &&
 	test_config core.abbrev 13 &&
--=20
1.8.3.1.599.g4459181
