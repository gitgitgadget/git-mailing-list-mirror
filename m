From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH(amend)] test git-rev-parse
Date: Wed, 28 Mar 2007 00:07:21 +0200
Message-ID: <20070327220721.GA20495@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net> <20070317143452.GA21140@moooo.ath.cx> <20070317144342.GB26290@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 00:07:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWJpM-00048g-T0
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 00:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934196AbXC0WH0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934208AbXC0WH0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 18:07:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:49494 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934196AbXC0WHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 18:07:25 -0400
Received: (qmail invoked by alias); 27 Mar 2007 22:07:23 -0000
Received: from pD9EBB62D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.182.45]
  by mail.gmx.net (mp039) with SMTP; 28 Mar 2007 00:07:23 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19Xfs9odsJXwr/qM4SBGAeBRbXF8B8tIvJvp2aLQj
	FvXwIK3tFeXt0h
Content-Disposition: inline
In-Reply-To: <20070317144342.GB26290@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43312>

this tests --is-bare-repository, --is-inside-git-dir, --show-cdup and
--show-prefix

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
The old version used --git-dir twice which was unnecessary.
---
 t/t1500-rev-parse.sh |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100755 t/t1500-rev-parse.sh

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
new file mode 100755
index 0000000..bfc615d
--- /dev/null
+++ b/t/t1500-rev-parse.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+
+test_description='test git rev-parse'
+. ./test-lib.sh
+
+test_expect_success 'toplevel: is-bare-repository' \
+	'test "false" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'toplevel: is-inside-git-dir' \
+	'test "false" = "$(git rev-parse --is-inside-git-dir)"'
+test_expect_success 'toplevel: show-cdup' \
+	'test "" = "$(git rev-parse --show-cdup)"'
+test_expect_success 'toplevel: show-prefix' \
+	'test "" = "$(git rev-parse --show-prefix)"'
+
+cd .git/objects || exit 1
+test_expect_success 'in-git-dir: is-bare-repository' \
+	'test "false" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'in-git-dir: is-inside-git-dir' \
+	'test "true" = "$(git rev-parse --is-inside-git-dir)"'
+test_expect_success 'in-git-dir: show-cdup' \
+	'test "../../" = "$(git rev-parse --show-cdup)"'
+test_expect_success 'in-git-dir: show-prefix' \
+	'test ".git/objects/" = "$(git rev-parse --show-prefix)"'
+cd ../.. || exit 1
+
+mkdir sub || exit 1
+cd sub || exit 1
+test_expect_success 'subdirectory: is-bare-repository' \
+	'test "false" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'subdirectory: is-inside-git-dir' \
+	'test "false" = "$(git rev-parse --is-inside-git-dir)"'
+test_expect_success 'subdirectory: show-cdup' \
+	'test "../" = "$(git rev-parse --show-cdup)"'
+test_expect_success 'subdirectory: show-prefix' \
+	'test "sub/" = "$(git rev-parse --show-prefix)"'
+cd .. || exit 1
+
+test_expect_success 'core.bare = true: is-bare-repository' \
+	'git config core.bare true &&
+	test "true" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'unset core.bare: is-bare-repository' \
+	'git config --unset core.bare &&
+	test "false" = "$(git rev-parse --is-bare-repository)"'
+
+mv .git foo.git || exit 1
+export GIT_DIR=foo.git
+export GIT_CONFIG=foo.git/config
+test_expect_success 'GIT_DIR=foo.git: is-bare-repository' \
+	'test "true" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'GIT_DIR=foo.git, core.bare = true: is-bare-repository' \
+	'git config core.bare true &&
+	test "true" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'GIT_DIR=foo.git, core.bare = false: is-bare-repository' \
+	'git config core.bare false &&
+	test "false" = "$(git rev-parse --is-bare-repository)"'
+
+test_done
-- 
1.5.1.rc2.621.gd841-dirty
