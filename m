From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/5] git-svn: fix handling of filenames with embedded '@'
Date: Sun, 11 Jun 2006 00:03:42 -0700
Message-ID: <11500094281515-git-send-email-normalperson@yhbt.net>
References: <11500094252972-git-send-email-normalperson@yhbt.net> <11500094271080-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 11 09:04:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpJzL-0005iD-EY
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 09:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWFKHDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 03:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWFKHDw
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 03:03:52 -0400
Received: from hand.yhbt.net ([66.150.188.102]:30129 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750812AbWFKHDu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 03:03:50 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B73927DC021;
	Sun, 11 Jun 2006 00:03:48 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 11 Jun 2006 00:03:48 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g2dc7b-dirty
In-Reply-To: <11500094271080-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21638>

svn has trouble parsing files with embedded '@' characters.  For
example,

  svn propget svn:keywords foo@bar.c
  svn: Syntax error parsing revision 'bar.c'

I asked about this on #svn and the workaround suggested was to append
an explicit revision specifier:

  svn propget svn:keywords foo@bar.c@BASE

This patch appends '@BASE' to the filename in all calls to 'svn
propget'.

Patch originally by Seth Falcon <sethfalcon@gmail.com>
Seth: signoff?

[ew: Made to work with older svn that don't support peg revisions]

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index aac8779..7ed11ef 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -34,7 +34,7 @@ my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_version, $_upgrade, $_authors);
 my (@_branch_from, %tree_map, %users);
-my $_svn_co_url_revs;
+my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 
 my %fc_opts = ( 'no-ignore-externals' => \$_no_ignore_ext,
 		'branch|b=s' => \@_branch_from,
@@ -336,7 +336,7 @@ sub show_ignore {
 	my %ign;
 	File::Find::find({wanted=>sub{if(lstat $_ && -d _ && -d "$_/.svn"){
 		s#^\./##;
-		@{$ign{$_}} = safe_qx(qw(svn propget svn:ignore),$_);
+		@{$ign{$_}} = svn_propget_base('svn:ignore', $_);
 		}}, no_chdir=>1},'.');
 
 	print "\n# /\n";
@@ -859,7 +859,7 @@ sub sys { system(@_) == 0 or croak $? }
 
 sub eol_cp {
 	my ($from, $to) = @_;
-	my $es = safe_qx(qw/svn propget svn:eol-style/, $to);
+	my $es = svn_propget_base('svn:eol-style', $to);
 	open my $rfd, '<', $from or croak $!;
 	binmode $rfd or croak $!;
 	open my $wfd, '>', $to or croak $!;
@@ -897,7 +897,7 @@ sub do_update_index {
 	while (my $x = <$p>) {
 		chomp $x;
 		if (!$no_text_base && lstat $x && ! -l _ &&
-				safe_qx(qw/svn propget svn:keywords/,$x)) {
+				svn_propget_base('svn:keywords', $x)) {
 			my $mode = -x _ ? 0755 : 0644;
 			my ($v,$d,$f) = File::Spec->splitpath($x);
 			my $tb = File::Spec->catfile($d, '.svn', 'tmp',
@@ -1135,6 +1135,9 @@ sub svn_compat_check {
 	if (grep /usage: checkout URL\[\@REV\]/,@co_help) {
 		$_svn_co_url_revs = 1;
 	}
+	if (grep /\[TARGET\[\@REV\]\.\.\.\]/, `svn propget -h`) {
+		$_svn_pg_peg_revs = 1;
+	}
 
 	# I really, really hope nobody hits this...
 	unless (grep /stop-on-copy/, (safe_qx(qw(svn log -h)))) {
@@ -1214,6 +1217,12 @@ sub load_authors {
 	close $authors or croak $!;
 }
 
+sub svn_propget_base {
+	my ($p, $f) = @_;
+	$f .= '@BASE' if $_svn_pg_peg_revs;
+	return safe_qx(qw/svn propget/, $p, $f);
+}
+
 __END__
 
 Data structures:
-- 
1.3.3.g2dc7b-dirty
