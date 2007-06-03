From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 6/7] extend rev-parse test for --is-inside-work-tree
Date: Sun, 3 Jun 2007 16:48:46 +0200
Message-ID: <20070603144846.GF20061@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 16:50:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HurPF-0008NF-WD
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 16:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759268AbXFCOsu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 10:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759060AbXFCOsu
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 10:48:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:55979 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760137AbXFCOss (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 10:48:48 -0400
Received: (qmail invoked by alias); 03 Jun 2007 14:48:47 -0000
Received: from pd9eb8af4.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.244]
  by mail.gmx.net (mp002) with SMTP; 03 Jun 2007 16:48:47 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18/nF1AOqI/aDVgZAE3Vxl4B9jYupNhL79ZZBMqW3
	6pil0S2ibx8nFR
Content-Disposition: inline
In-Reply-To: <20070603144401.GA9518@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49003>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 t/t1500-rev-parse.sh |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index a180309..44cb141 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -17,42 +17,47 @@ test_rev_parse() {
 	shift
 	[ $# -eq 0 ] && return
 
+	test_expect_success "$name: is-inside-work-tree" \
+	"test '$1' = \"\$(git rev-parse --is-inside-work-tree)\""
+	shift
+	[ $# -eq 0 ] && return
+
 	test_expect_success "$name: prefix" \
 	"test '$1' = \"\$(git rev-parse --show-prefix)\""
 	shift
 	[ $# -eq 0 ] && return
 }
 
-test_rev_parse toplevel false false ''
+test_rev_parse toplevel false false true ''
 
 cd .git || exit 1
-test_rev_parse .git/ false true .git/
+test_rev_parse .git/ false true true .git/
 cd objects || exit 1
-test_rev_parse .git/objects/ false true .git/objects/
+test_rev_parse .git/objects/ false true true .git/objects/
 cd ../.. || exit 1
 
 mkdir -p sub/dir || exit 1
 cd sub/dir || exit 1
-test_rev_parse subdirectory false false sub/dir/
+test_rev_parse subdirectory false false true sub/dir/
 cd ../.. || exit 1
 
 git config core.bare true
-test_rev_parse 'core.bare = true' true
+test_rev_parse 'core.bare = true' true false true
 
 git config --unset core.bare
-test_rev_parse 'core.bare undefined' false
+test_rev_parse 'core.bare undefined' false false true
 
-mv .git foo.git || exit 1
-export GIT_DIR=foo.git
-export GIT_CONFIG=foo.git/config
-
-git config core.bare true
-test_rev_parse 'GIT_DIR=foo.git, core.bare = true' true
+mv .git repo.git || exit 1
+export GIT_DIR=repo.git
+export GIT_CONFIG=repo.git/config
 
 git config core.bare false
-test_rev_parse 'GIT_DIR=foo.git, core.bare = false' false
+test_rev_parse 'GIT_DIR=repo.git, core.bare = false' false false true ''
+
+git config core.bare true
+test_rev_parse 'GIT_DIR=repo.git, core.bare = true' true false false
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=foo.git, core.bare undefined' true
+test_rev_parse 'GIT_DIR=repo.git, core.bare undefined' true false false
 
 test_done
-- 
1.5.0.3
