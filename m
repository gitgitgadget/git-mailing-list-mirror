From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/3] perf: make the tests work in worktrees
Date: Fri, 13 May 2016 15:25:58 +0200 (CEST)
Message-ID: <0f0bc7ac7b6eebed22b05c277cf7352122d164d2.1463145936.git.johannes.schindelin@gmx.de>
References: <cover.1462955446.git.johannes.schindelin@gmx.de> <cover.1463145936.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:26:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1D6a-0000Mt-D0
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 15:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbcEMN0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 09:26:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:56610 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbcEMN0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 09:26:05 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MSIf1-1bCSYI011f-00TU0c; Fri, 13 May 2016 15:25:57
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1463145936.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:2IlCyVE73FI7m9jZa0ME/eukAvm45ZQr3x0G1TQq0riytso2LXs
 tXYIKQn+F806NoSFxz52VLfTxcqiZ/tGZcDDZLe1mshPAvF08JBlpZTZiVU2lDFyP68dZOt
 3fE9Z0pyiNiy6j0vY4O3moTuwA/4KWqFE0p4dltNzcw+BL8+we3a6bbmeSyJDMUFpueqqdz
 hF2KiwRp63Hr2zPjVYEtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yra2EUKrCWQ=:BCuqB0BSKckwLk8uTyy6pP
 mNOh+5kNpJMRnpHQibFer2gFM8ILwhCPwUTVQWPUO6sSVIfqf4MHtyEN3bEgxWxji8irTwnkn
 ekS31zilcdry23+MoCnyLu01yEofeMlwbr8+pCnuK63aB1nFMW6vUtJ6EmARPzIKX0Wz6zZBG
 195vazMaGTsTYRt9XLWNjFF1pum1W0tXoVk/Uya7jsgeTkltuNPu5MfOE7LE/USSDWweYaq8U
 m7NwjfbVlzkGP/XojADZxqn/ub5fcVjeBbySEfpDw4ZXz//zmWZh+V7B5uRCuW4+LdxwTeEkR
 qoLls4IDurG862najSOQ9+ub32ANPfzFH8v5Sjqs5Yn6aT7xeTIeM+00v904+qDeq4GVY8zhD
 P3nQ/ukjatBI5NtoaCamLY8zkLCvkoaHaNJjbeDr8ACNypeyE6oPDRdWyGgK3uQWEHwY4fYMm
 5jjhou60USiv05rayupXL47Psrbb9sOvk8ghANEVYAU8JiHatA0OFIpCIY0uMk/eHvXBaiwmR
 n79Ul/TwZfjmbMXNKG+hnnzOPu7DxSmQF633INI65vkXJn5R9S59PbdX0jrHUfvoHut8vCCdF
 0rRelpZ/oQhkbcOevBjAkeH8jwQ/6Iioc63zTtgFCWCGK/rb+kWvHzZgi2aYfr/nw94LrSIKY
 Ma1994kgYndM6tAgS7EPw2uHvsqtklWyOR2K/IyjQPdtPk0WTGp9VuC8VzaGHZV+ClfJEG+In
 F/Lr0HZZ+5qHe9E6asYQM6QI+akjaH473bgxnQJYIntiUBv5EUqmCs2u3GXdCsyLfjmmEkQy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294534>

This patch makes perf-lib.sh more robust so that it can run correctly
even inside a worktree. For example, it assumed that $GIT_DIR/objects is
the objects directory (which is not the case for worktrees) and it used
the commondir file verbatim, even if it contained a relative path.

Furthermore, the setup code expected `git rev-parse --git-dir` to spit
out a relative path, which is also not true for worktrees. Let's just
change the code to accept both relative and absolute paths, by avoiding
the `cd` into the copied working directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/perf/perf-lib.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 9fa0706..5ef1744 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -80,22 +80,22 @@ test_perf_create_repo_from () {
 	error "bug in the test script: not 2 parameters to test-create-repo"
 	repo="$1"
 	source="$2"
-	source_git=$source/$(cd "$source" && git rev-parse --git-dir)
+	source_git="$(git -C "$source" rev-parse --git-dir)"
+	objects_dir="$(git -C "$source" rev-parse --git-path objects)"
 	mkdir -p "$repo/.git"
 	(
-		cd "$repo/.git" &&
-		{ cp -Rl "$source_git/objects" . 2>/dev/null ||
-			cp -R "$source_git/objects" .; } &&
+		{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
+			cp -R "$objects_dir" "$repo/.git/"; } &&
 		for stuff in "$source_git"/*; do
 			case "$stuff" in
-				*/objects|*/hooks|*/config)
+				*/objects|*/hooks|*/config|*/commondir)
 					;;
 				*)
-					cp -R "$stuff" . || exit 1
+					cp -R "$stuff" "$repo/.git/" || exit 1
 					;;
 			esac
 		done &&
-		cd .. &&
+		cd "$repo" &&
 		git init -q && {
 			test_have_prereq SYMLINKS ||
 			git config core.symlinks false
-- 
2.8.2.465.gb077790
