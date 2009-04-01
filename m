From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 05/10] difftool: use get_mergetool_path from git-mergetool-lib
Date: Wed,  1 Apr 2009 05:55:09 -0700
Message-ID: <1238590514-41893-6-git-send-email-davvid@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
 <1238590514-41893-2-git-send-email-davvid@gmail.com>
 <1238590514-41893-3-git-send-email-davvid@gmail.com>
 <1238590514-41893-4-git-send-email-davvid@gmail.com>
 <1238590514-41893-5-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, charles@hashpling.org
X-From: git-owner@vger.kernel.org Wed Apr 01 14:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp01g-0004A8-UL
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764715AbZDAMzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764699AbZDAMzn
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:55:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:13767 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764654AbZDAMzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:55:39 -0400
Received: by rv-out-0506.google.com with SMTP id f9so29191rvb.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 05:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0fSn3j58L5ZlAnVmk4mn6dAUfFGhxwMQfQrcgPDzvWY=;
        b=FMXRj52dJXjnBJO1biJ4Xzk65QCyYD7RqQahCQdQT1bSAFCjRM83RwUMjNJ90zSDQQ
         Ez2evoV8/nwx0aQWwhiVu00VRoCz7pl56w13Tiq4SiI4dCGNLQW5qV85k5DcHoW7TrrG
         tgkK2eNBhYiboJo03jCyyExFXUCH5jkNlpA6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p8Yu+nybCH5G4SZqaueimvYnq9UlZyorF+sYOiyc0DRPDazsA066xmuY+HA47+UBiF
         hFcOvAVV8uKyeANxngM4Cup84P7Q8gZ7Aw28FqKN8naBGDiUAHy+KiZyWep5nEgUYwrM
         gy6pUWrYH4wBdlauziBOlw6Pb24uEDCcHi3EQ=
Received: by 10.114.199.3 with SMTP id w3mr5192479waf.181.1238590538236;
        Wed, 01 Apr 2009 05:55:38 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v39sm7330872wah.5.2009.04.01.05.55.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 05:55:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
In-Reply-To: <1238590514-41893-5-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115380>

This refactors git-difftool-helper to use get_mergetool_path().

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool-helper.sh |   33 ++++++++++++---------------------
 1 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/git-difftool-helper.sh b/git-difftool-helper.sh
index 02bb135..d1bea18 100755
--- a/git-difftool-helper.sh
+++ b/git-difftool-helper.sh
@@ -7,6 +7,9 @@
 #
 # Copyright (c) 2009 David Aguilar
 
+# Load common functions from git-mergetool-lib
+. git-mergetool-lib
+
 # difftool.prompt controls the default prompt/no-prompt behavior
 # and is overridden with $GIT_DIFFTOOL*_PROMPT.
 should_prompt () {
@@ -125,25 +128,6 @@ valid_tool() {
 	esac
 }
 
-# Sets up the merge_tool_path variable.
-# This handles the difftool.<tool>.path configuration.
-# This also falls back to mergetool defaults.
-init_merge_tool_path() {
-	merge_tool_path=$(git config difftool."$1".path)
-	test -z "$merge_tool_path" &&
-	merge_tool_path=$(git config mergetool."$1".path)
-	if test -z "$merge_tool_path"; then
-		case "$1" in
-		emerge)
-			merge_tool_path=emacs
-			;;
-		*)
-			merge_tool_path="$1"
-			;;
-		esac
-	fi
-}
-
 # Allow GIT_DIFF_TOOL and GIT_MERGE_TOOL to provide default values
 test -n "$GIT_MERGE_TOOL" && merge_tool="$GIT_MERGE_TOOL"
 test -n "$GIT_DIFF_TOOL" && merge_tool="$GIT_DIFF_TOOL"
@@ -187,7 +171,7 @@ if test -z "$merge_tool"; then
 	# Loop over each candidate and stop when a valid merge tool is found.
 	for i in $merge_tool_candidates
 	do
-		init_merge_tool_path $i
+		merge_tool_path="$(get_merge_tool_path "$i")"
 		if type "$merge_tool_path" > /dev/null 2>&1; then
 			merge_tool=$i
 			break
@@ -206,7 +190,14 @@ else
 		exit 1
 	fi
 
-	init_merge_tool_path "$merge_tool"
+	# Sets up the merge_tool_path variable.
+	# This handles the difftool.<tool>.path configuration variable
+	# and falls back to mergetool defaults.
+	merge_tool_path=$(git config difftool."$1".path)
+	test -z "$merge_tool_path" &&
+	merge_tool_path=$(git config mergetool."$1".path)
+	merge_tool_path="$(get_merge_tool_path "$merge_tool" \
+	                                       "$merge_tool_path")"
 
 	if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
 		echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
-- 
1.6.1.3
