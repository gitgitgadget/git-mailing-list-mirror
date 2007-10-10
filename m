From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Fix invocation of external git commands with arguments with
 spaces.
Date: Wed, 10 Oct 2007 09:00:12 +0200
Message-ID: <470C787C.6090900@viscovery.net>
References: <470BB44B.3030500@viscovery.net> <11919659771056-git-send-email-prohaska@zib.de> <470C6E58.3080208@viscovery.net>
Reply-To: Steffen Prohaska <prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Oct 10 09:00:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfVYP-0002Uy-Bz
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 09:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbXJJHAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 03:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbXJJHAQ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 03:00:16 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:46005 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbXJJHAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 03:00:14 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IfVY6-0003hN-17; Wed, 10 Oct 2007 09:00:06 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D06A36B7; Wed, 10 Oct 2007 09:00:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <470C6E58.3080208@viscovery.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60471>

If an external git command (not a shell script) was invoked with arguments
that contain spaces, these arguments would be split into separate
arguments. They must be quoted. This also affected installations where
$prefix contained a space, as in "C:\Program Files\GIT". Both errors can
be triggered by invoking

     git hash-object "a b"

where "a b" is an existing file.
---
Johannes Sixt schrieb:
> BTW, I think the fix is incomplete anyway: We quote only argv[0], but 
> actually all of argv should be quoted. Will test.

Here is the proper fix.

Yes, this leaks memory on the error path. We can clean that up later...

-- Hannes

  compat/mingw.c |    7 ++++++-
  1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8bb0dba..2554f19 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -405,7 +405,12 @@ void mingw_execve()
  {
  	/* check if git_command is a shell script */
  	if (!try_shell_exec(cmd, argv, env)) {
-		int ret = spawnve(_P_WAIT, cmd, argv, env);
+		const char **qargv;
+		int n;
+		for (n = 0; argv[n];) n++;
+		qargv = xmalloc((n+1)*sizeof(char*));
+		quote_argv(qargv, argv);
+		int ret = spawnve(_P_WAIT, cmd, qargv, env);
  		if (ret != -1)
  			exit(ret);
  	}
-- 
1.5.3.717.g01fc-dirty
