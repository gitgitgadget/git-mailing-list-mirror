From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3] alias: use run_command api to execute aliases
Date: Fri,  7 Jan 2011 00:00:38 +0100
Message-ID: <1294354838-6336-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 07 00:01:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaypJ-0000W7-6M
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 00:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab1AFXAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 18:00:55 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41465 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab1AFXAy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 18:00:54 -0500
Received: by ewy5 with SMTP id 5so7605222ewy.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 15:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ks6f6dDQ5CTGaoXfdUTAa8cqsXy0sRMrYN3dg710BiA=;
        b=SCArXqrZjS6TbkJ8r/A2qT777MqKQBxNlW7AYCqKCzVzKy9zrm6381YW1uLxaEA2/G
         as28osssBqwc0SpAyqet6H5zoGUf3ER5+uTDbbcuM31PHCAzgxDLlbMTIUWm7MAJzQ62
         XBMz681JQU3QGcrCJgz79NMmv5TO6DOAFJq9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AYvLXFQQ4ccNz5C7gHbAoPJOQ/5xKmp4vMKeWvj+7SyLWtxpDfzhi3VU/jtPjJ4PTd
         ro/AzdUM33Feg//rMi+71b+z/gAyeCwYwdqiMe5xjkm1GAxAwWXszhKvekum8z2w/D9U
         c/AdmVFnhESHDGzYfu8bPXIgqQQY976WjivB0=
Received: by 10.213.7.17 with SMTP id b17mr905673ebb.44.1294354853154;
        Thu, 06 Jan 2011 15:00:53 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id t5sm1698072eeh.14.2011.01.06.15.00.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 15:00:52 -0800 (PST)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164685>

On Windows, system() executes with cmd.exe instead of /bin/sh. This
means that aliases currently has to be batch-scripts instead of
bourne-scripts. On top of that, cmd.exe does not handle single quotes,
which is what the code-path currently uses to handle arguments with
spaces.

To solve both problems in one go, use run_command_v_opt() to execute
the alias. It already does the right thing prepend "sh -c " to the
alias.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---

Fixed the issues pointed out by Jonathan Nieder. For real this time.
Also changed die to die_errno, as suggested by Johannes Sixt.

 git.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/git.c b/git.c
index 68334f6..23610aa 100644
--- a/git.c
+++ b/git.c
@@ -177,24 +177,24 @@ static int handle_alias(int *argcp, const char ***argv)
 	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
 		if (alias_string[0] == '!') {
+			const char **alias_argv;
+			int argc = *argcp, i;
+
 			commit_pager_choice();
-			if (*argcp > 1) {
-				struct strbuf buf;
-
-				strbuf_init(&buf, PATH_MAX);
-				strbuf_addstr(&buf, alias_string);
-				sq_quote_argv(&buf, (*argv) + 1, PATH_MAX);
-				free(alias_string);
-				alias_string = buf.buf;
-			}
-			trace_printf("trace: alias to shell cmd: %s => %s\n",
-				     alias_command, alias_string + 1);
-			ret = system(alias_string + 1);
-			if (ret >= 0 && WIFEXITED(ret) &&
-			    WEXITSTATUS(ret) != 127)
-				exit(WEXITSTATUS(ret));
-			die("Failed to run '%s' when expanding alias '%s'",
-			    alias_string + 1, alias_command);
+
+			/* build alias_argv */
+			alias_argv = xmalloc(sizeof(*alias_argv) * (argc + 1));
+			alias_argv[0] = alias_string + 1;
+			for (i = 1; i < argc; ++i)
+				alias_argv[i] = (*argv)[i];
+			alias_argv[argc] = NULL;
+
+			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
+			if (ret >= 0)   /* normal exit */
+				exit(ret);
+
+			die_errno("While expanding alias '%s': '%s'",
+			    alias_command, alias_string + 1);
 		}
 		count = split_cmdline(alias_string, &new_argv);
 		if (count < 0)
-- 
1.7.3.3.585.g74f6e
