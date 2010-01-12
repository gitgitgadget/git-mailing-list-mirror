From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [BUGFIX] Unbork remote helper execution
Date: Tue, 12 Jan 2010 20:53:29 +0100
Message-ID: <201001122053.29568.j6t@kdbg.org>
References: <1263321344-21237-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 12 20:54:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUmoz-0000Qs-H0
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 20:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab0ALTy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 14:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844Ab0ALTy3
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 14:54:29 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:59163 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753832Ab0ALTy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 14:54:28 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A5D80CDF89;
	Tue, 12 Jan 2010 20:54:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CCAD719F596;
	Tue, 12 Jan 2010 20:53:29 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1263321344-21237-1-git-send-email-ilari.liusvaara@elisanet.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136756>

[added git@vger]

On Dienstag, 12. Januar 2010, Ilari Liusvaara wrote:
> Someone that obiviously didn't test the change did the following (the
> code blames to me, but I didn't write this):
>
> code = start_command(helper);
> if (code < 0 && errno == ENOENT)
> 	die("Unable to find remote helper for '%s'", data->name);
> else
> 	exit(code);
>
> Which is obiviously wrong. The code shouldn't exit if code is 0.

Duh! Sorry for that. Your original code indeed has 'else if (code != 0)'.

Thanks for catching this. BTW, the test suite passes nevertheless.
Aren't there any tests that exercise the code path, or do I have them
disabled somehow? So, yes: I didn't test the change.

Here is the amended commit that replaces the tip of js/exec-error-report,
with some light testing this time.
--- 8< ---
From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH] Improve error message when a transport helper was not found

Perviously, the error message was:

    git: 'remote-foo' is not a git-command. See 'git --help'.

By not treating the transport helper as a git command, a more suitable
error is reported:

    fatal: Unable to find remote helper for 'foo'

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 transport-helper.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 6ece0d9..7dce4a4 100644
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
+	else if (code != 0)
+		exit(code);
+
 	data->helper = helper;
 	data->no_disconnect_req = 0;
 
-- 
1.6.6.115.gd1ab3
