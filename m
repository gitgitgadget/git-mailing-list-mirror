From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/24] wrapper.c: remove/unlink_or_warn: simplify, treat
 ENOENT as success
Date: Wed, 1 Oct 2014 18:54:35 -0700
Message-ID: <20141002015435.GU1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 03:54:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVbO-000517-Kg
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 03:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbaJBByj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 21:54:39 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36884 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbaJBByi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 21:54:38 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so1333197pad.15
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=p+frubaTXD/Z04IPTzvInU0uanuVMyTwkVNH2RojDts=;
        b=NBp/1G0y0b5mnf3r+frQqCNez2Rfg6TtiOiSECm9qE7YM7nSd0kGntzAX5UnGutYHW
         0Lie1DfbwXjn9J1QpAIT9A8emz6J4spOXgVQLT0rUQNHOMdV3EfXlBMZSMwTfejKK/Zj
         cKqGiuicEEDYoihocr8zwvcvTxLij4L+vVTkJXfBZEHjXjhdNA16Vl9rnBel5uljkxlj
         1NjnPXV++elCR751f/CqdXgcYj2su2WOXdy5FP4ojXgqrjWVW8bL5rUhIicrKRruorSy
         qjziuZsOKRHZ+jykXDjYi2ANBPix6yXd2lEcc45gzXXclGqjbS4vx5oOb4+3Oke4R+s7
         OdIw==
X-Received: by 10.68.209.138 with SMTP id mm10mr83194446pbc.88.1412214877934;
        Wed, 01 Oct 2014 18:54:37 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id c3sm2132558pbu.15.2014.10.01.18.54.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 18:54:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257773>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Jul 2014 11:01:18 -0700

Simplify the function warn_if_unremovable slightly. Additionally, change
behaviour slightly. If we failed to remove the object because the object
does not exist, we can still return success back to the caller since none of
the callers depend on "fail if the file did not exist".

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Change since v21:
- adjust caller to remove redundant errno check

 git-compat-util.h |  7 +++++--
 refs.c            |  2 +-
 wrapper.c         | 14 ++++++--------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b6f03b3..611e77b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -706,11 +706,14 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
- * Always returns the return value of unlink(2).
+ * Returns 0 on success which includes trying to unlink an object that does
+ * not exist.
  */
 int unlink_or_warn(const char *path);
 /*
- * Likewise for rmdir(2).
+ * Preserves errno, prints a message, but gives no warning for ENOENT.
+ * Returns 0 on success which includes trying to remove a directory that does
+ * not exist.
  */
 int rmdir_or_warn(const char *path);
 /*
diff --git a/refs.c b/refs.c
index 7235574..d0565b1 100644
--- a/refs.c
+++ b/refs.c
@@ -2557,7 +2557,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 		lock->lk->filename[i] = 0;
 		err = unlink_or_warn(lock->lk->filename);
 		lock->lk->filename[i] = '.';
-		if (err && errno != ENOENT)
+		if (err)
 			return 1;
 	}
 	return 0;
diff --git a/wrapper.c b/wrapper.c
index bc1bfb8..c9605cd 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -429,14 +429,12 @@ int xmkstemp_mode(char *template, int mode)
 
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
