From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH] run-command.c: Accept EACCES as command not found
Date: Mon, 21 Nov 2011 22:53:07 +0100
Message-ID: <1321912387-4569-1-git-send-email-fransklaver@gmail.com>
Cc: git@vger.kernel.org, Frans Klaver <fransklaver@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 22:54:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSboN-0004om-Mp
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 22:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075Ab1KUVxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 16:53:55 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58304 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab1KUVxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 16:53:54 -0500
Received: by eye27 with SMTP id 27so5898680eye.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 13:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=KF1QNMbETNg3ViAHi00blBnYH/UcpxxfZprKekjK5HY=;
        b=t0D6LlNYaSYmt0y8TdYERveR5dJUjTQMPuolr615WILlSe9dVtl+NLwitjqCuSWb5B
         NtpInBACtei07k40EoJ6CQORvhk2t3Eds+Y2BgAGWc97IkId4VPwVgmchKTbV/odCAED
         r8IyTCfW1HzNc5879PDM85O9fCqqmjdj7nimw=
Received: by 10.213.22.18 with SMTP id l18mr474278ebb.51.1321912432579;
        Mon, 21 Nov 2011 13:53:52 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id 5sm35283973eev.2.2011.11.21.13.53.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 13:53:51 -0800 (PST)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185763>

execvp returns ENOENT if a command was not found after searching PATH.
If path contains a directory that current user has insufficient
privileges to, EACCES is returned. This may still mean the program
wasn't found.

If the latter case is encountered, git errors out without giving aliases
a try, which breaks t0001.3 and alias handling in general.

This can be fixed by handling the EACCES case equally to the ENOENT
case.

Signed-off-by: Frans Klaver <fransklaver@gmail.com>
---

I'm actually not too happy about the location of the tests. I couldn't
find out from the available tests and the documentation where I would
have to create the new ones. For now, I've added the tests to the same
set that I found the issue with.

 run-command.c   |   10 ++++++++--
 t/t0001-init.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1c51043..ad3c120 100644
--- a/run-command.c
+++ b/run-command.c
@@ -280,12 +280,18 @@ fail_pipe:
 		} else {
 			execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
-		if (errno == ENOENT) {
+		switch (errno) {
+		case ENOENT:
 			if (!cmd->silent_exec_failure)
 				error("cannot run %s: %s", cmd->argv[0],
 					strerror(ENOENT));
 			exit(127);
-		} else {
+		case EACCES:
+			if (!cmd->silent_exec_failure)
+				error("fatal: cannot exec '%s': %s", cmd->argv[0],
+					strerror(EACCES));
+			exit(127);
+		default:
 			die_errno("cannot exec '%s'", cmd->argv[0]);
 		}
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index ad66410..d40966a 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -63,6 +63,54 @@ test_expect_success 'plain through aliased command, outside any git repo' '
 	check_config plain-aliased/.git false unset
 '
 
+test_expect_success 'plain through aliased command, inaccessible path, outside any git repo' '
+	(
+		sane_unset GIT_DIR GIT_WORK_TREE &&
+		HOME=$(pwd)/alias-config-path &&
+		export HOME &&
+		mkdir alias-config-path &&
+		echo "[alias] aliasedinit = init" >alias-config-path/.gitconfig &&
+
+		GIT_CEILING_DIRECTORIES=$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+
+		mkdir searchpath &&
+		chmod 400 searchpath &&
+		PATH=$(pwd)/searchpath:$PATH &&
+		export PATH &&
+
+		mkdir plain-aliased-path &&
+		cd plain-aliased-path &&
+		git aliasedinit
+	) &&
+	check_config plain-aliased-path/.git false unset
+'
+
+test_expect_success 'plain through aliased command, inaccessible command, outside any git repo' '
+	(
+		sane_unset GIT_DIR GIT_WORK_TREE &&
+		HOME=$(pwd)/alias-config-cmd &&
+		export HOME &&
+		mkdir alias-config-cmd &&
+		echo "[alias] aliasedinit = init" >alias-config-cmd/.gitconfig &&
+
+		GIT_CEILING_DIRECTORIES=$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+
+		mkdir searchpathcmd &&
+		chmod 755 searchpathcmd &&
+		PATH=$(pwd)/searchpathcmd:$PATH &&
+		export PATH &&
+
+		touch searchpathcmd/git-aliasedinit &&
+
+		mkdir plain-aliased-cmd &&
+		cd plain-aliased-cmd &&
+		git aliasedinit
+	) &&
+	check_config plain-aliased-cmd/.git false unset
+'
+
 test_expect_failure 'plain nested through aliased command' '
 	(
 		sane_unset GIT_DIR GIT_WORK_TREE &&
-- 
1.7.7
