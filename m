From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 03/10] tests: introduce test_ln_s_add
Date: Fri,  7 Jun 2013 22:53:27 +0200
Message-ID: <6bbcf9909d76a466695a66e894bae8b98612ba15.1370636706.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 22:54:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3fl-00075o-Cm
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757275Ab3FGUyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:54:00 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:33332 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756038Ab3FGUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:53:37 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5B82210012;
	Fri,  7 Jun 2013 22:53:35 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A50FB19F5EA;
	Fri,  7 Jun 2013 22:53:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
In-Reply-To: <cover.1370636706.git.j6t@kdbg.org>
References: <cover.1370636706.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226713>

Add a new function that creates a symbolic link and adds it to the index
to be used in cases where a symbolic link is not required on the file
system. We will use it to remove many SYMLINKS prerequisites from test
cases.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/README                | 14 ++++++++++++++
 t/test-lib-functions.sh | 17 +++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/t/README b/t/README
index e669bb3..bbe25c3 100644
--- a/t/README
+++ b/t/README
@@ -592,6 +592,20 @@ library for your script to use.
 		test_cmp expected actual
 	'
 
+ - test_ln_s_add <path1> <path2>
+
+   This function helps systems whose filesystem does not support symbolic
+   links. Use it to add a symbolic link entry to the index when it is not
+   important that the file system entry is a symbolic link, i.e., instead
+   of the sequence
+
+	ln -s foo bar &&
+	git add bar
+
+   Sometimes it is possible to split a test in a part that does not need
+   the symbolic link in the file system and a part that does; then only
+   the latter part need be protected by a SYMLINKS prerequisite (see below).
+
 Prerequisites
 -------------
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5251009..fac9234 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -679,3 +679,20 @@ test_create_repo () {
 		mv .git/hooks .git/hooks-disabled
 	) || exit
 }
+
+# This function helps on symlink challenged file systems when it is not
+# important that the file system entry is a symbolic link.
+# Use test_ln_s_add instead of "ln -s x y && git add y" to add a
+# symbolic link entry y to the index.
+
+test_ln_s_add () {
+	if test_have_prereq SYMLINKS
+	then
+		ln -s "$1" "$2" &&
+		git update-index --add "$2"
+	else
+		printf '%s' "$1" >"$2" &&
+		ln_s_obj=$(git hash-object -w "$2") &&
+		git update-index --add --cacheinfo 120000 $ln_s_obj "$2"
+	fi
+}
-- 
1.8.3.rc1.32.g8b61cbb
