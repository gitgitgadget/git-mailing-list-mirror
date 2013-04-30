From: Ilya Basin <basinilya@gmail.com>
Subject: [PATCH 3/5] git-svn: fix fetch erroneously recreating empty dir
 placeholder deleted earlier, try #3
Date: Tue, 30 Apr 2013 14:04:41 +0400
Message-ID: <5180046e.6905700a.65c8.00b7@mx.google.com>
Cc: Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEhe-0004K2-MG
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760859Ab3D3Ruo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:50:44 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:65002 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759165Ab3D3Rul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:50:41 -0400
Received: by mail-lb0-f170.google.com with SMTP id r10so787230lbi.29
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:from:date:subject:to:cc;
        bh=Da+KK7RykaCdoAfxKgf85tlJDO3RNB245VIAiXJbuj4=;
        b=Rhq1hTPzCegah6vzbQVJrWozJ2PFXHxNXlu9uEklynDLYdsoLkBfZaHS63VfyRm3EK
         1WeEFVfgL6B0/+g8cfykXJrPOzk4jymHkt+ueqi2iCYUizSuBx7JL5Vjw3Gmzg2yhpbB
         nB+1hsC9OvpVWmtZaOzqtmCTHhbLjWFK2PRfWGwWVgUYBxjfrK9gKl4RiQ6x9K1YWm40
         IygsHawwfPzFa47ewMjnX5BRKr6V9idaNNMrKrxmoEy6qUoiK4BXLLYhA2Y0c4ByuJ/4
         uEXLJbIkkgp6uWF18BANQ22UoC3A67Bz+II99ypVidI0U0tBPgGQmgwmZrEkp4fJwaZI
         kNxg==
X-Received: by 10.152.3.201 with SMTP id e9mr14870165lae.12.1367344239576;
        Tue, 30 Apr 2013 10:50:39 -0700 (PDT)
Received: from [192.168.0.78] ([178.71.111.32])
        by mx.google.com with ESMTPSA id r9sm18577lbr.3.2013.04.30.10.50.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 10:50:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222972>

The Fetcher accumulates deleted paths in an array and doesn't reset the
array on next commit. This causes different results when interrupting
and resuming the fetch.
When --preserve-empty-dirs flag is used, a path in the array can be
erroneously treated as just deleted (although it was deleted in the
previous commit) and cause the creation of an empty dir placeholder.
---
 perl/Git/SVN/Fetcher.pm                |  1 +
 t/t9160-git-svn-preserve-empty-dirs.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 4f96076..e658889 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -19,6 +19,7 @@ sub new {
 	my ($class, $git_svn, $switch_path) = @_;
 	my $self = SVN::Delta::Editor->new;
 	bless $self, $class;
+	@deleted_gpath = ();
 	if (exists $git_svn->{last_commit}) {
 		$self->{c} = $git_svn->{last_commit};
 		$self->{empty_symlinks} =
diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index 43b1852..ff06a86 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -19,6 +19,12 @@ test_expect_success 'initialize source svn repo containing empty dirs' '
 	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
 	(
 		cd "$SVN_TREE" &&
+		mkdir -p module/foo module/bar &&
+		echo x > module/foo/file.txt &&
+		svn_cmd add module &&
+		svn_cmd commit -mx &&
+		svn_cmd mv module/foo/file.txt module/bar/file.txt &&
+		svn_cmd commit -mx &&
 		mkdir -p 1 2 3/a 3/b 4 5 6 &&
 		echo "First non-empty file"  > 2/file1.txt &&
 		echo "Second non-empty file" > 2/file2.txt &&
@@ -44,6 +50,8 @@ test_expect_success 'initialize source svn repo containing empty dirs' '
 		svn_cmd del 3/b &&
 		svn_cmd commit -m "delete non-last entry in directory" &&
 
+		svn_cmd rm -m"x" "$svnrepo"/trunk/module &&
+
 		svn_cmd del 2/file1.txt &&
 		svn_cmd del 3/a &&
 		svn_cmd commit -m "delete last entry in directory" &&
@@ -66,6 +74,11 @@ test_expect_success 'directory empty from inception' '
 	test $(find "$GIT_REPO"/1 -type f | wc -l) = "1"
 '
 
+# "$GIT_REPO"/module/ should not be recreated
+test_expect_success 'no recreating empty dir deleted earlier' '
+	test_must_fail test -d "$GIT_REPO"/module/
+'
+
 # "$GIT_REPO"/2 and "$GIT_REPO"/3 should only contain the placeholder file.
 test_expect_success 'directory empty from subsequent svn commit' '
 	test -f "$GIT_REPO"/2/.gitignore &&
-- 
1.8.1.5
