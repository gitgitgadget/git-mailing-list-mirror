From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH v7 1/2] Add xpread() and xpwrite()
Date: Thu, 10 Apr 2014 21:31:20 +0300
Message-ID: <1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 20:31:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYJlM-00028Y-BK
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 20:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758893AbaDJSbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 14:31:41 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:54840 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbaDJSbj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 14:31:39 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so3304739eek.24
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2tVbReh9F4Ql6im43xaD72RLubbF3enkydEWK044Qc8=;
        b=J+rVyyOW4EODb9CLcRy/+o8hfK8JPxXrta6oK9Gamkhvz7lqRVb1HPLt+J4iaDvSvf
         eDJJISjNKCPiJpsga7XgvXgHcjrPCYaCSJWMPfybU+xBCYsGm0LVmoqH8zz7x5ZGvf+9
         qaft87eKSvN7LYRVrEmGj73v9g6SZw6W2uortTVLBWQHHdjBUnvGs3/rRW1oSnyqdC8O
         6mWWbAmWNgTBxI8viVk3/tXaSOMC+kL2MuyRdIeGrGgkxmBxQIOmVJLQPyGjm/UY+QKE
         oV9uK2zpizYP5vLLEv8/3r2OBRVAIxRg6ZyfAxIf4vg/uXGeCnwaT1B4NeJEdNonKJbs
         OdeQ==
X-Received: by 10.14.214.198 with SMTP id c46mr22912481eep.29.1397154698261;
        Thu, 10 Apr 2014 11:31:38 -0700 (PDT)
Received: from abyss.hitronhub.home ([46.251.117.183])
        by mx.google.com with ESMTPSA id l42sm11739629eew.19.2014.04.10.11.31.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Apr 2014 11:31:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246026>

xpread() and xpwrite() pay attention to EAGAIN/EINTR, so they will resume
automatically on interrupted call.

Signed-off-by: Yiannis Marangos <yiannis.marangos@gmail.com>
---
 builtin/index-pack.c |  2 +-
 compat/mmap.c        |  4 +---
 git-compat-util.h    |  2 ++
 wrapper.c            | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b9f6e12..1bac0f5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -542,7 +542,7 @@ static void *unpack_data(struct object_entry *obj,
 
 	do {
 		ssize_t n = (len < 64*1024) ? len : 64*1024;
-		n = pread(pack_fd, inbuf, n, from);
+		n = xpread(pack_fd, inbuf, n, from);
 		if (n < 0)
 			die_errno(_("cannot pread pack file"));
 		if (!n)
diff --git a/compat/mmap.c b/compat/mmap.c
index c9d46d1..7f662fe 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -14,7 +14,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 	}
 
 	while (n < length) {
-		ssize_t count = pread(fd, (char *)start + n, length - n, offset + n);
+		ssize_t count = xpread(fd, (char *)start + n, length - n, offset + n);
 
 		if (count == 0) {
 			memset((char *)start+n, 0, length-n);
@@ -22,8 +22,6 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 		}
 
 		if (count < 0) {
-			if (errno == EAGAIN || errno == EINTR)
-				continue;
 			free(start);
 			errno = EACCES;
 			return MAP_FAILED;
diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..4da04c6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -531,6 +531,8 @@ extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
+extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
+extern ssize_t xpwrite(int fd, const void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
diff --git a/wrapper.c b/wrapper.c
index 0cc5636..25b7419 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -174,6 +174,42 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 	}
 }
 
+/*
+ * xpread() is the same as pread(), but it automatically restarts pread()
+ * operations with a recoverable error (EAGAIN and EINTR). xpread() DOES
+ * NOT GUARANTEE that "len" bytes is read even if the data is available.
+ */
+ssize_t xpread(int fd, void *buf, size_t len, off_t offset)
+{
+	ssize_t nr;
+	if (len > MAX_IO_SIZE)
+	    len = MAX_IO_SIZE;
+	while (1) {
+		nr = pread(fd, buf, len, offset);
+		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
+			continue;
+		return nr;
+	}
+}
+
+/*
+ * xpwrite() is the same as pwrite(), but it automatically restarts pwrite()
+ * operations with a recoverable error (EAGAIN and EINTR). xpwrite() DOES NOT
+ * GUARANTEE that "len" bytes is written even if the operation is successful.
+ */
+ssize_t xpwrite(int fd, const void *buf, size_t len, off_t offset)
+{
+	ssize_t nr;
+	if (len > MAX_IO_SIZE)
+	    len = MAX_IO_SIZE;
+	while (1) {
+		nr = pwrite(fd, buf, len, offset);
+		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
+			continue;
+		return nr;
+	}
+}
+
 ssize_t read_in_full(int fd, void *buf, size_t count)
 {
 	char *p = buf;
-- 
1.9.1
