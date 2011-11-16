From: Robie Basak <robie.basak@canonical.com>
Subject: [PATCH] apply: squash consecutive slashes with p_value > 0
Date: Wed, 16 Nov 2011 12:04:03 +0000
Message-ID: <20111116120403.GA10342@mal.justgohome.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 13:04:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQeDs-0006i7-K2
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 13:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613Ab1KPMEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 07:04:06 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33064 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422Ab1KPMEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 07:04:05 -0500
Received: from 107.27.187.81.in-addr.arpa ([81.187.27.107] helo=localhost)
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71)
	(envelope-from <robie.basak@canonical.com>)
	id 1RQeDk-0000Gk-Iq
	for git@vger.kernel.org; Wed, 16 Nov 2011 12:04:04 +0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185539>

"patch" works with -p1 and diffs in the following form:
    --- foo.orig//bar
    +++ foo//bar
    ...

patch(1) says that "A sequence of one or more adjacent slashes is
counted as a single slash."

This patch amends git-apply's filename parsing to behave in the same
way, eliminating both '/'s with -p1 in this example.

Test case included.

Signed-off-by: Robie Basak <robie.basak@canonical.com>
---
 builtin/apply.c              |    8 ++++++--
 t/t4153-apply-doubleslash.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100755 t/t4153-apply-doubleslash.sh

diff --git a/builtin/apply.c b/builtin/apply.c
index 84a8a0b..78e25fa 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -627,9 +627,13 @@ static char *find_name_common(const char *line, char *def, int p_value,
 			if (name_terminate(start, line-start, c, terminate))
 				break;
 		}
-		line++;
-		if (c == '/' && !--p_value)
+		if (c == '/' && !--p_value) {
+			while (*line == '/')
+			    line++;
 			start = line;
+		} else {
+			line++;
+		}
 	}
 	if (!start)
 		return squash_slash(def);
diff --git a/t/t4153-apply-doubleslash.sh b/t/t4153-apply-doubleslash.sh
new file mode 100755
index 0000000..1ea76b5
--- /dev/null
+++ b/t/t4153-apply-doubleslash.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+# Copyright (c) 2011 Canonical Ltd.
+#
+
+test_description='git apply filenames with double slashes
+
+Try to apply a patch with git-apply where the filename specified has a double
+slash after the first (to-be-stripped) component'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit 1 f &&
+	cat > good.patch <<EOF
+diff -u a//f b//f
+--- a//f
++++ b//f
+@@ -1 +1 @@
+-1
++2
+EOF
+'
+
+test_expect_success 'apply diff with double slashes in filenames' '
+	git apply good.patch 2>err
+'
+
+test_done
-- 
1.7.5.4
