Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC0ECDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 16:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347307AbjJLQJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 12:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344056AbjJLQJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 12:09:58 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C587ACA
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 09:09:56 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EAB535B07B;
        Thu, 12 Oct 2023 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1697126995;
        bh=wi1BscaYLc53EhGD3KrzE0QRS/RVfN9sWoLSNgStKzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=r127qtzGSKobeiG5wf4tlpQ7Q2Chw6JUVpNuegZ7Bmf1jB4dltCbRj3vF2JZs8OaK
         yiFIHWuV+clHPvtBWSovQNYvvlrZnmoBZiXSGOqCH6x2pnp0ddmkwJ8xNOFd1x0Q2t
         jjrqIP26KZw4OMn9OBNQ2Lcr5WPOs1NXoZxZhXTypRaemv3k3G0fy1Hel3fzEAQU+F
         ho4KfS6fprRGQC669/fh6wCV/DtYirIZozsYnfd6WGuvrROJY5dmwEfNurQzZEi518
         tYp3MI2D7Owxq2Q14Zy4A+7eaDHFDUWJar5rkwIeT9L7Q+5zmII7x7ZG2nynpM7gfl
         CwXIbRD3Y6/MjjeDGDES1ckFrkp7IGLXmkmtN3v/fI0FBkNyXii2LWMmn3QfRCK3SC
         oEEHQzWzP2fXhKt4K6AyOoOHqEtNMFsSgnxN4K3IcW02UbRMZ28pZbq4gq6Q5DRLh5
         FuSxTdHbKNIkLZQBeeCgSgjl3nlzzq1lUbCHEVwK0MEySgsDTW5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jason Hatton <jhatton@globalfinishing.com>
Subject: [PATCH v2 1/2] t: add a test helper to truncate files
Date:   Thu, 12 Oct 2023 16:09:29 +0000
Message-ID: <20231012160930.330618-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012160930.330618-1-sandals@crustytoothpaste.net>
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

In a future commit, we're going to work with some large files which will
be at least 4 GiB in size.  To take advantage of the sparseness
functionality on most Unix systems and avoid running the system out of
disk, it would be convenient to use truncate(2) to simply create a
sparse file of sufficient size.

However, the GNU truncate(1) utility isn't portable, so let's write a
tiny test helper that does the work for us.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 Makefile                 |  1 +
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 t/helper/test-truncate.c | 27 +++++++++++++++++++++++++++
 4 files changed, 30 insertions(+)
 create mode 100644 t/helper/test-truncate.c

diff --git a/Makefile b/Makefile
index 9c6a2f125f..03adcb5a48 100644
--- a/Makefile
+++ b/Makefile
@@ -852,6 +852,7 @@ TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-submodule.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-trace2.o
+TEST_BUILTINS_OBJS += test-truncate.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-userdiff.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 9010ac6de7..876cd2dc31 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -86,6 +86,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
 	{ "trace2", cmd__trace2 },
+	{ "truncate", cmd__truncate },
 	{ "userdiff", cmd__userdiff },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "xml-encode", cmd__xml_encode },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f134f96b97..70dd4eba11 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -79,6 +79,7 @@ int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
+int cmd__truncate(int argc, const char **argv);
 int cmd__userdiff(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__xml_encode(int argc, const char **argv);
diff --git a/t/helper/test-truncate.c b/t/helper/test-truncate.c
new file mode 100644
index 0000000000..bd3fde364b
--- /dev/null
+++ b/t/helper/test-truncate.c
@@ -0,0 +1,27 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+
+/*
+ * Truncate a file to the given size.
+ */
+int cmd__truncate(int argc, const char **argv)
+{
+	char *p = NULL;
+	uintmax_t sz = 0;
+	int fd = -1;
+
+	if (argc != 3)
+		die("expected filename and size");
+
+	sz = strtoumax(argv[2], &p, 0);
+	if (*p)
+		die("invalid size");
+
+	fd = open(argv[1], O_WRONLY | O_CREAT, 0600);
+	if (fd < 0)
+		die_errno("failed to open file %s", argv[1]);
+
+	if (ftruncate(fd, (off_t) sz) < 0)
+		die_errno("failed to truncate file");
+	return 0;
+}
