From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: add --authors-file test
Date: Sun, 11 Jan 2009 15:44:07 -0800
Message-ID: <20090111234406.GA22763@yp-box.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 00:47:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMA1m-0004hm-8f
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 00:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbZAKXoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 18:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbZAKXoJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 18:44:09 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60057 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbZAKXoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 18:44:08 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0F21FDE5;
	Sun, 11 Jan 2009 23:44:07 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105254>

I'm not sure how often this functionality is used, but in case
it's not, having an extra test here will help catch breakage
sooner.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

  This was posted over a year ago and forgotten about.  Updated and
  cleaned up a bit to work with the new test suite.

 t/t9130-git-svn-authors-file.sh |   94 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)
 create mode 100755 t/t9130-git-svn-authors-file.sh

diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
new file mode 100755
index 0000000..b8fb277
--- /dev/null
+++ b/t/t9130-git-svn-authors-file.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Eric Wong
+#
+
+test_description='git svn authors file tests'
+
+. ./lib-git-svn.sh
+
+cat > svn-authors <<EOF
+aa = AAAAAAA AAAAAAA <aa@example.com>
+bb = BBBBBBB BBBBBBB <bb@example.com>
+EOF
+
+test_expect_success 'setup svnrepo' '
+	for i in aa bb cc dd
+	do
+		svn mkdir -m $i --username $i "$svnrepo"/$i
+	done
+	'
+
+test_expect_success 'start import with incomplete authors file' '
+	! git svn clone --authors-file=svn-authors "$svnrepo" x
+	'
+
+test_expect_success 'imported 2 revisions successfully' '
+	(
+		cd x
+		test "`git rev-list refs/remotes/git-svn | wc -l`" -eq 2 &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
+		  grep "^author BBBBBBB BBBBBBB <bb@example\.com> " &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
+		  grep "^author AAAAAAA AAAAAAA <aa@example\.com> "
+	)
+	'
+
+cat >> svn-authors <<EOF
+cc = CCCCCCC CCCCCCC <cc@example.com>
+dd = DDDDDDD DDDDDDD <dd@example.com>
+EOF
+
+test_expect_success 'continues to import once authors have been added' '
+	(
+		cd x
+		git svn fetch --authors-file=../svn-authors &&
+		test "`git rev-list refs/remotes/git-svn | wc -l`" -eq 4 &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
+		  grep "^author DDDDDDD DDDDDDD <dd@example\.com> " &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
+		  grep "^author CCCCCCC CCCCCCC <cc@example\.com> "
+	)
+	'
+
+test_expect_success 'authors-file against globs' '
+	svn mkdir -m globs --username aa \
+	  "$svnrepo"/aa/trunk "$svnrepo"/aa/branches "$svnrepo"/aa/tags &&
+	git svn clone --authors-file=svn-authors -s "$svnrepo"/aa aa-work &&
+	for i in bb ee cc
+	do
+		branch="aa/branches/$i"
+		svn mkdir -m "$branch" --username $i "$svnrepo/$branch"
+	done
+	'
+
+test_expect_success 'fetch fails on ee' '
+	( cd aa-work && ! git svn fetch --authors-file=../svn-authors )
+	'
+
+tmp_config_get () {
+	GIT_CONFIG=.git/svn/.metadata git config --get "$1"
+}
+
+test_expect_success 'failure happened without negative side effects' '
+	(
+		cd aa-work &&
+		test 6 -eq "`tmp_config_get svn-remote.svn.branches-maxRev`" &&
+		test 6 -eq "`tmp_config_get svn-remote.svn.tags-maxRev`"
+	)
+	'
+
+cat >> svn-authors <<EOF
+ee = EEEEEEE EEEEEEE <ee@example.com>
+EOF
+
+test_expect_success 'fetch continues after authors-file is fixed' '
+	(
+		cd aa-work &&
+		git svn fetch --authors-file=../svn-authors &&
+		test 8 -eq "`tmp_config_get svn-remote.svn.branches-maxRev`" &&
+		test 8 -eq "`tmp_config_get svn-remote.svn.tags-maxRev`"
+	)
+	'
+
+test_done
-- 
Eric Wong
