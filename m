From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/25] wrapper.c: add a new function unlink_or_msg
Date: Tue, 14 Oct 2014 17:47:37 -0700
Message-ID: <20141015004737.GH32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:47:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCkj-0008Mm-Gk
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbaJOArm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:47:42 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:60553 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbaJOArl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:47:41 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so212741pdb.25
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NXqnhwgKMIGw198cEJxZCVy/0/4/1QpwOEJb2QuzMUc=;
        b=IEgp22b9Ll53RBU5e3NtbEXpR2wIFN93f31CuhSwnxsbTpx+7ISmFN0/crL+aPdOd8
         kJbuRlwVxrOWQKa4aj4yHNsY4i+TWD6b1JwSeQkIIKei0w0NKJJPHTg+g3b73INRdAls
         dqrgwaHQ5sSx9qS+pO3mQxGGgYNiA9OKridtl1Tu71Vem0YsToBQFf+ckFj4u68E74nt
         HHgR7EYvR/lKvuU7S/vH18tGS9xmILMFhosKycD7V/4AyIoIMin6btwpXEW/VzmwT+eq
         T7SzXryjvtIEAaaJWknAr2AqTW5puFJC7J8gTzEw5VOTs+wTOt301XOLkJEtugv14s4t
         DR8g==
X-Received: by 10.70.48.138 with SMTP id l10mr7357727pdn.139.1413334060855;
        Tue, 14 Oct 2014 17:47:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id m2sm15348576pdf.48.2014.10.14.17.47.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:47:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Jul 2014 11:20:36 -0700

This behaves like unlink_or_warn except that on failure it writes the message
to its 'err' argument, which the caller can display in an appropriate way or
ignore.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-compat-util.h |  9 +++++++++
 wrapper.c         | 14 ++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index d67592f..59ecf21 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -326,6 +326,8 @@ static inline char *git_find_last_dir_sep(const char *path)
 
 #include "wildmatch.h"
 
+struct strbuf;
+
 /* General helper functions */
 extern void vreportf(const char *prefix, const char *err, va_list params);
 extern void vwritef(int fd, const char *prefix, const char *err, va_list params);
@@ -781,6 +783,13 @@ void git_qsort(void *base, size_t nmemb, size_t size,
  * not exist.
  */
 int unlink_or_warn(const char *path);
+ /*
+  * Tries to unlink file.  Returns 0 if unlink succeeded
+  * or the file already didn't exist.  Returns -1 and
+  * appends a message to err suitable for
+  * 'error("%s", err->buf)' on error.
+  */
+int unlink_or_msg(const char *file, struct strbuf *err);
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success, which includes trying to remove a directory that does
diff --git a/wrapper.c b/wrapper.c
index 8d4be66..007ec0d 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -475,6 +475,20 @@ static int warn_if_unremovable(const char *op, const char *file, int rc)
 	return rc;
 }
 
+int unlink_or_msg(const char *file, struct strbuf *err)
+{
+	int rc = unlink(file);
+
+	assert(err);
+
+	if (!rc || errno == ENOENT)
+		return 0;
+
+	strbuf_addf(err, "unable to unlink %s: %s",
+		    file, strerror(errno));
+	return -1;
+}
+
 int unlink_or_warn(const char *file)
 {
 	return warn_if_unremovable("unlink", file, unlink(file));
-- 
2.1.0.rc2.206.gedb03e5
