From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/25] wrapper.c: remove/unlink_or_warn: simplify, treat
 ENOENT as success
Date: Tue, 14 Oct 2014 17:46:53 -0700
Message-ID: <20141015004653.GF32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:47:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCk1-0007tL-46
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbaJOAq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:46:57 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:39030 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691AbaJOAq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:46:56 -0400
Received: by mail-pd0-f170.google.com with SMTP id p10so230000pdj.1
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/0aYgHDOgUKsylJ5LH2yo8a+HEwhVK7qyGeGmLtnDYg=;
        b=N0nYAECR6JulOKwHdqFukjNWy1BMBXdckw9OrLj4Knd7zJM6WW50tAuxtCFpUCzDRU
         CGH9ucANl6jjQJ6ONpnrbGx52snYCpMLemPojKfS1JldV1IbzOgCWiGkR5/UOrrDQKS0
         taUtKNk7fPxalpzSR+MgtjYO+AaoUaBO9ocmDXEa7d/BRv7/d/cd6T2Uel8FpNBgAI0l
         2uEvaCMwusedE78statyC6qAb7ha5ZAFQawFMHbMdEJn2pKAwN2nKgdlRaXAn9dICiTU
         g10KpcLhRmVqGLQpAYvuSs2Mhl71d46ruMoiF8cWol75AdrhAcFlvROzZH/YvYjufnte
         Q0Hw==
X-Received: by 10.68.164.4 with SMTP id ym4mr8257036pbb.123.1413334016512;
        Tue, 14 Oct 2014 17:46:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id ve10sm15278161pbc.65.2014.10.14.17.46.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:46:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Jul 2014 11:01:18 -0700

Simplify the function warn_if_unremovable slightly. Additionally, change
behaviour slightly. If we failed to remove the object because the object
does not exist, we can still return success back to the caller since none of
the callers depend on "fail if the file did not exist".

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-compat-util.h |  7 +++++--
 refs.c            |  2 +-
 wrapper.c         | 14 ++++++--------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index fb41118..d67592f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -777,11 +777,14 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
- * Always returns the return value of unlink(2).
+ * Returns 0 on success, which includes trying to unlink an object that does
+ * not exist.
  */
 int unlink_or_warn(const char *path);
 /*
- * Likewise for rmdir(2).
+ * Preserves errno, prints a message, but gives no warning for ENOENT.
+ * Returns 0 on success, which includes trying to remove a directory that does
+ * not exist.
  */
 int rmdir_or_warn(const char *path);
 /*
diff --git a/refs.c b/refs.c
index a77458f..2dcf6c6 100644
--- a/refs.c
+++ b/refs.c
@@ -2607,7 +2607,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 		char *loose_filename = get_locked_file_path(lock->lk);
 		int err = unlink_or_warn(loose_filename);
 		free(loose_filename);
-		if (err && errno != ENOENT)
+		if (err)
 			return 1;
 	}
 	return 0;
diff --git a/wrapper.c b/wrapper.c
index 5b77d2a..8d4be66 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -466,14 +466,12 @@ int xmkstemp_mode(char *template, int mode)
 
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
-	if (rc < 0) {
-		int err = errno;
-		if (ENOENT != err) {
-			warning("unable to %s %s: %s",
-				op, file, strerror(errno));
-			errno = err;
-		}
-	}
+	int err;
+	if (!rc || errno == ENOENT)
+		return 0;
+	err = errno;
+	warning("unable to %s %s: %s", op, file, strerror(errno));
+	errno = err;
 	return rc;
 }
 
-- 
2.1.0.rc2.206.gedb03e5
