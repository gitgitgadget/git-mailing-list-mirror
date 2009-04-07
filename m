From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 10/14] difftool: add various git-difftool tests
Date: Tue,  7 Apr 2009 01:21:21 -0700
Message-ID: <1239092483-14973-4-git-send-email-davvid@gmail.com>
References: <1239092483-14973-1-git-send-email-davvid@gmail.com>
 <1239092483-14973-2-git-send-email-davvid@gmail.com>
 <1239092483-14973-3-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 07 10:25:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6c8-00066J-9m
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824AbZDGIWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 04:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754810AbZDGIWE
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 04:22:04 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:3518 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770AbZDGIV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 04:21:57 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2620149rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 01:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4iPbyUIFooKOjUdyZ4tQqVvtwFHwXoglp7e4M2E+DnA=;
        b=lVW56x3v2DtP7VRa6e0AZL78DUz5KVxUPbv3WfjsF6EjtRuZRvO0iOnTLgsN3wDpm6
         KRTpM0KraL2dMbxkmMUO3kh+WudFe8Xn3HXG0ytjtxqcz8X97nAa2c1JhJicnqmJFJa1
         muouszBOEmYq0lwQnvlXo00lKCMphcF7c7WjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TuIOjthYVYSCArkMsjYnxOf+aK+MEDSJvcb+z0DhQ5JIO/ulHswauPRf3oCOsgyGEc
         m8bCINt32dBui1bh+nHsdt8z2jTmQurTLqmGvomovaWBNWMae90QVN9/gQFcKOZfvtdb
         bix3H1AAydSodb7hgHEoAOlujvXvIpF/Ny0d0=
Received: by 10.114.67.17 with SMTP id p17mr554622waa.49.1239092514297;
        Tue, 07 Apr 2009 01:21:54 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l38sm6655429waf.33.2009.04.07.01.21.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 01:21:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239092483-14973-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115936>

t7800-difftool.sh tests the various command-line flags,
git-config variables, and environment settings supported by
git-difftool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

The original broke the test suite on Mac OS.
Testing difftool.<path>.path is hard without internal support
for a fake tool.

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
1.6.2.2.414.g81aa9
