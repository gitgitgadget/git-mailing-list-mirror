From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: correctly kill keyword expansion without munging EOLs
Date: Fri, 11 Aug 2006 04:34:07 -0700
Message-ID: <20060811113407.GB3152@localdomain>
References: <m2vep7yqzh.fsf@gmail.com> <20060805211337.GA31264@hand.yhbt.net> <m2fygazbdc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 11 13:34:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBVHZ-00031e-S0
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 13:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWHKLeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 07:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWHKLeO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 07:34:14 -0400
Received: from hand.yhbt.net ([66.150.188.102]:8579 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932107AbWHKLeN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 07:34:13 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id DD2167DC025;
	Fri, 11 Aug 2006 04:34:07 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 11 Aug 2006 04:34:07 -0700
To: Seth Falcon <sethfalcon@gmail.com>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <m2fygazbdc.fsf@gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25224>

This bugfix applies to users of the svn command-line client only.

We no longer muck with newlines when killing keyword expansion.
This tended to generate unintended diffs in commits because svn
revert -R would destroy the manual EOL changes we were doing. Of
course, we didn't need the EOL munging in the first place, as
svn seems to do it for us even in the text-base files.

Now we set the mtime and atime the files changed by keyword
expansion killing to avoid triggering a change on svn revert,
which svn still seems to want to do.

Thanks to Seth Falcon for reporting this bug.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   45 ++++-----------------------------------------
 1 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 6453771..3327ad3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -31,6 +31,7 @@ use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev pass_through/;
 use File::Spec qw//;
+use File::Copy qw/copy/;
 use POSIX qw/strftime/;
 use IPC::Open3;
 use Memoize;
@@ -77,9 +78,6 @@ my %cmt_opts = ( 'edit|e' => \$_edit,
 		'copy-similarity|C=i'=> \$_cp_similarity
 );
 
-# yes, 'native' sets "\n".  Patches to fix this for non-*nix systems welcome:
-my %EOL = ( CR => "\015", LF => "\012", CRLF => "\015\012", native => "\012" );
-
 my %cmd = (
 	fetch => [ \&fetch, "Download new revisions from SVN",
 			{ 'revision|r=s' => \$_revision, %fc_opts } ],
@@ -1760,43 +1758,6 @@ sub svn_info {
 
 sub sys { system(@_) == 0 or croak $? }
 
-sub eol_cp {
-	my ($from, $to) = @_;
-	my $es = svn_propget_base('svn:eol-style', $to);
-	open my $rfd, '<', $from or croak $!;
-	binmode $rfd or croak $!;
-	open my $wfd, '>', $to or croak $!;
-	binmode $wfd or croak $!;
-	eol_cp_fd($rfd, $wfd, $es);
-	close $rfd or croak $!;
-	close $wfd or croak $!;
-}
-
-sub eol_cp_fd {
-	my ($rfd, $wfd, $es) = @_;
-	my $eol = defined $es ? $EOL{$es} : undef;
-	my $buf;
-	use bytes;
-	while (1) {
-		my ($r, $w, $t);
-		defined($r = sysread($rfd, $buf, 4096)) or croak $!;
-		return unless $r;
-		if ($eol) {
-			if ($buf =~ /\015$/) {
-				my $c;
-				defined($r = sysread($rfd,$c,1)) or croak $!;
-				$buf .= $c if $r > 0;
-			}
-			$buf =~ s/(?:\015\012|\015|\012)/$eol/gs;
-			$r = length($buf);
-		}
-		for ($w = 0; $w < $r; $w += $t) {
-			$t = syswrite($wfd, $buf, $r - $w, $w) or croak $!;
-		}
-	}
-	no bytes;
-}
-
 sub do_update_index {
 	my ($z_cmd, $cmd, $no_text_base) = @_;
 
@@ -1824,9 +1785,11 @@ sub do_update_index {
 						'text-base',"$f.svn-base");
 				$tb =~ s#^/##;
 			}
+			my @s = stat($x);
 			unlink $x or croak $!;
-			eol_cp($tb, $x);
+			copy($tb, $x);
 			chmod(($mode &~ umask), $x) or croak $!;
+			utime $s[8], $s[9], $x;
 		}
 		print $ui $x,"\0";
 	}
-- 
1.4.2.rc1.g018f
