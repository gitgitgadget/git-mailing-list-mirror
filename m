From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH 0/3] fix "Funny: git -p submodule summary"
Date: Tue, 27 Jan 2009 11:06:40 +0100
Message-ID: <497EDCB0.8080806@kdbg.org>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090127062512.GA10487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 11:08:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRkrl-0003yH-6A
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 11:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbZA0KG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 05:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbZA0KG4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 05:06:56 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:48590 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbZA0KGz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 05:06:55 -0500
Received: from [192.168.1.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 800102C4032;
	Tue, 27 Jan 2009 11:06:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090127062512.GA10487@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107328>

Jeff King schrieb:
> JSixt, there are some tweaks to the Windows code to report back the exec
> error. They look obviously correct to me, but I have no box to test
> (even compile test) them on.

Generally, I like this series, in particular since it does not degrade 
performance on Windows ;)

But the following is needed in addition.

- Note that run_command returns the negated exit code, therefore, we 
must negate it again in the call to exit(). Without this t6030 failed. 
(And negative exit codes causes grief on Windows because bash for some 
reason does not recognize that as failure.)

- The close() calls can overwrite errno. And since fork() should not 
(cannot?) fail with ENOENT, it's safe to remove the #ifdef __MINGW32__.

-- Hannes

diff --git a/git.c b/git.c
index 79a836c..35635d1 100644
--- a/git.c
+++ b/git.c
@@ -414,7 +414,7 @@ static void execv_dashed_external
  	 */
  	status = run_command_v_opt(argv, 0);
  	if (status != -ERR_RUN_COMMAND_EXEC)
-		exit(status);
+		exit(-status);
  	errno = ENOENT; /* as if we called execvp */

  	argv[0] = tmp;
diff --git a/run-command.c b/run-command.c
index 2437798..b05c734 100644
--- a/run-command.c
+++ b/run-command.c
@@ -187,27 +187,24 @@ int start_command
  	if (s2 >= 0)
  		dup2(s2, 2), close(s2);
  #endif

  	if (cmd->pid < 0) {
+		int err = errno;
  		if (need_in)
  			close_pair(fdin);
  		else if (cmd->in)
  			close(cmd->in);
  		if (need_out)
  			close_pair(fdout);
  		else if (cmd->out)
  			close(cmd->out);
  		if (need_err)
  			close_pair(fderr);
-#ifndef __MINGW32__
-		return -ERR_RUN_COMMAND_FORK;
-#else
-		return errno == ENOENT ?
+		return err == ENOENT ?
  			-ERR_RUN_COMMAND_EXEC :
  			-ERR_RUN_COMMAND_FORK;
-#endif
  	}

  	if (need_in)
  		close(fdin[0]);
  	else if (cmd->in)
