From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool--lib: make (g)vimdiff workable under Windows
Date: Sat,  4 Apr 2009 21:15:23 -0700
Message-ID: <1238904923-13368-1-git-send-email-davvid@gmail.com>
Cc: markus.heidelberg@web.de, charles@hashpling.org,
	git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 05 06:18:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqJoE-0001gu-T9
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 06:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbZDEEPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 00:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbZDEEPc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 00:15:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:23180 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbZDEEPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 00:15:31 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1314852wah.21
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 21:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=s3afrE3QRUnhrx8qvhsmDsfAx+4WHSwhpuCNBgp6Hik=;
        b=PlFMzOmHHJVD8x3L350xcs3lnf9KPVosVdMI8X91xr9DyZpmSFbQXJUHmTsCvvErpt
         6Tb7ysZ7OMAnnrtzNjTu/rMwgNnUMACmrsP+2xvxCtZ4kjNMi3c6CdtpbG/ZSBLMcIcJ
         EMm8VwId6RjhjWgV0bVjQJlFY2A23VKgo6Lxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=diXmVP42JBc/pAXMOW+VYUrAW+q+jcES4zuni+NJmt5Mm+tyHlpFa4e6r8ZjH7Cwxo
         lxmGCdfjn3B/zzEN7HP4+mZ2inLG5Ryit4YDj94FO+OZIFQQJKO4p9PiLaptOMUSyIHr
         PzaaZBzbzrhS8Z4dK5TBKZhty/A/l+OxJaL78=
Received: by 10.114.103.1 with SMTP id a1mr1494599wac.218.1238904929757;
        Sat, 04 Apr 2009 21:15:29 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id f20sm3929499waf.35.2009.04.04.21.15.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 21:15:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.469.gdffc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115633>

From: Markus Heidelberg <markus.heidelberg@web.de>

Under Windows vimdiff and gvimdiff are not available as symbolic links,
but as batch files vimdiff.bat and gvimdiff.bat. These files weren't
found by 'type vimdiff' which led to the following error:

The merge tool vimdiff is not available as 'vimdiff'

Even if they were found, it wouldn't work to invoke these batch files
from git-mergetool.

To solve this, use vim and gvim (vim.exe and gvim.exe) and pass the -d
command line switch over to them.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

Markus' last patch rebased.

This patch goes on top of the current difftool/mergetool patches from David.
This is 'da/difftool' in the current 'pu' and in addition:
[PATCH] mergetool-lib: refactor run_mergetool and check_unchanged
[PATCH] mergetool-lib: specialize opendiff options when in diff mode


 git-mergetool--lib.sh |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 268485a..3d3edda 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -12,6 +12,12 @@ translate_merge_tool_path () {
 		echo "$2"
 	else
 		case "$1" in
+		vimdiff)
+			path=vim
+			;;
+		gvimdiff)
+			path=gvim
+			;;
 		emerge)
 			path=emacs
 			;;
@@ -146,19 +152,19 @@ run_merge_tool () {
 	vimdiff)
 		if merge_mode; then
 			touch "$BACKUP"
-			"$merge_tool_path" -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
 		else
-			"$merge_tool_path" -c "wincmd l" "$LOCAL" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$REMOTE"
 		fi
 		;;
 	gvimdiff)
 		if merge_mode; then
 			touch "$BACKUP"
-			"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
 		else
-			"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$REMOTE"
 		fi
 		;;
 	xxdiff)
-- 
1.6.2.1.469.gdffc1
