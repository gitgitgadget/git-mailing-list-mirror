From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/6] git-p4: handle utf16 filetype properly
Date: Sun, 16 Oct 2011 18:47:19 -0400
Message-ID: <20111016224719.GA23368@arf.padd.com>
References: <20111016144215.GC22144@arf.padd.com>
 <20111016144435.GE22144@arf.padd.com>
 <7vaa90reqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
	Chris Li <git@chrisli.org>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 00:47:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFZUb-0001sz-IW
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 00:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab1JPWrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 18:47:37 -0400
Received: from honk.padd.com ([74.3.171.149]:54439 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986Ab1JPWrg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 18:47:36 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 8F3DC1FEA;
	Sun, 16 Oct 2011 15:47:34 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8D324313B8; Sun, 16 Oct 2011 18:47:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vaa90reqm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183741>

gitster@pobox.com wrote on Sun, 16 Oct 2011 11:08 -0700:
> Pete Wyckoff <pw@padd.com> writes:
> > +		python "$TRASH_DIRECTORY/k_smush.py" <"$cli/k-text-k" >cli-k-text-k-smush &&
> 
> Shouldn't this pay attention to PYTHON_PATH in any way?

Yes.  I did not notice that the configuration variable existed.
I'll respond to 1/6 to fix that one too.  Below is the new 2/6,
please.  Includes the extra \n that Stefano noticed too.

		-- Pete

--------------------8<--------------------------
From f177a75182576251ae4c895861d1e0f1f92794fc Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <pw@padd.com>
Date: Sat, 17 Sep 2011 19:16:14 -0400
Subject: [PATCH 2/6] git-p4: handle utf16 filetype properly

One of the filetypes that p4 supports is utf16.  Its behavior is
odd in this case.  The data delivered through "p4 -G print" is
not encoded in utf16, although "p4 print -o" will produce the
proper utf16-encoded file.

When dealing with this filetype, discard the data from -G, and
instead read the contents directly.

An alternate approach would be to try to encode the data in
python.  That worked for true utf16 files, but for other files
marked as utf16, p4 delivers mangled text in no recognizable encoding.

Add a test case to check utf16 handling, and +k and +ko handling.

Reported-by: Chris Li <git@chrisli.org>
Acked-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   11 +++++
 t/t9802-git-p4-filetype.sh |  108 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 0 deletions(-)
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
index 0000000..3b358ef
--- /dev/null
+++ b/t/t9802-git-p4-filetype.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+
+test_description='git-p4 p4 filetype tests'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'utf-16 file create' '
+	(
+		cd "$cli" &&
+
+		# p4 saves this verbatim
+		printf "three\nline\ntext\n" >f-ascii &&
+		p4 add -t text f-ascii &&
+
+		# p4 adds \377\376 header
+		cp f-ascii f-ascii-as-utf16 &&
+		p4 add -t utf16 f-ascii-as-utf16 &&
+
+		# p4 saves this exactly as iconv produced it
+		printf "three\nline\ntext\n" | iconv -f ascii -t utf-16 >f-utf16 &&
+		p4 add -t utf16 f-utf16 &&
+
+		# this also is unchanged
+		cp f-utf16 f-utf16-as-text &&
+		p4 add -t text f-utf16-as-text &&
+
+		p4 submit -d "f files" &&
+
+		# force update of client files
+		p4 sync -f
+	)
+'
+
+test_expect_success 'utf-16 file test' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+
+		test_cmp "$cli/f-ascii" f-ascii &&
+		test_cmp "$cli/f-ascii-as-utf16" f-ascii-as-utf16 &&
+		test_cmp "$cli/f-utf16" f-utf16 &&
+		test_cmp "$cli/f-utf16-as-text" f-utf16-as-text
+	)
+'
+
+test_expect_success 'keyword file create' '
+	(
+		cd "$cli" &&
+
+		printf "id\n\$Id\$\n\$Author\$\ntext\n" >k-text-k &&
+		p4 add -t text+k k-text-k &&
+
+		cp k-text-k k-text-ko &&
+		p4 add -t text+ko k-text-ko &&
+
+		cat k-text-k | iconv -f ascii -t utf-16 >k-utf16-k &&
+		p4 add -t utf16+k k-utf16-k &&
+
+		cp k-utf16-k k-utf16-ko &&
+		p4 add -t utf16+ko k-utf16-ko &&
+
+		p4 submit -d "k files" &&
+		p4 sync -f
+	)
+'
+
+build_smush() {
+	cat >k_smush.py <<-\EOF &&
+	import re, sys
+	sys.stdout.write(re.sub(r'(?i)\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$', r'$\1$', sys.stdin.read()))
+	EOF
+	cat >ko_smush.py <<-\EOF
+	import re, sys
+	sys.stdout.write(re.sub(r'(?i)\$(Id|Header):[^$]*\$', r'$\1$', sys.stdin.read()))
+	EOF
+}
+
+test_expect_success 'keyword file test' '
+	build_smush &&
+	test_when_finished rm -f k_smush.py ko_smush.py &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+
+		# text, ensure unexpanded
+		"$PYTHON_PATH" "$TRASH_DIRECTORY/k_smush.py" <"$cli/k-text-k" >cli-k-text-k-smush &&
+		test_cmp cli-k-text-k-smush k-text-k &&
+		"$PYTHON_PATH" "$TRASH_DIRECTORY/ko_smush.py" <"$cli/k-text-ko" >cli-k-text-ko-smush &&
+		test_cmp cli-k-text-ko-smush k-text-ko &&
+
+		# utf16, even though p4 expands keywords, git-p4 does not
+		# try to undo that
+		test_cmp "$cli/k-utf16-k" k-utf16-k &&
+		test_cmp "$cli/k-utf16-ko" k-utf16-ko
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.7
