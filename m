From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 1/2] Introduce an unlink(2) wrapper which gives warning if
	unlink failed
Date: Wed, 29 Apr 2009 23:21:46 +0200
Message-ID: <20090429212146.GA12099@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:23:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHF5-0004RC-ET
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758797AbZD2VV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbZD2VV6
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:21:58 -0400
Received: from mout3.freenet.de ([195.4.92.93]:51445 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229AbZD2VV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 17:21:56 -0400
Received: from [195.4.92.14] (helo=4.mx.freenet.de)
	by mout3.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1LzHE1-00005x-Nx; Wed, 29 Apr 2009 23:21:53 +0200
Received: from x6432.x.pppool.de ([89.59.100.50]:41631 helo=tigra.home)
	by 4.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1LzHE1-000544-Cg; Wed, 29 Apr 2009 23:21:53 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 836C0277D8;
	Wed, 29 Apr 2009 23:21:47 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 0BBF836D28; Wed, 29 Apr 2009 23:21:46 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117948>

This seem to be a very common pattern in the current code.

The function prints a generic removal failure message, the file name
which failed and readable errno presentation. The function preserves
errno and always returns the value unlink(2) returned, but prints
no message for ENOENT, as it was the most often filtered out in the
code calling unlink. Besides, removing a file is anyway the purpose of
calling unlink.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 git-compat-util.h |    6 ++++++
 wrapper.c         |   16 ++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 1ac16bd..d1d4eaf 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -415,4 +415,10 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #define fstat_is_reliable() 1
 #endif
 
+/*
+ * Preserves errno, prints a message, but gives no warning for ENOENT.
+ * Always returns the return value of unlink(2).
+ */
+int unlink_or_warn(const char *path);
+
 #endif
diff --git a/wrapper.c b/wrapper.c
index d8efb13..7eb3218 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -289,3 +289,19 @@ int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1)
 	safe_create_leading_directories(name);
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
+
+int unlink_or_warn(const char *file)
+{
+	int rc = unlink(file);
+
+	if (rc < 0) {
+		int err = errno;
+		if (ENOENT != err) {
+			warning("unable to unlink %s: %s",
+				file, strerror(errno));
+			errno = err;
+		}
+	}
+	return rc;
+}
+
-- 
1.6.3.rc3.39.g49fd5
