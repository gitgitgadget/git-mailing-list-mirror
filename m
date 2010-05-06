From: Torsten Schmutzler <git-ts@theblacksun.eu>
Subject: [PATCH] git-svn: mangle refnames forbidden in git
Date: Thu, 06 May 2010 22:20:43 +0200
Message-ID: <4BE3249B.7050100@theblacksun.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 06 22:50:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA81g-0005PQ-Om
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 22:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649Ab0EFUu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 16:50:26 -0400
Received: from theblacksun.eu ([85.214.73.53]:39243 "EHLO theblacksun.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932611Ab0EFUuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 16:50:16 -0400
X-Greylist: delayed 1769 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2010 16:50:16 EDT
Received: from 77-64-180-33.dynamic.primacom.net ([77.64.180.33])
	by theblacksun.eu with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <git-ts@theblacksun.eu>)
	id 1OA7Yr-0001uH-Ox; Thu, 06 May 2010 22:20:46 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146498>

git-check-ref-format(1) describes names which
cannot be used as refnames for git.  Some are
legal branchnames in subversion however.
Mangle the not yet handled cases.

Signed-off-by: Torsten Schmutzler <git-ts@theblacksun.eu>
---
 git-svn.perl                          |    8 ++++++++
 t/t9118-git-svn-funky-branch-names.sh |   21 +++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2c86ea2..57df509 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2086,6 +2086,14 @@ sub refname {
 	# .. becomes %2E%2E
 	$refname =~ s{\.\.}{%2E%2E}g;
 
+	# trailing dots and .lock are not allowed
+	# .$ becomes %2E and .lock becomes %2Elock
+	$refname =~ s{\.(?=$|lock$)}{%2E};
+
+	# the sequence @{ is used to access the reflog
+	# @{ becomes %40{
+	$refname =~ s{\@\{}{%40\{}g;
+
 	return $refname;
 }
 
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index ac52bff..7d7acc3 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -21,6 +21,14 @@ test_expect_success 'setup svnrepo' '
 	                      "$svnrepo/pr ject/branches/more fun plugin!" &&
 	svn_cmd cp -m "scary" "$svnrepo/pr ject/branches/fun plugin" \
 	              "$svnrepo/pr ject/branches/$scary_uri" &&
+	svn_cmd cp -m "leading dot" "$svnrepo/pr ject/trunk" \
+			"$svnrepo/pr ject/branches/.leading_dot" &&
+	svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
+			"$svnrepo/pr ject/branches/trailing_dot." &&
+	svn_cmd cp -m "trailing .lock" "$svnrepo/pr ject/trunk" \
+			"$svnrepo/pr ject/branches/trailing_dotlock.lock" &&
+	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
+			"$svnrepo/pr ject/branches/not-a@{0}reflog" &&
 	start_httpd
 	'
 
@@ -30,6 +38,10 @@ test_expect_success 'test clone with funky branch names' '
 		git rev-parse "refs/remotes/fun%20plugin" &&
 		git rev-parse "refs/remotes/more%20fun%20plugin!" &&
 		git rev-parse "refs/remotes/$scary_ref" &&
+		git rev-parse "refs/remotes/%2Eleading_dot" &&
+		git rev-parse "refs/remotes/trailing_dot%2E" &&
+		git rev-parse "refs/remotes/trailing_dotlock%2Elock" &&
+		git rev-parse "refs/remotes/not-a%40{0}reflog" &&
 	cd ..
 	'
 
@@ -51,6 +63,15 @@ test_expect_success 'test dcommit to scary branch' '
 	cd ..
 	'
 
+test_expect_success 'test dcommit to trailing_dotlock branch' '
+	cd project &&
+	git reset --hard "refs/remotes/trailing_dotlock%2Elock" &&
+	echo who names branches like this anyway? >> foo &&
+	git commit -m "bar" -- foo &&
+	git svn dcommit &&
+	cd ..
+	'
+
 stop_httpd
 
 test_done
-- 
1.7.1.12.ge45de
