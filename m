From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/19] wrapper.c: remove/unlink_or_warn: simplify, treat
 ENOENT as success
Date: Wed, 10 Sep 2014 20:04:44 -0700
Message-ID: <20140911030444.GF18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:04:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRugl-0008NM-Qt
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbaIKDEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:04:48 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33014 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbaIKDEr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:04:47 -0400
Received: by mail-pd0-f171.google.com with SMTP id p10so9544470pdj.30
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oItTEUGpnxUGUX27cRAN7BvTWFD5uYAYDfWz5Hd+RE8=;
        b=qrTp7+lWgZb6+L9DGPdmgKpXD5ye29mVR/8KWICQu7yUWXnKV+YYjEttv9vF3x8v3s
         /3x4qdyDRaQFxQaNeUjWFrAkdCBPOCDodJqoxgv357aC/TPVBZ3C4PSh8H/0na77rb+f
         JFcYx/sAVqfKQEkfeySZHGIfenvbAaCb/2/1MAAVl3xHFJUzeIYl2eGxL0/bfHiyHAND
         niNyDy0BgYzziRWND5wllxbMDlAULs6Kufffsle6jDvDjgdv3aVuUmEIwCsVHy8HE+zf
         EWkS2UE4e0sJtZNloDMd6awIWWQaLJgOfp+GTv//gT9OsDj8J3AxEsHv9+2oj8UZJW8o
         WQkQ==
X-Received: by 10.69.25.35 with SMTP id in3mr43706696pbd.63.1410404687203;
        Wed, 10 Sep 2014 20:04:47 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id f12sm16675036pat.36.2014.09.10.20.04.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:04:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256814>

From: Ronnie Sahlberg <sahlberg@google.com>

Simplify the function warn_if_unremovable slightly. Additionally, change
behaviour slightly. If we failed to remove the object because the object
does not exist, we can still return success back to the caller since none of
the callers depend on "fail if the file did not exist".

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-compat-util.h |  7 +++++--
 wrapper.c         | 14 ++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

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
