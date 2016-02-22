From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v4 2/3] git-svn: enable "svn.pathnameencoding" on dcommit
Date: Mon, 22 Feb 2016 02:55:10 +0000
Message-ID: <1456109711-26866-3-git-send-email-normalperson@yhbt.net>
References: <1456109711-26866-1-git-send-email-normalperson@yhbt.net>
Cc: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 03:55:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXgf9-0006oz-CX
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 03:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbcBVCzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 21:55:46 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39293 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013AbcBVCzc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 21:55:32 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC7320457;
	Mon, 22 Feb 2016 02:55:27 +0000 (UTC)
In-Reply-To: <1456109711-26866-1-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286872>

From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>

Without the initialization of $self->{pathnameencoding}, conversion in
repo_path() is always skipped as $self->{pathnameencoding} is undefined
even if "svn.pathnameencoding" is configured.

The lack of conversion results in mysterious failure of dcommit (e.g.
"Malformed XML") which happen only when a commit involves a change on
non-ASCII path.

[ew: add test case to t9115,
 squash LC_ALL=$a_utf8_locale export from Kazutoshi for Cygwin]

Signed-off-by: Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN/Editor.pm                   |  1 +
 t/t9115-git-svn-dcommit-funky-renames.sh | 25 +++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index c50176e..d9d9bdf 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -41,6 +41,7 @@ sub new {
 	                       "$self->{svn_path}/" : '';
 	$self->{config} = $opts->{config};
 	$self->{mergeinfo} = $opts->{mergeinfo};
+	$self->{pathnameencoding} = Git::config('svn.pathnameencoding');
 	return $self;
 }
 
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 6a48e40..a3927c4 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -77,11 +77,32 @@ test_expect_success 'make a commit to test rebase' '
 	'
 
 test_expect_success 'git svn rebase works inside a fresh-cloned repository' '
-	cd test-rebase &&
+	(
+		cd test-rebase &&
 		git svn rebase &&
 		test -e test-rebase-main &&
 		test -e test-rebase
-	'
+	)'
+
+# Without this, LC_ALL=C as set in test-lib.sh, and Cygwin converts
+# non-ASCII characters in filenames unexpectedly, and causes errors.
+# https://cygwin.com/cygwin-ug-net/using-specialnames.html#pathnames-specialchars
+# > Some characters are disallowed in filenames on Windows filesystems. ...
+# ...
+# > ... All of the above characters, except for the backslash, are converted
+# > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
+# > "Private use area") when creating or accessing files.
+prepare_a_utf8_locale
+test_expect_success UTF8 'svn.pathnameencoding=cp932 new file on dcommit' '
+	LC_ALL=$a_utf8_locale &&
+	export LC_ALL &&
+	neq=$(printf "\201\202") &&
+	git config svn.pathnameencoding cp932 &&
+	echo neq >"$neq" &&
+	git add "$neq" &&
+	git commit -m "neq" &&
+	git svn dcommit
+'
 
 stop_httpd
 
-- 
EW
