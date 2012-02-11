From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: [PATCH] strbuf: move strbuf_readline_fd() from bundle.c to strbuf.{c,h}
Date: Sat, 11 Feb 2012 17:50:37 +0800
Message-ID: <CAMocUqRutwERQ64a=9t36Za6Lm8KxpseS0NYbdGKWbixbsXeyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: =?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 11 10:50:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw9bQ-0000vr-8V
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 10:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab2BKJuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 04:50:39 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49660 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab2BKJui (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 04:50:38 -0500
Received: by bkcjm19 with SMTP id jm19so3465434bkc.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 01:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=S/xngZB36TQLyBeAef9wq0Y6+z6p5dNPHh2ro3qZDaI=;
        b=Vfqvn75ZvOboegTBWW1hDwrO8V3StLRpFK/PUxMMfSo87c43IeS8l6Li7584fMr4WU
         +5IDR2bhIIlkMEKqZD5+mZQXE24J3twGu9LHSV/YRxnngSy+Pd+WQS2DaB75gBDw9wqj
         qxiHZgI/WtLxmv8KqpHR5c23aJ2KFdbO+zm0E=
Received: by 10.204.128.132 with SMTP id k4mr2194232bks.26.1328953837263; Sat,
 11 Feb 2012 01:50:37 -0800 (PST)
Received: by 10.204.130.72 with HTTP; Sat, 11 Feb 2012 01:50:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190504>

strbuf_readline_fd() existed in bundle.c since e9ee84cf, but this
function can be used elsewhere, and since it's relevant to strbuf, it
should be in strbuf.{c,h}.

Signed-off-by: Xu Di <xudifsd@gmail.com>
---
 bundle.c |   18 +-----------------
 strbuf.c |   16 ++++++++++++++++
 strbuf.h |    1 +
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/bundle.c b/bundle.c
index b8acf3c..9344a91 100644
--- a/bundle.c
+++ b/bundle.c
@@ -7,6 +7,7 @@
 #include "list-objects.h"
 #include "run-command.h"
 #include "refs.h"
+#include "strbuf.h"

 static const char bundle_signature[] = "# v2 git bundle\n";

@@ -23,23 +24,6 @@ static void add_to_ref_list(const unsigned char
*sha1, const char *name,
 	list->nr++;
 }

-/* Eventually this should go to strbuf.[ch] */
-static int strbuf_readline_fd(struct strbuf *sb, int fd)
-{
-	strbuf_reset(sb);
-
-	while (1) {
-		char ch;
-		ssize_t len = xread(fd, &ch, 1);
-		if (len <= 0)
-			return len;
-		strbuf_addch(sb, ch);
-		if (ch == '\n')
-			break;
-	}
-	return 0;
-}
-
 static int parse_bundle_header(int fd, struct bundle_header *header,
 			       const char *report_path)
 {
diff --git a/strbuf.c b/strbuf.c
index ff0b96b..7532a13 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -282,6 +282,22 @@ void strbuf_addbuf_percentquote(struct strbuf
*dst, const struct strbuf *src)
 	}
 }

+int strbuf_readline_fd(struct strbuf *sb, int fd)
+{
+	strbuf_reset(sb);
+
+	while (1) {
+		char ch;
+		ssize_t len = xread(fd, &ch, 1);
+		if (len <= 0)
+			return len;
+		strbuf_addch(sb, ch);
+		if (ch == '\n')
+			break;
+	}
+	return 0;
+}
+
 size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 {
 	size_t res;
diff --git a/strbuf.h b/strbuf.h
index fbf059f..ecebd11 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -109,6 +109,7 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 }

 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
+extern int strbuf_readline_fd(struct strbuf *sb, int fd);
 /* XXX: if read fails, any partial read is undone */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
-- 
1.7.8.1.749.gb6b3b
