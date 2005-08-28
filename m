From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 2/9] Fix detection of files with only one line in git-apply.
Date: Sun, 28 Aug 2005 15:24:27 +0000
Message-ID: <1125242667404-git-send-email-robfitz@273k.net>
References: <11252426672473-git-send-email-robfitz@273k.net>
Reply-To: Robert Fitzsimons <robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Aug 28 17:22:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9Ozf-0006KZ-Is
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 17:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVH1PWp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 11:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVH1PWo
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 11:22:44 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:35309 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751203AbVH1PWo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 11:22:44 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1E9OzP-0004PH-J7; Sun, 28 Aug 2005 16:22:32 +0100
In-Reply-To: <11252426672473-git-send-email-robfitz@273k.net>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 7.5)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7868>

A patch which added one line to an empty file or removed the only line
from a one line file would be incorrectly detected as an invalid new
or delete patch.  Added a new test case.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

 apply.c                  |    4 ++--
 t/t4103-apply-oneline.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 t/t4103-apply-oneline.sh

babd40afef54b06775b11a877b347685edbedcd2
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -638,9 +638,9 @@ static int parse_fragment(char *line, un
 			patch->new_name = NULL;
 	}
 
-	if (patch->is_new != !oldlines)
+	if (patch->is_new && (patch->is_new != !oldlines))
 		return error("new file depends on old contents");
-	if (patch->is_delete != !newlines) {
+	if (patch->is_delete && (patch->is_delete != !newlines)) {
 		if (newlines)
 			return error("deleted file still has contents");
 		fprintf(stderr, "** warning: file %s becomes empty but is not deleted\n", patch->new_name);
diff --git a/t/t4103-apply-oneline.sh b/t/t4103-apply-oneline.sh
new file mode 100644
--- /dev/null
+++ b/t/t4103-apply-oneline.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2005 Robert Fitzsimons
+#
+
+test_description='git-apply files with one line.
+
+'
+. ./test-lib.sh
+
+# setup
+
+cat > patch1.patch <<\EOF
+diff --git a/main.c b/main.c
+new file mode 100644
+--- /dev/null
++++ b/main.c
+@@ -0,0 +0,0 @@
+EOF
+cat > patch2.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -0,0 +1,1 @@
++#include <stdio.h>
+EOF
+cat > patch3.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -1,1 +0,0 @@
+-#include <stdio.h>
+EOF
+
+test_expect_success "S = patch1 (new file with no lines)" \
+    'git-apply patch1.patch'
+
+test_expect_success "S = patch2 (add one line)" \
+    'git-apply patch2.patch'
+
+test_expect_success "S = patch3 (delete one line)" \
+    'git-apply patch3.patch'
+
+test_done
+
