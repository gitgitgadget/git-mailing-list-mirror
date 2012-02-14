From: Per Cederqvist <cederp@opera.com>
Subject: [PATCH] filter-branch: cd to the correct directory when -d is used
Date: Tue, 14 Feb 2012 10:49:37 +0100
Message-ID: <4F3A2E31.9040006@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: cederp@opera.com, ceder@lysator.liu.se
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 10:59:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxFAF-0008JB-Mg
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 10:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759959Ab2BNJ7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 04:59:07 -0500
Received: from smtp.opera.com ([213.236.208.81]:51106 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759569Ab2BNJ7G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 04:59:06 -0500
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Feb 2012 04:59:05 EST
Received: from [10.30.1.61] (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q1E9ncUb014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 14 Feb 2012 09:49:39 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Thunderbird/3.1.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190713>

git-filter-branch changes directory to $tempdir/t, which by default is
.git-rewrite/t.  Before doing the read-tree to update the working tree
it uses "cd ../.." to get back to the working tree.  This breaks if
you use something like "-d /tmp/tempdir", as the read-tree will be
executed in /tmp instead of in your working tree.

Fixed by adding a variable that holds the original value of $(pwd),
and cd back to that value.

Added tests that demonstrates some issues that can happen without this
fix.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
  git-filter-branch.sh     |    3 ++-
  t/t7003-filter-branch.sh |   38 ++++++++++++++++++++++++++++++++++++++
  2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index add2c02..a58b50b 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -217,6 +217,7 @@ t)
  	test -d "$tempdir" &&
  		die "$tempdir already exists, please remove it"
  esac
+oldpwd="$(pwd)"
  mkdir -p "$tempdir/t" &&
  tempdir="$(cd "$tempdir"; pwd)" &&
  cd "$tempdir/t" &&
@@ -489,7 +490,7 @@ if [ "$filter_tag_name" ]; then
  	done
  fi

-cd ../..
+cd "$oldpwd"
  rm -rf "$tempdir"

  trap - 0
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e022773..fa464a2 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -367,4 +367,42 @@ test_expect_success 'replace submodule revision' '
  	test $orig_head != `git show-ref --hash --head HEAD`
  '

+test_expect_success 'get a fresh tree' '
+	rm -fr ?* .git .gitmodules
+'
+
+deep_tree() {
+	test_expect_success 'setup deep tree' '
+		rm -fr drepo &&
+		mkdir drepo &&
+		( cd drepo &&
+		git init &&
+		mkdir kom++ &&
+		test_commit authors kom++/AUTHORS "Fake authors file" &&
+		test_commit changelog kom++/ChangeLog "Fake ChangeLog file"
+		)
+	'
+
+	test_expect_success '-d tempdir with --subdirectory-filter' '
+		(cd drepo &&
+		git filter-branch -d "$TRASHDIR/tmpdir" --subdirectory-filter kom++ 
--tag-name-filter cat -- --all
+		)
+	'
+
+	test_expect_success 'content after -d with --subdirectory-filter' '
+		test_path_is_missing AUTHORS "AUTHORS created in tmpdir/.."
+		test_path_is_missing ChangeLog "ChangeLog created in tmpdir/.."
+		test_path_is_missing drepo/kom++ "kom++ remains"
+		test_path_is_file drepo/AUTHORS "AUTHORS not moved to top-level"
+		test_path_is_file drepo/ChangeLog "ChangeLog not moved to top-level"
+	'
+
+	test_expect_success 'Clean workdir' '
+		cd drepo&&git diff --quiet
+	'
+}
+
+deep_tree
+deep_tree # In Git 1.7.9 and earlier filter-branch fails the second time.
+
  test_done
-- 
1.7.9
