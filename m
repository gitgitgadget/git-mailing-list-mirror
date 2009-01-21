From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] mergetool: respect autocrlf by using checkout-index
Date: Wed, 21 Jan 2009 22:57:48 +0000
Message-ID: <1232578668-2203-1-git-send-email-charles@hashpling.org>
References: <20090121210348.GD9088@mit.edu>
Cc: Hannu Koivisto <azure@iki.fi>, Theodore Tso <tytso@mit.edu>,
	Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 23:59:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPm2e-0002xq-Rd
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbZAUW55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbZAUW55
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:57:57 -0500
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:1353 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753940AbZAUW54 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 17:57:56 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAJbhdknUnw4U/2dsb2JhbADNcIVz
Received: from pih-relay08.plus.net ([212.159.14.20])
  by relay.pcl-ipout02.plus.net with ESMTP; 21 Jan 2009 22:57:54 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1LPm1C-0007gk-Ad; Wed, 21 Jan 2009 22:57:54 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0LMvmxi002231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Jan 2009 22:57:48 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0LMvmHX002230;
	Wed, 21 Jan 2009 22:57:48 GMT
X-Mailer: git-send-email 1.6.1.235.gc9d403
In-Reply-To: <20090121210348.GD9088@mit.edu>
X-Plusnet-Relay: 26e6080e14d90f4bb8593fa23cd4e153
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106697>

Previously, git mergetool used cat-file which does not perform git to
worktree conversion. This changes mergetool to use git checkout-index
instead which means that the temporary files used for mergetool use the
correct line endings for the platform.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 git-mergetool.sh     |   14 +++++++++++---
 t/t7610-mergetool.sh |   15 +++++++++++++--
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 00e1337..a4855d9 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -127,6 +127,14 @@ check_unchanged () {
     fi
 }
 
+checkout_staged_file () {
+    tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
+
+    if test $? -eq 0 -a -n "$tmpfile" ; then
+	mv -- "$tmpfile" "$3"
+    fi
+}
+
 merge_file () {
     MERGED="$1"
 
@@ -153,9 +161,9 @@ merge_file () {
     local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
     remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
 
-    base_present   && git cat-file blob ":1:$prefix$MERGED" >"$BASE" 2>/dev/null
-    local_present  && git cat-file blob ":2:$prefix$MERGED" >"$LOCAL" 2>/dev/null
-    remote_present && git cat-file blob ":3:$prefix$MERGED" >"$REMOTE" 2>/dev/null
+    base_present   && checkout_staged_file 1 "$prefix$MERGED" "$BASE"
+    local_present  && checkout_staged_file 2 "$prefix$MERGED" "$LOCAL"
+    remote_present && checkout_staged_file 3 "$prefix$MERGED" "$REMOTE"
 
     if test -z "$local_mode" -o -z "$remote_mode"; then
 	echo "Deleted merge conflict for '$MERGED':"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 09fa5f1..edb6a57 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -34,13 +34,24 @@ test_expect_success 'custom mergetool' '
     git config merge.tool mytool &&
     git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
     git config mergetool.mytool.trustExitCode true &&
-	git checkout branch1 &&
+    git checkout branch1 &&
     test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file1>/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2>/dev/null 2>&1 ) &&
     test "$(cat file1)" = "master updated" &&
     test "$(cat file2)" = "master new" &&
-	git commit -m "branch1 resolved with mergetool"
+    git commit -m "branch1 resolved with mergetool"
+'
+
+test_expect_success 'mergetool crlf' '
+    git config core.autocrlf true &&
+    git reset --hard HEAD^
+    test_must_fail git merge master >/dev/null 2>&1 &&
+    ( yes "" | git mergetool file1>/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file2>/dev/null 2>&1 ) &&
+    test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
+    test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
+    git commit -m "branch1 resolved with mergetool - autocrlf"
 '
 
 test_done
-- 
1.6.1.235.gc9d403
