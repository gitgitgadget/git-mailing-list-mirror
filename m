X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1.1/2] git-svn: fix output reporting from the delta fetcher
Date: Tue, 28 Nov 2006 02:29:58 -0800
Message-ID: <20061128102958.GA5207@soma>
References: <loom.20061124T143148-286@post.gmane.org> <20061128054448.GA396@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 10:30:54 +0000 (UTC)
Cc: git@vger.kernel.org, Pazu <pazu@pazu.com.br>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061128054448.GA396@soma>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32505>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp0E4-0006mX-FJ for gcvg-git@gmane.org; Tue, 28 Nov
 2006 11:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935805AbWK1KaE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 05:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935818AbWK1KaD
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 05:30:03 -0500
Received: from hand.yhbt.net ([66.150.188.102]:16619 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S935805AbWK1KaA (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 05:30:00 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id E8D7E2DC034; Tue, 28 Nov 2006 02:29:58 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 28 Nov 2006
 02:29:58 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

There was nothing printed in the code originally because I left
out a pair of parentheses.  Nevertheless, the affected code has
been replaced with a more efficient version that respects the -q
flag as well as requiring less bandwidth.

We save some bandwidth by not requesting changed paths
information when calling get_log() since we're using the delta
fetcher.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   31 +++++++++++++------------------
 1 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9b86d91..1a675c4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2906,7 +2906,7 @@ sub libsvn_log_entry {
 }
 
 sub process_rm {
-	my ($gui, $last_commit, $f) = @_;
+	my ($gui, $last_commit, $f, $q) = @_;
 	# remove entire directories.
 	if (safe_qx('git-ls-tree',$last_commit,'--',$f) =~ /^040000 tree/) {
 		defined(my $pid = open my $ls, '-|') or croak $!;
@@ -2917,10 +2917,13 @@ sub process_rm {
 		local $/ = "\0";
 		while (<$ls>) {
 			print $gui '0 ',0 x 40,"\t",$_ or croak $!;
+			print "\tD\t$_\n" unless $q;
 		}
+		print "\tD\t$f/\n" unless $q;
 		close $ls or croak $?;
 	} else {
 		print $gui '0 ',0 x 40,"\t",$f,"\0" or croak $!;
+		print "\tD\t$f\n" unless $q;
 	}
 }
 
@@ -2931,8 +2934,7 @@ sub libsvn_fetch {
 sub libsvn_fetch_delta {
 	my ($last_commit, $paths, $rev, $author, $date, $msg) = @_;
 	my $pool = SVN::Pool->new;
-	my $ed = SVN::Git::Fetcher->new({ c => $last_commit, ra => $SVN,
-	                                  paths => $paths });
+	my $ed = SVN::Git::Fetcher->new({ c => $last_commit, q => $_q });
 	my $reporter = $SVN->do_update($rev, '', 1, $ed, $pool);
 	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
 	my (undef, $last_rev, undef) = cmt_metadata($last_commit);
@@ -2956,8 +2958,7 @@ sub libsvn_fetch_full {
 			$f =~ s#^/##;
 		}
 		if ($m =~ /^[DR]$/) {
-			print "\t$m\t$f\n" unless $_q;
-			process_rm($gui, $last_commit, $f);
+			process_rm($gui, $last_commit, $f, $_q);
 			next if $m eq 'D';
 			# 'R' can be file replacements, too, right?
 		}
@@ -3174,6 +3175,7 @@ sub libsvn_find_parent_branch {
 
 sub libsvn_get_log {
 	my ($ra, @args) = @_;
+	$args[4] = 0 if $_xfer_delta && ! $_follow_parent;
 	if ($SVN::Core::VERSION le '1.2.0') {
 		splice(@args, 3, 1);
 	}
@@ -3187,7 +3189,7 @@ sub libsvn_new_tree {
 	my ($paths, $rev, $author, $date, $msg) = @_;
 	if ($_xfer_delta) {
 		my $pool = SVN::Pool->new;
-		my $ed = SVN::Git::Fetcher->new({paths => $paths, ra => $SVN});
+		my $ed = SVN::Git::Fetcher->new({q => $_q});
 		my $reporter = $SVN->do_update($rev, '', 1, $ed, $pool);
 		my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
 		$reporter->set_path('', $rev, 1, @lock, $pool);
@@ -3382,20 +3384,14 @@ sub new {
 	open my $gui, '| git-update-index -z --index-info' or croak $!;
 	$self->{gui} = $gui;
 	$self->{c} = $git_svn->{c} if exists $git_svn->{c};
-	if (my $p = $git_svn->{paths} && $git_svn->{ra}) {
-		my $s = $git_svn->{ra}->{svn_path};
-		$s = length $s ? qr#^/\Q$s\E/# : qr#^/#;
-		$self->{paths} = { map { my $x = $_;
-		                         $x =~ s/$s//;
-		                         $x => $p->{$_} } keys %$p };
-	}
+	$self->{q} = $git_svn->{q};
 	require Digest::MD5;
 	$self;
 }
 
 sub delete_entry {
 	my ($self, $path, $rev, $pb) = @_;
-	process_rm($self->{gui}, $self->{c}, $path);
+	process_rm($self->{gui}, $self->{c}, $path, $self->{q});
 	undef;
 }
 
@@ -3404,13 +3400,13 @@ sub open_file {
 	my ($mode, $blob) = (safe_qx('git-ls-tree',$self->{c},'--',$path)
 	                     =~ /^(\d{6}) blob ([a-f\d]{40})\t/);
 	{ path => $path, mode_a => $mode, mode_b => $mode, blob => $blob,
-	  pool => SVN::Pool->new };
+	  pool => SVN::Pool->new, action => 'M' };
 }
 
 sub add_file {
 	my ($self, $path, $pb, $cp_path, $cp_rev) = @_;
 	{ path => $path, mode_a => 100644, mode_b => 100644,
-	  pool => SVN::Pool->new };
+	  pool => SVN::Pool->new, action => 'A' };
 }
 
 sub change_file_prop {
@@ -3493,8 +3489,7 @@ sub close_file {
 	$fb->{pool}->clear;
 	my $gui = $self->{gui};
 	print $gui "$fb->{mode_b} $hash\t$path\0" or croak $!;
-	print "\t", $self->{paths}->{$path}->action,
-	      "\t$path\n" if defined $self->{paths}->{$path};
+	print "\t$fb->{action}\t$path\n" if $fb->{action} && ! $self->{q};
 	undef;
 }
 
-- 
1.4.4.1.g22a08
