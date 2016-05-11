From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/3] perf: make the tests work in worktrees
Date: Wed, 11 May 2016 10:42:38 +0200 (CEST)
Message-ID: <d783290cabe601ee8623044482b2992fb7936534.1462955446.git.johannes.schindelin@gmx.de>
References: <cover.1462894344.git.johannes.schindelin@gmx.de> <cover.1462955446.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:44:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0PkU-00008M-9G
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbcEKIoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:44:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:56052 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbcEKIn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:43:59 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lbi2Z-1bSZpv0Kp1-00lIEp; Wed, 11 May 2016 10:43:48
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462955446.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:e9rjrXGFyHhhMaJEz1VwgGKU7JcnBkigcu+PD6n7UofYg75UUmy
 G56rDIAieS4JmepUTUl82NIkNLYZ9V5JEFJiHh7r5K8pEgjRNo+u2cB0a6LEiNIdWslxNFl
 FuArRQFUXyNeVey7evfbO+xlk2hHXwRfo8GRZXDcOOJZm9QqpmVP//Aaphtnp/LOhBqUAQv
 YjVpHLLMe1ak8lirYIc3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zpxy05/vBYo=:QrT+6zElbhlbUpjLMa3q3h
 qzP4g2up/HmOpzmXzIzc0kDh1FpNLhrE8boRJRIDC5lYmANuVvUQpfIyC9HpOFY+OYYhixfSQ
 I3T/FQRTCW/segWn/9tM7moiOh3m/iKk2ZglRw5/rnoUQ0TIirdC6/yt5qcNOIdbksUxyNZZf
 d4Jfvn0kxNO+9jv+As/EpacWToGQVNw/EiHLmMYFE08K3Z1FFZRG594Z8vqGUMuKXTZSXu/cd
 pt29a0zh9ieQsrl5b8nZLm4oa7ybGTxqjwdGSMSFjZZUtZCKg69/EIG9Myoi8+Zquw/5vO2gv
 8e9G04jgOxK40v7L3Yhk5kp9oV7GYGlpPtDhPmA+3mt8uQa2HYNeI1C2QBkJxtEj/SNn/InPE
 tq6rgvwrSsD7kU/gxkiabOTumC4tss8Dx2OZVbymZiXVkjqZOvlT3v9woAtjmDlurENkEx+hN
 JLSXnpA+3uEIUd9bf0H2BBmmZAaZBZ4ZhXkENGrCr3x/z1/HfmvPkNTPBX+Ji4Vcr+gIqzhd8
 8x2DpAFrTJH3wqd5f/8KrVXCzfQR79qqfuI5SpmNP+erYKrG/0mNvzSrZnhl1twTOfaBHL8iA
 /ZBfKIR0AqtOV/X7qfjiyR7LLUUhWhr/82jhW8ubDxf/Oxd9LTmk8ScraZRQG23jdq7CPofJe
 ccbdaVfzvT3weAsyaH5qF04lkNPcCOvDzXS5LJYmqD+0OO7/t2x00WL/Ou1F3PLBTCDHqAuln
 HURMS23qiqik98V7CeiF87tOhXqOA602oo5z7SEXkmR+1kA7Lm64dNpFyI6QffM1Io+AWbDV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294242>

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
index 50c8c39..cb88b08 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -80,22 +80,22 @@ test_perf_create_repo_from () {
 	error "bug in the test script: not 2 parameters to test-create-repo"
 	repo="$1"
 	source="$2"
-	source_git=$source/$(cd "$source" && git rev-parse --git-dir)
+	source_git="$(cd "$source" && git rev-parse --git-dir)"
+	objects_dir="$(cd "$source" && git rev-parse --git-path objects)"
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
 		git init -q && {
 			test_have_prereq SYMLINKS ||
-- 
2.8.2.465.gb077790
