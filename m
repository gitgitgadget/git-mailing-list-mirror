From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] difftool: add various git-difftool tests
Date: Tue, 24 Mar 2009 20:58:29 -0700
Message-ID: <1237953509-24307-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 25 04:59:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmKHF-0001q2-2E
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 04:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631AbZCYD5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 23:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754172AbZCYD5w
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 23:57:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:32118 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000AbZCYD5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 23:57:51 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1978787wah.21
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 20:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=M/QA04/FHprft3EWQPKIa+vXnrSCe+DE+w6QrgfRfoY=;
        b=uxG7AI3svDs/dQeqb2lu/z4XUR/n18hI9YyeuUkwH5p8O4RyltrAIPdbf4jRUxs7mO
         BDqkftlHFtpEtDbd9xCZnBT2lwG7G74vHy5mvtbsuDAdqTEZKawpKOQcuKUvfHzy5Lxo
         KOFacRCjyiV1AvRrfp1PIpCBPM9azGetmH94o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jpjDdCkM4ZLfiPiOfuzeZQYb2TrdyuxfvSc7hZSOFZfhCRurkg7mnnUNTNuSBdAf+v
         hh/2GKaFtOaKPg26bYGgQ79XQX6EN1ucQJa/BQdbiMUUuQaUPKmktGjKLaGhurBHYvc8
         gdP6WgCiD+eWSZpnf//fWutfE0eCFckptJlQg=
Received: by 10.114.53.18 with SMTP id b18mr6160835waa.6.1237953468370;
        Tue, 24 Mar 2009 20:57:48 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n30sm7091164wag.21.2009.03.24.20.57.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 20:57:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.303.g63699
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114554>

t7800-difftool.sh tests the various command-line flags,
git-config variables, and environment settings supported by
git-difftool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh |  139 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 139 insertions(+), 0 deletions(-)
 create mode 100755 t/t7800-difftool.sh

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
new file mode 100755
index 0000000..ceef84b
--- /dev/null
+++ b/t/t7800-difftool.sh
@@ -0,0 +1,139 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 David Aguilar
+#
+
+test_description='git-difftool
+
+Testing basic diff tool invocation
+'
+
+. ./test-lib.sh
+
+remove_config_vars()
+{
+	# Unset all config variables used by git-difftool
+	git config --unset diff.tool
+	git config --unset difftool.test-tool.cmd
+	git config --unset merge.tool
+	git config --unset mergetool.test-tool.cmd
+	return 0
+}
+
+restore_test_defaults()
+{
+	# Restores the test defaults used by several tests
+	remove_config_vars
+	unset GIT_DIFF_TOOL
+	unset GIT_MERGE_TOOL
+	unset GIT_DIFFTOOL_NO_PROMPT
+	git config diff.tool test-tool &&
+	git config difftool.test-tool.cmd 'cat $LOCAL'
+}
+
+# Create a file on master and change it on branch
+test_expect_success 'setup' '
+	echo master >file &&
+	git add file &&
+	git commit -m "added file" &&
+
+	git checkout -b branch master &&
+	echo branch >file &&
+	git commit -a -m "branch changed file" &&
+	git checkout master
+'
+
+# Configure a custom difftool.<tool>.cmd and use it
+test_expect_success 'custom commands' '
+	restore_test_defaults &&
+	git config difftool.test-tool.cmd "cat \$REMOTE" &&
+
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "master" &&
+
+	restore_test_defaults &&
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch"
+'
+
+# Ensures that git-difftool ignores bogus --tool values
+test_expect_success 'difftool ignores bad --tool values' '
+	diff=$(git difftool --no-prompt --tool=bogus-tool branch)
+	test "$?" = 1 &&
+	test "$diff" = ""
+'
+
+# Specify the diff tool using $GIT_DIFF_TOOL
+test_expect_success 'GIT_DIFF_TOOL variable' '
+	git config --unset diff.tool
+	GIT_DIFF_TOOL=test-tool &&
+	export GIT_DIFF_TOOL &&
+
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
+# Test the $GIT_*_TOOL variables and ensure
+# that $GIT_DIFF_TOOL always wins unless --tool is specified
+test_expect_success 'GIT_DIFF_TOOL overrides' '
+	git config diff.tool bogus-tool &&
+	git config merge.tool bogus-tool &&
+
+	GIT_MERGE_TOOL=test-tool &&
+	export GIT_MERGE_TOOL &&
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch" &&
+	unset GIT_MERGE_TOOL &&
+
+	GIT_MERGE_TOOL=bogus-tool &&
+	GIT_DIFF_TOOL=test-tool &&
+	export GIT_MERGE_TOOL &&
+	export GIT_DIFF_TOOL &&
+
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch" &&
+
+	GIT_DIFF_TOOL=bogus-tool &&
+	export GIT_DIFF_TOOL &&
+
+	diff=$(git difftool --no-prompt --tool=test-tool branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
+# Test that we don't have to pass --no-prompt to difftool
+# when $GIT_DIFFTOOL_NO_PROMPT is true
+test_expect_success 'GIT_DIFFTOOL_NO_PROMPT variable' '
+	GIT_DIFFTOOL_NO_PROMPT=true &&
+	export GIT_DIFFTOOL_NO_PROMPT &&
+
+	diff=$(git difftool branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
+# git-difftool falls back to git-mergetool config variables
+# so test that behavior here
+test_expect_success 'difftool + mergetool config variables' '
+	remove_config_vars
+	git config merge.tool test-tool &&
+	git config mergetool.test-tool.cmd "cat \$LOCAL" &&
+
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch" &&
+
+	# set merge.tool to something bogus, diff.tool to test-tool
+	git config merge.tool bogus-tool &&
+	git config diff.tool test-tool &&
+
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
+test_done
-- 
1.6.2.1.303.g63699
