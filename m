From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 02/31] wrapper: implement xfopen()
Date: Thu, 18 Jun 2015 19:25:14 +0800
Message-ID: <1434626743-8552-3-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:26:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xxh-0004Py-OS
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbbFRL0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:20 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33557 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbbFRL0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:17 -0400
Received: by pdjn11 with SMTP id n11so64824604pdj.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/YWjyzqhPmtmOHefd96aSl8GWkw+XwfOBXBn2y6dby8=;
        b=JQjQWkrZRDqkCeL+Kk7elu3DXWO9KYQC3J1oiTWNLfAy0ME8ZxfYyrtBKsUxihiTta
         gWSgXOvBrkO14RuOQ/+9b8Mmya9XAaFVpndr3R66u3l76QY0baEkyi9wj6J6+3iPbPiE
         BePLk3h4k9yxU4bKPJbou/h9oEoY8w4ShqcI23GXGSZO6JftJamG65VX2mwWXi+SYcVk
         2X8aWwGT7/iRv3N4pRojCgov+WToFh8/yWdjRp4q9QDY4tWbbjhCmCwZ7moG0DL0QJqQ
         b5urzM+qKjFuwDUUaoZwa+lK5wQmKoj3xIkNLj9MQGnyAHrAaXEI3KmsrtBdq6Hsoo59
         4v8w==
X-Received: by 10.70.91.234 with SMTP id ch10mr20727919pdb.39.1434626776678;
        Thu, 18 Jun 2015 04:26:16 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:15 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271966>

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
index bc77d77..4e69110 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -724,6 +724,7 @@ extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
+extern FILE *xfopen(const char *path, const char *mode);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
diff --git a/wrapper.c b/wrapper.c
index 82658b3..9692460 100644
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
2.1.4
