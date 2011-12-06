From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/5] Add test-scrap-cache-tree
Date: Tue, 6 Dec 2011 18:43:35 +0100
Message-ID: <534454506f92428863de8fe0638f4129e962a073.1323191497.git.trast@student.ethz.ch>
References: <cover.1323191497.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 06 18:43:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXz3W-0000Dz-Rk
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 18:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab1LFRnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 12:43:46 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:35844 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab1LFRnn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 12:43:43 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:43:39 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:43:40 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <cover.1323191497.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186358>

A simple utility that invalidates all existing cache-tree data.  We
need this for tests.  (We don't need a tool to rebuild the cache-tree
data; git read-tree HEAD works for that.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 .gitignore              |    1 +
 Makefile                |    1 +
 test-scrap-cache-tree.c |   17 +++++++++++++++++
 3 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 test-scrap-cache-tree.c

diff --git a/.gitignore b/.gitignore
index 8572c8c..122336c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -171,6 +171,7 @@
 /test-date
 /test-delta
 /test-dump-cache-tree
+/test-scrap-cache-tree
 /test-genrandom
 /test-index-version
 /test-line-buffer
diff --git a/Makefile b/Makefile
index cbb5601..6bfa10b 100644
--- a/Makefile
+++ b/Makefile
@@ -436,6 +436,7 @@ TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
+TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
diff --git a/test-scrap-cache-tree.c b/test-scrap-cache-tree.c
new file mode 100644
index 0000000..4728013
--- /dev/null
+++ b/test-scrap-cache-tree.c
@@ -0,0 +1,17 @@
+#include "cache.h"
+#include "tree.h"
+#include "cache-tree.h"
+
+static struct lock_file index_lock;
+
+int main(int ac, char **av)
+{
+	int fd = hold_locked_index(&index_lock, 1);
+	if (read_cache() < 0)
+		die("unable to read index file");
+	active_cache_tree = NULL;
+	if (write_cache(fd, active_cache, active_nr)
+	    || commit_lock_file(&index_lock))
+		die("unable to write index file");
+	return 0;
+}
-- 
1.7.8.425.ga639d3
