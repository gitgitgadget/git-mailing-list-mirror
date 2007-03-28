From: Jeff King <peff@peff.net>
Subject: [PATCH] Add some basic tests of rev-list --pretty=format
Date: Tue, 27 Mar 2007 20:08:28 -0400
Message-ID: <20070328000828.GA13273@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 02:08:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLiM-0001lC-BZ
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 02:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454AbXC1AIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 20:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933460AbXC1AIb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 20:08:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4583 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933454AbXC1AIa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 20:08:30 -0400
Received: (qmail 6783 invoked from network); 28 Mar 2007 00:09:00 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 00:09:00 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2007 20:08:28 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43331>

These could stand to be a little more complex, but it should
at least catch obvious problems (like the recently fixed %ct
bug).

Signed-off-by: Jeff King <peff@peff.net>
---

Junio: warning, there is (intentional) trailing whitespace in one of the
test results.

 t/t6006-rev-list-format.sh |  108 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100644 t/t6006-rev-list-format.sh

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
new file mode 100644
index 0000000..cf096c3
--- /dev/null
+++ b/t/t6006-rev-list-format.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+
+test_description='git-rev-list --pretty=format test'
+
+. ./test-lib.sh
+
+test_tick
+test_expect_success 'setup' '
+touch foo && git-add foo && git-commit -m "added foo" &&
+  echo changed >foo && git-commit -a -m "changed foo"
+'
+
+# usage: test_format name format_string <expected_output
+test_format() {
+	cat >expect.$1
+	test_expect_success "format $1" "
+git-rev-list --pretty=format:$2 master >output.$1 &&
+git-diff expect.$1 output.$1
+"
+}
+
+test_format hash %H%n%h <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+131a310eb913d107dd3c09a65d1651175898735d
+131a310
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+86c75cf
+EOF
+
+test_format tree %T%n%t <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+fe722612f26da5064c32ca3843aa154bdb0b08a0
+fe72261
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+4d5fcadc293a348e88f777dc0920f11e7d71441c
+4d5fcad
+EOF
+
+test_format parents %P%n%p <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+86c75cfd708a0e5868dc876ed5b8bb66c80b4873 
+86c75cf 
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+86c75cf 
+86c75cf 
+EOF
+
+# we don't test relative here
+test_format author %an%n%ae%n%ad%n%aD%n%at <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+A U Thor
+author@example.com
+Thu Apr 7 15:13:13 2005 -0700
+Thu, 7 Apr 2005 15:13:13 -0700
+1112911993
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+A U Thor
+author@example.com
+Thu Apr 7 15:13:13 2005 -0700
+Thu, 7 Apr 2005 15:13:13 -0700
+1112911993
+EOF
+
+test_format committer %cn%n%ce%n%cd%n%cD%n%ct <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+C O Mitter
+committer@example.com
+Thu Apr 7 15:13:13 2005 -0700
+Thu, 7 Apr 2005 15:13:13 -0700
+1112911993
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+C O Mitter
+committer@example.com
+Thu Apr 7 15:13:13 2005 -0700
+Thu, 7 Apr 2005 15:13:13 -0700
+1112911993
+EOF
+
+test_format encoding %e <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+<unknown>
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+<unknown>
+EOF
+
+test_format subject %s <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+changed foo
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+added foo
+EOF
+
+test_format body %b <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+<unknown>
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+<unknown>
+EOF
+
+test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+[31mfoo[32mbar[34mbaz[mxyzzy
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+[31mfoo[32mbar[34mbaz[mxyzzy
+EOF
+
+test_done
-- 
1.5.1.rc2.619.g9dd2d
