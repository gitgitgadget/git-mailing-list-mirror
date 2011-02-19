From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 2/8] git-p4: fix key error for p4 problem
Date: Sat, 19 Feb 2011 08:17:55 -0500
Message-ID: <1298121481-7005-3-git-send-email-pw@padd.com>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 14:18:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqmhp-0001Jr-BG
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab1BSNSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:18:34 -0500
Received: from honk.padd.com ([74.3.171.149]:51185 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201Ab1BSNST (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:18:19 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 04B8F20C3;
	Sat, 19 Feb 2011 05:18:16 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E5BF931A06; Sat, 19 Feb 2011 08:18:06 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298121481-7005-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167275>

Some p4 failures result in an error, but the info['code'] is not
set.  These include a bad p4 executable, or a core dump from p4,
and other odd internal errors where p4 fails to generate proper
marshaled output.

Make sure the info key exists before using it to avoid a python
traceback.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    5 ++++-
 t/t9800-git-p4.sh          |   13 +++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..2fefea4 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1440,10 +1440,13 @@ class P4Sync(Command):
                                            % (p, revision)
                                            for p in self.depotPaths])):
 
-            if info['code'] == 'error':
+            if 'code' in info and info['code'] == 'error':
                 sys.stderr.write("p4 returned an error: %s\n"
                                  % info['data'])
                 sys.exit(1)
+            if 'p4ExitCode' in info:
+                sys.stderr.write("p4 exitcode: %s\n" % info['p4ExitCode'])
+                sys.exit(1)
 
 
             change = int(info["change"])
diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 2d354f8..c1ea4d4 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -45,6 +45,19 @@ test_expect_success 'basic git-p4 clone' '
 	rm -rf "$git" && mkdir "$git"
 '
 
+test_expect_success 'exit when p4 fails to produce marshaled output' '
+	badp4dir="$TRASH_DIRECTORY/badp4dir" &&
+	mkdir -p "$badp4dir" &&
+	cat >"$badp4dir"/p4 <<-EOF &&
+	#!$SHELL_PATH
+	exit 1
+	EOF
+	chmod 755 "$badp4dir"/p4 &&
+	PATH="$badp4dir:$PATH" "$GITP4" clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
+	test $retval -eq 1 &&
+	test_must_fail grep -q Traceback errs
+'
+
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
 	test -n "$pid" &&
-- 
1.7.4.1
