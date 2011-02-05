From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/8] git-p4: test script
Date: Sat, 5 Feb 2011 17:51:05 -0500
Message-ID: <20110205225105.GB30963@arf.padd.com>
References: <20110205224848.GA30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 23:51:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlqyO-0005vp-DP
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 23:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab1BEWvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 17:51:15 -0500
Received: from honk.padd.com ([74.3.171.149]:33455 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735Ab1BEWvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 17:51:15 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id B16E8EF;
	Sat,  5 Feb 2011 14:51:13 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6D70331ADE; Sat,  5 Feb 2011 17:51:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20110205224848.GA30963@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166121>

Add a basic test script for git-p4.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100755 t/t9800-git-p4.sh

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
new file mode 100755
index 0000000..f4956b7
--- /dev/null
+++ b/t/t9800-git-p4.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description='git-p4 tests'
+
+. ./test-lib.sh
+
+p4 -h >/dev/null 2>&1
+retc=$?
+p4d -h >/dev/null 2>&1
+retd=$?
+if test $retc -ne 0 -o $retd -ne 0
+then
+	skip_all='skipping git-p4 tests; no p4 or p4d'
+	test_done
+fi
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
+	# wait for it to finish its initialization
+	sleep 1 &&
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
1.7.2.3
