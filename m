From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 3/7 (amend)] test git rev-parse
Date: Wed, 6 Jun 2007 09:01:21 +0200
Message-ID: <20070606070121.GA18315@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx> <20070603144700.GC20061@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 09:01:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvpWS-00023s-Db
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 09:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbXFFHB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 03:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755828AbXFFHB0
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 03:01:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:52925 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753781AbXFFHBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 03:01:25 -0400
Received: (qmail invoked by alias); 06 Jun 2007 07:01:23 -0000
Received: from pD9EBB5B0.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.176]
  by mail.gmx.net (mp045) with SMTP; 06 Jun 2007 09:01:23 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/9xslVvjz95meccGQNRuqRRLluLByJXX7ruwc3To
	mQASktSZm6gMTw
Content-Disposition: inline
In-Reply-To: <20070603144700.GC20061@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49249>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
The amended version has a new test:
When GIT_DIR is set and the repository is not bare the current working
directory should be used as working tree.
---
 t/t1500-rev-parse.sh |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)
 create mode 100755 t/t1500-rev-parse.sh

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
new file mode 100755
index 0000000..66b0e58
--- /dev/null
+++ b/t/t1500-rev-parse.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='test git rev-parse'
+. ./test-lib.sh
+
+test_rev_parse() {
+	name=$1
+	shift
+
+	test_expect_success "$name: is-bare-repository" \
+	"test '$1' = \"\$(git rev-parse --is-bare-repository)\""
+	shift
+	[ $# -eq 0 ] && return
+
+	test_expect_success "$name: is-inside-git-dir" \
+	"test '$1' = \"\$(git rev-parse --is-inside-git-dir)\""
+	shift
+	[ $# -eq 0 ] && return
+
+	test_expect_success "$name: prefix" \
+	"test '$1' = \"\$(git rev-parse --show-prefix)\""
+	shift
+	[ $# -eq 0 ] && return
+}
+
+test_rev_parse toplevel false false ''
+
+cd .git || exit 1
+test_rev_parse .git/ false true .git/
+cd objects || exit 1
+test_rev_parse .git/objects/ false true .git/objects/
+cd ../.. || exit 1
+
+mkdir -p sub/dir || exit 1
+cd sub/dir || exit 1
+test_rev_parse subdirectory false false sub/dir/
+cd ../.. || exit 1
+
+git config core.bare true
+test_rev_parse 'core.bare = true' true
+
+git config --unset core.bare
+test_rev_parse 'core.bare undefined' false
+
+mkdir work || exit 1
+cd work || exit 1
+export GIT_DIR=../.git
+export GIT_CONFIG="$GIT_DIR"/config
+
+git config core.bare false
+test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false ''
+
+git config core.bare true
+test_rev_parse 'GIT_DIR=../.git, core.bare = true' true
+
+git config --unset core.bare
+test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false ''
+
+mv ../.git ../repo.git || exit 1
+export GIT_DIR=../repo.git
+export GIT_CONFIG="$GIT_DIR"/config
+
+git config core.bare false
+test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false ''
+
+git config core.bare true
+test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true
+
+git config --unset core.bare
+test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' true
+
+test_done
-- 
1.5.2.1.116.g9f308
