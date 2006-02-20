From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/9] git-svn: allow --find-copies-harder and -l<num> to be passed on commit
Date: Mon, 20 Feb 2006 10:57:26 -0800
Message-ID: <11404618464102-git-send-email-normalperson@yhbt.net>
References: <11404618452729-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:58:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGE0-0001PS-8r
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 19:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWBTS52 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 13:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWBTS52
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 13:57:28 -0500
Received: from hand.yhbt.net ([66.150.188.102]:54971 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932622AbWBTS50 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 13:57:26 -0500
Received: from untitled (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 200852DC099;
	Mon, 20 Feb 2006 10:57:26 -0800 (PST)
In-Reply-To: <11404618452729-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16492>

Both of these options are passed directly to git-diff-tree when
committing to a SVN repository.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn     |   10 ++++++++--
 contrib/git-svn/git-svn.txt |    7 +++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

f00770e6f3151e5fdc94208efab22b3068dbb882
diff --git a/contrib/git-svn/git-svn b/contrib/git-svn/git-svn
index 1a8f40e..477ec16 100755
--- a/contrib/git-svn/git-svn
+++ b/contrib/git-svn/git-svn
@@ -30,7 +30,8 @@ use Getopt::Long qw/:config gnu_getopt n
 use File::Spec qw//;
 my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{6,40}/;
-my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit);
+my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
+	$_find_copies_harder, $_l);
 
 GetOptions(	'revision|r=s' => \$_revision,
 		'no-ignore-externals' => \$_no_ignore_ext,
@@ -38,6 +39,8 @@ GetOptions(	'revision|r=s' => \$_revisio
 		'edit|e' => \$_edit,
 		'rmdir' => \$_rmdir,
 		'help|H|h' => \$_help,
+		'find-copies-harder' => \$_find_copies_harder,
+		'l=i' => \$_l,
 		'no-stop-on-copy' => \$_no_stop_copy );
 my %cmd = (
 	fetch => [ \&fetch, "Download new revisions from SVN" ],
@@ -348,7 +351,10 @@ sub svn_checkout_tree {
 	my $pid = open my $diff_fh, '-|';
 	defined $pid or croak $!;
 	if ($pid == 0) {
-		exec(qw(git-diff-tree -z -r -C), $from, $commit) or croak $!;
+		my @diff_tree = qw(git-diff-tree -z -r -C);
+		push @diff_tree, '--find-copies-harder' if $_find_copies_harder;
+		push @diff_tree, "-l$_l" if defined $_l;
+		exec(@diff_tree, $from, $commit) or croak $!;
 	}
 	my $mods = parse_diff_tree($diff_fh);
 	unless (@$mods) {
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index 4b79fb0..9912f5a 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -99,6 +99,13 @@ OPTIONS
 	default for objects that are commits, and forced on when committing
 	tree objects.
 
+-l<num>::
+--find-copies-harder::
+	Both of these are only used with the 'commit' command.
+
+	They are both passed directly to git-diff-tree see
+	git-diff-tree(1) for more information.
+
 COMPATIBILITY OPTIONS
 ---------------------
 --no-ignore-externals::
-- 
1.2.0.gdee6
