From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 09/11] Allow a relative builtin template directory.
Date: Tue, 13 Nov 2007 21:05:04 +0100
Message-ID: <1194984306-3181-10-git-send-email-johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-7-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-8-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-9-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21G-0001Be-EE
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761500AbXKMUFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761196AbXKMUFd
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:33 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49205 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762508AbXKMUFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:12 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 953C410AD33;
	Tue, 13 Nov 2007 21:05:09 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
In-Reply-To: <1194984306-3181-9-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64857>

In order to make git relocatable (i.e. not have the prefix compiled-in)
the template directory must depend on the location where this git instance
is found, which is GIT_EXEC_DIR.

The exec path is prepended only if the compiled-in default template
directory is to be used and that is relative. Any relative directories
that are specified via environment variable or the --exec-dir switch are
taken as is.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-init-db.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 763fa55..e1393b8 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "exec_cmd.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -131,10 +132,19 @@ static void copy_templates(const char *git_dir, int len, const char *template_di
 	int template_len;
 	DIR *dir;
 
-	if (!template_dir) {
+	if (!template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
-		if (!template_dir)
-			template_dir = DEFAULT_GIT_TEMPLATE_DIR;
+	if (!template_dir) {
+		/*
+		 * if the hard-coded template is relative, it is
+		 * interpreted relative to the exec_dir
+		 */
+		template_dir = DEFAULT_GIT_TEMPLATE_DIR;
+		if (!is_absolute_path(template_dir)) {
+			const char *exec_path = git_exec_path();
+			template_dir = prefix_path(exec_path, strlen(exec_path),
+						   template_dir);
+		}
 	}
 	strcpy(template_path, template_dir);
 	template_len = strlen(template_path);
-- 
1.5.3.5.1592.g0d6db
