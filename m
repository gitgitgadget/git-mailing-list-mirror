From: bert Dvornik <dvornik+git@gmail.com>
Subject: [PATCH] start_command: close cmd->err descriptor when fork/spawn fails
Date: Sun, 25 Apr 2010 21:15:40 -0400
Message-ID: <1272244540-5960-1-git-send-email-dvornik+git@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	bert Dvornik <dvornik+git@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Apr 26 03:17:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Cx8-000483-HE
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 03:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab0DZBRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 21:17:21 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56087 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab0DZBRU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 21:17:20 -0400
Received: by vws17 with SMTP id 17so1073781vws.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 18:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=ctJ5NBLMgYD2AnfbVFOmtLY274C2lUw2PIMxQCq6UaQ=;
        b=ixOHUoWoC9c6EBc+WbxlgIBbVZTxnlCkEe28nz7ykwWVoyxfP77MJ4bwORdvExwc6W
         u4+fKS+vNfZqlPqSp/UMR1UBRh//AqCEIdDRgGgOMD2jpU9wC6jPmeJFghiBEY0TVQqR
         EEtUd4zyArrcDndXhAP493GzMlh1zOggf9Sxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=XDDgWC/WRnGTMi3BhOuOd5MdZGH/eqAadTYdAAtCl8mchBDDpYjUOBYnOU5loLWSsi
         DEhGjBumq+b3yfezsAF9WOpslLwX7M4uRYSqSDu9ZWzjSH7qVhuw56UUFtwwJIp/syRQ
         yJT9l8i6rniZ9tXeTtDFp1ktE7tlMlbrRUbDA=
Received: by 10.220.127.11 with SMTP id e11mr1432931vcs.125.1272244639176;
        Sun, 25 Apr 2010 18:17:19 -0700 (PDT)
Received: from localhost (pool-96-237-1-59.bstnma.east.verizon.net [96.237.1.59])
        by mx.google.com with ESMTPS id i29sm17323658vcr.0.2010.04.25.18.17.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 18:17:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.1794.g4bea1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145777>

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

I'm not sure why (or if) this problem hasn't cropped up under Linux.
The non-Windows code *does* try to check for execve() failures in the
child, in addition to the fork() failures.

Signed-off-by: bert Dvornik <dvornik+git@gmail.com>
---
 run-command.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index d1a8ceb..41666ac 100644
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
-- 
1.7.1.rc1.1794.g4bea1
