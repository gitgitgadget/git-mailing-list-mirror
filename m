From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Fix misuse of prefix_path()
Date: Tue, 05 Feb 2008 09:17:33 +0100
Message-ID: <47A81B9D.3090209@viscovery.net>
References: <7v3as9mce7.fsf@gitster.siamese.dyndns.org> <1202123606.47a6f3567ebb9@webmail.eunet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 09:18:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMJ0Q-0003wS-4U
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 09:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbYBEIRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 03:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754255AbYBEIRk
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 03:17:40 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50265 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172AbYBEIRj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 03:17:39 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JMIzT-0001if-PL; Tue, 05 Feb 2008 09:17:16 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0B49169F; Tue,  5 Feb 2008 09:17:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1202123606.47a6f3567ebb9@webmail.eunet.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72632>

From: Johannes Sixt <johannes.sixt@telecom.at>

When DEFAULT_GIT_TEMPLATE_DIR is specified as a relative path,
init-db made it relative to exec_path using prefix_path(), which
is wrong.  prefix_path() is about a file inside the work tree.
There was a similar misuse in config.c that takes relative
ETC_GITCONFIG path. Noticed by Junio C Hamano.

We concatenate the paths manually. (prefix_filename() won't do
because it expects a prefix with a trailing '/'.)

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-init-db.c |    6 +++---
 config.c          |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index e1393b8..5d7cdda 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -141,9 +141,9 @@ static void copy_templates(const char *git_dir, int len, const char *template_di
 		 */
 		template_dir = DEFAULT_GIT_TEMPLATE_DIR;
 		if (!is_absolute_path(template_dir)) {
-			const char *exec_path = git_exec_path();
-			template_dir = prefix_path(exec_path, strlen(exec_path),
-						   template_dir);
+			struct strbuf d = STRBUF_INIT;
+			strbuf_addf(&d, "%s/%s", git_exec_path(), template_dir);
+			template_dir = strbuf_detach(&d, NULL);
 		}
 	}
 	strcpy(template_path, template_dir);
diff --git a/config.c b/config.c
index 526a3f4..498259e 100644
--- a/config.c
+++ b/config.c
@@ -484,9 +484,9 @@ const char *git_etc_gitconfig(void)
 		system_wide = ETC_GITCONFIG;
 		if (!is_absolute_path(system_wide)) {
 			/* interpret path relative to exec-dir */
-			const char *exec_path = git_exec_path();
-			system_wide = prefix_path(exec_path, strlen(exec_path),
-						system_wide);
+			struct strbuf d = STRBUF_INIT;
+			strbuf_addf(&d, "%s/%s", git_exec_path(), system_wide);
+			system_wide = strbuf_detach(&d, NULL);
 		}
 	}
 	return system_wide;
-- 
1.5.4.rc5.842.ge7ba5
