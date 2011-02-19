From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 1/8] git-p4: test script
Date: Sat, 19 Feb 2011 08:17:54 -0500
Message-ID: <1298121481-7005-2-git-send-email-pw@padd.com>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 14:18:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqmhn-0001Jr-Oj
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab1BSNSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:18:18 -0500
Received: from honk.padd.com ([74.3.171.149]:51173 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301Ab1BSNSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:18:17 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id EE03EE77;
	Sat, 19 Feb 2011 05:18:15 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E35E93197C; Sat, 19 Feb 2011 08:18:06 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298121481-7005-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167273>

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100755 t/t9800-git-p4.sh

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
new file mode 100755
index 0000000..2d354f8
--- /dev/null
+++ b/t/t9800-git-p4.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='git-p4 tests'
+
+. ./test-lib.sh
+
+( p4 -h && p4d -h ) >/dev/null 2>&1 || {
+	skip_all='skipping git-p4 tests; no p4 or p4d'
+	test_done
+}
+
+GITP4=$GIT_BUILD_DIR/contrib/fast-import/git-p4
+P4DPORT=10669
+
+db="$TRASH_DIRECTORY/db"
+cli="$TRASH_DIRECTORY/cli"
+git="$TRASH_DIRECTORY/git"
+
+test_debug 'echo p4d -q -d -r "$db" -p $P4DPORT'
+test_expect_success setup '
+	mkdir -p "$db" &&
+	p4d -q -d -r "$db" -p $P4DPORT &&
+	mkdir -p "$cli" &&
+	mkdir -p "$git" &&
+	export P4PORT=localhost:$P4DPORT
+'
+
+test_expect_success 'add p4 files' '
+	cd "$cli" &&
+	p4 client -i <<-EOF &&
+	Client: client
+	Description: client
+	Root: $cli
+	View: //depot/... //client/...
+	EOF
+	export P4CLIENT=client &&
+	echo file1 >file1 &&
+	p4 add file1 &&
+	p4 submit -d "file1" &&
+	cd "$TRASH_DIRECTORY"
+'
+
+test_expect_success 'basic git-p4 clone' '
+	"$GITP4" clone --dest="$git" //depot &&
+	rm -rf "$git" && mkdir "$git"
+'
+
+test_expect_success 'shutdown' '
+	pid=`pgrep -f p4d` &&
+	test -n "$pid" &&
+	test_debug "ps wl `echo $pid`" &&
+	kill $pid
+'
+
+test_done
-- 
1.7.4.1
