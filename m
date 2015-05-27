From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP 2/8] wrapper: implement xfopen()
Date: Wed, 27 May 2015 21:33:32 +0800
Message-ID: <1432733618-25629-3-git-send-email-pyokagan@gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 15:34:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbTd-00065H-L3
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbbE0Ne3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:34:29 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33201 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbbE0Ne1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 09:34:27 -0400
Received: by pdbqa5 with SMTP id qa5so15501510pdb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 06:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=neyhxXNykvudLi53AXiTaHySBJQRL0fedLgTMvKhT3s=;
        b=ScJihKkFv9K3t/x8KvLnTyO+RZ3YsZ+92Y/2Syw5jYeeW/LpGRe1P7Irc1ZLQdRudt
         ZCClNOXv/O/zMYe18FNV+pqwnHhTjRG/I44Pv1+BjCAf4ply4dSh+NiGpBvkeqB+rdYJ
         zScf3HjV5kNC8r3UpPqvVrmBVWAsOtVUf7CAaJciEthFHfYypbkVPzZahelndU7f72lj
         fMOhlwehw8KaMAWSKXNvUBhi1TcXepJ7imnrcXv9cIMDtwHhvpyMxnTybECU+wOtEI00
         FtLZINdnBzIel6fiHTtPPWiSXW5YRLAlO5uqxfL0n29sk/TIzcobX2BPzKcIu3dObPRl
         6HQQ==
X-Received: by 10.70.37.144 with SMTP id y16mr58649486pdj.86.1432733667167;
        Wed, 27 May 2015 06:34:27 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id e5sm16301395pdc.94.2015.05.27.06.34.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 May 2015 06:34:26 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270047>

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
 wrapper.c         | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9745962..914d450 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -723,6 +723,7 @@ extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
+extern FILE *xfopen(const char *path, const char *mode);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
diff --git a/wrapper.c b/wrapper.c
index 971665a..d5ed780 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -329,6 +329,25 @@ int xdup(int fd)
 	return ret;
 }
 
+/**
+ * xfopen() is the same as fopen(), but it die()s if the fopen() fails.
+ */
+FILE *xfopen(const char *path, const char *mode)
+{
+	FILE *fp;
+
+	assert(path);
+	assert(mode);
+	fp = fopen(path, mode);
+	if (!fp) {
+		if (*mode == 'w' || *mode == 'a')
+			die_errno(_("could not open '%s' for writing"), path);
+		else
+			die_errno(_("could not open '%s' for reading"), path);
+	}
+	return fp;
+}
+
 FILE *xfdopen(int fd, const char *mode)
 {
 	FILE *stream = fdopen(fd, mode);
-- 
2.1.4
