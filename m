From: Jim Hill <gjthill@gmail.com>
Subject: [PATCH 2/2] remove hold_lock_file_for_append
Date: Sun, 31 May 2015 11:15:23 -0700
Message-ID: <1433096123-14420-3-git-send-email-gjthill@gmail.com>
References: <1433096123-14420-1-git-send-email-gjthill@gmail.com>
Cc: git@vger.kernel.org
To: Junio Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 31 20:15:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz7lw-0007Rz-11
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 20:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758540AbbEaSPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 14:15:38 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35432 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758472AbbEaSPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 14:15:35 -0400
Received: by pdbnf5 with SMTP id nf5so29935700pdb.2
        for <git@vger.kernel.org>; Sun, 31 May 2015 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Id7aBwKRvVdI8nPyzHU48e1oKJyvCyMuB3wlfmfMZ2w=;
        b=eCnx+zwRxLbiDFkBI46xDaphluVYmQlaB7uLN0YQliXimIPthJGlzYXwJ0u5kV+f+4
         FZ4iIFDMBQfPnADFhYuo6DxsIImI9/RBD2tbW5vHzFES4ZOjvRgKtlAWOlValrEpP118
         KaAMF6lxu9ezqEEzAIsc4nDpodgSFb+yTNouIuMwzZbnE2GBovZmWdt/Ayy1zsBSeCyx
         tNC77ZyDmd4Wk1RUANJzXKSHwqe2QNUQFxhbz0k1L0Q8LwG9vPZQR+HskyVaLT6X/0j/
         gSLhPulSwV8Me2vHi+TLg1wZ6yfiHlG+FVjEIVMDNlKTcC/iCF4nJhQAWTZzujcht7Dm
         zzIA==
X-Received: by 10.68.136.42 with SMTP id px10mr34020669pbb.19.1433096134688;
        Sun, 31 May 2015 11:15:34 -0700 (PDT)
Received: from gadabout.domain.actdsltmp (pool-71-119-14-52.lsanca.dsl-w.verizon.net. [71.119.14.52])
        by mx.google.com with ESMTPSA id l10sm11826347pbq.87.2015.05.31.11.15.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 11:15:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.4.gfc728c2
In-Reply-To: <1433096123-14420-1-git-send-email-gjthill@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270342>

No uses of hold_lock_file_for_append remain, so remove it.

hold_lock_file_for_append copies its target file internally.  This makes
it too heavyweight for logging and too limited for anything else. It
shouldn't be used.

Signed-off-by: Jim Hill <gjthill@gmail.com>
---
 lockfile.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 9889277..1467778 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -187,44 +187,6 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 	return fd;
 }
 
-int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
-{
-	int fd, orig_fd;
-
-	fd = lock_file(lk, path, flags);
-	if (fd < 0) {
-		if (flags & LOCK_DIE_ON_ERROR)
-			unable_to_lock_die(path, errno);
-		return fd;
-	}
-
-	orig_fd = open(path, O_RDONLY);
-	if (orig_fd < 0) {
-		if (errno != ENOENT) {
-			int save_errno = errno;
-
-			if (flags & LOCK_DIE_ON_ERROR)
-				die("cannot open '%s' for copying", path);
-			rollback_lock_file(lk);
-			error("cannot open '%s' for copying", path);
-			errno = save_errno;
-			return -1;
-		}
-	} else if (copy_fd(orig_fd, fd)) {
-		int save_errno = errno;
-
-		if (flags & LOCK_DIE_ON_ERROR)
-			exit(128);
-		close(orig_fd);
-		rollback_lock_file(lk);
-		errno = save_errno;
-		return -1;
-	} else {
-		close(orig_fd);
-	}
-	return fd;
-}
-
 FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
 {
 	if (!lk->active)
-- 
2.4.1.4.gfc728c2
