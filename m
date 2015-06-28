From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 02/44] wrapper: implement xfopen()
Date: Sun, 28 Jun 2015 22:05:24 +0800
Message-ID: <1435500366-31700-3-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:07:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DEh-0001cL-Le
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbbF1OHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:07:03 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34949 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbbF1OG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:06:59 -0400
Received: by pactm7 with SMTP id tm7so91488774pac.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G7kLhGDkhmhaRigbLjL/06jLp9tAM+oKXJslMH/P+v8=;
        b=ODdXeTkiSFcgDaTovQe6pxGEIPFdLNM6ZFqWXcH6jWDbss3iNVPFjmvqLjJbsnqN3I
         SP3USD9iuN081sFb+lv61W0zYLI9rI2nNpba4yYnHuzFWzPLs6RL1DO1b2A9pk/IaBj6
         6yomrcdPFv+MRgOYvalJZCQ1T7oQXb1BhY3y96avReLYVe7459eptRRiaZRnR+XEwX1y
         2eTIjDDGOB3MP1LNiHoSmzayB3QWjWO0/iD9ZghCSE+SITOuLpF8K5vEBE3EvgZBFj8l
         iaoYi/jkI+cyiDkzV0g1cLRKC3SIUfEYCgJEeJvXcMznKFRDTZXCysguw+myTL35QTYz
         PwXw==
X-Received: by 10.68.65.7 with SMTP id t7mr22409785pbs.133.1435500418653;
        Sun, 28 Jun 2015 07:06:58 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.06.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:06:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272878>

A common usage pattern of fopen() is to check if it succeeded, and die()
if it failed:

	FILE *fp = fopen(path, "w");
	if (!fp)
		die_errno(_("could not open '%s' for writing"), path);

Implement a wrapper function xfopen() for the above, so that we can save
a few lines of code and make the die() messages consistent.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-compat-util.h |  1 +
 wrapper.c         | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e168dfd..392da79 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -722,6 +722,7 @@ extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
+extern FILE *xfopen(const char *path, const char *mode);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
diff --git a/wrapper.c b/wrapper.c
index 7e13ae0..f127eb3 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -336,6 +336,24 @@ int xdup(int fd)
 	return ret;
 }
 
+/**
+ * xfopen() is the same as fopen(), but it die()s if the fopen() fails.
+ */
+FILE *xfopen(const char *path, const char *mode)
+{
+	assert(path);
+	assert(mode);
+
+	for (;;) {
+		FILE *fp = fopen(path, mode);
+		if (fp)
+			return fp;
+		if (errno == EINTR)
+			continue;
+		die_errno(_("could not open '%s'"), path);
+	}
+}
+
 FILE *xfdopen(int fd, const char *mode)
 {
 	FILE *stream = fdopen(fd, mode);
-- 
2.5.0.rc0.76.gb2c6e93
