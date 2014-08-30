From: Max Kirillov <max@max630.net>
Subject: [PATCH] rev-parse: include HEAD in --all output
Date: Sun, 31 Aug 2014 01:24:48 +0300
Message-ID: <1409437488-25233-1-git-send-email-max@max630.net>
References: <CAF7_NFRz6Zc-wTDSFdkW4N2wRATZ8-g05j6sFu1t7DB0X72dkg@mail.gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Max Kirillov <max@max630.net>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 00:34:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNrE6-00085l-Mi
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 00:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbaH3WdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 18:33:23 -0400
Received: from p3plsmtpa12-10.prod.phx3.secureserver.net ([68.178.252.239]:37936
	"EHLO p3plsmtpa12-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751427AbaH3WdX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2014 18:33:23 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Aug 2014 18:33:23 EDT
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa12-10.prod.phx3.secureserver.net with 
	id lARK1o0083gsSd601ARSna; Sat, 30 Aug 2014 15:25:33 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
In-Reply-To: <CAF7_NFRz6Zc-wTDSFdkW4N2wRATZ8-g05j6sFu1t7DB0X72dkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256272>

for_each_ref() does not include it itself, and without the hash
the detached HEAD may be missed by some frontends (like gitk).

Add test which verifies the head is returned

Update test t6018-rev-list-glob.sh which relied on exact list of
returned hashes.

Signed-off-by: Max Kirillov <max@max630.net>
---
 builtin/rev-parse.c           |  1 +
 t/t1514-rev-parse-detached.sh | 21 +++++++++++++++++++++
 t/t6018-rev-list-glob.sh      |  4 ++--
 3 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100755 t/t1514-rev-parse-detached.sh

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index d85e08c..42f468c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -642,6 +642,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
+				head_ref(show_reference, NULL);
 				for_each_ref(show_reference, NULL);
 				continue;
 			}
diff --git a/t/t1514-rev-parse-detached.sh b/t/t1514-rev-parse-detached.sh
new file mode 100755
index 0000000..eeb2318
--- /dev/null
+++ b/t/t1514-rev-parse-detached.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='test git rev-parse references'
+
+. ./test-lib.sh
+
+test_expect_success 'make repo' '
+	git commit --allow-empty -m commit1 &&
+	git commit --allow-empty -m commit2 &&
+	git checkout  --detach master &&
+	git commit --allow-empty -m commit3
+'
+
+head_sha1=`git rev-parse HEAD`
+
+test_expect_success 'HEAD should be listed in rev-parse --all' '
+	git rev-parse --all >all_refs &&
+	grep -q "$head_sha1" all_refs
+'
+
+test_done
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index d00f7db..ba0b89c 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -134,11 +134,11 @@ test_expect_success 'rev-parse --exclude with --branches' '
 '
 
 test_expect_success 'rev-parse --exclude with --all' '
-	compare rev-parse "--exclude=refs/remotes/* --all" "--branches --tags"
+	compare rev-parse "--exclude=refs/remotes/* --all" "HEAD --branches --tags"
 '
 
 test_expect_success 'rev-parse accumulates multiple --exclude' '
-	compare rev-parse "--exclude=refs/remotes/* --exclude=refs/tags/* --all" --branches
+	compare rev-parse "--exclude=refs/remotes/* --exclude=refs/tags/* --all" "HEAD --branches"
 '
 
 test_expect_success 'rev-list --glob=refs/heads/subspace/*' '
-- 
2.0.1.1697.g73c6810
