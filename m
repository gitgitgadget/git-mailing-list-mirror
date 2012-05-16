From: Bobby Powers <bobbypowers@gmail.com>
Subject: [PATCH v2] diff --no-index: reset temporary buffer lengths on directory iteration
Date: Wed, 16 May 2012 10:28:31 -0400
Message-ID: <1337178511-22980-1-git-send-email-bobbypowers@gmail.com>
References: <CAArOQ2UNJyBHNa5_+G+J0bihCEOxPebey8-EkcoXDyeR1wM+yw@mail.gmail.com>
Cc: Bobby Powers <bobbypowers@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 16:29:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUfDk-0007Lw-27
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 16:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab2EPO2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 10:28:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54002 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab2EPO2h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 10:28:37 -0400
Received: by pbbrp8 with SMTP id rp8so1175785pbb.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hnsIo0jpsZS6jyxWFJzGGxrxP66YY5RP2kDeRamrGjo=;
        b=SsnTk2K53VgiEr+UqlTu7qT3Y0uwmYQVOSM0RUsNgbp3qW1q6QfiAJGQOJA5h/8XTF
         M7Wy2maHH0SjdOQf/FbXocjqxCmzrW9msEkpXjBDkQ4Q/duETFs/FaCrF7d73DYGFPmL
         uWE4SJjyzj34EywTpRbOOIpU3gthfyD50h67Ru2wMXj811iv1n1l9a+roQ1Vo2lWHUd2
         0QY1bTN9JbU3DT76vgiRsVhWrIW/yb0X81cBZNrKCqpP7CW7Th+RNvyJ0THsTSYeNOjH
         H9Zsp1HtDA+czN2uyJS4ddTfbF4HJ17er+SP3ERjKtWLXuJZDg+UaKGrMB3oRxWeSWfX
         ETig==
Received: by 10.68.203.225 with SMTP id kt1mr17154807pbc.133.1337178517617;
        Wed, 16 May 2012 07:28:37 -0700 (PDT)
Received: from eduardo.slate.com ([64.125.223.146])
        by mx.google.com with ESMTPS id kd6sm5638806pbc.24.2012.05.16.07.28.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 07:28:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.521.g8ddb639
In-Reply-To: <CAArOQ2UNJyBHNa5_+G+J0bihCEOxPebey8-EkcoXDyeR1wM+yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197882>

Commit 875b91b3 introduced a regression when using diff --no-index
with directories.  When iterating through a directory, the switch to
strbuf from heap-allocated char arrays caused paths to form like
'dir/file1', 'dir/file1file2', rather than 'dir/file1', 'dir/file2' as
expected.  By resetting the length on each iteration (but not
buf.alloc), we avoid this.

Signed-off-by: Bobby Powers <bobbypowers@gmail.com>
---
 diff-no-index.c          |  6 ++++++
 t/t4053-diff-no-index.sh | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100755 t/t4053-diff-no-index.sh

diff --git a/diff-no-index.c b/diff-no-index.c
index b44473e..3080b66 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -68,6 +68,7 @@ static int queue_diff(struct diff_options *o,
 		struct string_list p1 = STRING_LIST_INIT_DUP;
 		struct string_list p2 = STRING_LIST_INIT_DUP;
 		int i1, i2, ret = 0;
+		size_t len1 = 0, len2 = 0;
 
 		if (name1 && read_directory(name1, &p1))
 			return -1;
@@ -80,18 +81,23 @@ static int queue_diff(struct diff_options *o,
 			strbuf_addstr(&buffer1, name1);
 			if (buffer1.len && buffer1.buf[buffer1.len - 1] != '/')
 				strbuf_addch(&buffer1, '/');
+			len1 = buffer1.len;
 		}
 
 		if (name2) {
 			strbuf_addstr(&buffer2, name2);
 			if (buffer2.len && buffer2.buf[buffer2.len - 1] != '/')
 				strbuf_addch(&buffer2, '/');
+			len2 = buffer2.len;
 		}
 
 		for (i1 = i2 = 0; !ret && (i1 < p1.nr || i2 < p2.nr); ) {
 			const char *n1, *n2;
 			int comp;
 
+			strbuf_setlen(&buffer1, len1);
+			strbuf_setlen(&buffer2, len2);
+
 			if (i1 == p1.nr)
 				comp = 1;
 			else if (i2 == p2.nr)
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
new file mode 100755
index 0000000..4dc8c67
--- /dev/null
+++ b/t/t4053-diff-no-index.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='diff --no-index'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir a &&
+	mkdir b &&
+	echo 1 >a/1 &&
+	echo 2 >a/2
+'
+
+test_expect_success 'git diff --no-index directories' '
+	git diff --no-index a b >cnt
+	test $? = 1 && test_line_count = 14 cnt
+'
+
+test_done
-- 
1.7.10.2.521.g8ddb639
