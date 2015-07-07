From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 02/44] wrapper: implement xfopen()
Date: Tue,  7 Jul 2015 22:20:20 +0800
Message-ID: <1436278862-2638-3-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:21:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTkZ-00041m-8v
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757440AbbGGOV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:21:27 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34738 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216AbbGGOVX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:23 -0400
Received: by pdbep18 with SMTP id ep18so126712736pdb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J22nl5xuagnKzW31qXkB4H3HqmHA0T4+bluM0apjvfs=;
        b=uy3ydey4pPdcSkoIbwTYF04IOaE33hi6KTdS2Huhk8JH+bNP6rIdODvNBTJbvpvRS9
         mq1fPacMWgbhcjOSm4cBOyWeui755gsLQZ7ER80DsajDhktTswd0A1BPcpE3JkyZpd2t
         bcdIcVoYaPBVf1Cvm5YHpm0YPsXYq3s/PU0xen9bdHH/FDZ92ne6/OXbplSDG6FnFxbv
         MzRLwIiQJFYsdObMG7apdIPbH0XAcEtmJmO/ORiD2Sj8ivaAeGjXQMPivEkjcNy908XZ
         cHGE4OYMAsCUBgxRcz2R5pEK50KE/R6w0xqKIqXjZ4svx0KFpGq1o4SEyBx3a9TtLkP7
         raGw==
X-Received: by 10.68.131.104 with SMTP id ol8mr9626283pbb.39.1436278882313;
        Tue, 07 Jul 2015 07:21:22 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:21 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273523>

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

Notes:
    v5
    
    * Removed assert()s since we do not need to over-zealously guard against
      insane code.
    
    * The read/write error messages have returned as they are useful in
      diagnosing permission errors. Hopefully I got the logic right this
      time.

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
2.5.0.rc1.76.gf60a929
