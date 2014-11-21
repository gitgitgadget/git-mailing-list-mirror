From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/3] mergetool--lib: remove use of $status global
Date: Thu, 20 Nov 2014 17:20:27 -0800
Message-ID: <1416532829-68662-2-git-send-email-davvid@gmail.com>
References: <1416532829-68662-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 02:20:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrcu0-0006Aj-Sh
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 02:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757426AbaKUBUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 20:20:45 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57044 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757360AbaKUBUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 20:20:44 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so3749384pab.0
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 17:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=97rQvXld8SFrN/cmBHsmhhSKu8XTVUdawQPXBP/hBaY=;
        b=xigysvXrymq9UkHlOCCgpEJVaTXprTsNH1wp/LvuFIZLUhTAVLQHER/SHcDbbn/058
         E8tQ3h4IQlWzrkMOVshX5zw2Rc+qcKLK4EL+yjbHFnaY2VcpJ840DE2bVzGKkcPVdLwe
         ubWfdP8MnALJMDrB2qfvKnOk+9ciLh5C7wpKf38HJibAeGaZ8Eu32+zEyn1kUHF1nu8W
         LJzNDjUskFleC+MFDEKHHmYScHIfGDmgSxutHYNNt83hyRFliK3Q+h9TKPDlaBqZ8TwF
         Y7bu/z4WLjD3+Pao/9IteDP3ea2Ktg1P9Quc5MyAT0F5Lrk5lrzqdSZGzG+rRjGXICMq
         1d6Q==
X-Received: by 10.68.135.132 with SMTP id ps4mr2140801pbb.128.1416532844019;
        Thu, 20 Nov 2014 17:20:44 -0800 (PST)
Received: from lustrous.local.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by mx.google.com with ESMTPSA id w5sm3151439pds.25.2014.11.20.17.20.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 17:20:43 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.26.g3e3388f
In-Reply-To: <1416532829-68662-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove return statements and rework check_unchanged() so that the exit
status from the last evaluated expression bubbles up to the callers.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 2b66351..fe61e89 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -92,7 +92,7 @@ translate_merge_tool_path () {
 check_unchanged () {
 	if test "$MERGED" -nt "$BACKUP"
 	then
-		status=0
+		return 0
 	else
 		while true
 		do
@@ -100,8 +100,8 @@ check_unchanged () {
 			printf "Was the merge successful? [y/n] "
 			read answer || return 1
 			case "$answer" in
-			y*|Y*) status=0; break ;;
-			n*|N*) status=1; break ;;
+			y*|Y*) return 0 ;;
+			n*|N*) return 1 ;;
 			esac
 		done
 	fi
@@ -119,8 +119,6 @@ setup_user_tool () {
 
 	diff_cmd () {
 		( eval $merge_tool_cmd )
-		status=$?
-		return $status
 	}
 
 	merge_cmd () {
@@ -130,13 +128,10 @@ setup_user_tool () {
 		then
 			touch "$BACKUP"
 			( eval $merge_tool_cmd )
-			status=$?
 			check_unchanged
 		else
 			( eval $merge_tool_cmd )
-			status=$?
 		fi
-		return $status
 	}
 }
 
@@ -153,13 +148,11 @@ setup_tool () {
 	}
 
 	diff_cmd () {
-		status=1
-		return $status
+		return 1
 	}
 
 	merge_cmd () {
-		status=1
-		return $status
+		return 1
 	}
 
 	translate_merge_tool_path () {
@@ -210,7 +203,6 @@ run_merge_tool () {
 
 	merge_tool_path=$(get_merge_tool_path "$1") || exit
 	base_present="$2"
-	status=0
 
 	# Bring tool-specific functions into scope
 	setup_tool "$1" || return 1
@@ -221,8 +213,6 @@ run_merge_tool () {
 	else
 		run_diff_cmd "$1"
 	fi
-	status=$?
-	return $status
 }
 
 # Run a either a configured or built-in diff tool
-- 
2.2.0.rc2.26.g3e3388f
