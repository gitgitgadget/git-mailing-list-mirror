From: lists@haller-berlin.de (Stefan Haller)
Subject: [PATCH] Add tests to demonstrate update-index bug with core.symlinks/core.filemode
Date: Sun, 24 Oct 2010 13:40:04 +0200
Message-ID: <1jqvbx3.1icsj8j1jf26lfM%lists@haller-berlin.de>
References: <1jqpu2f.1qxnixxtdqhreM%lists@haller-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 13:40:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9yvv-0001c7-3W
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 13:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521Ab0JXLkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 07:40:07 -0400
Received: from mail.ableton.net ([62.96.12.115]:41281 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932448Ab0JXLkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 07:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:To; bh=I2oHNW3N8VulcLJaYveQmXyxT8RAAvX8/A2jETOT3ck=;
	b=A9nuo3wmN3XNQGfSoWOT0CE3VEHldl6KbOxDSMQdk9GUe77itvOY3aSTOk1Kx2oUWgdqqR3hKLy+US2OxM9hxoaszQVSuPOs1RIQnTo7JE/EdvU1kEfrk9oKQvDL7KHKKkfLAryVd8ldoMSzGUmjUuVszSUvPAAbYU9sumFtEP0=;
Received: from dslb-088-073-104-214.pools.arcor-ip.net ([88.73.104.214] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1P9yvk-0001gQ-AI
	for git@vger.kernel.org; Sun, 24 Oct 2010 13:40:04 +0200
In-Reply-To: <1jqpu2f.1qxnixxtdqhreM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159855>

When calling update-index on an unmerged file that is executable and
core.filemode is false, or that is a symlink and core.symlink is false,
the executable bit or the symlink property is lost.
---
Stefan Haller <lists@haller-berlin.de> wrote:

> There's a bug with the handling of the executable bit when core.filemode
> is false: when you have an executable file that has unmerged changes,
> and you stage it with "git update-index", the executable bit is lost.
> If you stage it with "git add" instead, it works fine.

It turns out that the same bug exists for symlinks when core.symlink is
false. Here's a patch that adds two tests that demonstrate the problems.
(I suspect both have a similar cause, and/or a similar solution.)

This is the first time I write a git test, so please point out anything
I might have done wrong. Also, I still don't have much of an idea how or
where to fix the problem, so any guidance towards that is much
appreciated.

 t/t2107-update-index-executable-bit-merged.sh |   44 +++++++++++++++++++++++++
 t/t2108-update-index-symlink-merged.sh        |   43 ++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100755 t/t2107-update-index-executable-bit-merged.sh
 create mode 100755 t/t2108-update-index-symlink-merged.sh

diff --git a/t/t2107-update-index-executable-bit-merged.sh b/t/t2107-update-index-executable-bit-merged.sh
new file mode 100755
index 0000000..7a8f740
--- /dev/null
+++ b/t/t2107-update-index-executable-bit-merged.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Stefan Haller
+#
+
+test_description='git update-index on filesystem w/o symlinks test.
+
+This tests that git update-index keeps the executable bit when staging
+an unmerged file after a merge if core.filemode is false.'
+
+. ./test-lib.sh
+
+test_expect_success \
+'preparation' '
+git config core.filemode false &&
+touch foo &&
+git add foo &&
+git update-index --chmod=+x foo &&
+git commit -m "Create"'
+
+test_expect_success \
+'modify the file on two branches and merge' '
+git branch br &&
+test_commit "Modify_on_master" foo &&
+git checkout br -- &&
+test_commit "Modify_on_branch" foo &&
+test_must_fail git merge master'
+
+test_expect_success \
+'double-check that file is indeed unmerged' '
+git ls-files --unmerged --error-unmatch -- foo'
+
+test_expect_success \
+'stage unmerged file with update-index' '
+git update-index -- foo'
+
+test_expect_failure \
+'check that filemode is still 100755' '
+case "`git ls-files --stage --cached -- foo`" in
+"100755 "*foo) echo pass;;
+*) echo fail; git ls-files --stage --cached -- foo; (exit 1);;
+esac'
+
+test_done
diff --git a/t/t2108-update-index-symlink-merged.sh b/t/t2108-update-index-symlink-merged.sh
new file mode 100755
index 0000000..7e28e91
--- /dev/null
+++ b/t/t2108-update-index-symlink-merged.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Stefan Haller
+#
+
+test_description='git update-index on filesystem w/o symlinks test.
+
+This tests that git update-index keeps the executable bit when staging
+an unmerged file after a merge if core.filemode is false.'
+
+. ./test-lib.sh
+
+test_expect_success \
+'preparation' '
+git config core.symlinks false &&
+l=$(printf file | git hash-object -t blob -w --stdin) &&
+echo "120000 $l    symlink" | git update-index --index-info &&
+git commit -m "Create"'
+
+test_expect_success \
+'modify the symlink on two branches and merge' '
+git branch br &&
+test_commit "Modify_on_master" symlink &&
+git checkout br -- &&
+test_commit "Modify_on_branch" symlink &&
+test_must_fail git merge master'
+
+test_expect_success \
+'double-check that file is indeed unmerged' '
+git ls-files --unmerged --error-unmatch -- symlink'
+
+test_expect_success \
+'stage unmerged file with update-index' '
+git update-index -- symlink'
+
+test_expect_failure \
+'check that file is still a symlink' '
+case "`git ls-files --stage --cached -- symlink`" in
+"120000 "*symlink) echo pass;;
+*) echo fail; git ls-files --stage --cached -- symlink; (exit 1);;
+esac'
+
+test_done
-- 
1.7.3.1.57.gb5d9d
