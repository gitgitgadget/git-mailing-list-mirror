From: Rei Thiessen <rei.thiessen@gmail.com>
Subject: [PATCH] cygwin: set write permission before unlink
Date: Wed, 29 Jun 2011 01:18:18 -0600
Message-ID: <1309331898-32247-1-git-send-email-rei.thiessen@gmail.com>
Cc: Rei Thiessen <rei.thiessen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 09:22:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbp60-0008VD-Uh
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 09:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab1F2HV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 03:21:56 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62241 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab1F2HVy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 03:21:54 -0400
Received: by pvg12 with SMTP id 12so586480pvg.19
        for <git@vger.kernel.org>; Wed, 29 Jun 2011 00:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=L1hOP3+dCRvxaU3zTO7g/Khw6qooVZYDRNnD0mnN1Xw=;
        b=kmJf43Qe62bq3fVnOvFzv5LJzW/GdUvsSMte5aOoeFKblBOIPYkFF0gbQtiMN4aMqk
         9e/Ox2cvdpz7tfiC/H4itKdWa0AO5OjoszTWLIZautWQybIfAGilFbAAXpOu+L69zCld
         rP1FnEXTcF7kdXbVfU1FKmLhfazQpava2KnxE=
Received: by 10.143.97.23 with SMTP id z23mr284356wfl.48.1309332114483;
        Wed, 29 Jun 2011 00:21:54 -0700 (PDT)
Received: from localhost.localdomain (innisfree.cs.ualberta.ca [129.128.4.225])
        by mx.google.com with ESMTPS id k4sm732412pbl.11.2011.06.29.00.21.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Jun 2011 00:21:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176438>

On Cygwin 1.7, if filesystems are mounted with the "noacl" option,
files without write permission (in particular, the temp files created
in write_loose_object()) have their "read-only" flags set in NTFS.
"read-only" files can't be unlinked.

For Cygwin, set write permissions on files that are about to be unlinked.

Signed-off-by: Rei Thiessen <rei.thiessen@gmail.com>
---
 compat/cygwin.c |    7 +++++++
 compat/cygwin.h |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/compat/cygwin.c b/compat/cygwin.c
index b4a51b9..f40ee6d 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -141,3 +141,10 @@ static int cygwin_lstat_stub(const char *file_name, struct stat *buf)
 stat_fn_t cygwin_stat_fn = cygwin_stat_stub;
 stat_fn_t cygwin_lstat_fn = cygwin_lstat_stub;
 
+#undef unlink
+int cygwin_unlink(const char *pathname)
+{
+	/* "read-only" files can't be unlinked */
+	chmod(pathname, 0666);
+	return unlink(pathname);
+}
diff --git a/compat/cygwin.h b/compat/cygwin.h
index a3229f5..aa2ba3e 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -7,3 +7,6 @@ extern stat_fn_t cygwin_lstat_fn;
 
 #define stat(path, buf) (*cygwin_stat_fn)(path, buf)
 #define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
+
+int cygwin_unlink(const char *pathname);
+#define unlink cygwin_unlink
-- 
1.7.4.1
