From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/5 maint] start_command: close cmd->err descriptor when fork/spawn fails
Date: Thu, 20 May 2010 20:57:52 +0200
Message-ID: <753dbe1c95461e736185f4a1b06e20937dab9db7.1274380838.git.j6t@kdbg.org>
References: <cover.1274380838.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	bert Dvornik <dvornik+git@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 20 21:01:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFAzM-0008GA-Bn
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 21:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab0ETTA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 15:00:58 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:15285 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751895Ab0ETTA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 15:00:56 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BF6BECDF8B;
	Thu, 20 May 2010 21:00:55 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5572219F5F0;
	Thu, 20 May 2010 20:58:13 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.64.ga1799.dirty
In-Reply-To: <cover.1274380838.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147408>

From: bert Dvornik <dvornik+git@gmail.com>

Fix the problem where the cmd->err passed into start_command wasn't
being properly closed when certain types of errors occurr.  (Compare
the affected code with the clean shutdown code later in the function.)

On Windows, this problem would be triggered if mingw_spawnvpe()
failed, which would happen if the command to be executed was malformed
(e.g. a text file that didn't start with a #! line).  If cmd->err was
a pipe, the failure to close it could result in a hang while the other
side was waiting (forever) for either input or pipe close, e.g. while
trying to shove the output into the side band.  On msysGit, this
problem was causing a hang in t5516-fetch-push.

[J6t: With a slight adjustment of the test case, the hang is also
observed on Linux.]

Signed-off-by: bert Dvornik <dvornik+git@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 run-command.c         |    2 ++
 t/t5516-fetch-push.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index eb5c575..c7793f5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -383,6 +383,8 @@ fail_pipe:
 			close(cmd->out);
 		if (need_err)
 			close_pair(fderr);
+		else if (cmd->err)
+			close(cmd->err);
 		errno = failed_errno;
 		return -1;
 	}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2de98e6..6a37a4d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -528,7 +528,7 @@ test_expect_success 'push does not update local refs on failure' '
 	mk_test heads/master &&
 	mk_child child &&
 	mkdir testrepo/.git/hooks &&
-	echo exit 1 >testrepo/.git/hooks/pre-receive &&
+	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
 	chmod +x testrepo/.git/hooks/pre-receive &&
 	(cd child &&
 		git pull .. master
-- 
1.7.1.64.ga1799.dirty
