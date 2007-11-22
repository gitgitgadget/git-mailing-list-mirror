From: Thomas Harning <harningt@gmail.com>
Subject: [PATCH] Converted git-merge-ours.sh -> builtin-merge-ours.c
Date: Thu, 22 Nov 2007 15:19:40 -0500
Message-ID: <4745E45C.7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, thomas.harning@trustbearer.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 22 21:19:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvIWS-00016C-Uw
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 21:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbXKVUTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 15:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbXKVUTT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 15:19:19 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:5689 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbXKVUTS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 15:19:18 -0500
Received: by an-out-0708.google.com with SMTP id d31so614846and
        for <git@vger.kernel.org>; Thu, 22 Nov 2007 12:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=TVo5hewQebCtXKlNqCRXeU/yLLcmXTad3BUkPwtyT/8=;
        b=iWFf2pm53Kpjez4QMk1AXZ2TomLoh4eihIQIzMJm8UL8geos4x1Wke/U8ZJDxrSNTJBHF3Uz3WmndRKkEimGAVqRAtjLUfMOQnT9XV8aLhzXLGr5HG8sw3Y7dV/p3Bn+6LPAvV//OnUWnN9NPaEDENigIfuHk7cCQmON7Ore+nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=fHlHrsthfxEVtPQNbp+TfRwlGXshQlzyikBRtOKrWWXuIv0EiIp7p2hGv9Ryxot4fwVqGEd8IeprFHL9plDGQTt562a59ufNVXVcFAztnlRGglRNHvIj5nECb8zUcG//oyVocvcjB9eZVpg6YibzBMil6+WPElKDSD/p+yQQQyg=
Received: by 10.100.214.15 with SMTP id m15mr4896865ang.1195762757624;
        Thu, 22 Nov 2007 12:19:17 -0800 (PST)
Received: from ?192.168.1.104? ( [68.159.147.149])
        by mx.google.com with ESMTPS id p27sm2163003ele.2007.11.22.12.19.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Nov 2007 12:19:16 -0800 (PST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65842>

Here's a simple patch to make git-merge-ours.sh into a builtin.

I figure this would be a simple way of getting in the git-development flow.

Signed-off-by: Thomas Harning Jr <harningt@gmail.com>
---
 Makefile             |    3 ++-
 builtin-merge-ours.c |   32 ++++++++++++++++++++++++++++++++
 builtin.h            |    1 +
 git-merge-ours.sh    |   14 --------------
 git.c                |    1 +
 5 files changed, 36 insertions(+), 15 deletions(-)
 create mode 100644 builtin-merge-ours.c
 delete mode 100755 git-merge-ours.sh

diff --git a/Makefile b/Makefile
index cabde81..7a0ee78 100644
--- a/Makefile
+++ b/Makefile
@@ -221,7 +221,7 @@ SCRIPT_SH = \
 	git-sh-setup.sh \
 	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
-	git-merge-resolve.sh git-merge-ours.sh \
+	git-merge-resolve.sh \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
 	git-filter-branch.sh \
 	git-stash.sh
@@ -353,6 +353,7 @@ BUILTIN_OBJS = \
 	builtin-mailsplit.o \
 	builtin-merge-base.o \
 	builtin-merge-file.o \
+	builtin-merge-ours.o \
 	builtin-mv.o \
 	builtin-name-rev.o \
 	builtin-pack-objects.o \
diff --git a/builtin-merge-ours.c b/builtin-merge-ours.c
new file mode 100644
index 0000000..fbfe183
--- /dev/null
+++ b/builtin-merge-ours.c
@@ -0,0 +1,32 @@
+/*
+ * Implementation of git-merge-ours.sh as builtin
+ * 
+ * Copyright (c) 2007 Thomas Harning Jr
+ * Original:
+ * Original Copyright (c) 2005 Junio C Hamano
+ *
+ * Pretend we resolved the heads, but declare our tree trumps everybody else.
+ */
+#include "git-compat-util.h"
+#include "builtin.h"
+
+int cmd_merge_ours(int argc, const char **argv, const char *prefix)
+{
+	const char *nargv[] = {
+		"diff-index",
+		"--quiet",
+		"--cached",
+		"HEAD",
+		NULL
+	};
+	int i;
+
+	int ret = cmd_diff_index(4, nargv, prefix);
+	printf("GOT: %i\n", ret);
+	/* We need to exit with 2 if the index does not match our HEAD tree,
+	 * because the current index is what we will be committing as the
+	 * merge result.
+	 */
+	if(ret) ret = 2;
+	return ret;
+}
diff --git a/builtin.h b/builtin.h
index 9a6213a..bcb54aa 100644
--- a/builtin.h
+++ b/builtin.h
@@ -51,6 +51,7 @@ extern int cmd_ls_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 extern int cmd_mailsplit(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
+extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
diff --git a/git-merge-ours.sh b/git-merge-ours.sh
deleted file mode 100755
index c81a790..0000000
--- a/git-merge-ours.sh
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano
-#
-# Pretend we resolved the heads, but declare our tree trumps everybody else.
-#
-
-# We need to exit with 2 if the index does not match our HEAD tree,
-# because the current index is what we will be committing as the
-# merge result.
-
-git diff-index --quiet --cached HEAD || exit 2
-
-exit 0
diff --git a/git.c b/git.c
index 7604319..80c2f14 100644
--- a/git.c
+++ b/git.c
@@ -325,6 +325,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
 		{ "merge-file", cmd_merge_file },
+		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
-- 
1.5.3.6.861.gd794
