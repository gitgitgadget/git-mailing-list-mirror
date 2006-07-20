From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Re: git-svn: Missing files
Date: Wed, 19 Jul 2006 20:48:41 -0700
Message-ID: <20060720034841.GA28298@localdomain>
References: <b6327a230607191902n47b81993x8caea2df3955d8c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 20 05:48:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3PWr-0008Vw-6m
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 05:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWGTDso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 23:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWGTDso
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 23:48:44 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50876 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932565AbWGTDsn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jul 2006 23:48:43 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C86F17DC022;
	Wed, 19 Jul 2006 20:48:41 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 19 Jul 2006 20:48:41 -0700
To: Ben Williamson <benw@pobox.com>
Content-Disposition: inline
In-Reply-To: <b6327a230607191902n47b81993x8caea2df3955d8c0@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24017>

Ben, can you please try this patch against the git-svn.perl file in
master?  You can also find the full patched file here:

	http://git-svn.bogomips.org/git-svn.perl

From: Eric Wong <normalperson@yhbt.net>
Date: Wed, 19 Jul 2006 20:42:35 -0700
Subject: [PATCH] git-svn: fix fetching new directories copies when using SVN:: libs

Log output from SVN doesn't list all the new files that were
added if a new directory was copied from an existing place in
the repository.  This means we'll have to do some extra work and
traverse new directories ourselves.

Thanks to Ben Williamson for the excellent bug report.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 89ad840..577a284 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2692,6 +2692,7 @@ sub libsvn_fetch {
 	my ($last_commit, $paths, $rev, $author, $date, $msg) = @_;
 	open my $gui, '| git-update-index -z --index-info' or croak $!;
 	my @amr;
+	my %fetched = ();
 	foreach my $f (keys %$paths) {
 		my $m = $paths->{$f}->action();
 		$f =~ s#^/+##;
@@ -2709,10 +2710,13 @@ sub libsvn_fetch {
 			} else {
 				die "Unrecognized action: $m, ($f r$rev)\n";
 			}
+		} elsif ($t == $SVN::Node::dir && $m =~ /^[AR]$/) {
+			libsvn_traverse($gui, '', $f, $rev, \%fetched);
 		}
 		$pool->clear;
 	}
 	foreach (@amr) {
+		next if $fetched{$_->[1]};
 		print "\t$_->[0]\t$_->[1]\n" unless $_q;
 		libsvn_get_file($gui, $_->[1], $rev)
 	}
@@ -2778,7 +2782,7 @@ sub libsvn_parse_revision {
 }
 
 sub libsvn_traverse {
-	my ($gui, $pfx, $path, $rev) = @_;
+	my ($gui, $pfx, $path, $rev, $files) = @_;
 	my $cwd = "$pfx/$path";
 	my $pool = SVN::Pool->new;
 	$cwd =~ s#^/+##g;
@@ -2786,10 +2790,12 @@ sub libsvn_traverse {
 	foreach my $d (keys %$dirent) {
 		my $t = $dirent->{$d}->kind;
 		if ($t == $SVN::Node::dir) {
-			libsvn_traverse($gui, $cwd, $d, $rev);
+			libsvn_traverse($gui, $cwd, $d, $rev, $files);
 		} elsif ($t == $SVN::Node::file) {
-			print "\tA\t$cwd/$d\n" unless $_q;
-			libsvn_get_file($gui, "$cwd/$d", $rev);
+			my $file = "$cwd/$d";
+			print "\tA\t$file\n" unless $_q;
+			libsvn_get_file($gui, $file, $rev);
+			$files->{$file} = 1 if defined $files;
 		}
 	}
 	$pool->clear;
@@ -2913,9 +2919,7 @@ sub libsvn_new_tree {
 	}
 	my ($paths, $rev, $author, $date, $msg) = @_;
 	open my $gui, '| git-update-index -z --index-info' or croak $!;
-	my $pool = SVN::Pool->new;
-	libsvn_traverse($gui, '', $SVN_PATH, $rev, $pool);
-	$pool->clear;
+	libsvn_traverse($gui, '', $SVN_PATH, $rev);
 	close $gui or croak $?;
 	return libsvn_log_entry($rev, $author, $date, $msg);
 }
-- 
1.4.1.g9d8f
