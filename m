From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/1] Tried to fix git-svn's handling of filenames with embedded '@'.
Date: Sun, 28 May 2006 23:35:43 -0700
Message-ID: <20060529063543.GA8128@localdomain>
References: <m21wuem2xj.fsf@ziti.fhcrc.org> <m2verqkobr.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 08:36:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkbLx-0004J9-4M
	for gcvg-git@gmane.org; Mon, 29 May 2006 08:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWE2Gfq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 02:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWE2Gfq
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 02:35:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:45483 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751277AbWE2Gfp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 02:35:45 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D09A67DC021;
	Sun, 28 May 2006 23:35:43 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 28 May 2006 23:35:43 -0700
To: Seth Falcon <sethfalcon@gmail.com>
Content-Disposition: inline
In-Reply-To: <m2verqkobr.fsf@ziti.fhcrc.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20924>

Seth: how does this work?

Ick, I just found out keyword killing tests don't pass with
svn 1.1, though...

--- 

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
index b3e0684..54b93f4 100755
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
@@ -860,7 +860,7 @@ sub sys { system(@_) == 0 or croak $? }
 
 sub eol_cp {
 	my ($from, $to) = @_;
-	my $es = safe_qx(qw/svn propget svn:eol-style/, $to);
+	my $es = svn_propget_base('svn:eol-style', $to);
 	open my $rfd, '<', $from or croak $!;
 	binmode $rfd or croak $!;
 	open my $wfd, '>', $to or croak $!;
@@ -898,7 +898,7 @@ sub do_update_index {
 	while (my $x = <$p>) {
 		chomp $x;
 		if (!$no_text_base && lstat $x && ! -l _ &&
-				safe_qx(qw/svn propget svn:keywords/,$x)) {
+				svn_propget_base('svn:keywords', $x)) {
 			my $mode = -x _ ? 0755 : 0644;
 			my ($v,$d,$f) = File::Spec->splitpath($x);
 			my $tb = File::Spec->catfile($d, '.svn', 'tmp',
@@ -1136,6 +1136,9 @@ sub svn_compat_check {
 	if (grep /usage: checkout URL\[\@REV\]/,@co_help) {
 		$_svn_co_url_revs = 1;
 	}
+	if (grep /\[TARGET\[\@REV\]\.\.\.\]/, `svn propget -h`) {
+		$_svn_pg_peg_revs = 1;
+	}
 
 	# I really, really hope nobody hits this...
 	unless (grep /stop-on-copy/, (safe_qx(qw(svn log -h)))) {
@@ -1215,6 +1218,12 @@ sub load_authors {
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
1.3.3.gef0f
