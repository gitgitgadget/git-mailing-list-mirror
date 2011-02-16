From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v3 2/2] mergetool: don't skip modify/remove conflicts
Date: Wed, 16 Feb 2011 05:47:45 -0500
Message-ID: <1297853265-18993-3-git-send-email-martin.von.zweigbergk@gmail.com>
References: <7vbp2dnjkt.fsf@alter.siamese.dyndns.org>
 <1297853265-18993-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 11:48:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpewH-0001vi-7X
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758894Ab1BPKsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 05:48:43 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42445 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067Ab1BPKsl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:48:41 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so1127592qwa.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 02:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Pgi4uTViRRmH+Z75QzE7bfA3KP8Sznwb7tkhsiHFxvI=;
        b=qwjNFQxpqhcXg0ECUhn75/1hpEDustyeiYwP/3V/D5ZbMqcPAVqV4IRaL97m11D0Ni
         0tRmRoNa2OBmAQe4MZj70WmFmZxKR/Cl/QsE86N8xNEKw4zJDWwFhqvxhM3tv139iq1P
         kTDk08/cod1evoGPfYex8GOOQQP06hnTv2SyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jA1V16hezufxzib/kmSU72Er7coLvs3/y1FDzGB3mb6X8v9VvLrQ2K/aND5LNyhBqG
         22F23nHhs+YTtsPEy3T85y0E9dFAkNw3mMyk1xO3IgR/BVxxkMKenOzZmhxZRA9LQONU
         Rj7xC+Ewl6Lntv326yzDHbQbyXY3XH3dLfIjw=
Received: by 10.224.53.200 with SMTP id n8mr520586qag.226.1297853321211;
        Wed, 16 Feb 2011 02:48:41 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id c8sm1339vcc.33.2011.02.16.02.48.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 02:48:40 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297853265-18993-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166956>

Since bb0a484 (mergetool: Skip autoresolved paths, 2010-08-17),
mergetool uses different ways of figuring out the list of files with
merge conflicts depending on whether rerere is active. If rerere is
active, mergetool will use 'git rerere status' to list the files with
remaining conflicts. However, the output from that command does not
list conflicts of types that rerere does not handle, such as
modify/remove conflicts.

Another problem with solely relying on the output from 'git rerere
status' is that, for new conflicts that are not yet known to rerere,
the output from the command will list the files even after adding them
to the index. This means that if the conflicts in some files have been
resolved and 'git mergetool' is run again, it will ask the user
something like the following for each of those files.

 file1: file does not need merging
 Continue merging other unresolved paths (y/n) ?

Solve both of these problems by replacing the call to 'git rerere
status' with a call to the new 'git rerere remaining' that was
introduced in the previous commit.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-mergetool.sh     |    2 +-
 t/t7610-mergetool.sh |   40 ++++++++++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 2f8dc44..bacbda2 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -269,7 +269,7 @@ rerere=false
 files_to_merge() {
     if test "$rerere" = true
     then
-	git rerere status
+	git rerere remaining
     else
 	git ls-files -u | sed -e 's/^[^	]*	//' | sort -u
     fi
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index d78bdec..dc838c9 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -16,23 +16,33 @@ Testing basic merge tool invocation'
 test_expect_success 'setup' '
     git config rerere.enabled true &&
     echo master >file1 &&
+    echo master file11 >file11 &&
+    echo master file12 >file12 &&
+    echo master file13 >file13 &&
+    echo master file14 >file14 &&
     mkdir subdir &&
     echo master sub >subdir/file3 &&
-    git add file1 subdir/file3 &&
-    git commit -m "added file1" &&
+    git add file1 file1[1-4] subdir/file3 &&
+    git commit -m "add initial versions" &&
 
     git checkout -b branch1 master &&
     echo branch1 change >file1 &&
     echo branch1 newfile >file2 &&
+    echo branch1 change file11 >file11 &&
+    echo branch1 change file13 >file13 &&
     echo branch1 sub >subdir/file3 &&
-    git add file1 file2 subdir/file3 &&
+    git add file1 file11 file13 file2 subdir/file3 &&
+    git rm file12 &&
     git commit -m "branch1 changes" &&
 
     git checkout master &&
     echo master updated >file1 &&
     echo master new >file2 &&
+    echo master updated file12 >file12 &&
+    echo master updated file14 >file14 &&
     echo master new sub >subdir/file3 &&
-    git add file1 file2 subdir/file3 &&
+    git add file1 file12 file14 file2 subdir/file3 &&
+    git rm file11 &&
     git commit -m "master updates" &&
 
     git config merge.tool mytool &&
@@ -46,6 +56,8 @@ test_expect_success 'custom mergetool' '
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
     test "$(cat file1)" = "master updated" &&
     test "$(cat file2)" = "master new" &&
     test "$(cat subdir/file3)" = "master new sub" &&
@@ -59,6 +71,8 @@ test_expect_success 'mergetool crlf' '
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
     test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
     test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
     test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
@@ -82,6 +96,8 @@ test_expect_success 'mergetool on file in parent dir' '
 	cd subdir &&
 	( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool ../file11 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool ../file12 >/dev/null 2>&1 ) &&
 	test "$(cat ../file1)" = "master updated" &&
 	test "$(cat ../file2)" = "master new" &&
 	git commit -m "branch1 resolved with mergetool - subdir"
@@ -92,6 +108,8 @@ test_expect_success 'mergetool skips autoresolved' '
     git checkout -b test4 branch1 &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
+    ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
     output="$(git mergetool --no-prompt)" &&
     test "$output" = "No files need merging" &&
     git reset --hard
@@ -102,13 +120,23 @@ test_expect_success 'mergetool merges all from subdir' '
 	cd subdir &&
 	git config rerere.enabled false &&
 	test_must_fail git merge master &&
-	git mergetool --no-prompt &&
+	( yes "d" "d" | git mergetool --no-prompt ) &&
 	test "$(cat ../file1)" = "master updated" &&
 	test "$(cat ../file2)" = "master new" &&
 	test "$(cat file3)" = "master new sub" &&
-	git add ../file1 ../file2 file3 &&
 	git commit -m "branch2 resolved by mergetool from subdir"
     )
 '
 
+test_expect_success 'mergetool skips resolved paths when rerere is active' '
+    git config rerere.enabled true &&
+    rm -rf .git/rr-cache &&
+    git checkout -b test5 branch1
+    test_must_fail git merge master >/dev/null 2>&1 &&
+    ( yes "d" "d" | git mergetool --no-prompt >/dev/null 2>&1 ) &&
+    output="$(yes "n" | git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging" &&
+    git reset --hard
+'
+
 test_done
-- 
1.7.4.rc2.33.g8a14f
