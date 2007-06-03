From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 3/7] test git rev-parse
Date: Sun, 3 Jun 2007 16:47:00 +0200
Message-ID: <20070603144700.GC20061@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 16:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HurPB-0008NF-6A
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 16:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759488AbXFCOrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 10:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758473AbXFCOrE
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 10:47:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:35821 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759478AbXFCOrC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 10:47:02 -0400
Received: (qmail invoked by alias); 03 Jun 2007 14:47:01 -0000
Received: from pD9EB8AF4.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.244]
  by mail.gmx.net (mp029) with SMTP; 03 Jun 2007 16:47:01 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18vTJB+SH8vNAqmqRU3zFZ6hRX3adX6xJUe4seWyj
	jDMbXaXksh73Rs
Content-Disposition: inline
In-Reply-To: <20070603144401.GA9518@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49001>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 t/t1500-rev-parse.sh |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100755 t/t1500-rev-parse.sh

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
new file mode 100755
index 0000000..a180309
--- /dev/null
+++ b/t/t1500-rev-parse.sh
@@ -0,0 +1,58 @@
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
+mv .git foo.git || exit 1
+export GIT_DIR=foo.git
+export GIT_CONFIG=foo.git/config
+
+git config core.bare true
+test_rev_parse 'GIT_DIR=foo.git, core.bare = true' true
+
+git config core.bare false
+test_rev_parse 'GIT_DIR=foo.git, core.bare = false' false
+
+git config --unset core.bare
+test_rev_parse 'GIT_DIR=foo.git, core.bare undefined' true
+
+test_done
-- 
1.5.0.3
