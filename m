From: Mattias Nissler <mattias.nissler@gmx.de>
Subject: [PATCH 1/2] git-svn: Always duplicate paths returned from get_log
Date: Tue, 07 Jul 2009 01:39:52 +0200
Message-ID: <1246923592.4618.17.camel@kea>
References: <20090706212742.GA8219@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 01:40:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNxn6-0005bV-Rh
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 01:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbZGFXjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 19:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbZGFXjv
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 19:39:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:38388 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753165AbZGFXjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 19:39:51 -0400
Received: (qmail invoked by alias); 06 Jul 2009 23:39:53 -0000
Received: from e182067244.adsl.alicedsl.de (EHLO [192.168.1.50]) [85.182.67.244]
  by mail.gmx.net (mp015) with SMTP; 07 Jul 2009 01:39:53 +0200
X-Authenticated: #429267
X-Provags-ID: V01U2FsdGVkX19PzLZwfD5PVDGSGvgZ1VqqiA+FPsUjbIu62aZv5o
	cRV4VH/K/r8hj4
In-Reply-To: <20090706212742.GA8219@dcvr.yhbt.net>
X-Mailer: Evolution 2.26.2 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122811>

This makes get_log more safe to use because callers cannot run into path
clobbering any more. The additional overhead will not affect performance
since the critical calls from the fetch loop need the path duplication
anyway and the rest of the call sites is not performance critical.

Signed-off-by: Mattias Nissler <mattias.nissler@gmx.de>
---
 git-svn.perl |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d1af1a3..57d13af 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2538,9 +2538,8 @@ sub find_parent_branch {
 	unless (defined $paths) {
 		my $err_handler = $SVN::Error::handler;
 		$SVN::Error::handler = \&Git::SVN::Ra::skip_unknown_revs;
-		$self->ra->get_log([$self->{path}], $rev, $rev, 0, 1, 1, sub {
-		                   $paths =
-				      Git::SVN::Ra::dup_changed_paths($_[0]) });
+		$self->ra->get_log([$self->{path}], $rev, $rev, 0, 1, 1,
+				   sub { $paths = $_[0] });
 		$SVN::Error::handler = $err_handler;
 	}
 	return undef unless defined $paths;
@@ -4431,6 +4430,26 @@ sub get_log {
 	my ($self, @args) = @_;
 	my $pool = SVN::Pool->new;
 
+	# svn_log_changed_path_t objects passed to get_log are likely to be
+	# overwritten even if only the refs are copied to an external variable,
+	# so we should dup the structures in their entirety.  Using an externally
+	# passed pool (instead of our temporary and quickly cleared pool in
+	# Git::SVN::Ra) does not help matters at all...
+	my $receiver = pop @args;
+	push(@args, sub {
+		my ($paths) = $_[0];
+		return &$receiver(@_) unless $paths;
+		$_[0] = ();
+		foreach my $p (keys %$paths) {
+			my $i = $paths->{$p};
+			my %s = map { $_ => $i->$_ }
+				      qw/copyfrom_path copyfrom_rev action/;
+			$_[0]{$p} = \%s;
+		}
+		&$receiver(@_);
+	});
+
+
 	# the limit parameter was not supported in SVN 1.1.x, so we
 	# drop it.  Therefore, the receiver callback passed to it
 	# is made aware of this limitation by being wrapped if
@@ -4600,8 +4619,7 @@ sub gs_fetch_loop_common {
 		};
 		sub _cb {
 			my ($paths, $r, $author, $date, $log) = @_;
-			[ dup_changed_paths($paths),
-			  { author => $author, date => $date, log => $log } ];
+			[ $paths, { author => $author, date => $date, log => $log } ];
 		}
 		$self->get_log([$longest_path], $min, $max, 0, 1, 1,
 		               sub { $revs{$_[1]} = _cb(@_) });
@@ -4823,24 +4841,6 @@ sub skip_unknown_revs {
 	die "Error from SVN, ($errno): ", $err->expanded_message,"\n";
 }
 
-# svn_log_changed_path_t objects passed to get_log are likely to be
-# overwritten even if only the refs are copied to an external variable,
-# so we should dup the structures in their entirety.  Using an externally
-# passed pool (instead of our temporary and quickly cleared pool in
-# Git::SVN::Ra) does not help matters at all...
-sub dup_changed_paths {
-	my ($paths) = @_;
-	return undef unless $paths;
-	my %ret;
-	foreach my $p (keys %$paths) {
-		my $i = $paths->{$p};
-		my %s = map { $_ => $i->$_ }
-		              qw/copyfrom_path copyfrom_rev action/;
-		$ret{$p} = \%s;
-	}
-	\%ret;
-}
-
 package Git::SVN::Log;
 use strict;
 use warnings;
-- 
1.6.3.3
