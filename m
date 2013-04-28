From: Ilya Basin <basinilya@gmail.com>
Subject: [PATCH 1/3] git-svn: fix occasional "Failed to strip path" error on fetch next commit, try #2
Date: Mon, 29 Apr 2013 00:10:35 +0400
Message-ID: <188302397.20130429001035@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 8bit
Cc: Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 28 22:12:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWXxN-00057n-Dh
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 22:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537Ab3D1UMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 16:12:16 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:54841 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344Ab3D1UMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 16:12:15 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so815499lbh.21
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:x-priority:message-id:to:cc:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=h0BV4GhJLKxd+OBWX6W6ah7BbnC+5N0gSx4OnfNSHTo=;
        b=zzCb4tMva7i28p0DB7uWmmSIO6TqI8AAcXnsomz7j5wZfCzFoEpnbDhySPX0N/SDbi
         6cHSFFOLfudx3qNFTRj5WznANIylF4ZqC3ix39JPkSIpxdN14GGpk/zT++a4JmV+M782
         4YhZdIkl4F30Ch6PL2YcnORTTz+SSCDTZ2KPJHa0PjuPC6e7fbxa8IQE1xj+bGQJC3Bs
         tMX+I+L2SWpcUG9IHiaE1qDNEs5BncF2NpBdYmYQY7zyDtAH1RCcloVqaNghCofBquOq
         pSF8ohDjFY7QuMFszTAWOBg5JJHpC41FYyVsYCkntoOccLZ1iponEH/6ouO5Rcydx2z5
         N0tA==
X-Received: by 10.152.116.113 with SMTP id jv17mr22237588lab.35.1367179933594;
        Sun, 28 Apr 2013 13:12:13 -0700 (PDT)
Received: from [192.168.0.78] (92-100-235-219.dynamic.avangarddsl.ru. [92.100.235.219])
        by mx.google.com with ESMTPSA id t20sm8286801lbi.5.2013.04.28.13.12.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 28 Apr 2013 13:12:12 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222750>

When --stdlayout and --preserve-empty-dirs flags are used and a
directory becomes empty, two things happen:

Sometimes find_empty_directories() returns empty list and no empty dir
placeholder file created. This happens, because find_empty_directories()
marks all directories as non-empty, if at least one updated directory is
non-empty.

Sometimes git-svn dies with "Failed to strip path" error. This happens,
because find_empty_directories() returns git paths and
add_placeholder_file() expects svn paths
---
 perl/Git/SVN/Fetcher.pm                | 12 ++++++++----
 t/t9160-git-svn-preserve-empty-dirs.sh | 18 +++++++++++++-----
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 046a7a2..4f96076 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -129,6 +129,7 @@ sub is_path_ignored {
 
 sub set_path_strip {
 	my ($self, $path) = @_;
+	$self->{pathprefix_strip} = length $path ? ($path . "/") : "";
 	$self->{path_strip} = qr/^\Q$path\E(\/|$)/ if length $path;
 }
 
@@ -458,9 +459,12 @@ sub find_empty_directories {
 		my $skip_added = 0;
 		foreach my $t (qw/dir_prop file_prop/) {
 			foreach my $path (keys %{ $self->{$t} }) {
-				if (exists $self->{$t}->{dirname($path)}) {
-					$skip_added = 1;
-					last;
+				if (length $self->git_path($path)) {
+					$path = dirname($path);
+					if ($dir eq $self->git_path($path) && exists $self->{$t}->{$path}) {
+						$skip_added = 1;
+						last;
+					}
 				}
 			}
 			last if $skip_added;
@@ -477,7 +481,7 @@ sub find_empty_directories {
 		delete $files{$_} foreach (@deleted_gpath);
 
 		# Report the directory if there are no filenames left.
-		push @empty_dirs, $dir unless (scalar %files);
+		push @empty_dirs, ($self->{pathprefix_strip} . $dir) unless (scalar %files);
 	}
 	@empty_dirs;
 }
diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index b4a4434..1b5a286 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -51,13 +51,21 @@ test_expect_success 'initialize source svn repo containing empty dirs' '
 		echo "Conflict file" > 5/.placeholder &&
 		mkdir 6/.placeholder &&
 		svn_cmd add 5/.placeholder 6/.placeholder &&
-		svn_cmd commit -m "Placeholder Namespace conflict"
+		svn_cmd commit -m "Placeholder Namespace conflict" &&
+
+		echo x > fil.txt &&
+		svn_cmd add fil.txt &&
+		svn_cmd commit -m "this commit should not kill git-svn"
 	) &&
 	rm -rf "$SVN_TREE"
 '
 
-test_expect_success 'clone svn repo with --preserve-empty-dirs' '
-	git svn clone "$svnrepo"/trunk --preserve-empty-dirs "$GIT_REPO"
+test_expect_success 'clone svn repo with --preserve-empty-dirs --stdlayout' '
+	git svn clone "$svnrepo" --preserve-empty-dirs --stdlayout "$GIT_REPO" || (
+		cd "$GIT_REPO"
+		git svn fetch # fetch the rest can succeed even if clone failed
+		false # this test still failed
+	)
 '
 
 # "$GIT_REPO"/1 should only contain the placeholder file.
@@ -81,11 +89,11 @@ test_expect_success 'add entry to previously empty directory' '
 	test -f "$GIT_REPO"/4/a/b/c/foo
 '
 
-# The HEAD~2 commit should not have introduced .gitignore placeholder files.
+# The HEAD~3 commit should not have introduced .gitignore placeholder files.
 test_expect_success 'remove non-last entry from directory' '
 	(
 		cd "$GIT_REPO" &&
-		git checkout HEAD~2
+		git checkout HEAD~3
 	) &&
 	test_must_fail test -f "$GIT_REPO"/2/.gitignore &&
 	test_must_fail test -f "$GIT_REPO"/3/.gitignore
-- 
1.8.1.5
