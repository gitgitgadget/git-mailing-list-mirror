From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 096/104] start_command: close cmd->err descriptor when fork/spawn fails
Date: Wed, 26 May 2010 18:01:06 +1200
Message-ID: <1274853674-18521-96-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: bert Dvornik <dvornik+git@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9lh-0004ff-Pf
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934051Ab0EZGGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:43 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49309 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933735Ab0EZGGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id DC55233911;
	Wed, 26 May 2010 18:02:04 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2-60ZM3sA7D1; Wed, 26 May 2010 18:02:03 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id BD7B4338E0;
	Wed, 26 May 2010 18:01:38 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147752>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.7.1.rc2.333.gb2668
