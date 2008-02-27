From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 31/40] Compute the ultimate fallback for exec_path from the program invocation.
Date: Wed, 27 Feb 2008 19:54:54 +0100
Message-ID: <1204138503-6126-32-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVS-00022R-Vk
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320AbYB0Sz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbYB0Sz4
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:56 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40427 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755656AbYB0SzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:12 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 0DB8897609;
	Wed, 27 Feb 2008 19:55:10 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75266>

Since on Windows the user is fairly free where to install programs, we
cannot rely on a hard-coded path. We use the program name to derive the
installation directory and use that as exec_path.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 exec_cmd.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 3f3fa79..6d2f740 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -8,7 +8,36 @@ static const char *argv_exec_path;
 
 static const char *builtin_exec_path(void)
 {
+#ifndef __MINGW32__
 	return GIT_EXEC_PATH;
+#else
+	int len;
+	char *p, *q, *sl;
+	static char *ep;
+	if (ep)
+		return ep;
+
+	len = strlen(_pgmptr);
+	if (len < 2)
+		return ep = ".";
+
+	p = ep = xmalloc(len+1);
+	q = _pgmptr;
+	sl = NULL;
+	/* copy program name, turn '\\' into '/', skip last part */
+	while ((*p = *q)) {
+		if (*q == '\\' || *q == '/') {
+			*p = '/';
+			sl = p;
+		}
+		p++, q++;
+	}
+	if (sl)
+		*sl = '\0';
+	else
+		ep[0] = '.', ep[1] = '\0';
+	return ep;
+#endif
 }
 
 void git_set_argv_exec_path(const char *exec_path)
-- 
1.5.4.1.126.ge5a7d
