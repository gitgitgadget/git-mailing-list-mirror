From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] Skip t1300.70 and 71 on msysGit.
Date: Mon, 15 Feb 2010 23:14:28 +0000
Message-ID: <87r5omghop.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Tue Feb 16 01:14:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhB5d-00064J-6z
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 01:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370Ab0BPAOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 19:14:51 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:38579 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932359Ab0BPAOu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2010 19:14:50 -0500
Received: from [172.23.170.146] (helo=anti-virus03-09)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NhB5U-0002iN-Eh; Tue, 16 Feb 2010 00:14:48 +0000
Received: from [77.99.239.132] (helo=badger.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1NhB5T-0006Xz-H3; Tue, 16 Feb 2010 00:14:47 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 1D52113D389; Tue, 16 Feb 2010 00:14:47 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (usg-unix-v)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140051>


These two tests fail on msysGit because /dev/null is an alias for nul on
Windows and when reading the value back from git config the alias does
not match the real filename. Also the HOME environment variable has a
unix-style path but git returns a native equivalent path for '~'.  As
these are platform-dependent equivalent results it seems simplest to
skip the test entirely.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 t/t1300-repo-config.sh |    6 +++---
 t/test-lib.sh          |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index f11f98c..90541a3 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -701,7 +701,7 @@ cat >expect <<\EOF
 	trailingtilde = foo~
 EOF
 
-test_expect_success 'set --path' '
+test_expect_success NONMINGW 'set --path' '
 	git config --path path.home "~/" &&
 	git config --path path.normal "/dev/null" &&
 	git config --path path.trailingtilde "foo~" &&
@@ -713,14 +713,14 @@ $HOME/
 foo~
 EOF
 
-test_expect_success 'get --path' '
+test_expect_success NONMINGW 'get --path' '
 	git config --get --path path.home > result &&
 	git config --get --path path.normal >> result &&
 	git config --get --path path.trailingtilde >> result &&
 	test_cmp expect result
 '
 
-rm .git/config
+test_have_prereq NONMINGW && rm .git/config
 
 git config quote.leading " test"
 git config quote.ending "test "
diff --git a/t/test-lib.sh b/t/test-lib.sh
index afd3053..f6a1590 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -776,6 +776,7 @@ case $(uname -s) in
 	test_set_prereq POSIXPERM
 	test_set_prereq BSLASHPSPEC
 	test_set_prereq EXECKEEPSPID
+	test_set_prereq NONMINGW
 	;;
 esac
 
-- 
1.7.0.rc2.1438.gebbe6.dirty
