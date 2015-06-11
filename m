From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 02/19] wrapper: implement xfopen()
Date: Thu, 11 Jun 2015 18:21:48 +0800
Message-ID: <1434018125-31804-3-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:22:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zcw-0007f4-PO
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbbFKKWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:22 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36042 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbbFKKWU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:20 -0400
Received: by pdjm12 with SMTP id m12so1945526pdj.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Tl0oZYf+n7zqzQI1BmPKWCczOV35pLU4RI4I0k/A9g=;
        b=Qb6BskevxD4dfFgweIVeEz1jx8hsyHHgCIK4EiMjXV87cqyFlw15tnsnt5blYYFU+O
         s4Qaew4u1GcVKIx8NZOy7NlarhF4OHaeGy1n0lwkAMIfhhewGawTCIFLcapP9WHBenRX
         XnkHGJ3bxKMdo6wRs34cjIHbc7oyY9S0PcwllU74Zi8EgjLgfZSywGrF5uatuYnQPpn6
         UvPCuGmu+0EaLiQntacQ9YNm1VF3G0YSNXBTyAfsDjHIfV29ZfhJPGXh6lJQvJGArsET
         zK88fP3rBuOal787LQYs+rFPmb4x5Z+Fu8dDTbVg2B84GR0jUi2FM0qtyPuR43kF2iYc
         Wyew==
X-Received: by 10.70.90.1 with SMTP id bs1mr13782491pdb.10.1434018140330;
        Thu, 11 Jun 2015 03:22:20 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:19 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271383>

A common usage pattern of fopen() is to check if it succeeded, and die()
if it failed:

	FILE *fp = fopen(path, "w");
	if (!fp)
		die_errno(_("could not open '%s' for writing"), path);

Implement a wrapper function xfopen() for the above, so that we can save
a few lines of code and make the die() messages consistent.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Removed the error message distinction between reading and writing.
    
    * Handle EINTR.

 git-compat-util.h |  1 +
 wrapper.c         | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 95cc278..03ea3a2 100644
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
