From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC] Add posibility to preload stat information.
Date: Wed, 20 Mar 2013 13:15:32 +0100
Message-ID: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, iveqy@iveqy.com
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Mar 20 13:15:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIHuz-00024Z-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869Ab3CTMOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 08:14:30 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:53063 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756115Ab3CTMO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:14:28 -0400
Received: by mail-la0-f49.google.com with SMTP id fs13so2768849lab.22
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=0P1E1T3C0YyCuPc5mMSTy1KnUB0lcjjHk/2PrdaRegg=;
        b=bf3FI5AL9fxiUZUm6jPJxxgIzSQ4z4ii0cemWrJbPA1APb4inm3jxOB/8PEgPtZD/p
         5Yp5+txr/rHPuuOnUkIouk8bGoY9MstCao4L2SnbocHytPSIFivbl1Jd+jkg+H+rbkM5
         kmEoSmoMzTOadXU+h7+S3N+o/FTVNeJQ1mf8x6fRZ8Xg19+XASFVRF6Matja12rmWQ9x
         uS5eFfTR+tyGkclPpkVP/Zl2IfkQ6tlt/ZkqZp2R4B2vnSdigBsCd7iTEFsQtFJfcakt
         jxENOfEm3PKMNUnhL5hid18/PPpxKhYfR2vri3Yev925fXnBfKm6BfP7vhWiBh+GYliu
         2dow==
X-Received: by 10.152.134.40 with SMTP id ph8mr5097762lab.39.1363781667274;
        Wed, 20 Mar 2013 05:14:27 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id v7sm469443lbg.13.2013.03.20.05.14.25
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:14:26 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UIHvi-0002yN-DL; Wed, 20 Mar 2013 13:15:42 +0100
X-Mailer: git-send-email 1.8.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218587>

When entering a git working dir, optionally run a forked process that
stat all files in the whole workdir and therefore loads stat information
to RAM which will speedup things like git status and so on.

The feature is optional and by default it's off.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 contrib/completion/git-prompt.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 341422a..e67bc97 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -78,6 +78,12 @@
 # If you would like a colored hint about the current dirty state, set
 # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
 # the colored output of "git status -sb".
+#
+# When enter a git work dir you can have a forked process run
+# stat on all files in the top level directory for git and down.
+# This will decrease later calls to git status and alike because
+# stat info will already be loaded into RAM. set GIT_PRE_STAT to
+# a nonempty value.
 
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
@@ -222,6 +228,19 @@ __git_ps1_show_upstream ()
 
 }
 
+# Forks and recursive do a stat from the toplevel git dir.
+# This will load inodes into RAM for faster access when running
+# A git command, like git show.
+__git_recursive_stat ()
+{
+	if test ! -e /tmp/gitbash.lock
+	then
+		touch /tmp/gitbash.lock
+		cd $(git rev-parse --show-toplevel)
+		find . | xargs stat 2&> /dev/null
+		rm /tmp/gitbash.lock
+	fi
+}
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # when called from PS1 using command substitution
@@ -320,6 +339,10 @@ __git_ps1 ()
 				b="GIT_DIR!"
 			fi
 		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
+			if [ -n "${GIT_PRE_STAT-}" ];
+			then
+				(__git_recursive_stat 2&> /dev/null &)
+			fi
 			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
 			   [ "$(git config --bool bash.showDirtyState)" != "false" ]
 			then
-- 
1.8.1.5
