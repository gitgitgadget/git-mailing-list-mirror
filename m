From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 2/5] test git-rev-parse
Date: Sat, 17 Mar 2007 15:43:42 +0100
Message-ID: <20070317144342.GB26290@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net> <20070317143452.GA21140@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 15:43:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSa8M-0006aw-Ew
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 15:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbXCQOnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 10:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbXCQOnp
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 10:43:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:39074 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752674AbXCQOno (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 10:43:44 -0400
Received: (qmail invoked by alias); 17 Mar 2007 14:43:42 -0000
X-Provags-ID: V01U2FsdGVkX19ReD0BlTVRhFKXaJondK16leVgJKVxg8d3kJ84Qp
	CozvCM++tlmV2c
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070317143452.GA21140@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42438>

this tests --is-bare-repository, --is-inside-git-dir, --show-cdup and
--show-prefix

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/t1500-rev-parse.sh |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100755 t/t1500-rev-parse.sh

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
new file mode 100755
index 0000000..c385660
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
+	'git --git-dir foo.git config core.bare true &&
+	test "true" = "$(git --git-dir foo.git rev-parse --is-bare-repository)"'
+test_expect_success 'GIT_DIR=foo.git, core.bare = false: is-bare-repository' \
+	'git config core.bare false &&
+	test "false" = "$(git rev-parse --is-bare-repository)"'
+
+test_done
-- 
1.5.0.4.414.g32da9
