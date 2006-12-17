X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] git-diff: don't add trailing blanks (i.e., do what GNU diff -u now does)
Date: Sun, 17 Dec 2006 20:32:14 +0100
Message-ID: <87y7p6nwsh.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 19:52:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1169 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 14:51:44 EST
Original-Lines: 70
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34702>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw23D-0001QT-Md for gcvg-git@gmane.org; Sun, 17 Dec
 2006 20:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750989AbWLQTvp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 14:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWLQTvp
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 14:51:45 -0500
Received: from mx.meyering.net ([82.230.74.64]:41022 "EHLO mx.meyering.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1750989AbWLQTvo
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 14:51:44 -0500
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000) id
 1D8ED6B03; Sun, 17 Dec 2006 20:32:14 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

You may recall that GNU diff -u changed recently so that it no
longer outputs any trailing space unless the input data has it.
This means that blank context lines are now blank also in diff -u output.
Before, they would have a single trailing space.

Then, git was changed to allow that new diff output format.
Now that git-diff generates output using its internal diff, its
output is no longer identical to what you get when using GNU diff.

This patch makes the output of git-diff the same as GNU diff's.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 t/t4016-diff-trailing-space.sh |   31 +++++++++++++++++++++++++++++++
 xdiff/xutils.c                 |    3 +++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t4016-diff-trailing-space.sh b/t/t4016-diff-trailing-space.sh
new file mode 100755
index 0000000..95c4674
--- /dev/null
+++ b/t/t4016-diff-trailing-space.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+#
+# Copyright (c) Jim Meyering
+#
+test_description='diff does not add trailing spaces'
+
+. ./test-lib.sh
+
+cat <<\EOF > exp ||
+diff --git a/f b/f
+index 5f6a263..8cb8bae 100644
+--- a/f
++++ b/f
+@@ -1,2 +1,2 @@
+
+-x
++y
+EOF
+exit 1
+
+test_expect_success \
+    "$test_description" \
+    '(echo; echo x) > f &&
+     git-add f &&
+     git-commit -q -m. f &&
+     (echo; echo y) > f &&
+     git-diff f > actual &&
+     cmp exp actual
+     '
+
+test_done
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 1b899f3..8b7380a 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -51,6 +51,9 @@ int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 	mb[0].size = psize;
 	mb[1].ptr = (char *) rec;
 	mb[1].size = size;
+	/* Don't emit a trailing space for an empty context line.  */
+	if (size == 1 && rec[0] == '\n' && psize == 1 && *pre == ' ')
+		mb[0].size = 0;
 	if (size > 0 && rec[size - 1] != '\n') {
 		mb[2].ptr = (char *) "\n\\ No newline at end of file\n";
 		mb[2].size = strlen(mb[2].ptr);
--
