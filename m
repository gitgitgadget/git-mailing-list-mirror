From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 04/10] mergetool: use get_mergetool_path from git-mergetool-lib
Date: Wed,  1 Apr 2009 05:55:08 -0700
Message-ID: <1238590514-41893-5-git-send-email-davvid@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
 <1238590514-41893-2-git-send-email-davvid@gmail.com>
 <1238590514-41893-3-git-send-email-davvid@gmail.com>
 <1238590514-41893-4-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, charles@hashpling.org
X-From: git-owner@vger.kernel.org Wed Apr 01 14:58:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp01h-0004A8-Ma
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764726AbZDAMzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764714AbZDAMzp
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:55:45 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:5853 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763348AbZDAMzi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:55:38 -0400
Received: by wa-out-1112.google.com with SMTP id j5so13652wah.21
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qPgi/p/0+yEqvzomUoW8VaQBeFvr9WE7MetZTAhCohw=;
        b=Zh6gdWt4qS76lmHVRLJpaBSYL1CmWOcaQpdy8PeWY4angFHLkrL9ApuTFA7NGyA2xq
         JO5yUwtzqZ95C1krD1ahlCkGk/2dyLJ5iNhnSTd/+dypp8vnQOaXNCy8jhITPQlPMzFu
         9h/+oWyBu5wQ2FTHG5ZS8n52cmSeh6hwn/X1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gtX3g2N4nRn4Wa3+pSJJjufMNOXbxoLWCQuaZrsYGXyvqNdqOCcisSJ/I/48u5qUzl
         Xb4gBMr9+Yrr+Nd82to6lW1ngCA60P1rok0bO/H1g//aKBVljGDQOsz0TSoe8SseXYTH
         gC4jEwYPoFsBO2TbbRpdZJwMoSuxajbZLyLMA=
Received: by 10.114.24.1 with SMTP id 1mr5197302wax.179.1238590536708;
        Wed, 01 Apr 2009 05:55:36 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v9sm7243561wah.60.2009.04.01.05.55.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 05:55:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
In-Reply-To: <1238590514-41893-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115387>

This refactors git-mergetool to use get_mergetool_path().

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 7c04031..732a5b7 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -12,6 +12,7 @@ USAGE='[--tool=tool] [-y|--no-prompt|--prompt] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
+. git-mergetool-lib
 require_work_tree
 
 # Returns true if the mode reflects a symlink
@@ -355,20 +356,6 @@ valid_tool() {
 	esac
 }
 
-init_merge_tool_path() {
-	merge_tool_path=$(git config mergetool.$1.path)
-	if test -z "$merge_tool_path" ; then
-		case "$1" in
-			emerge)
-				merge_tool_path=emacs
-				;;
-			*)
-				merge_tool_path=$1
-				;;
-		esac
-	fi
-}
-
 prompt_after_failed_merge() {
     while true; do
 	printf "Continue merging other unresolved paths (y/n) ? "
@@ -412,7 +399,7 @@ if test -z "$merge_tool" ; then
     fi
     echo "merge tool candidates: $merge_tool_candidates"
     for i in $merge_tool_candidates; do
-        init_merge_tool_path $i
+        merge_tool_path="$(get_merge_tool_path "$i" "$merge_tool_path")"
         if type "$merge_tool_path" > /dev/null 2>&1; then
             merge_tool=$i
             break
@@ -428,8 +415,7 @@ else
         exit 1
     fi
 
-    init_merge_tool_path "$merge_tool"
-
+    merge_tool_path="$(get_merge_tool_path "$merge_tool")"
     merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
     merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
-- 
1.6.1.3
