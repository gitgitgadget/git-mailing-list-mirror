From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 02/45] wrapper: implement xfopen()
Date: Mon, 20 Jul 2015 00:09:54 +0800
Message-ID: <1437322237-29863-3-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrB4-0005wJ-5f
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbbGSQKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:10:52 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36338 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbbGSQKv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:10:51 -0400
Received: by pdjr16 with SMTP id r16so91391780pdj.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i8rL/2VLCIB8Fp87N7xcjUVBHcxT51ooTtOX5NNw1ps=;
        b=fTI8b6crpR4rafEC7Nze98chCmHBOvtIH1H/2e3SUl+74DpFcjtl2sUnZkBJ3R8cHY
         gBnmp0bi7lilKwUe4t70xLw7gU8aKS/FozOuG6DtZkvkhFPtRnsLGU1Myj9HaJtDH7l8
         PY5MSEsBieV4nQkn1D5vuHUuQu1W06xzhJn+JxrEyVbYkx14BiPswL06igdB19wqQd3d
         7uTuMSxHzYJ59ilYeiplpx45Cszg3A5IsTA4jmhDUINtuvz2aQzkP+EKsZy8Vj838Q2i
         ZxxyjunutB9jKDofzft5Lfl41uYKVjIgmdnpPQMSiFrSGeniQkVCVVY3BJ0oK1UizfwI
         Butg==
X-Received: by 10.68.238.168 with SMTP id vl8mr23585113pbc.3.1437322250973;
        Sun, 19 Jul 2015 09:10:50 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.10.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:10:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274226>

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
2.5.0.rc2.110.gb39b692
