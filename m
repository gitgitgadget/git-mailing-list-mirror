From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cg-clean test
Date: Mon, 12 Dec 2005 15:56:15 -0500
Message-ID: <1134420975.4695.16.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Dec 12 21:59:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eluim-0004mq-0p
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 21:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVLLU43 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 15:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVLLU43
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 15:56:29 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:48602 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751213AbVLLU42
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 15:56:28 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EluhS-0002ts-CE
	for git@vger.kernel.org; Mon, 12 Dec 2005 15:55:17 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EluiV-00044w-Tv; Mon, 12 Dec 2005 15:56:15 -0500
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13540>

This is a test for cg-clean functionality.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/t/t9400-clean.sh b/t/t9400-clean.sh
new file mode 100755
index 0000000..76186b6
--- /dev/null
+++ b/t/t9400-clean.sh
@@ -0,0 +1,112 @@
+#!/usr/bin/env bash
+#
+# Copyright (c) 2005 Pvel Roskin
+#
+test_description="Tests basic cg-clean functionality
+
+Create files and directories and check that cg-clean removes them."
+
+. ./test-lib.sh
+
+# Use spaces in names to make sure they are handled properly.
+echo "repo file 1" >"repo file 1"
+mkdir "repo dir"
+echo "repo file 2" >"repo dir/repo file 2"
+echo "*.ign" >".gitignore"
+echo "*.ign1" >"repo dir/.gitignore"
+
+test_expect_success 'initialize repo' \
+	"(cg-add -r * .gitignore && \
+	  cg-commit -C -m\"Initial commit\")"
+
+echo "extra file 1" >"extra file 1"
+mkdir "extra dir 1"
+echo "extra file 2" >"repo dir/extra file 2"
+mkdir "repo dir/extra dir 2"
+echo "extra file 3" >"extra dir 1/extra file 3"
+echo "ign file 1" >"ign file 1.ign"
+echo "ign file 2" >"ign file 2.ign1"
+echo "ign file 3" >"repo dir/ign file 3.ign"
+echo "ign file 4" >"repo dir/ign file 4.ign1"
+
+# Create file lists under .git/temp, exclude .git/ from listings.
+# Compare lists before and after cg-clean and check if only the expected
+# files were removed.
+topdir="`pwd`"
+mkdir .git/temp
+list="$topdir/.git/temp/list"
+
+mklist()
+{
+	cd "$topdir"
+	find . 2>/dev/null |sed -n "/^.\/.git\//d;s/^..//p" | \
+		sort > "$list-$1"
+}
+
+check_loss()
+{
+	mklist new
+	echo "$loss" | cat - "$list-new" | \
+	grep -v ^$ | sort >"$list-combined"
+	diff -u "$list-init" "$list-combined" > "$list.diff" && \
+	cp -f "$list-new" "$list-init"
+}
+
+mklist init
+loss=''
+test_expect_success 'cg-clean -n in top-level dir' \
+	"(cg-clean -n && check_loss)"
+
+test_expect_success 'cg-clean -Ddxqn in top-level dir' \
+	"(cg-clean -Ddxqn && check_loss)"
+
+test_expect_success 'cg-clean -n in subdir' \
+	"(cd 'repo dir' && cg-clean -n && check_loss)"
+
+loss='repo dir/extra file 2'
+test_expect_success 'cg-clean in subdir' \
+	"(cd 'repo dir' && cg-clean && check_loss)"
+
+loss='repo dir/extra dir 2'
+test_expect_success 'cg-clean -d in subdir' \
+	"(cd 'repo dir' && cg-clean -d && check_loss)"
+
+loss='repo dir/ign file 3.ign
+repo dir/ign file 4.ign1'
+test_expect_success 'cg-clean -x in subdir' \
+	"(cd 'repo dir' && cg-clean -x && check_loss)"
+
+# Restore extra files in "repo dir"
+echo "extra file 2" >"repo dir/extra file 2"
+mkdir "repo dir/extra dir 2"
+echo "ign file 3" >"repo dir/ign file 3.ign"
+echo "ign file 4" >"repo dir/ign file 4.ign1"
+mklist init
+
+# FIXME: cg-clean shouldn't clean unknown directories without "-d"
+loss='extra file 1
+ign file 2.ign1
+extra dir 1/extra file 3
+repo dir/extra file 2'
+test_expect_success 'cg-clean in top-level dir' \
+	"(cg-clean && check_loss)"
+
+loss='ign file 1.ign
+repo dir/ign file 3.ign
+repo dir/ign file 4.ign1'
+test_expect_success 'cg-clean -x in top-level dir' \
+	"(cg-clean -x && check_loss)"
+
+loss='extra dir 1
+repo dir/extra dir 2'
+test_expect_success 'cg-clean -d in top-level dir' \
+	"(cg-clean -d && check_loss)"
+
+mkdir "extra dir 3"
+chmod 000 "extra dir 3"
+mklist init
+loss='extra dir 3'
+test_expect_success 'cg-clean -D in top-level dir' \
+	"(cg-clean -D && check_loss)"
+
+test_done


-- 
Regards,
Pavel Roskin
