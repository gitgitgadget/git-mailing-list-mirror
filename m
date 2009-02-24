From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Test refactor
Date: Tue, 24 Feb 2009 23:01:55 +0000
Message-ID: <1235516515-3996-1-git-send-email-charles@hashpling.org>
References: <1235516466-3930-1-git-send-email-charles@hashpling.org>
Cc: Caleb Cushing <xenoterracide@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 00:03:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc6JE-0003Va-HM
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 00:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759869AbZBXXCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 18:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759113AbZBXXCA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 18:02:00 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:25721 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757376AbZBXXB7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 18:01:59 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAHQLpEnUnw6U/2dsb2JhbADYM4QRBg
Received: from fhw-relay07.plus.net ([212.159.14.148])
  by relay.ptn-ipout02.plus.net with ESMTP; 24 Feb 2009 23:01:56 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1Lc6Hk-0007He-6Y; Tue, 24 Feb 2009 23:01:56 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n1ON1tH3004026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Feb 2009 23:01:55 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n1ON1tNC004025;
	Tue, 24 Feb 2009 23:01:55 GMT
X-Mailer: git-send-email 1.6.2.rc1.258.g314b8b
In-Reply-To: <1235516466-3930-1-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: 7ce22dc71d4a3b1c7a7debb43b4a984b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111358>

---
 git-mergetool.sh |  110 +++++++++++++++++++++++++++++-------------------------
 1 files changed, 59 insertions(+), 51 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 87fa88a..9446b8e 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -99,7 +99,7 @@ resolve_deleted_merge () {
 		return 0
 		;;
 	    [dD]*)
-		git rm -- "$MERGED" > /dev/null
+		git rm -q -- "$MERGED"
 		cleanup_temp_files
 		return 0
 		;;
@@ -134,55 +134,8 @@ checkout_staged_file () {
     fi
 }
 
-merge_file () {
-    MERGED="$1"
-
-    f=`git ls-files -u -- "$MERGED"`
-    if test -z "$f" ; then
-	if test ! -f "$MERGED" ; then
-	    echo "$MERGED: file not found"
-	else
-	    echo "$MERGED: file does not need merging"
-	fi
-	return 1
-    fi
-
-    ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
-    BACKUP="./$MERGED.BACKUP.$ext"
-    LOCAL="./$MERGED.LOCAL.$ext"
-    REMOTE="./$MERGED.REMOTE.$ext"
-    BASE="./$MERGED.BASE.$ext"
-
-    mv -- "$MERGED" "$BACKUP"
-    cp -- "$BACKUP" "$MERGED"
-
-    base_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}'`
-    local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
-    remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
-
-    base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
-    local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
-    remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"
+resolve_normal_merge () {
 
-    if test -z "$local_mode" -o -z "$remote_mode"; then
-	echo "Deleted merge conflict for '$MERGED':"
-	describe_file "$local_mode" "local" "$LOCAL"
-	describe_file "$remote_mode" "remote" "$REMOTE"
-	resolve_deleted_merge
-	return
-    fi
-
-    if is_symlink "$local_mode" || is_symlink "$remote_mode"; then
-	echo "Symbolic link merge conflict for '$MERGED':"
-	describe_file "$local_mode" "local" "$LOCAL"
-	describe_file "$remote_mode" "remote" "$REMOTE"
-	resolve_symlink_merge
-	return
-    fi
-
-    echo "Normal merge conflict for '$MERGED':"
-    describe_file "$local_mode" "local" "$LOCAL"
-    describe_file "$remote_mode" "remote" "$REMOTE"
     if "$prompt" = true; then
 	printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
 	read ans
@@ -278,7 +231,62 @@ merge_file () {
 	    fi
 	    ;;
     esac
-    if test "$status" -ne 0; then
+
+    if test $status -eq 0; then
+	git add -- "$MERGED"
+    fi
+
+    return $status
+}
+
+merge_file () {
+    MERGED="$1"
+
+    f=`git ls-files -u -- "$MERGED"`
+    if test -z "$f" ; then
+	if test ! -f "$MERGED" ; then
+	    echo "$MERGED: file not found"
+	else
+	    echo "$MERGED: file does not need merging"
+	fi
+	return 1
+    fi
+
+    ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
+    BACKUP="./$MERGED.BACKUP.$ext"
+    LOCAL="./$MERGED.LOCAL.$ext"
+    REMOTE="./$MERGED.REMOTE.$ext"
+    BASE="./$MERGED.BASE.$ext"
+
+    mv -- "$MERGED" "$BACKUP"
+    cp -- "$BACKUP" "$MERGED"
+
+    base_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}'`
+    local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
+    remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
+
+    base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
+    local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
+    remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"
+
+    if test -z "$local_mode" -o -z "$remote_mode"; then
+	echo "Deleted merge conflict for '$MERGED':"
+	describe_file "$local_mode" "local" "$LOCAL"
+	describe_file "$remote_mode" "remote" "$REMOTE"
+	resolve_deleted_merge
+    elif is_symlink "$local_mode" || is_symlink "$remote_mode"; then
+	echo "Symbolic link merge conflict for '$MERGED':"
+	describe_file "$local_mode" "local" "$LOCAL"
+	describe_file "$remote_mode" "remote" "$REMOTE"
+	resolve_symlink_merge
+    else
+	echo "Normal merge conflict for '$MERGED':"
+	describe_file "$local_mode" "local" "$LOCAL"
+	describe_file "$remote_mode" "remote" "$REMOTE"
+	resolve_normal_merge
+    fi
+
+    if test $? -ne 0; then
 	echo "merge of $MERGED failed" 1>&2
 	mv -- "$BACKUP" "$MERGED"
 
@@ -295,8 +303,8 @@ merge_file () {
 	rm -- "$BACKUP"
     fi
 
-    git add -- "$MERGED"
     cleanup_temp_files
+
     return 0
 }
 
-- 
1.6.2.rc1.258.g314b8b
