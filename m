From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 03/16] Tests on Windows: $(pwd) must return Windows-style paths
Date: Sat, 21 Mar 2009 22:26:26 +0100
Message-ID: <4114156ae959a8ecfea62213df35fd8f778d9c4e.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:30:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8lf-0004Ii-4h
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbZCUV1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbZCUV1J
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:09 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27918 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EBEB2CDF85;
	Sat, 21 Mar 2009 22:26:54 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C36804279F;
	Sat, 21 Mar 2009 22:26:54 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114067>

Many tests pass $(pwd) in some form to git and later test that the output
of git contains the correct value of $(pwd). For example, the test of
'git remote show' sets up a remote that contains $(pwd) and then the
expected result must contain $(pwd).

Again, MSYS-bash's path mangling kicks in: Plain $(pwd) uses the MSYS style
absolute path /c/path/to/git. The test case would write this name into
the 'expect' file. But when git is invoked, MSYS-bash converts this name to
the Windows style path c:/path/to/git, and git would produce this form in
the result; the test would fail.

We fix this by passing -W to bash's pwd that produces the Windows-style
path.

There are a two cases that need an accompanying change:

- In t1504 the value of $(pwd) becomes part of a path list. In this case,
  the lone 'c' in something like /foo:c:/path/to/git:/bar inhibits
  MSYS-bashes path mangling; IOW in this case we want the /c/path/to/git
  form to allow path mangling. We use $PWD instead of $(pwd), which always
  has the latter form.

- In t6200, $(pwd) - the Windows style path - must be used to construct the
  expected result because that is the path form that git sees. (The change
  in the test itself is just for consistency: 'git fetch' always sees the
  Windows-style path, with or without the change.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t1504-ceiling-dirs.sh  |    2 +-
 t/t6200-fmt-merge-msg.sh |    4 ++--
 t/test-lib.sh            |    4 ++++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index e377d48..df5ad8c 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -13,7 +13,7 @@ test_fail() {
 	"git rev-parse --show-prefix"
 }
 
-TRASH_ROOT="$(pwd)"
+TRASH_ROOT="$PWD"
 ROOT_PARENT=$(dirname "$TRASH_ROOT")
 
 
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 8f5a06f..2049ab6 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -83,13 +83,13 @@ test_expect_success 'merge-msg test #1' '
 '
 
 cat >expected <<EOF
-Merge branch 'left' of $TEST_DIRECTORY/$test
+Merge branch 'left' of $(pwd)
 EOF
 
 test_expect_success 'merge-msg test #2' '
 
 	git checkout master &&
-	git fetch "$TEST_DIRECTORY/$test" left &&
+	git fetch "$(pwd)" left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4720b9a..0a0696a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -649,5 +649,9 @@ case $(uname -s) in
 	sum () {
 		md5sum "$@"
 	}
+	# git sees Windows-style pwd
+	pwd () {
+		builtin pwd -W
+	}
 	;;
 esac
-- 
1.6.2.1.224.g2225f
