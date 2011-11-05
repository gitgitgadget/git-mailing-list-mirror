From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] git-p4: ignore apple filetype
Date: Sat, 5 Nov 2011 13:36:07 -0400
Message-ID: <20111105173607.GA12532@arf.padd.com>
References: <CAOk9v+-==GwDQaZ=4BW1QfEF7+5SfhNF409Xom0bHdT_qKaiFA@mail.gmail.com>
 <20111101020841.GA8116@arf.padd.com>
 <CAOk9v+_xXRGAGWg2L5u=r9qBS=H+ZmdF=TwumSyq7WKf-15okw@mail.gmail.com>
 <loom.20111102T153631-769@post.gmane.org>
 <CAOk9v+_xaS_Y1m17TROOSjgiscT+QEJWbpZbAZFmh8_tAviF6Q@mail.gmail.com>
 <CAOpHH-W1JO9PLsyp2hQxfr6eyKRr+=pMkaDikV5NcFwF98Miow@mail.gmail.com>
 <20111104183957.GB18517@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Wookey <michaelwookey@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 05 18:37:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMkBP-0001HM-Ea
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 18:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697Ab1KERgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 13:36:40 -0400
Received: from honk.padd.com ([74.3.171.149]:59841 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359Ab1KERgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 13:36:39 -0400
Received: from arf.padd.com (unknown [50.52.169.245])
	by honk.padd.com (Postfix) with ESMTPSA id 31B6E29E1;
	Sat,  5 Nov 2011 10:36:37 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C4F28313D4; Sat,  5 Nov 2011 13:36:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20111104183957.GB18517@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184870>

Revert 97a21ca (git-p4: stop ignoring apple filetype, 2011-10-16)
and add a test case.

Reported-by: Michael Wookey <michaelwookey@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---

This is mostly a revert, but the test moves down a bit to be near
a similar clause for utf16.  Adding a big comment and test case
hopefully keeps this code in place in the future.

Michael: if you're willing to test this, I'd appreciate it.  In
fact, running all the git-p4 unit tests on Mac would be great
if you have a p4d:

    mac$ ( cd t ; make t98* )

 contrib/fast-import/git-p4 |   13 +++++++++++++
 t/t9802-git-p4-filetype.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index f885d70..b975d67 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1318,6 +1318,19 @@ class P4Sync(Command, P4UserMap):
             text = p4_read_pipe(['print', '-q', '-o', '-', file['depotFile']])
             contents = [ text ]
 
+        if type_base == "apple":
+            # Apple filetype files will be streamed as a concatenation of
+            # its appledouble header and the contents.  This is useless
+            # on both macs and non-macs.  If using "print -q -o xx", it
+            # will create "xx" with the data, and "%xx" with the header.
+            # This is also not very useful.
+            #
+            # Ideally, someday, this script can learn how to generate
+            # appledouble files directly and import those to git, but
+            # non-mac machines can never find a use for apple filetype.
+            print "\nIgnoring apple filetype file %s" % file['depotFile']
+            return
+
         # Perhaps windows wants unicode, utf16 newlines translated too;
         # but this is not doing it.
         if self.isWindows and type_base == "text":
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 3b358ef..992bb8c 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -101,6 +101,37 @@ test_expect_success 'keyword file test' '
 	)
 '
 
+build_gendouble() {
+	cat >gendouble.py <<-\EOF
+	import sys
+	import struct
+	import array
+
+	s = array.array("c", '\0' * 26)
+	struct.pack_into(">L", s,  0, 0x00051607)  # AppleDouble
+	struct.pack_into(">L", s,  4, 0x00020000)  # version 2
+	s.tofile(sys.stdout)
+	EOF
+}
+
+test_expect_success 'ignore apple' '
+	test_when_finished rm -f gendouble.py &&
+	build_gendouble &&
+	(
+		cd "$cli" &&
+		test-genrandom apple 1024 >double.png &&
+		"$PYTHON_PATH" "$TRASH_DIRECTORY/gendouble.py" >%double.png &&
+		p4 add -t apple double.png &&
+		p4 submit -d appledouble
+	) &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		test ! -f double.png
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.7.345.g88d3c
