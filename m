From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/7] Add buffer pool library
Date: Sun, 23 May 2010 23:40:28 +0200
Message-ID: <1274650832-7411-4-git-send-email-artagnon@gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 23 23:39:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGIti-0004cg-By
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 23:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432Ab0EWVjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 17:39:24 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40688 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab0EWVjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 17:39:16 -0400
Received: by mail-wy0-f174.google.com with SMTP id 29so1098038wyb.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 14:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SXcm8U5LQE2EKfmPhFdJoBz2rYu98q5Dnm1SkUinh78=;
        b=EiKKgqM7YORBbUI1qf3epy0ZPwB1AdSOKaNqLIvMul8iLijzmioaqd0cym2tT/y3F7
         OFAw53ibpGOcdrcBBrNNDYGBqT0NSYZ0YPLyWzAwUfwvADaFPflTYyF0CQ306JjnyZ3m
         vD1BOEQXHZWVxG6CHrzA1CCJJLeWIPJPEymrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nedZBMTUeHG6UO49nafxAyt8UNER9EBbQbkEBMDwYyXgu4ETNVwoY198rHxGwizD/X
         MqudtMVulZHPuwOVHPiEp1RuOtF+GaY6H5cVTEnIciU/zAQ92cWzX1ntD6pa7AgG4xB8
         9FGnmFUBzQsP/1a/LmP/1X9ilHtiX+07eOigg=
Received: by 10.216.88.196 with SMTP id a46mr2835390wef.36.1274650755382;
        Sun, 23 May 2010 14:39:15 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 16sm1631167ewy.7.2010.05.23.14.39.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 14:39:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147594>

line_buffer creates a couple of static buffers and expose an API for
using them. The idea is to maintain a fixed static memory pool to
avoid constant allocation and de-allocation of memory. Taken directly
from David Michael Barr's svn-dump-fast-export repository.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/line_buffer.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/line_buffer.h |   14 ++++++
 2 files changed, 129 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
new file mode 100644
index 0000000..6b47d38
--- /dev/null
+++ b/vcs-svn/line_buffer.c
@@ -0,0 +1,115 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "line_buffer.h"
+
+#define LINE_BUFFER_LEN 10000
+#define COPY_BUFFER_LEN 4096
+
+static char line_buffer[LINE_BUFFER_LEN];
+static char byte_buffer[COPY_BUFFER_LEN];
+static uint32_t line_buffer_len = 0;
+static uint32_t line_len = 0;
+
+char *buffer_read_line(void)
+{
+    char *end;
+    uint32_t n_read;
+
+    if (line_len) {
+        memmove(line_buffer, &line_buffer[line_len],
+                line_buffer_len - line_len);
+        line_buffer_len -= line_len;
+        line_len = 0;
+    }
+
+    end = memchr(line_buffer, '\n', line_buffer_len);
+    while (line_buffer_len < LINE_BUFFER_LEN - 1 &&
+           !feof(stdin) && NULL == end) {
+        n_read =
+            fread(&line_buffer[line_buffer_len], 1,
+                  LINE_BUFFER_LEN - 1 - line_buffer_len,
+                  stdin);
+        end = memchr(&line_buffer[line_buffer_len], '\n', n_read);
+        line_buffer_len += n_read;
+    }
+
+    if (ferror(stdin))
+        return NULL;
+
+    if (end != NULL) {
+        line_len = end - line_buffer;
+        line_buffer[line_len++] = '\0';
+    } else {
+        line_len = line_buffer_len;
+        line_buffer[line_buffer_len] = '\0';
+    }
+
+    if (line_len == 0)
+        return NULL;
+
+    return line_buffer;
+}
+
+char *buffer_read_string(uint32_t len)
+{
+    char *s = malloc(len + 1);
+    uint32_t offset = 0;
+    if (line_buffer_len > line_len) {
+        offset = line_buffer_len - line_len;
+        if (offset > len)
+            offset = len;
+        memcpy(s, &line_buffer[line_len], offset);
+        line_len += offset;
+    }
+    while (offset < len && !feof(stdin)) {
+        offset += fread(&s[offset], 1, len - offset, stdin);
+    }
+    s[offset] = '\0';
+    return s;
+}
+
+void buffer_copy_bytes(uint32_t len)
+{
+    uint32_t in, out;
+    if (line_buffer_len > line_len) {
+        in = line_buffer_len - line_len;
+        if (in > len)
+            in = len;
+        out = 0;
+        while (out < in && !ferror(stdout)) {
+            out +=
+                fwrite(&line_buffer[line_len + out], 1, in - out, stdout);
+        }
+        len -= in;
+        line_len += in;
+    }
+    while (len > 0 && !feof(stdin)) {
+        in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+        in = fread(byte_buffer, 1, in, stdin);
+        len -= in;
+        out = 0;
+        while (out < in && !ferror(stdout)) {
+            out += fwrite(&byte_buffer[out], 1, in - out, stdout);
+        }
+    }
+}
+
+void buffer_skip_bytes(uint32_t len)
+{
+    uint32_t in;
+    if (line_buffer_len > line_len) {
+        in = line_buffer_len - line_len;
+        if (in > len)
+            in = len;
+        line_len += in;
+        len -= in;
+    }
+    while (len > 0 && !feof(stdin)) {
+        in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+        in = fread(byte_buffer, 1, in, stdin);
+        len -= in;
+    }
+}
+
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
new file mode 100644
index 0000000..e546f4d
--- /dev/null
+++ b/vcs-svn/line_buffer.h
@@ -0,0 +1,14 @@
+#ifndef LINE_BUFFER_H_
+#define LINE_BUFFER_H_
+
+#include <stdint.h>
+
+char *buffer_read_line(void);
+
+char *buffer_read_string(uint32_t len);
+
+void buffer_copy_bytes(uint32_t len);
+
+void buffer_skip_bytes(uint32_t len);
+
+#endif
-- 
1.7.1
