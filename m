From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v4 3/3] git-svn: apply "svn.pathnameencoding" before URL encoding
Date: Mon, 22 Feb 2016 02:55:11 +0000
Message-ID: <1456109711-26866-4-git-send-email-normalperson@yhbt.net>
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
	id 1aXgf9-0006oz-VY
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 03:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbcBVCzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 21:55:46 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39303 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086AbcBVCzg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 21:55:36 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF4D20458;
	Mon, 22 Feb 2016 02:55:27 +0000 (UTC)
In-Reply-To: <1456109711-26866-1-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286871>

From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>

The conversion from "svn.pathnameencoding" to UTF-8 should be applied
first, and then URL encoding should be applied on the resulting UTF-8
path. The reversed order of these transforms (used before this fix)
makes non-UTF-8 URL which causes error from Subversion such as
"Filesystem has no item: '...' path not found" when sending a rename (or
a copy) from non-ASCII path.

[ew: t9115 test case added (requires SVN_HTTPD_PORT set to test),
 squash LC_ALL=$a_utf8_locale export from Kazutoshi for Cygwin]

Signed-off-by: Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN/Editor.pm                   |  3 ++-
 t/t9115-git-svn-dcommit-funky-renames.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index d9d9bdf..4c4199a 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -144,11 +144,12 @@ sub repo_path {
 
 sub url_path {
 	my ($self, $path) = @_;
+	$path = $self->repo_path($path);
 	if ($self->{url} =~ m#^https?://#) {
 		# characters are taken from subversion/libsvn_subr/path.c
 		$path =~ s#([^~a-zA-Z0-9_./!$&'()*+,-])#sprintf("%%%02X",ord($1))#eg;
 	}
-	$self->{url} . '/' . $self->repo_path($path);
+	$self->{url} . '/' . $path;
 }
 
 sub rmdirs {
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index a3927c4..0990f8d 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -104,6 +104,21 @@ test_expect_success UTF8 'svn.pathnameencoding=cp932 new file on dcommit' '
 	git svn dcommit
 '
 
+# See the comment on the above test for setting of LC_ALL.
+test_expect_success 'svn.pathnameencoding=cp932 rename on dcommit' '
+	LC_ALL=$a_utf8_locale &&
+	export LC_ALL &&
+	inf=$(printf "\201\207") &&
+	git config svn.pathnameencoding cp932 &&
+	echo inf >"$inf" &&
+	git add "$inf" &&
+	git commit -m "inf" &&
+	git svn dcommit &&
+	git mv "$inf" inf &&
+	git commit -m "inf rename" &&
+	git svn dcommit
+'
+
 stop_httpd
 
 test_done
-- 
EW
