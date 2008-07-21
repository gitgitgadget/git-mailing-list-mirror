From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 8/9] Windows: Make sure argv[0] has a path
Date: Mon, 21 Jul 2008 21:19:57 +0200
Message-ID: <1216667998-8879-9-git-send-email-johannes.sixt@telecom.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-3-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-4-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-5-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-6-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-7-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-8-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:21:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL0x3-00025p-Py
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 21:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbYGUTU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 15:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754672AbYGUTUZ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 15:20:25 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:39828 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbYGUTUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 15:20:04 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 2CBD033EE1;
	Mon, 21 Jul 2008 21:20:03 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.18.g6aef2
In-Reply-To: <1216667998-8879-8-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89387>

Since the exec-path on Windows is derived from the program invocation path,
we must ensure that argv[0] always has a path. Unfortunately, if a program
is invoked from CMD, argv[0] has no path. But on the other hand, the
C runtime offers a global variable, _pgmptr, that always has the full path
to the program. We hook into main() with a preprocessor macro, where we
replace argv[0].

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 8ffec51..290a9e6 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -223,3 +223,15 @@ void mingw_open_html(const char *path);
 char **copy_environ(void);
 void free_environ(char **env);
 char **env_setenv(char **env, const char *name);
+
+/*
+ * A replacement of main() that ensures that argv[0] has a path
+ */
+
+#define main(c,v) main(int argc, const char **argv) \
+{ \
+	static int mingw_main(); \
+	argv[0] = xstrdup(_pgmptr); \
+	return mingw_main(argc, argv); \
+} \
+static int mingw_main(c,v)
-- 
1.6.0.rc0.18.g6aef2
