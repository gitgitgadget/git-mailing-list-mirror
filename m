From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3] mergetool: Provide an empty file when needed
Date: Thu, 19 Jan 2012 23:37:18 -0800
Message-ID: <1327045038-91710-1-git-send-email-davvid@gmail.com>
References: <7v7h0mhm8g.fsf@alter.siamese.dyndns.org>
Cc: jcwenger@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 20 08:37:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro92S-0001sC-Sh
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab2ATHh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 02:37:28 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:56313 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751743Ab2ATHh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 02:37:28 -0500
Received: by obcva7 with SMTP id va7so354193obc.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 23:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ptb3mJGyAhPQIlQ/EyeDOahsB+QrqEnH3NJPFFJwmkY=;
        b=BSssTzK5l09iGdibvTWWsacB1HbqBkWcHjbyqtE6T66TgR5vHdTzF3uk0NTz/UUax3
         vwoX4dK5L4lDOu+9HDREjJgWGyctJjQSsvtmx7Xo/rsCXWPFDiogerUp/6H54qSZ5/KL
         hwOe7CnF46l5/10jb6/mm3LFHmQK8KZKFnuOE=
Received: by 10.50.157.229 with SMTP id wp5mr31787741igb.22.1327045047289;
        Thu, 19 Jan 2012 23:37:27 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id gh7sm3431046igb.1.2012.01.19.23.37.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jan 2012 23:37:26 -0800 (PST)
X-Mailer: git-send-email 1.7.9.rc2.1.g1c18
In-Reply-To: <7v7h0mhm8g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188865>

Some merge tools cannot cope when $LOCAL, $BASE, or $REMOTE
are missing.  $BASE can be missing when two branches
independently add the same filename.  $LOCAL and $REMOTE
can be missing when a delete/modify conflict occurs.

Provide an empty file to make these tools happy.

Reported-by: Jason Wenger <jcwenger@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh     |   20 +++++++++++++++++---
 t/t7610-mergetool.sh |   27 ++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 085e213..8cd70eb 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -224,9 +224,23 @@ merge_file () {
     mv -- "$MERGED" "$BACKUP"
     cp -- "$BACKUP" "$MERGED"
 
-    base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
-    local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
-    remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"
+    if base_present; then
+	checkout_staged_file 1 "$MERGED" "$BASE"
+    else
+	>"$BASE"
+    fi
+
+    if local_present; then
+	checkout_staged_file 2 "$MERGED" "$LOCAL"
+    else
+	>"$LOCAL"
+    fi
+
+    if remote_present; then
+	checkout_staged_file 3 "$MERGED" "$REMOTE"
+    else
+	>"$REMOTE"
+    fi
 
     if test -z "$local_mode" -o -z "$remote_mode"; then
 	echo "Deleted merge conflict for '$MERGED':"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 4aab2a7..2272743 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -39,6 +39,7 @@ test_expect_success 'setup' '
     echo branch1 change >file1 &&
     echo branch1 newfile >file2 &&
     echo branch1 spaced >"spaced name" &&
+    echo branch1 both added > both &&
     echo branch1 change file11 >file11 &&
     echo branch1 change file13 >file13 &&
     echo branch1 sub >subdir/file3 &&
@@ -50,6 +51,7 @@ test_expect_success 'setup' '
 	git checkout -b submod-branch1
     ) &&
     git add file1 "spaced name" file11 file13 file2 subdir/file3 submod &&
+    git add both &&
     git rm file12 &&
     git commit -m "branch1 changes" &&
 
@@ -58,6 +60,7 @@ test_expect_success 'setup' '
     echo master updated >file1 &&
     echo master new >file2 &&
     echo master updated spaced >"spaced name" &&
+    echo master both added > both &&
     echo master updated file12 >file12 &&
     echo master updated file14 >file14 &&
     echo master new sub >subdir/file3 &&
@@ -69,18 +72,22 @@ test_expect_success 'setup' '
 	git checkout -b submod-master
     ) &&
     git add file1 "spaced name" file12 file14 file2 subdir/file3 submod &&
+    git add both &&
     git rm file11 &&
     git commit -m "master updates" &&
 
     git config merge.tool mytool &&
     git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
-    git config mergetool.mytool.trustExitCode true
+    git config mergetool.mytool.trustExitCode true &&
+    git config mergetool.mybase.cmd "cat \"\$BASE\" >\"\$MERGED\"" &&
+    git config mergetool.mybase.trustExitCode true
 '
 
 test_expect_success 'custom mergetool' '
     git checkout -b test1 branch1 &&
     git submodule update -N &&
     test_must_fail git merge master >/dev/null 2>&1 &&
+    ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file1 file1 ) &&
     ( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
@@ -101,6 +108,7 @@ test_expect_success 'mergetool crlf' '
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool "spaced name" >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
@@ -131,6 +139,7 @@ test_expect_success 'mergetool on file in parent dir' '
 	cd subdir &&
 	( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool ../file2 ../spaced\ name >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool ../both >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool ../file11 >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool ../file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool ../submod >/dev/null 2>&1 ) &&
@@ -212,6 +221,7 @@ test_expect_success 'deleted vs modified submodule' '
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
     ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     rmdir submod && mv submod-movedaside submod &&
@@ -228,6 +238,7 @@ test_expect_success 'deleted vs modified submodule' '
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
     ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     test ! -e submod &&
@@ -241,6 +252,7 @@ test_expect_success 'deleted vs modified submodule' '
     test_must_fail git merge test6 &&
     test -n "$(git ls-files -u)" &&
     ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     test ! -e submod &&
@@ -256,6 +268,7 @@ test_expect_success 'deleted vs modified submodule' '
     test_must_fail git merge test6 &&
     test -n "$(git ls-files -u)" &&
     ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     test "$(cat submod/bar)" = "master submodule" &&
@@ -279,6 +292,7 @@ test_expect_success 'file vs modified submodule' '
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
     ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     rmdir submod && mv submod-movedaside submod &&
@@ -294,6 +308,7 @@ test_expect_success 'file vs modified submodule' '
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
     ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     git submodule update -N &&
@@ -309,6 +324,7 @@ test_expect_success 'file vs modified submodule' '
     test_must_fail git merge test7 &&
     test -n "$(git ls-files -u)" &&
     ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     test -d submod.orig &&
@@ -324,6 +340,7 @@ test_expect_success 'file vs modified submodule' '
     test_must_fail git merge test7 &&
     test -n "$(git ls-files -u)" &&
     ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool both>/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     test "$(cat submod/bar)" = "master submodule" &&
@@ -445,4 +462,12 @@ test_expect_success 'directory vs modified submodule' '
     git submodule update -N
 '
 
+test_expect_success 'file with no base' '
+    git checkout -b test13 branch1 &&
+    test_must_fail git merge master &&
+    git mergetool --no-prompt --tool mybase -- base &&
+    test "$(cat "$MERGED")" = "" &&
+    git reset --hard master >/dev/null 2>&1
+'
+
 test_done
-- 
1.7.9.rc2.1.g1c18
