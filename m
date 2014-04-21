From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Sun, 20 Apr 2014 19:17:34 -0500
Message-ID: <1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 02:28:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc26K-00029c-96
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 02:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbaDUA2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 20:28:41 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:58698 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaDUA2D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 20:28:03 -0400
Received: by mail-yk0-f172.google.com with SMTP id 200so2969932ykr.31
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 17:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DH2l+S/mSRn0ZD9ZXkJRnvLevEwkXvvP/QFM3CxTKfY=;
        b=ZLCEAD1z30IYTqODck3GoUFGkWSZ6EQKOI+2Oq4AClikd79YSJ23po/KlYkyuRtevx
         c+4HireseRwsmEQ/z4+ffch8pOU3mfvs2bvYos6KkhAO33kMIbQuzJmxNVW6bihcpRTQ
         urx677P9/S6PVVxWgieR/TqwuFgZ6xqh2GXtMYoO8117jV09MBFJE8G65+3ei0dEWzHq
         6HBbKklRA/40TpbR+D62Px8dmErZBYZP8UitWl0i/CWFeTEBSyvq88yX7zgK7Xl+lcrC
         aA5gyBsYxRcOoipJGZhV0fh1NGFLyyWzBeRfR6S93QYGwcrX6x3/JVkLn5cG0Lh3+fMt
         Vq8A==
X-Received: by 10.236.13.46 with SMTP id a34mr49220126yha.28.1398040082876;
        Sun, 20 Apr 2014 17:28:02 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id p68sm66616442yho.10.2014.04.20.17.28.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 17:28:02 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
In-Reply-To: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246601>

It's annoying to see the prompt:

  Hit return to start merge resolution tool (foo):

Every time the user does 'git mergetool' even if the user already
configured 'foo' as the wanted tool.

Display this prompt only when the user hasn't explicitly configured a
tool.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-mergetool.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 332528f..d08dc92 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -277,7 +277,7 @@ merge_file () {
 	echo "Normal merge conflict for '$MERGED':"
 	describe_file "$local_mode" "local" "$LOCAL"
 	describe_file "$remote_mode" "remote" "$REMOTE"
-	if "$prompt" = true
+	if test "$guessed_merge_tool" = true || test "$prompt" = true
 	then
 		printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
 		read ans || return 1
@@ -315,7 +315,8 @@ merge_file () {
 	return 0
 }
 
-prompt=$(git config --bool mergetool.prompt || echo true)
+prompt=$(git config --bool mergetool.prompt)
+guessed_merge_tool=false
 
 while test $# != 0
 do
@@ -373,7 +374,14 @@ prompt_after_failed_merge () {
 
 if test -z "$merge_tool"
 then
-	merge_tool=$(get_merge_tool "$merge_tool") || exit
+	# Check if a merge tool has been configured
+	merge_tool=$(get_configured_merge_tool)
+	# Try to guess an appropriate merge tool if no tool has been set.
+	if test -z "$merge_tool"
+	then
+		merge_tool=$(guess_merge_tool) || exit
+		guessed_merge_tool=true
+	fi
 fi
 merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
-- 
1.9.2+fc1.1.g5c924db
