From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool: Skip autoresolved paths
Date: Tue, 17 Aug 2010 02:22:46 -0700
Message-ID: <1282036966-26799-1-git-send-email-davvid@gmail.com>
References: <7veie0gy3r.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Magnus=20B=C3=A4ck?= <magnus.back@sonyericsson.com>,
	Charles Bailey <charles@hashpling.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 11:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlIHC-00063T-NA
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 11:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab0HQJQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 05:16:04 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53824 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab0HQJQD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 05:16:03 -0400
Received: by pzk26 with SMTP id 26so2271662pzk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0KFjrmbWNLgJKvAv7Ite9Xm1oLrv/s4S6V/JJ1mltDo=;
        b=EPN0GyEp0vOmSkWwc/FxI4jfE4E4cGgaOPHuGOlG/4lR9una0WDBjAmFhy+FN4QSal
         u1BQc3cSMtq6LQiPLUxqqR2xL9qN8QXQCoMKh37BUCH5Hi4H1ot06Q4Up7RSdMySA0Va
         +5aWGCRQcpL+CIRvYg33KwLDlVwC/HiO5yzy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ac36oDtyRVOxvRlRZcu6oZQ8VDo5tJ5PmJ/243di7mHy1ZJAEL/1MqqB1+2IaxWIkC
         es8pxR9SK4C2D6ggy3EshzqwGtIeL82wKtAWB5SemtsSQrgGuy+dxKQUzeSQNhNHrgxe
         o9RhtnrEBLW4qhN4bWjNVn2eP3mbCe8ByvpFY=
Received: by 10.142.131.21 with SMTP id e21mr5624712wfd.88.1282036561565;
        Tue, 17 Aug 2010 02:16:01 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id t11sm9459959wfc.16.2010.08.17.02.15.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 02:15:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.98.gd9365.dirty
In-Reply-To: <7veie0gy3r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153734>

When mergetool is run without path limiters it loops
over each entry in 'git ls-files -u'.  This includes
autoresolved paths.

Teach mergetool to only merge files listed in 'rerere status'
when rerere is enabled.

There are some subtle but harmless changes in behavior.
We now call cd_to_toplevel when no paths are given.
We do this because 'rerere status' paths are always relative
to the root.  This is beneficial for the non-rerere use as
well in that mergetool now runs against all unmerged files
regardless of the current directory.

This also slightly tweaks the output when run without paths
to be more readable.

The old output:

Merging the files: foo
bar
baz

The new output:

Merging:
foo
bar
baz

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh     |   28 +++++++++++++++++++++++-----
 t/t7610-mergetool.sh |   46 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index b52a741..bd7ab02 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -264,17 +264,35 @@ merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo fa
 
 last_status=0
 rollup_status=0
+rerere=false
+
+files_to_merge() {
+    if test "$rerere" = true
+    then
+	git rerere status
+    else
+	git ls-files -u | sed -e 's/^[^	]*	//' | sort -u
+    fi
+}
+
 
 if test $# -eq 0 ; then
-    files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
+    cd_to_toplevel
+
+    if test -e "$GIT_DIR/MERGE_RR"
+    then
+	rerere=true
+    fi
+
+    files=$(files_to_merge)
     if test -z "$files" ; then
 	echo "No files need merging"
 	exit 0
     fi
-    echo Merging the files: "$files"
-    git ls-files -u |
-    sed -e 's/^[^	]*	//' |
-    sort -u |
+    printf "Merging:\n"
+    printf "$files\n"
+
+    files_to_merge |
     while IFS= read i
     do
 	if test $last_status -ne 0; then
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index e768c3e..f5a7bf4 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -14,6 +14,7 @@ Testing basic merge tool invocation'
 # running mergetool
 
 test_expect_success 'setup' '
+    git config rerere.enabled true &&
     echo master >file1 &&
     mkdir subdir &&
     echo master sub >subdir/file3 &&
@@ -71,19 +72,40 @@ test_expect_success 'mergetool in subdir' '
     cd subdir && (
     test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
-    test "$(cat file3)" = "master new sub" )
+    test "$(cat file3)" = "master new sub") &&
+    cd ..
 '
 
-# We can't merge files from parent directories when running mergetool
-# from a subdir. Is this a bug?
-#
-#test_expect_failure 'mergetool in subdir' '
-#    cd subdir && (
-#    ( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
-#    ( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
-#    test "$(cat ../file1)" = "master updated" &&
-#    test "$(cat ../file2)" = "master new" &&
-#    git commit -m "branch1 resolved with mergetool - subdir" )
-#'
+test_expect_success 'mergetool on file in parent dir' '
+    cd subdir && (
+    ( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
+    test "$(cat ../file1)" = "master updated" &&
+    test "$(cat ../file2)" = "master new" &&
+    git commit -m "branch1 resolved with mergetool - subdir") &&
+    cd ..
+'
+
+test_expect_success 'mergetool skips autoresolved' '
+    git checkout -b test4 branch1 &&
+    test_must_fail git merge master &&
+    test -n "$(git ls-files -u)" &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging" &&
+    git reset --hard
+'
+
+test_expect_success 'mergetool merges all from subdir' '
+    cd subdir && (
+    git config rerere.enabled false &&
+    test_must_fail git merge master &&
+    git mergetool --no-prompt &&
+    test "$(cat ../file1)" = "master updated" &&
+    test "$(cat ../file2)" = "master new" &&
+    test "$(cat file3)" = "master new sub" &&
+    git add ../file1 ../file2 file3 &&
+    git commit -m "branch2 resolved by mergetool from subdir") &&
+    cd ..
+'
 
 test_done
-- 
1.7.2.1.98.gd9365.dirty
