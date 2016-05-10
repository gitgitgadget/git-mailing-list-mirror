From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/3] perf: make the tests work in worktrees
Date: Tue, 10 May 2016 17:42:00 +0200 (CEST)
Message-ID: <63972edcda32c3c927e956f2e96d5b61843d64f2.1462894344.git.johannes.schindelin@gmx.de>
References: <cover.1462894344.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 17:42:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b09na-00071y-9W
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 17:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbcEJPmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 11:42:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:57980 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbcEJPmH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 11:42:07 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MQhyf-1bCe733BDp-00U6r0; Tue, 10 May 2016 17:42:00
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462894344.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:cwwkz3y1l9IpQyfaY9D8pU9yOXWxParl7WXMvVUwFbymO+UXfGb
 mKTEWbfqwmDRFBA+TcDwjTgzqdbFUdNUQrifW0xT50hMFqq/XdaYOTDIJSZTuk066wS+xvk
 QhmXvE/Tyecw3mLuEf8rmBmSq4Gb2Mn3/U8r3Ovd6tS94O3ajvPWnZUhiv36EcOatnFrQl2
 TDxhRnR4govbQwcAzFp1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TQyNajw2BY8=:CnN+ciTw63ZTqy3k5OcmeY
 tg7LRLjlJyMoiJMqbzjB6W2C9i45MQvXSlUAw7FSkkD672BISdb77B7wOgeqQJkCG3a27zmsx
 PnEcgOFonKqEwUxhQAH8l6otKRWRucaY1+94OJVJnHUPmGtVvGIEdVZpL+0NvGHu4rRM9q1xZ
 cR7prWWMizZnqs6hh9obLmhFHigU9qxd8fz3m69zTy4SlEs0hSKo4Eh6ZAAm+WdJz+GioNdsr
 O9gzBd1XSDFT9aVpa/nxYb20GRukZoKlutIWcyVE7AzxLhPxR0R/gfnsQ/n2kFdsL/9ZU5Y70
 HaG2SPp6LslYIHft6MAG1EnlUjgFl4kh6o55Ez+VztVab7YR4MaCYwFu2vhrYkbueEFLwZLiE
 WyvkUZzxEtyxThjEJabyU5ynOfVXV+SfWNpV0467+rNHt3FzFW1Ez6I/Bf9eERU9+ydtLIKPa
 DQLmcxh14f6xhIXQKD5B/PA7wDYh0UVbYRz8Sv8AsTIMQ4E+K89Z5zMBSPcp1NcCmyoi7j31e
 aFNmLwQvyp9cJ9rcVsdMB9UNbcxSVo8GkqkWa4o984D9a/KX2lO+XCRR9CNkDxA4zn17LUUiz
 Kit2oqXV7GK4uFf5knyEJkRcKtHu5GFTWOY0thqZ+Tb+xssEfN1yHY8DTkUinL6+6CECUj040
 Cnh9fjobRVNFw+EYFx8//1Fx5GNqDEw4z5ADtuBiWnIq/SG/019Xb+WR8nldLMgpgQdMi5ITi
 tfjZgENQ5HWGzUWfIwAi4QlyzZtGtsAvIMTwUjaeiKFYBEzKN9DIgHv4HijATXKcyypBNZ4G 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294150>

This patch makes perf-lib.sh more robust so that it can run correctly
even inside a worktree. For example, it assumed that $GIT_DIR/objects is
the objects directory (which is not the case for worktrees) and it used
the commondir file verbatim, even if it contained a relative path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/perf/perf-lib.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index e9020d0..e5682f7 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -80,22 +80,22 @@ test_perf_create_repo_from () {
 	error "bug in the test script: not 2 parameters to test-create-repo"
 	repo="$1"
 	source="$2"
-	source_git=$source/$(cd "$source" && git rev-parse --git-dir)
+	source_git="$(cd "$source" && git rev-parse --git-dir)"
+	objects_dir="$(git rev-parse --git-path objects)"
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
 		git init -q &&
 		if test_have_prereq MINGW
 		then
-- 
2.8.2.465.gb077790
