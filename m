From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 19/23] t5536: new test of refspec conflicts when fetching
Date: Wed, 30 Oct 2013 06:33:08 +0100
Message-ID: <1383111192-23780-20-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:42:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXl-0007Xo-5i
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab3J3FmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:42:02 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48314 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752459Ab3J3FmA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:42:00 -0400
X-AuditID: 1207440e-b7fbc6d000004ad9-2f-52709a6cd57e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 10.1E.19161.C6A90725; Wed, 30 Oct 2013 01:34:36 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIU014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:34 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqJszqyDI4Ol2c4vpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7Y3ZTO3tBt0zFph032RoYX4l1MXJySAiYSLxvO8cEYYtJXLi3nq2LkYtDSOAyo8S8PZ3s
	EM4VJol7sxaxglSxCehKLOppBusQEVCTmNh2iAWkiFlgIrPE8emLgBwODmEBH4nz3aIgNSwC
	qhIn95xkB7F5BVwlnh27A7VNQeJG81SwmZxA8U+7boLVCAm4SDS1f2afwMi7gJFhFaNcYk5p
	rm5uYmZOcWqybnFyYl5eapGusV5uZoleakrpJkZI2PLtYGxfL3OIUYCDUYmH1+BBfpAQa2JZ
	cWXuIUZJDiYlUd60KQVBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4px8HKudNSaysSi3Kh0lJ
	c7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfAqzwQaKliUmp5akZaZU4KQZuLgBBFcIBt4
	gDbwgBTyFhck5hZnpkMUnWJUlBLnTQJJCIAkMkrz4AbAEswrRnGgf4Qh2nmAyQmu+xXQYCag
	wXtY8kAGlyQipKQaGDWCl0+KDVP4+l2s/3beLo3ZEy7suib87oGo7IldQtY2mZznF36/OeH7
	7n2Gxd2J6ikrn+s35d260WZ/btEkm0mzEmz+fGVf3qca9VIl+MQ68yu3Dyxp9Dkv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236979>

Add some tests that "git fetch" handles refspec conflicts (i.e., when
the same local reference should be updated from two different remote
references) correctly.

There is a small bug when updating references opportunistically,
namely that an explicit user wish like

    git fetch origin \
        refs/heads/branch1:refs/remotes/origin/branch2 \
        refs/heads/branch2:refs/remotes/origin/branch1

should override a configured refspec like

    +refs/heads/*:refs/remotes/origin/*

The current code incorrectly treats this as a fatal error.

In a few commits we will improve the error messages for refspec
conflicts in general and also turn this buggy fatal error into a
warning.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5536-fetch-conflicts.sh | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100755 t/t5536-fetch-conflicts.sh

diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
new file mode 100755
index 0000000..679c53e
--- /dev/null
+++ b/t/t5536-fetch-conflicts.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='fetch handles conflicting refspecs correctly'
+
+. ./test-lib.sh
+
+D=$(pwd)
+
+setup_repository () {
+	git init "$1" && (
+		cd "$1" &&
+		git config remote.origin.url "$D" &&
+		shift &&
+		for refspec in "$@"
+		do
+			git config --add remote.origin.fetch "$refspec"
+		done
+	)
+}
+
+verify_stderr () {
+	cat >expected &&
+	# We're not interested in the error
+	# "fatal: The remote end hung up unexpectedly":
+	grep -v "hung up" <error >actual &&
+	test_cmp expected actual
+}
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m "Initial" &&
+	git branch branch1 &&
+	git tag tag1 &&
+	git commit --allow-empty -m "First" &&
+	git branch branch2 &&
+	git tag tag2
+'
+
+test_expect_success 'fetch with no conflict' '
+	setup_repository ok "+refs/heads/*:refs/remotes/origin/*" && (
+		cd ok &&
+		git fetch origin
+	)
+'
+
+test_expect_success 'fetch conflict: config vs. config' '
+	setup_repository ccc \
+		"+refs/heads/branch1:refs/remotes/origin/branch1" \
+		"+refs/heads/branch2:refs/remotes/origin/branch1" && (
+		cd ccc &&
+		test_must_fail git fetch origin 2>error &&
+		verify_stderr <<-\EOF
+		fatal: refs/remotes/origin/branch1 tracks both refs/heads/branch1 and refs/heads/branch2
+		EOF
+	)
+'
+
+test_expect_success 'fetch duplicate: config vs. config' '
+	setup_repository dcc \
+		"+refs/heads/*:refs/remotes/origin/*" \
+		"+refs/heads/branch1:refs/remotes/origin/branch1" && (
+		cd dcc &&
+		git fetch origin
+	)
+'
+
+test_expect_success 'fetch conflict: arg overrides config' '
+	setup_repository aoc \
+		"+refs/heads/*:refs/remotes/origin/*" && (
+		cd aoc &&
+		git fetch origin refs/heads/branch2:refs/remotes/origin/branch1
+	)
+'
+
+test_expect_success 'fetch conflict: arg vs. arg' '
+	setup_repository caa && (
+		cd caa &&
+		test_must_fail git fetch origin \
+			refs/heads/*:refs/remotes/origin/* \
+			refs/heads/branch2:refs/remotes/origin/branch1 2>error &&
+		verify_stderr <<-\EOF
+		fatal: refs/remotes/origin/branch1 tracks both refs/heads/branch1 and refs/heads/branch2
+		EOF
+	)
+'
+
+test_expect_failure 'fetch conflict: criss-cross args' '
+	setup_repository xaa \
+		"+refs/heads/*:refs/remotes/origin/*" && (
+		cd xaa &&
+		git fetch origin \
+			refs/heads/branch1:refs/remotes/origin/branch2 \
+			refs/heads/branch2:refs/remotes/origin/branch1
+	)
+'
+
+test_done
-- 
1.8.4.1
