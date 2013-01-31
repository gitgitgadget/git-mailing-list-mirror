From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 2/3] run-command: Be more informative about what failed
Date: Wed, 30 Jan 2013 18:01:05 -0800
Message-ID: <1359597666-10108-3-git-send-email-sboyd@codeaurora.org>
References: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 03:01:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0jTP-0008G0-MG
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 03:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682Ab3AaCBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 21:01:24 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:42603 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755477Ab3AaCBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 21:01:15 -0500
X-IronPort-AV: E=Sophos;i="4.84,573,1355126400"; 
   d="scan'208";a="23137437"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2013 18:01:09 -0800
Received: from sboyd-linux.qualcomm.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 4A45210004C7
	for <git@vger.kernel.org>; Wed, 30 Jan 2013 18:01:09 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.439.g50a6b54
In-Reply-To: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215086>

While debugging an error with verify_signed_buffer() the error
messages from run-command weren't very useful:

 error: cannot create pipe for gpg: Too many open files
 error: could not run gpg.

because they didn't indicate *which* pipe couldn't be created.

Print which pipe failed to be created in the error message so we
can more easily debug similar problems in the future.

For example, the above error now prints:

 error: cannot create stderr pipe for gpg: Too many open files
 error: could not run gpg.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 run-command.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 12d4ddb..016dd05 100644
--- a/run-command.c
+++ b/run-command.c
@@ -274,6 +274,7 @@ int start_command(struct child_process *cmd)
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
 	int failed_errno = failed_errno;
+	char *str;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
@@ -286,6 +287,7 @@ int start_command(struct child_process *cmd)
 			failed_errno = errno;
 			if (cmd->out > 0)
 				close(cmd->out);
+			str = "stdin";
 			goto fail_pipe;
 		}
 		cmd->in = fdin[1];
@@ -301,6 +303,7 @@ int start_command(struct child_process *cmd)
 				close_pair(fdin);
 			else if (cmd->in)
 				close(cmd->in);
+			str = "stdout";
 			goto fail_pipe;
 		}
 		cmd->out = fdout[0];
@@ -318,9 +321,10 @@ int start_command(struct child_process *cmd)
 				close_pair(fdout);
 			else if (cmd->out)
 				close(cmd->out);
+			str = "stderr";
 fail_pipe:
-			error("cannot create pipe for %s: %s",
-				cmd->argv[0], strerror(failed_errno));
+			error("cannot create %s pipe for %s: %s",
+				str, cmd->argv[0], strerror(failed_errno));
 			errno = failed_errno;
 			return -1;
 		}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
