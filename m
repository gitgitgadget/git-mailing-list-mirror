From: Kenichi Saita <nitoyon@gmail.com>
Subject: [PATCH v2] difftool --dir-diff: always use identical working tree file
Date: Tue, 28 May 2013 00:31:37 +0900
Message-ID: <1369668697-1016-1-git-send-email-nitoyon@gmail.com>
References: <20130526154429.GK27005@serenity.lan>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Kenichi Saita <nitoyon@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 27 17:32:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgzP2-0007Rn-Nt
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 17:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab3E0PcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 11:32:00 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:36250 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab3E0Pb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 11:31:59 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so6873767pbb.38
        for <git@vger.kernel.org>; Mon, 27 May 2013 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fqniHlYIu3utKXNidnuE+iy216OsS40sPufU9YDzp9I=;
        b=bJL+P7mGzUHJgcZ/SjXTdudbeupe8e9PY+3+CtejtEd5FqU9Koy9LBkBACkYBInMi/
         ahdNvyPlR3CUBiLlRd+k0FrdFlaHlhcPplG4GHGmTLvtOxl2wd0znybPGf5U5IglP2MP
         BctDkFn/KDV3exAbd8tLD7Wi+6h5xfGp13QMqwzATGG2Zj0T98A6Y02Ys2a1WEFLmX1Q
         EIELfy3tdfinvDxQi/Zm7HDmGh7YHdZ7Lx6cZjbG59FiSHSU6uutVDLryLQwoIqTsqjL
         dfxqC61xK3AZGc6dq88vZfT72KakKWTpu226zvOj8aG6DT97dfVGbYfJZO6Lga+ksPXL
         XCkg==
X-Received: by 10.66.218.200 with SMTP id pi8mr30439030pac.40.1369668718846;
        Mon, 27 May 2013 08:31:58 -0700 (PDT)
Received: from localhost.localdomain (144.72.102.121.dy.bbexcite.jp. [121.102.72.144])
        by mx.google.com with ESMTPSA id if5sm28959648pbb.31.2013.05.27.08.31.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 27 May 2013 08:31:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <20130526154429.GK27005@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225598>

When deciding whether or not we should link a working tree file into
the temporary right-hand directory for a directory diff, we
currently behave differently in the --symlink and --no-symlink
cases.  If using symlinks any identical files are linked across but
with --no-symlink only files that contain unstaged changes are
copied back into the working tree.

Change this so that identical files are copied back as well.  This
is beneficial because it widens the set of circumstances in which we
copy changes made by the user back into the working tree.

Signed-off-by: Kenichi Saita <nitoyon@gmail.com>
---
 git-difftool.perl   |    9 ++-------
 t/t7800-difftool.sh |   19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 8a75205..e57d3d1 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -85,13 +85,9 @@ sub exit_cleanup
 
 sub use_wt_file
 {
-	my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
+	my ($repo, $workdir, $file, $sha1) = @_;
 	my $null_sha1 = '0' x 40;
 
-	if ($sha1 ne $null_sha1 and not $symlinks) {
-		return 0;
-	}
-
 	if (! -e "$workdir/$file") {
 		# If the file doesn't exist in the working tree, we cannot
 		# use it.
@@ -213,8 +209,7 @@ EOF
 
 		if ($rmode ne $null_mode) {
 			my ($use, $wt_sha1) = use_wt_file($repo, $workdir,
-							  $dst_path, $rsha1,
-							  $symlinks);
+							  $dst_path, $rsha1);
 			if ($use) {
 				push @working_tree, $dst_path;
 				$wtindex .= "$rmode $wt_sha1\t$dst_path\0";
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index d46f041..2418528 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -385,6 +385,25 @@ test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstage
 	test_cmp actual expect
 '
 
+write_script modify-right-file <<\EOF
+echo "new content" >"$2/file"
+EOF
+
+run_dir_diff_test 'difftool --dir-diff syncs worktree with unstaged change' '
+	test_when_finished git reset --hard &&
+	echo "orig content" >file &&
+	git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
+	echo "new content" >expect &&
+	test_cmp expect file
+'
+
+run_dir_diff_test 'difftool --dir-diff syncs worktree without unstaged change' '
+	test_when_finished git reset --hard &&
+	git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
+	echo "new content" >expect &&
+	test_cmp expect file
+'
+
 write_script modify-file <<\EOF
 echo "new content" >file
 EOF
-- 
1.7.1
