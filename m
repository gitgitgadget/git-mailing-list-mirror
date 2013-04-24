From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 1/3] remote: add a test for extra arguments, according to docs
Date: Wed, 24 Apr 2013 15:54:35 +0200
Message-ID: <372aa93e4a7a3583730c02543583ce93e095ec64.1366811347.git.trast@inf.ethz.ch>
References: <cover.1366811347.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 15:55:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV09z-0002hP-Th
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 15:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774Ab3DXNyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 09:54:47 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34610 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782Ab3DXNym (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 09:54:42 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 15:54:37 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 15:54:39 +0200
X-Mailer: git-send-email 1.8.2.1.935.g71f5136
In-Reply-To: <cover.1366811347.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222251>

This adds one test or comment for each subcommand of git-remote
according to its current documentation.  All but 'set-branches' and
'update' are listed as taking only a fixed number of arguments; for
those we can write a test with one more (bogus) argument, and see if
the command notices that.

They fail on several counts: 'add' does not check for extra arguments,
and 'show' and 'prune' actually iterate over remotes (i.e., take any
number of args).  We'll fix them in the next two patches.

The -f machinery is only there to make the tests readable while still
ensuring they pass as a whole, and will be removed in the final patch.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/t5505-remote.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 6579a86..764ee97 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1003,4 +1003,31 @@ test_expect_success 'remote set-url --delete baz' '
 	cmp expect actual
 '
 
+test_expect_success 'extra args: setup' '
+	# add a dummy origin so that this does not trigger failure
+	git remote add origin .
+'
+
+test_extra_arg () {
+	expect="success"
+	if test "z$1" = "z-f"; then
+		expect=failure
+		shift
+	fi
+	test_expect_$expect "extra args: $*" "
+		test_must_fail git remote $* bogus_extra_arg 2>actual &&
+		grep '^usage:' actual
+	"
+}
+
+test_extra_arg -f add nick url
+test_extra_arg rename origin newname
+test_extra_arg remove origin
+test_extra_arg set-head origin master
+# set-branches takes any number of args
+test_extra_arg set-url origin newurl oldurl
+test_extra_arg -f show origin
+test_extra_arg -f prune origin
+# update takes any number of args
+
 test_done
-- 
1.8.2.1.931.g0116868
