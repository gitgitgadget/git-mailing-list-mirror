From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 4/4] Improve error message when a transport helper was not found
Date: Sun, 10 Jan 2010 14:18:39 +0100
Message-ID: <201001101418.39321.j6t@kdbg.org>
References: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi> <1263044757-12560-2-git-send-email-ilari.liusvaara@elisanet.fi> <201001101404.22258.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jan 10 14:19:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTxhp-0003Kl-Kp
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 14:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab0AJNTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 08:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196Ab0AJNTc
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 08:19:32 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:25949 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750834Ab0AJNTb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 08:19:31 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E7514CDF86;
	Sun, 10 Jan 2010 14:19:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 62F9419F610;
	Sun, 10 Jan 2010 14:18:39 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201001101404.22258.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136580>

From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>

Perviously, the error message was:

    git: 'remote-foo' is not a git-command. See 'git --help'.

By not treating the transport helper as a git command, a more suitable
error is reported:

    fatal: Unable to find remote helper for 'foo'

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 While I agree mostly with the implementation of your patch, the justification
 was completely off, and I think it was because you did not notice that the
 parent process died from SIGPIPE. When patches 1-3/4 are applied, the
 parent does not die from SIGPIPE anymore, and the issue is now only minor
 (an unsuitable error message instead of no error message). Therefore,
 I rewrote the commit message to tone it down.

 -- Hannes

 transport-helper.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 6ece0d9..d1bc3af 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -102,6 +102,7 @@ static struct child_process *get_helper(struct transport *transport)
 	int refspec_nr = 0;
 	int refspec_alloc = 0;
 	int duped;
+	int code;
 
 	if (data->helper)
 		return data->helper;
@@ -111,13 +112,18 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->out = -1;
 	helper->err = 0;
 	helper->argv = xcalloc(4, sizeof(*helper->argv));
-	strbuf_addf(&buf, "remote-%s", data->name);
+	strbuf_addf(&buf, "git-remote-%s", data->name);
 	helper->argv[0] = strbuf_detach(&buf, NULL);
 	helper->argv[1] = transport->remote->name;
 	helper->argv[2] = remove_ext_force(transport->url);
-	helper->git_cmd = 1;
-	if (start_command(helper))
-		die("Unable to run helper: git %s", helper->argv[0]);
+	helper->git_cmd = 0;
+	helper->silent_exec_failure = 1;
+	code = start_command(helper);
+	if (code < 0 && errno == ENOENT)
+		die("Unable to find remote helper for '%s'", data->name);
+	else
+		exit(code);
+
 	data->helper = helper;
 	data->no_disconnect_req = 0;
 
-- 
1.6.6.115.gd1ab3
