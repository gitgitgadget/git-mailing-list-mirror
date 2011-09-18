From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/5] git-p4: handle utf16 filetype properly
Date: Sat, 17 Sep 2011 21:28:31 -0400
Message-ID: <20110918012831.GB4619@arf.padd.com>
References: <20110918012634.GA4578@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 03:28:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R56BT-0006Sd-7q
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 03:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab1IRB2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 21:28:34 -0400
Received: from honk.padd.com ([74.3.171.149]:50733 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756030Ab1IRB2e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 21:28:34 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id AD993BFC;
	Sat, 17 Sep 2011 18:28:33 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 186B031448; Sat, 17 Sep 2011 21:28:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110918012634.GA4578@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181594>

One of the filetypes that p4 supports is utf16.  Its behavior is
odd in this case.  The data delivered through "p4 -G print" is
not encoded in utf16, although "p4 print -o" will produce the
proper utf16-encoded file.

When dealing with this filetype, discard the data from -G, and
intstead read the contents directly.

An alternate approach would be to try to encode the data in
python.  That worked for true utf16 files, but for other files
marked as utf16, p4 delivers mangled text in no recognizable encoding.

Add a test case to check utf16 handling, and +k and +ko handling.

Reported-by: Chris Li <git@chrisli.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   11 +++++
 t/t9802-git-p4-filetype.sh |  107 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 0 deletions(-)
 create mode 100755 t/t9802-git-p4-filetype.sh

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2f7b270..e69caf3 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1238,6 +1238,15 @@ class P4Sync(Command, P4UserMap):
             data = ''.join(contents)
             contents = [data[:-1]]
 
+        if file['type'].startswith("utf16"):
+            # p4 delivers different text in the python output to -G
+            # than it does when using "print -o", or normal p4 client
+            # operations.  utf16 is converted to ascii or utf8, perhaps.
+            # But ascii text saved as -t utf16 is completely mangled.
+            # Invoke print -o to get the real contents.
+            text = p4_read_pipe('print -q -o - "%s"' % file['depotFile'])
+            contents = [ text ]
+
         if self.isWindows and file["type"].endswith("text"):
             mangled = []
             for data in contents:
@@ -1245,6 +1254,8 @@ class P4Sync(Command, P4UserMap):
                 mangled.append(data)
             contents = mangled
 
+        # Note that we do not try to de-mangle keywords on utf16 files,
+        # even though in theory somebody may want that.
         if file['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
             contents = map(lambda text: re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text), contents)
         elif file['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
new file mode 100755
index 0000000..f112eaa
--- /dev/null
+++ b/t/t9802-git-p4-filetype.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+
+test_description='git-p4 p4 filetype tests'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	kill_p4d || : &&
+	start_p4d &&
+	cd "$TRASH_DIRECTORY"
+'
+
+test_expect_success 'utf-16 file create' '
+	cd "$cli" &&
+
+	# p4 saves this verbatim
+	echo -e "three\nline\ntext" > f-ascii &&
+	p4 add -t text f-ascii &&
+
+	# p4 adds \377\376 header
+	cp f-ascii f-ascii-as-utf16 &&
+	p4 add -t utf16 f-ascii-as-utf16 &&
+
+	# p4 saves this exactly as iconv produced it
+	echo -e "three\nline\ntext" | iconv -f ascii -t utf-16 > f-utf16 &&
+	p4 add -t utf16 f-utf16 &&
+
+	# this also is unchanged
+	cp f-utf16 f-utf16-as-text &&
+	p4 add -t text f-utf16-as-text &&
+
+	p4 submit -d "f files" &&
+
+	# force update of client files
+	p4 sync -f &&
+	cd "$TRASH_DIRECTORY"
+'
+
+test_expect_success 'utf-16 file test' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot@all &&
+	cd "$git" &&
+
+	cmp "$cli/f-ascii" f-ascii &&
+	cmp "$cli/f-ascii-as-utf16" f-ascii-as-utf16 &&
+	cmp "$cli/f-utf16" f-utf16 &&
+	cmp "$cli/f-utf16-as-text" f-utf16-as-text
+'
+
+test_expect_success 'keyword file create' '
+	cd "$cli" &&
+
+	echo -e "id\n\$Id\$\n\$Author\$\ntext" > k-text-k &&
+	p4 add -t text+k k-text-k &&
+
+	cp k-text-k k-text-ko &&
+	p4 add -t text+ko k-text-ko &&
+
+	cat k-text-k | iconv -f ascii -t utf-16 > k-utf16-k &&
+	p4 add -t utf16+k k-utf16-k &&
+
+	cp k-utf16-k k-utf16-ko &&
+	p4 add -t utf16+ko k-utf16-ko &&
+
+	p4 submit -d "k files" &&
+	p4 sync -f &&
+	cd "$TRASH_DIRECTORY"
+'
+
+ko_smush() {
+	cat >smush.py <<-EOF &&
+	import re, sys
+	sys.stdout.write(re.sub(r'(?i)\\\$(Id|Header):[^$]*\\\$', r'$\1$', sys.stdin.read()))
+	EOF
+	python smush.py < "$1"
+}
+
+k_smush() {
+	cat >smush.py <<-EOF &&
+	import re, sys
+	sys.stdout.write(re.sub(r'(?i)\\\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\\\$', r'$\1$', sys.stdin.read()))
+	EOF
+	python smush.py < "$1"
+}
+
+test_expect_success 'keyword file test' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot@all &&
+	cd "$git" &&
+
+	# text, ensure unexpanded
+	k_smush "$cli/k-text-k" > cli-k-text-k-smush &&
+	cmp cli-k-text-k-smush k-text-k &&
+	ko_smush "$cli/k-text-ko" > cli-k-text-ko-smush &&
+	cmp cli-k-text-ko-smush k-text-ko &&
+
+	# utf16, even though p4 expands keywords, git-p4 does not
+	# try to undo that
+	cmp "$cli/k-utf16-k" k-utf16-k &&
+	cmp "$cli/k-utf16-ko" k-utf16-ko
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.6.3
