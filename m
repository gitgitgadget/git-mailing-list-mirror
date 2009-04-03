From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool-lib: refactor run_mergetool and check_unchanged
Date: Thu,  2 Apr 2009 19:10:03 -0700
Message-ID: <1238724603-59551-1-git-send-email-davvid@gmail.com>
Cc: charles@hashpling.org, markus.heidelberg@web.de,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 03 04:11:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpYsn-00084Q-Bi
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 04:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbZDCCKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 22:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbZDCCKS
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 22:10:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:31357 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbZDCCKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 22:10:16 -0400
Received: by rv-out-0506.google.com with SMTP id f9so928172rvb.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+0P/fQLupnIFYM6Lz6yqN/3NDPB6cJEf7vkGQGgshQ8=;
        b=gUbBUEgyoOxNoQ/c+jB2YU+FJ2TiHHnYySfSxvBaCuioOJW2WGrJIQkDHBf/6yfcSg
         V43sknfTSHsAq5tTmOlIkW4G/wLdOVKaLKoe87rNjvHt+v/TGxQJyOZhdQuDG/kLpTAo
         7WqsT6Giq9LOzWa557PWjLOlcW0ncePMN7nS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ecnkjvQrba6YXIFtvMXfUgroP72MuDh3eoLYhEL77XTRhjDG6NbqASGnqf5JwA0VkF
         EysArz1RIg5COssMKrpWr39YQaQU18a1YHbE6neP+wszjvF2T15LkEQIvGVFYcqk7wRy
         1gaHpHKH63455EyX0hr7ibX8eU8o7MFVWmlEU=
Received: by 10.140.202.12 with SMTP id z12mr259977rvf.228.1238724614412;
        Thu, 02 Apr 2009 19:10:14 -0700 (PDT)
Received: from localhost (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id f42sm5235097rvb.21.2009.04.02.19.10.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 19:10:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.404.ge96f3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115509>

This moves run_mergetool and check_unchanged into mergetool--lib.
git-mergetool no longer uses the global $status variable and instead
checks the return value of run_mergetool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh |   21 +++++++++++++++++++--
 git-mergetool.sh      |   20 +-------------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 91d5453..06d261a 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -22,9 +22,25 @@ get_merge_tool_path () {
 	echo "$path"
 }
 
-# Overridden in git-mergetool
 check_unchanged () {
-	true
+	if merge_mode; then
+		if test "$MERGED" -nt "$BACKUP"; then
+			status=0
+		else
+			while true; do
+				echo "$MERGED seems unchanged."
+				printf "Was the merge successful? [y/n] "
+				read answer < /dev/tty
+				case "$answer" in
+				y*|Y*) status=0; break ;;
+				n*|N*) status=1; break ;;
+				esac
+			done
+		fi
+	else
+		status=0
+	fi
+	return $status
 }
 
 valid_tool () {
@@ -213,4 +229,5 @@ run_mergetool () {
 		fi
 		;;
 	esac
+	return $status
 }
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 401c107..298b0a1 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -112,22 +112,6 @@ resolve_deleted_merge () {
 	done
 }
 
-check_unchanged () {
-    if test "$MERGED" -nt "$BACKUP" ; then
-	status=0;
-    else
-	while true; do
-	    echo "$MERGED seems unchanged."
-	    printf "Was the merge successful? [y/n] "
-	    read answer < /dev/tty
-	    case "$answer" in
-		y*|Y*) status=0; break ;;
-		n*|N*) status=1; break ;;
-	    esac
-	done
-    fi
-}
-
 checkout_staged_file () {
     tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
 
@@ -194,9 +178,7 @@ merge_file () {
     base_present &&
     present=true
 
-    run_mergetool "$merge_tool" "$present"
-
-    if test "$status" -ne 0; then
+    if ! run_mergetool "$merge_tool" "$present"; then
 	echo "merge of $MERGED failed" 1>&2
 	mv -- "$BACKUP" "$MERGED"
 
-- 
1.6.1.3
