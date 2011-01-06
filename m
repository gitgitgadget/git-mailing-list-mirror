From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] alias: use run_command api to execute aliases
Date: Thu,  6 Jan 2011 20:13:07 +0100
Message-ID: <1294341187-3956-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 20:13:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PavH6-0008Td-4Y
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 20:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663Ab1AFTNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 14:13:23 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39728 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab1AFTNW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 14:13:22 -0500
Received: by ewy5 with SMTP id 5so7516206ewy.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 11:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=aoer2xXVC1wGF8Smx3DCR8FXxSvsikmsdqWAMW1jHkA=;
        b=tbHkG9+ck3O1puyztpXuWWtXXj9lud+Ww98kwarLYZvZkWaj9k4M9DwfNB8iU5ZuOv
         XmdLgciLhUsAlnK5dfMnEXEQTeLwQZ/gJZl5rw7YmFJ6efEwpifePB8rzQoPNFDYvkQZ
         7PyEnAg6d+UaO08YCKss1b4kmqeQhvqyK+cpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xXufBSMSQxWYxFT+aiY5Ka8rGXpyt04n7pFUatAAtVrC/Ak2ioDboGA1XRmdmKnHrJ
         OsOh+4QdVXejcWWf+EtpQgp+KCVRbStKfrFnv2NVEFSZjOf3J1tiWF5sq7lYsJv0qUkq
         vd8DdH4nztkKPSpPEhmHYtiMHDFeMaQPvb3j4=
Received: by 10.213.27.71 with SMTP id h7mr748278ebc.21.1294341201153;
        Thu, 06 Jan 2011 11:13:21 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q58sm1550047eeh.3.2011.01.06.11.13.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 11:13:20 -0800 (PST)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164656>

On Windows, system() executes with cmd.exe instead of /bin/sh. This
means that aliases currently has to be batch-scripts instead of
bourne-scripts. On top of that, cmd.exe does not handle single quotes,
which is what the code-path currently uses to handle arguments with
spaces.

To solve both problems in one go, use run_command_v_opt() to execute
the alias. It already does the right thing prepend "sh -c " to the
alias.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

This fixes issue 553 in the msysGit issue tracker.

 git.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/git.c b/git.c
index 68334f6..5b0b9d8 100644
--- a/git.c
+++ b/git.c
@@ -177,19 +177,20 @@ static int handle_alias(int *argcp, const char ***argv)
 	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
 		if (alias_string[0] == '!') {
+			const char **alias_argv;
+			int i;
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
+
+			/* build alias_argv */
+			alias_argv = malloc(sizeof(char *) * *argcp + 1);
+			alias_argv[0] = alias_string + 1;
+			for (i = 1; i < *argcp; ++i)
+				alias_argv[i] = (*argv)[i];
+			alias_argv[*argcp] = NULL;
+
+			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
+
 			if (ret >= 0 && WIFEXITED(ret) &&
 			    WEXITSTATUS(ret) != 127)
 				exit(WEXITSTATUS(ret));
-- 
1.7.3.3.585.g74f6e
