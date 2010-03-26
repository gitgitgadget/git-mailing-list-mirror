From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 04/12] Generalise the unlink_or_warn function
Date: Fri, 26 Mar 2010 15:25:32 +0000
Message-ID: <1269617140-7827-5-git-send-email-peter@pcc.me.uk>
References: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:26:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBQA-0005Ty-RU
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293Ab0CZPZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:25:57 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:55539 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754231Ab0CZPZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:25:56 -0400
Received: from [10.179.145.9] (helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ2-0001o5-BV; Fri, 26 Mar 2010 15:25:54 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ1-00023D-3j; Fri, 26 Mar 2010 15:25:53 +0000
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143238>

This patch moves the warning code of the unlink_or_warn function into
a separate function named warn_if_unremovable so that it may be reused.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 wrapper.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 9c71b21..0bbff56 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -311,18 +311,20 @@ int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
-int unlink_or_warn(const char *file)
+static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
-	int rc = unlink(file);
-
 	if (rc < 0) {
 		int err = errno;
 		if (ENOENT != err) {
-			warning("unable to unlink %s: %s",
-				file, strerror(errno));
+			warning("unable to %s %s: %s",
+				op, file, strerror(errno));
 			errno = err;
 		}
 	}
 	return rc;
 }
 
+int unlink_or_warn(const char *file)
+{
+	return warn_if_unremovable("unlink", file, unlink(file));
+}
-- 
1.6.5
