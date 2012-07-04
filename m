From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/3] git p4 test: refactor marshal_dump
Date: Wed,  4 Jul 2012 09:34:19 -0400
Message-ID: <1341408860-26965-3-git-send-email-pw@padd.com>
References: <1341408860-26965-1-git-send-email-pw@padd.com>
Cc: Michael Horowitz <mike@horowitz.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 15:35:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmPji-0004qG-Er
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 15:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab2GDNfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 09:35:07 -0400
Received: from honk.padd.com ([74.3.171.149]:54383 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab2GDNfE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 09:35:04 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id D44F01FED;
	Wed,  4 Jul 2012 06:35:03 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6F28B5A90B; Wed,  4 Jul 2012 09:35:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.125.g4a65fea
In-Reply-To: <1341408860-26965-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201006>

This function will be useful in future tests.  Move it to
the git-p4 test library.  Let it accept an optional argument
to pick a certain marshaled object out of the input stream.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh         | 14 ++++++++++++++
 t/t9800-git-p4-basic.sh |  5 -----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 31d75ae..080b2c1 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -102,3 +102,17 @@ cleanup_git() {
 	rm -rf "$git" &&
 	mkdir "$git"
 }
+
+marshal_dump() {
+	what=$1 &&
+	line=${2:-1} &&
+	cat >"$TRASH_DIRECTORY/marshal-dump.py" <<-EOF &&
+	import marshal
+	import sys
+	for i in range($line):
+	    d = marshal.load(sys.stdin)
+	print d['$what']
+	EOF
+	"$PYTHON_PATH" "$TRASH_DIRECTORY/marshal-dump.py"
+}
+
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 07c2e15..b7ad716 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -155,11 +155,6 @@ test_expect_success 'clone bare' '
 	)
 '
 
-marshal_dump() {
-	what=$1
-	"$PYTHON_PATH" -c 'import marshal, sys; d = marshal.load(sys.stdin); print d["'$what'"]'
-}
-
 # Sleep a bit so that the top-most p4 change did not happen "now".  Then
 # import the repo and make sure that the initial import has the same time
 # as the top-most change.
-- 
1.7.11.1.125.g4a65fea
