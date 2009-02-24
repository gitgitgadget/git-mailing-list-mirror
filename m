From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH] Add a new commit-raw command.
Date: Tue, 24 Feb 2009 23:28:34 +0200
Message-ID: <1235510914-23319-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Rene Stadler" <renestadler84@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 22:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc4qz-0000OF-Ad
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 22:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759506AbZBXV2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758781AbZBXV2l
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:28:41 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:53924 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759609AbZBXV2k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:28:40 -0500
Received: by bwz5 with SMTP id 5so6183356bwz.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 13:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=akpo1nWqfUs5ocxoAHgAmQC5ZGQkO+HXtqO5zLeNIzM=;
        b=DtfU4rsDLE42gkDWZ5DdLf8fLgmLZnOUpAFJBkYvz6Z6ZoGI9NLXgRhRPj4AV2TOSS
         Hz1NgMbUf7qGOTujCcIZftZQh2K6+TKBJyiRf3giKClMFaqsrHe0KHKbjRFyfjj+JfGz
         ci1k+v5nRnEDfS/G8TU5zOmCsvV0ZFxl9nrIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gMiLPPEhK8EEwzAwCnNTtiOHlYhToGSbp5WVXdyswOcCuH9+LF2XBDMjElJ5p8yfit
         1H4IahIGQwHYDXG1YgvLqahhQTSK3x7ElUZ+t7WLfMpEHYxsHz+xGX9SL/p2Vpcf4itH
         Fy7c2B3BoUeYjOyUj2lH0s/BC7FGO5ZUQJ89M=
Received: by 10.181.30.10 with SMTP id h10mr62057bkj.200.1235510917370;
        Tue, 24 Feb 2009 13:28:37 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 12sm6409282fks.25.2009.02.24.13.28.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 13:28:35 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111344>

This command receives as input a raw commit object, and outputs the
generated sha1. This is very useful when doing some serious repo
reconstructions.

For example: git cat-file -p 343ee25 | git write-raw
343ee2589d1b94772f513cc699765622351acb19

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile             |    1 +
 builtin-commit-raw.c |   23 +++++++++++++++++++++++
 builtin.h            |    1 +
 git.c                |    1 +
 4 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 builtin-commit-raw.c

diff --git a/Makefile b/Makefile
index b040a96..94212b3 100644
--- a/Makefile
+++ b/Makefile
@@ -524,6 +524,7 @@ BUILTIN_OBJS += builtin-checkout-index.o
 BUILTIN_OBJS += builtin-checkout.o
 BUILTIN_OBJS += builtin-clean.o
 BUILTIN_OBJS += builtin-clone.o
+BUILTIN_OBJS += builtin-commit-raw.o
 BUILTIN_OBJS += builtin-commit-tree.o
 BUILTIN_OBJS += builtin-commit.o
 BUILTIN_OBJS += builtin-config.o
diff --git a/builtin-commit-raw.c b/builtin-commit-raw.c
new file mode 100644
index 0000000..66c41f4
--- /dev/null
+++ b/builtin-commit-raw.c
@@ -0,0 +1,23 @@
+/*
+ * Writes a raw commit object
+ */
+
+#include "cache.h"
+#include "commit.h"
+
+int cmd_commit_raw(int argc, const char **argv, const char *unused_prefix)
+{
+	unsigned char commit_sha1[20];
+	struct strbuf buffer;
+
+	strbuf_init(&buffer, 8192);
+
+	strbuf_read(&buffer, 0, 0);
+
+	if (!write_sha1_file(buffer.buf, buffer.len, "commit", commit_sha1)) {
+		printf("%s\n", sha1_to_hex(commit_sha1));
+		return 0;
+	}
+	else
+		return 1;
+}
diff --git a/builtin.h b/builtin.h
index 1495cf6..5c33e69 100644
--- a/builtin.h
+++ b/builtin.h
@@ -38,6 +38,7 @@ extern int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
 extern int cmd_clone(int argc, const char **argv, const char *prefix);
 extern int cmd_clean(int argc, const char **argv, const char *prefix);
 extern int cmd_commit(int argc, const char **argv, const char *prefix);
+extern int cmd_commit_raw(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_describe(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index c2b181e..b033365 100644
--- a/git.c
+++ b/git.c
@@ -285,6 +285,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "clone", cmd_clone },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
+		{ "commit-raw", cmd_commit_raw, RUN_SETUP },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
-- 
1.6.1.3
