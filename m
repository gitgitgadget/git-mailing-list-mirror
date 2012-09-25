From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool--lib: Allow custom commands to override built-ins
Date: Tue, 25 Sep 2012 00:48:11 -0700
Message-ID: <1348559291-71739-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Sylvain Rabot <srabot@steek.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	K Gateway <kowloongateway1@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Mike Schuld <mike.schuld@foundant.com>,
	Stefan Kendall <stefankendall@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 09:48:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGPsY-0006zF-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 09:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab2IYHsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 03:48:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57079 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab2IYHsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 03:48:16 -0400
Received: by pbbrr4 with SMTP id rr4so8623866pbb.19
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xMpvAo6r58BOBtCQSvNjM/7nJeVgcKi2BDQ714cnJes=;
        b=0v3TMJX2VVqPKrhSGck4Hp+bIa27UAK6+sQ3q8v9L58hUgmFVHpRQfP9UyrylNSkrF
         PT2vOaNHE+AZQ+8Te3Q4a7Zt2p99UHlNOEfckfobkiLWl0mJxDIGGrZw10LJDEy0LpEr
         96shhEnPGU1azp4Db7VP0fBR3rROmYQOWbh4RtwJipVi0FoDJS3FEPagWBL7L8pCrI6A
         gHgTQjXUvEjNX9Ya0LKX8uy0QLF1JsBSY9Iy7y4btUTY9Z7Z5lWWiSIqu13/+2RL6+9O
         9a3jQNubdGUYyDuNyzsFuj6zUSYJCu3KIM7Atxd78aSEoPuIJkv+Mend/Ws/tGCu6vEe
         UxZA==
Received: by 10.66.88.197 with SMTP id bi5mr26256391pab.58.1348559296191;
        Tue, 25 Sep 2012 00:48:16 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id kt2sm10941999pbc.73.2012.09.25.00.48.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Sep 2012 00:48:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.402.g0792a52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206355>

Allow users to override the default commands provided by the
mergetools/* scriptlets.

Users occasionally run into problems where they expect to be
able to override the built-in tool names.  The documentation
does not explicitly mention that built-ins cannot be overridden,
so it's easy to assume that it should work.

Lift this restriction so that built-in tools are handled the
same way as user-configured tools.  Add tests to guarantee this
behavior.

A nice benefit of this change is that it protects users from
having future versions of git trump their custom configuration
with a new built-in tool.

C.f.:

http://stackoverflow.com/questions/7435002/mergetool-from-gitconfig-being-ignored
http://thread.gmane.org/gmane.comp.version-control.msysgit/13188
http://thread.gmane.org/gmane.comp.version-control.git/148267

Signed-off-by: David Aguilar <davvid@gmail.com>
---
The Cc: list includes folks who were involved in the above threads.
Hopefully we can do without the workarounds now ;-)

 git-mergetool--lib.sh | 40 ++++++++++++++++++++++++++++++++++++++--
 mergetools/defaults   | 28 ++--------------------------
 t/t7610-mergetool.sh  | 13 +++++++++++++
 t/t7800-difftool.sh   | 11 +++++++++++
 4 files changed, 64 insertions(+), 28 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 54cb708..f013a03 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -104,13 +104,49 @@ run_merge_tool () {
 
 	if merge_mode
 	then
-		merge_cmd "$1"
+		run_merge_cmd "$1"
 	else
-		diff_cmd "$1"
+		run_diff_cmd "$1"
 	fi
 	return $status
 }
 
+# Run a either a configured or built-in diff tool
+run_diff_cmd () {
+	merge_tool_cmd="$(get_merge_tool_cmd "$1")"
+	if test -n "$merge_tool_cmd"
+	then
+		( eval $merge_tool_cmd )
+		status=$?
+		return $status
+	else
+		diff_cmd "$1"
+	fi
+}
+
+# Run a either a configured or built-in merge tool
+run_merge_cmd () {
+	merge_tool_cmd="$(get_merge_tool_cmd "$1")"
+	if test -n "$merge_tool_cmd"
+	then
+		trust_exit_code="$(git config --bool \
+			mergetool."$1".trustExitCode || echo false)"
+		if test "$trust_exit_code" = "false"
+		then
+			touch "$BACKUP"
+			( eval $merge_tool_cmd )
+			status=$?
+			check_unchanged
+		else
+			( eval $merge_tool_cmd )
+			status=$?
+		fi
+		return $status
+	else
+		merge_cmd "$1"
+	fi
+}
+
 list_merge_tool_candidates () {
 	if merge_mode
 	then
diff --git a/mergetools/defaults b/mergetools/defaults
index 1d8f2a3..21e63ec 100644
--- a/mergetools/defaults
+++ b/mergetools/defaults
@@ -8,36 +8,12 @@ can_diff () {
 }
 
 diff_cmd () {
-	merge_tool_cmd="$(get_merge_tool_cmd "$1")"
-	if test -z "$merge_tool_cmd"
-	then
-		status=1
-		break
-	fi
-	( eval $merge_tool_cmd )
-	status=$?
+	status=1
 	return $status
 }
 
 merge_cmd () {
-	merge_tool_cmd="$(get_merge_tool_cmd "$1")"
-	if test -z "$merge_tool_cmd"
-	then
-		status=1
-		break
-	fi
-	trust_exit_code="$(git config --bool \
-		mergetool."$1".trustExitCode || echo false)"
-	if test "$trust_exit_code" = "false"
-	then
-		touch "$BACKUP"
-		( eval $merge_tool_cmd )
-		status=$?
-		check_unchanged
-	else
-		( eval $merge_tool_cmd )
-		status=$?
-	fi
+	status=1
 	return $status
 }
 
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 6fa0c70..bc38737 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -509,4 +509,17 @@ test_expect_success 'file with no base' '
     git reset --hard master >/dev/null 2>&1
 '
 
+test_expect_success 'custom commands override built-ins' '
+    git checkout -b test14 branch1 &&
+    git config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
+    git config mergetool.defaults.trustExitCode true &&
+    test_must_fail git merge master &&
+    git mergetool --no-prompt --tool defaults -- both &&
+    echo master both added >expected &&
+    test_cmp both expected &&
+    git config --unset mergetool.defaults.cmd &&
+    git config --unset mergetool.defaults.trustExitCode &&
+    git reset --hard master >/dev/null 2>&1
+'
+
 test_done
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 9c3e997..eb1d3f8 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -76,6 +76,17 @@ test_expect_success PERL 'custom commands' '
 	test "$diff" = "branch"
 '
 
+# Ensures that a custom difftool.<tool>.cmd overrides built-ins
+test_expect_success PERL 'custom commands override built-ins' '
+	restore_test_defaults &&
+	git config difftool.defaults.cmd "cat \$REMOTE" &&
+
+	diff=$(git difftool --tool defaults --no-prompt branch) &&
+	test "$diff" = "master" &&
+
+	git config --unset difftool.defaults.cmd
+'
+
 # Ensures that git-difftool ignores bogus --tool values
 test_expect_success PERL 'difftool ignores bad --tool values' '
 	diff=$(git difftool --no-prompt --tool=bad-tool branch)
-- 
1.7.12.1.402.g28d36ee
