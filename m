From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: add various git-difftool tests
Date: Mon, 23 Mar 2009 01:41:16 -0700
Message-ID: <1237797676-32047-2-git-send-email-davvid@gmail.com>
References: <1237797676-32047-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 23 09:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlfjY-0005mJ-8E
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 09:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757777AbZCWIkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 04:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757734AbZCWIkp
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 04:40:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:47373 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757980AbZCWIko (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 04:40:44 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1673228rvb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bX6AopCw7yLUekUm1pnq1E6kpAwJIPnDyPoyDQPT7nk=;
        b=Dk7p22nv8T1W0V4cSN0vg1V6qWLq8w2GTui9rUfjFymNxeFW5Rg92o82gaibpGFoLy
         r/GbhpyRy7hfqElrWU1C9KrBpR9v9LFu9twQUYXyWr8J6uD1rSnvJW9lqTtwm/UW1ncv
         NLXJFrVHDFMRK8NAJaXeO9GwaQxSedzsmXrPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Rbezg4GIYJM3yByn8TMGg1AalIViTLE/3h1ickPPVcLbaEtg1hWdWbjaW1btLv/5px
         kMyN7NvGnu1XECv1dYj4Znunv+nIW97tG0u57OoNvbpmw6Jw1x6KIzDMtm+lVSuQmzNc
         otoLxWdXJJZPnqabqivor4x8g0/xgCkyXMcM8=
Received: by 10.114.211.17 with SMTP id j17mr4648630wag.61.1237797643151;
        Mon, 23 Mar 2009 01:40:43 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v25sm5124595wah.51.2009.03.23.01.40.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 01:40:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.303.g63699
In-Reply-To: <1237797676-32047-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114265>

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
index 0000000..c7cd2b1
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
+	unset GIT_DIFF_TOOL &&
+	unset GIT_MERGE_TOOL &&
+	unset GIT_DIFFTOOL_NO_PROMPT &&
+	git config diff.tool test-tool &&
+	git config difftool.test-tool.cmd "cat \$LOCAL"
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
+	git config --unset diff.tool &&
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
