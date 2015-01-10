From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] git.c: prevent change of environment variables
Date: Sat, 10 Jan 2015 18:53:36 +0600
Message-ID: <1420894416-22615-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 13:54:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9vYH-0007zN-0V
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 13:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbbAJMx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 07:53:56 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59038 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbbAJMxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 07:53:55 -0500
Received: by mail-lb0-f174.google.com with SMTP id 10so12549768lbg.5
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 04:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XPMt0o/uijZWBJ7qZP63WWhF8FCQ9Aw8emb+tSbMZdk=;
        b=XZ5iFqTYHGb5tSTo4/IXHI2/pZT6lzk1Ud60mru0Cioet43cTd52Uc08AE0Ka+oOVo
         CtiFIHqeEYa2/AnzO4abYC2sopvuppEcVxlPSTfOaEbgR8e4CiBPOy1dCYPonSFVpmrc
         9ONlWVK4adiUMZlNsAuYNwA/OmRCnDxcwOyL3GUyR1DhMTa3cnVjYiG2l/hHkFPRNHr1
         wwmPmOsWNsPEWZgaXrXbCc/LAv+zU8fVtA697rdQTdQb83JpEwEwuq6lqv7CEpJwZA8G
         AxHYrhYafRhz3Au2CADQdQ7uNKtQ3452YNg//xkpq/P7ZNG5YIgyi9ISHdkDxOuYLauE
         pbgg==
X-Received: by 10.152.20.98 with SMTP id m2mr27088373lae.49.1420894433535;
        Sat, 10 Jan 2015 04:53:53 -0800 (PST)
Received: from localhost.localdomain ([95.59.92.204])
        by mx.google.com with ESMTPSA id bs3sm2543269lbd.37.2015.01.10.04.53.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jan 2015 04:53:52 -0800 (PST)
X-Mailer: git-send-email 2.2.1.531.g5addc96.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262260>

We can't change environment variables in aliases which doesn't start with '!'

* 'git --exec-path=path' changes $GIT_EXEC_PATH variable in
git_set_argv_exec_path

* 'git -p/--paginate' sets 'use_pager' to 1 and commit_pager_choice
will change $GIT_PAGER_IN_USE variable in setup_pager(void) from pager.c

* 'git -c' calls git_config_push_parameter which will change
$GIT_CONFIG_PARAMETERS variable

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 git.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index c9bec99..3e87f05 100644
--- a/git.c
+++ b/git.c
@@ -89,8 +89,11 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		 * Check remaining flags.
 		 */
 		if (skip_prefix(cmd, "--exec-path", &cmd)) {
-			if (*cmd == '=')
+			if (*cmd == '=') {
 				git_set_argv_exec_path(cmd + 1);
+				if (envchanged)
+					*envchanged = 1;
+			}
 			else {
 				puts(git_exec_path());
 				exit(0);
@@ -106,6 +109,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			use_pager = 1;
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--no-pager")) {
 			use_pager = 0;
 			if (envchanged)
@@ -171,6 +176,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				usage(git_usage_string);
 			}
 			git_config_push_parameter((*argv)[1]);
+			if (envchanged)
+				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
 		} else if (!strcmp(cmd, "--literal-pathspecs")) {
-- 
2.2.1.531.g5addc96.dirty
