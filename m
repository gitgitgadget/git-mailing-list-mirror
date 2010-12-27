From: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
Subject: [PATCH] setup: translate symlinks in filename when using absolute paths
Date: Mon, 27 Dec 2010 02:54:37 -0800
Message-ID: <1293447277-30598-1-git-send-email-carenas@sajinet.com.pe>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 27 11:54:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXAj0-0002aI-Na
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 11:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab0L0Kyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 05:54:41 -0500
Received: from sajino.sajinet.com.pe ([76.74.239.193]:49768 "EHLO
	sajino.sajinet.com.pe" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab0L0Kyk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 05:54:40 -0500
Received: by sajino.sajinet.com.pe (Postfix, from userid 65534)
	id 58E66A580F7; Mon, 27 Dec 2010 10:54:38 +0000 (UTC)
Received: from dell.sajinet.com.pe (dsl081-071-036.sfo1.dsl.speakeasy.net [64.81.71.36])
	by sajino.sajinet.com.pe (Postfix) with ESMTP id 0CBBAA580A8
	for <git@vger.kernel.org>; Mon, 27 Dec 2010 10:54:37 +0000 (UTC)
X-Mailer: git-send-email 1.7.3.4.626.g73e7b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164218>

otherwise, comparison to validate against work tree will fail when
the path includes a symlink and the name passed is not canonical.

Signed-off-by: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
---
 setup.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 91887a4..e7c0d4d 100644
--- a/setup.c
+++ b/setup.c
@@ -7,10 +7,13 @@ static int inside_work_tree = -1;
 char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
-	char *sanitized = xmalloc(len + strlen(path) + 1);
-	if (is_absolute_path(orig))
-		strcpy(sanitized, path);
-	else {
+	char *sanitized;
+	if (is_absolute_path(orig)) {
+		const char *temp = make_absolute_path(path);
+		sanitized = xmalloc(len + strlen(temp) + 1);
+		strcpy(sanitized, temp);
+	} else {
+		sanitized = xmalloc(len + strlen(path) + 1);
 		if (len)
 			memcpy(sanitized, prefix, len);
 		strcpy(sanitized + len, path);
-- 
1.7.3.4.626.g73e7b.dirty
