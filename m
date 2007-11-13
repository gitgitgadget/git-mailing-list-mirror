From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
Date: Tue, 13 Nov 2007 21:05:06 +0100
Message-ID: <1194984306-3181-12-git-send-email-johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-7-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-8-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-9-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-10-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-11-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:06:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21H-0001Be-Pt
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761507AbXKMUFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761196AbXKMUFi
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:38 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49200 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761509AbXKMUFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:12 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 700FF10AD3D;
	Tue, 13 Nov 2007 21:05:10 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
In-Reply-To: <1194984306-3181-11-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64856>

If ETC_GITCONFIG is not an absolute path, interpret it relative to
--exec-dir. This makes the installed binaries relocatable because the
prefix is not compiled-in.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 config.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index dd7e9ad..9f014bb 100644
--- a/config.c
+++ b/config.c
@@ -6,6 +6,7 @@
  *
  */
 #include "cache.h"
+#include "exec_cmd.h"
 
 #define MAXNAME (256)
 
@@ -454,7 +455,17 @@ int git_config_from_file(config_fn_t fn, const char *filename)
 
 const char *git_etc_gitconfig(void)
 {
-	return ETC_GITCONFIG;
+	static const char *system_wide;
+	if (!system_wide) {
+		system_wide = ETC_GITCONFIG;
+		if (!is_absolute_path(system_wide)) {
+			/* interpret path relative to exec-dir */
+			const char *exec_path = git_exec_path();
+			system_wide = prefix_path(exec_path, strlen(exec_path),
+						system_wide);
+		}
+	}
+	return system_wide;
 }
 
 int git_config(config_fn_t fn)
-- 
1.5.3.5.1592.g0d6db
