From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 02/45] wrapper: implement xfopen()
Date: Tue,  4 Aug 2015 21:51:23 +0800
Message-ID: <1438696326-19590-3-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:53:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMceZ-00028L-CH
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934221AbbHDNxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:11 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35899 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934093AbbHDNxE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:04 -0400
Received: by pacgq8 with SMTP id gq8so9159645pac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=72BFEZNhAyod6BbXFz9CUCZV1hMhBVVnzRVVTnROh9g=;
        b=fF6JXoUcFtdiOu2T8cYOQWZxf1R5kUkMaxhbWM0UnIq3CHWgTahC/79GVruFGzLx5M
         qYiTPansadzZ5WUP+cv3VHnEfacEYHHABxWIXGTRQ3+k/v9bby2svrG1KpfxSySuP6Ad
         rWhpWQOnfBz95WSRh+KIssn+wb/7maq67YTw50JFhTSLuM6XVuBDP0z9i9l4ZYJnP5pU
         o7g969iJEZKfkEmHW8JoRbjK3PwJGpriHuLl5H6RZm6WzS+ko05aVmXqz/n8gCahDcZo
         F5PyMemtUYJT9fdpXRIRsdhryb6md6/28d1bGhnmM7LuSGRq8f7DRKfKcVJA7a6rJrH9
         WC4A==
X-Received: by 10.67.5.231 with SMTP id cp7mr8192095pad.36.1438696383927;
        Tue, 04 Aug 2015 06:53:03 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275276>

A common usage pattern of fopen() is to check if it succeeded, and die()
if it failed:

	FILE *fp = fopen(path, "w");
	if (!fp)
		die_errno(_("could not open '%s' for writing"), path);

Implement a wrapper function xfopen() for the above, so that we can save
a few lines of code and make the die() messages consistent.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-compat-util.h |  1 +
 wrapper.c         | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

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
index 0a4502d..e451463 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -346,6 +346,27 @@ int xdup(int fd)
 	return ret;
 }
 
+/**
+ * xfopen() is the same as fopen(), but it die()s if the fopen() fails.
+ */
+FILE *xfopen(const char *path, const char *mode)
+{
+	for (;;) {
+		FILE *fp = fopen(path, mode);
+		if (fp)
+			return fp;
+		if (errno == EINTR)
+			continue;
+
+		if (*mode && mode[1] == '+')
+			die_errno(_("could not open '%s' for reading and writing"), path);
+		else if (*mode == 'w' || *mode == 'a')
+			die_errno(_("could not open '%s' for writing"), path);
+		else
+			die_errno(_("could not open '%s' for reading"), path);
+	}
+}
+
 FILE *xfdopen(int fd, const char *mode)
 {
 	FILE *stream = fdopen(fd, mode);
-- 
2.5.0.280.gd88bd6e
