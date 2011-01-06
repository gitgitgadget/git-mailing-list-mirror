From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2] alias: use run_command api to execute aliases
Date: Thu,  6 Jan 2011 20:54:09 +0100
Message-ID: <1294343649-6272-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 20:54:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pavun-0007dY-Ox
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 20:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab1AFTyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 14:54:25 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55992 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab1AFTyY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 14:54:24 -0500
Received: by ewy5 with SMTP id 5so7535184ewy.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 11:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=n+5e4rKVlvdaHpSaOdM+DdmPX2gRcrLXy2MUxEKa4yg=;
        b=r0fC705rsxYj6IUhX02bUfoP83cWIY7SKWDHSljtOTiO+tbQMdn87glfJ5TmMgwaf3
         SCvEZKH/D9YYV8BrZmAWZOcjKI1BHo9W3BD7txXmpc5CUYg6N/TjJxw57QBctQH4uq96
         Cdyq8ONLz2MqOmUcYKxLuQK1QXD1BEwY2qDy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Xh1LIX2vhKmTKb2WdZ4ju6Ahb23lMlbzXniHKj1RKJUN8NC1ysnCRksZ00q7Ar+tfc
         w9N90DbEpDIl38icRAGe0kEJYsGzBdVCZir9nAQLRUDRRUKz+FkOutSDtKu0huxiNezG
         kHyVweUeyZtJe47DLHr2sh3rpVBPQe//dEWuY=
Received: by 10.213.108.201 with SMTP id g9mr744761ebp.92.1294343663602;
        Thu, 06 Jan 2011 11:54:23 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id t5sm1573685eeh.20.2011.01.06.11.54.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 11:54:22 -0800 (PST)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164663>

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

Fixed the issues pointed out by Jonathan Nieder.

 git.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/git.c b/git.c
index 68334f6..f3666a8 100644
--- a/git.c
+++ b/git.c
@@ -177,22 +177,22 @@ static int handle_alias(int *argcp, const char ***argv)
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
+
+			/* build alias_argv */
+			alias_argv = xmalloc(sizeof(char *) * argc + 1);
+			alias_argv[0] = alias_string + 1;
+			for (i = 1; i < argc; ++i)
+				alias_argv[i] = (*argv)[i];
+			alias_argv[argc] = NULL;
+
+			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
+			if (ret >= 0)   /* normal exit */
+				exit(ret);
+
 			die("Failed to run '%s' when expanding alias '%s'",
 			    alias_string + 1, alias_command);
 		}
-- 
1.7.3.3.585.g74f6e
