From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 06/10] mergetool: use valid_tool from git-mergetool-lib
Date: Wed,  1 Apr 2009 05:55:10 -0700
Message-ID: <1238590514-41893-7-git-send-email-davvid@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
 <1238590514-41893-2-git-send-email-davvid@gmail.com>
 <1238590514-41893-3-git-send-email-davvid@gmail.com>
 <1238590514-41893-4-git-send-email-davvid@gmail.com>
 <1238590514-41893-5-git-send-email-davvid@gmail.com>
 <1238590514-41893-6-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, charles@hashpling.org
X-From: git-owner@vger.kernel.org Wed Apr 01 14:58:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp01i-0004A8-Eh
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764728AbZDAMzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761612AbZDAMzr
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:55:47 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:10345 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764259AbZDAMzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:55:41 -0400
Received: by rv-out-0506.google.com with SMTP id f9so29184rvb.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 05:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CGqtSLH3vDpe5APuAOGtw2M37N/bCEnzXusnr5pFVZ0=;
        b=CpqPDTL+3QpastuFz1RmbU08fszzRJQ2+o7YK2mq3zhL58G3a28/xxOx9v1DMIO2pN
         3FN+G6stmPY5eyC/OvWjZMWyUSh8phzr5VAU3pQkZggFZw1jiRgEVAIjAslDd88I0She
         boFho9ZuNC85waF8JFyTtd7GipPAteFrwAF6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S7+NNqO0zG1Th8s0KKcJjTET2ENA3LW25+nzm4Tr4Ykg5d2a3M0Gu/HFH1x1yO/RnC
         Vchx1BQTeSQ/vrDIuAsuNOFEsSHjKDN2kVQzvNCr50KIQrbb/PJV4HM5u2X4UUg0ZYCE
         e14gKdkZ6HRqpy6tgPbnmfx8ZmqgSrulEbcQo=
Received: by 10.114.76.8 with SMTP id y8mr5193161waa.201.1238590539882;
        Wed, 01 Apr 2009 05:55:39 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v39sm7177068wah.40.2009.04.01.05.55.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 05:55:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
In-Reply-To: <1238590514-41893-6-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115381>

This refactors git-mergetool to use valid_tool from git-mergetool-lib.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh |   21 +++------------------
 1 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 732a5b7..957993c 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -11,6 +11,7 @@
 USAGE='[--tool=tool] [-y|--no-prompt|--prompt] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
+TOOL_MODE=merge
 . git-sh-setup
 . git-mergetool-lib
 require_work_tree
@@ -338,24 +339,6 @@ do
     shift
 done
 
-valid_custom_tool()
-{
-    merge_tool_cmd="$(git config mergetool.$1.cmd)"
-    test -n "$merge_tool_cmd"
-}
-
-valid_tool() {
-	case "$1" in
-		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
-			;; # happy
-		*)
-			if ! valid_custom_tool "$1"; then
-				return 1
-			fi
-			;;
-	esac
-}
-
 prompt_after_failed_merge() {
     while true; do
 	printf "Continue merging other unresolved paths (y/n) ? "
@@ -409,12 +392,14 @@ if test -z "$merge_tool" ; then
 	echo "No known merge resolution program available."
 	exit 1
     fi
+    merge_tool_cmd="$(git config mergetool."$merge_tool".cmd)"
 else
     if ! valid_tool "$merge_tool"; then
         echo >&2 "Unknown merge_tool $merge_tool"
         exit 1
     fi
 
+    merge_tool_cmd="$(git config mergetool.$merge_tool.cmd)"
     merge_tool_path="$(get_merge_tool_path "$merge_tool")"
     merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
     merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
-- 
1.6.1.3
