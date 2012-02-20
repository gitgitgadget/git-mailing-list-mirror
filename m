From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] git-svn.perl: fix a false-positive in the "already exists" test
Date: Mon, 20 Feb 2012 09:17:54 -0500
Message-ID: <1329747474-17976-1-git-send-email-stevenrwalter@gmail.com>
References: <20120219105442.GA11889@dcvr.yhbt.net>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: normalperson@yhbt.net, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 15:18:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzU47-0002de-S0
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 15:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab2BTOSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 09:18:03 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38640 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab2BTOSB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 09:18:01 -0500
Received: by ghrr11 with SMTP id r11so2568333ghr.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 06:18:00 -0800 (PST)
Received-SPF: pass (google.com: domain of stevenrwalter@gmail.com designates 10.236.176.233 as permitted sender) client-ip=10.236.176.233;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stevenrwalter@gmail.com designates 10.236.176.233 as permitted sender) smtp.mail=stevenrwalter@gmail.com; dkim=pass header.i=stevenrwalter@gmail.com
Received: from mr.google.com ([10.236.176.233])
        by 10.236.176.233 with SMTP id b69mr28581655yhm.122.1329747480674 (num_hops = 1);
        Mon, 20 Feb 2012 06:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8LYUL+s2wP1EhTHqjs5phSQP0AVi9hH/KO+5qcfP7Xo=;
        b=jGJZwQ8MbWbhOdaIB4muPY7ne49bbP8DRMZLj+Vb06/JN+7PMLB7DKsPcJiWFfD78N
         ZXGVPK4RB1muf8vylaYe5fz0atbNX7Aqlgj/MWV29rn5MgzaPnCrMNEchTIvlNG5W1gJ
         KcdHZeM/c/z8C2lMv9UTaZz8JvtTwApTaymQ8=
Received: by 10.236.176.233 with SMTP id b69mr21977958yhm.122.1329747480604;
        Mon, 20 Feb 2012 06:18:00 -0800 (PST)
Received: from brock (adsl-184-43-8-254.bgk.bellsouth.net. [184.43.8.254])
        by mx.google.com with ESMTPS id h29sm27563727ann.16.2012.02.20.06.17.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Feb 2012 06:17:59 -0800 (PST)
Received: from srwalter by brock with local (Exim 4.76)
	(envelope-from <srwalter@brock>)
	id 1RzU3y-0004gX-3u; Mon, 20 Feb 2012 09:17:58 -0500
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <20120219105442.GA11889@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191073>

open_or_add_dir checks to see if the directory already exists or not.
If it already exists and is not a directory, then we fail.  However,
open_or_add_dir did not previously account for the possibility that the
path did exist as a file, but is deleted in the current commit.

In order to prevent this legitimate case from failing, open_or_add_dir
needs to know what files are deleted in the current commit.
Unfortunately that information has to be plumbed through a couple of
layers.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 git-svn.perl             |   43 ++++++++++++++++++++++++++-----------------
 t/t9100-git-svn-basic.sh |   33 ++++++++++++++++++---------------
 2 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 06c9322..c7a961d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5130,7 +5130,7 @@ sub rmdirs {
 }
 
 sub open_or_add_dir {
-	my ($self, $full_path, $baton) = @_;
+	my ($self, $full_path, $baton, $deletions) = @_;
 	my $t = $self->{types}->{$full_path};
 	if (!defined $t) {
 		die "$full_path not known in r$self->{r} or we have a bug!\n";
@@ -5139,7 +5139,7 @@ sub open_or_add_dir {
 		no warnings 'once';
 		# SVN::Node::none and SVN::Node::file are used only once,
 		# so we're shutting up Perl's warnings about them.
-		if ($t == $SVN::Node::none) {
+		if ($t == $SVN::Node::none || defined($deletions->{$full_path})) {
 			return $self->add_directory($full_path, $baton,
 			    undef, -1, $self->{pool});
 		} elsif ($t == $SVN::Node::dir) {
@@ -5154,17 +5154,18 @@ sub open_or_add_dir {
 }
 
 sub ensure_path {
-	my ($self, $path) = @_;
+	my ($self, $path, $deletions) = @_;
 	my $bat = $self->{bat};
 	my $repo_path = $self->repo_path($path);
 	return $bat->{''} unless (length $repo_path);
+
 	my @p = split m#/+#, $repo_path;
 	my $c = shift @p;
-	$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{''});
+	$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{''}, $deletions);
 	while (@p) {
 		my $c0 = $c;
 		$c .= '/' . shift @p;
-		$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{$c0});
+		$bat->{$c} ||= $self->open_or_add_dir($c, $bat->{$c0}, $deletions);
 	}
 	return $bat->{$c};
 }
@@ -5221,9 +5222,9 @@ sub apply_autoprops {
 }
 
 sub A {
-	my ($self, $m) = @_;
+	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir);
+	my $pbat = $self->ensure_path($dir, $deletions);
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 					undef, -1);
 	print "\tA\t$m->{file_b}\n" unless $::_q;
@@ -5233,9 +5234,9 @@ sub A {
 }
 
 sub C {
-	my ($self, $m) = @_;
+	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir);
+	my $pbat = $self->ensure_path($dir, $deletions);
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$self->url_path($m->{file_a}), $self->{r});
 	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
@@ -5252,9 +5253,9 @@ sub delete_entry {
 }
 
 sub R {
-	my ($self, $m) = @_;
+	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir);
+	my $pbat = $self->ensure_path($dir, $deletions);
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$self->url_path($m->{file_a}), $self->{r});
 	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
@@ -5263,14 +5264,14 @@ sub R {
 	$self->close_file($fbat,undef,$self->{pool});
 
 	($dir, $file) = split_path($m->{file_a});
-	$pbat = $self->ensure_path($dir);
+	$pbat = $self->ensure_path($dir, $deletions);
 	$self->delete_entry($m->{file_a}, $pbat);
 }
 
 sub M {
-	my ($self, $m) = @_;
+	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir);
+	my $pbat = $self->ensure_path($dir, $deletions);
 	my $fbat = $self->open_file($self->repo_path($m->{file_b}),
 				$pbat,$self->{r},$self->{pool});
 	print "\t$m->{chg}\t$m->{file_b}\n" unless $::_q;
@@ -5340,9 +5341,9 @@ sub chg_file {
 }
 
 sub D {
-	my ($self, $m) = @_;
+	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
-	my $pbat = $self->ensure_path($dir);
+	my $pbat = $self->ensure_path($dir, $deletions);
 	print "\tD\t$m->{file_b}\n" unless $::_q;
 	$self->delete_entry($m->{file_b}, $pbat);
 }
@@ -5375,10 +5376,18 @@ sub apply_diff {
 	my ($self) = @_;
 	my $mods = $self->{mods};
 	my %o = ( D => 0, C => 1, R => 2, A => 3, M => 4, T => 5 );
+	my %deletions;
+
+	foreach my $m (@$mods) {
+		if ($m->{chg} eq "D") {
+			$deletions{$m->{file_b}} = 1;
+		}
+	}
+
 	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
 		my $f = $m->{chg};
 		if (defined $o{$f}) {
-			$self->$f($m);
+			$self->$f($m, \%deletions);
 		} else {
 			fatal("Invalid change type: $f");
 		}
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index b041516..4029f84 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -92,9 +92,11 @@ test_expect_success "$name" '
 	echo yyy > bar/zzz/yyy &&
 	git update-index --add bar/zzz/yyy &&
 	git commit -m "$name" &&
-	test_must_fail git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch3' || true
-
+	git svn set-tree --find-copies-harder --rmdir \
+		${remotes_git_svn}..mybranch3 &&
+	svn_cmd up "$SVN_TREE" &&
+	test -d "$SVN_TREE"/bar/zzz &&
+	test -e "$SVN_TREE"/bar/zzz/yyy ' || true
 
 name='detect node change from directory to file #2'
 test_expect_success "$name" '
@@ -134,10 +136,10 @@ test_expect_success "$name" '
 	test -x "$SVN_TREE"/exec.sh'
 
 
-name='executable file becomes a symlink to bar/zzz (file)'
+name='executable file becomes a symlink to file'
 test_expect_success "$name" '
 	rm exec.sh &&
-	ln -s bar/zzz exec.sh &&
+	ln -s file exec.sh &&
 	git update-index exec.sh &&
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
@@ -148,14 +150,14 @@ test_expect_success "$name" '
 name='new symlink is added to a file that was also just made executable'
 
 test_expect_success "$name" '
-	chmod +x bar/zzz &&
-	ln -s bar/zzz exec-2.sh &&
-	git update-index --add bar/zzz exec-2.sh &&
+	chmod +x file &&
+	ln -s file exec-2.sh &&
+	git update-index --add file exec-2.sh &&
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
 	svn_cmd up "$SVN_TREE" &&
-	test -x "$SVN_TREE"/bar/zzz &&
+	test -x "$SVN_TREE"/file &&
 	test -h "$SVN_TREE"/exec-2.sh'
 
 name='modify a symlink to become a file'
@@ -195,14 +197,15 @@ name='check imported tree checksums expected tree checksums'
 rm -f expected
 if test_have_prereq UTF8
 then
-	echo tree bf522353586b1b883488f2bc73dab0d9f774b9a9 > expected
+	echo tree dc68b14b733e4ec85b04ab6f712340edc5dc936e > expected
 fi
 cat >> expected <<\EOF
-tree 83654bb36f019ae4fe77a0171f81075972087624
-tree 031b8d557afc6fea52894eaebb45bec52f1ba6d1
-tree 0b094cbff17168f24c302e297f55bfac65eb8bd3
-tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
-tree 56a30b966619b863674f5978696f4a3594f2fca9
+tree c3322890dcf74901f32d216f05c5044f670ce632
+tree d3ccd5035feafd17b030c5732e7808cc49122853
+tree d03e1630363d4881e68929d532746b20b0986b83
+tree 149d63cd5878155c846e8c55d7d8487de283f89e
+tree 312b76e4f64ce14893aeac8591eb3960b065e247
+tree 149d63cd5878155c846e8c55d7d8487de283f89e
 tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
 tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
 EOF
-- 
1.7.3.4
