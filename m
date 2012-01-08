From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/5 v2] dashed externals: kill children on exit
Date: Sun, 8 Jan 2012 21:41:09 +0100
Message-ID: <20120108204109.GA3394@ecki.lan>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
 <1325936567-3136-1-git-send-email-drizzd@aon.at>
 <1325936567-3136-3-git-send-email-drizzd@aon.at>
 <20120107145004.GB2461@sigill.intra.peff.net>
 <7v4nw6hfpy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:49:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjzgM-0003j1-HO
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab2AHUt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 15:49:29 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:40094 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754272Ab2AHUt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 15:49:28 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 2E0A3130049;
	Sun,  8 Jan 2012 21:49:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v4nw6hfpy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188134>

Several git commands are so-called dashed externals, that is commands
executed as a child process of the git wrapper command. If the git
wrapper is killed by a signal, the child process will continue to run.
This is different from internal commands, which always die with the git
wrapper command.

Enable the recently introduced cleanup mechanism for child processes in
order to make dashed externals act more in line with internal commands.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sat, Jan 07, 2012 at 10:26:49PM -0800, Junio C Hamano wrote:
> 
> Yeah, I agree 100% with that reasoning. I seem to recall that was how this
> commit was done in what I privately reviewed after Clemens announced his
> github branch?

What I had previously enabled child cleanup for all callers of
run_command_v_opt. There is quite a few of those as well, most of them
not related to dashed externals at all.

So I reworked that patch a bit to enable cleanup only for dashed
externals. This is a replacement for "[PATCH 2/5] run-command: kill
children on exit by default".

I also re-added Jeff's "send-pack: kill pack-objects helper on signal or
exit" and I dropped the extraneous newline that Erik spotted in
"[PATCH 1/5] run-command: optionally kill children on exit".

I have pushed the reworked series to cb/git-daemon-tests on my github
repo.

 git.c         |    2 +-
 run-command.c |    1 +
 run-command.h |    1 +
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index fb9029c..3805616 100644
--- a/git.c
+++ b/git.c
@@ -495,7 +495,7 @@ static void execv_dashed_external(const char **argv)
 	 * if we fail because the command is not found, it is
 	 * OK to return. Otherwise, we just pass along the status code.
 	 */
-	status = run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE);
+	status = run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE | RUN_CLEAN_ON_EXIT);
 	if (status >= 0 || errno != ENOENT)
 		exit(status);
 
diff --git a/run-command.c b/run-command.c
index fff9073..90bfd8c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -496,6 +496,7 @@ static void prepare_run_command_v_opt(struct child_process *cmd,
 	cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
 	cmd->silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
 	cmd->use_shell = opt & RUN_USING_SHELL ? 1 : 0;
+	cmd->clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
 }
 
 int run_command_v_opt(const char **argv, int opt)
diff --git a/run-command.h b/run-command.h
index 2a69466..44f7d2b 100644
--- a/run-command.h
+++ b/run-command.h
@@ -53,6 +53,7 @@ extern int run_hook(const char *index_file, const char *name, ...);
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
 #define RUN_SILENT_EXEC_FAILURE 8
 #define RUN_USING_SHELL 16
+#define RUN_CLEAN_ON_EXIT 32
 int run_command_v_opt(const char **argv, int opt);
 
 /*
-- 
1.7.8
