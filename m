From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix fetching new directories copies when using SVN:: libs
Date: Thu, 20 Jul 2006 01:43:01 -0700
Message-ID: <20060720084301.GA29440@localdomain>
References: <b6327a230607191902n47b81993x8caea2df3955d8c0@mail.gmail.com> <20060720034841.GA28298@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Williamson <benw@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 20 10:43:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3U7s-0006zg-D7
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 10:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWGTInF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 04:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWGTInF
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 04:43:05 -0400
Received: from hand.yhbt.net ([66.150.188.102]:29886 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964908AbWGTInE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jul 2006 04:43:04 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4577D7DC022;
	Thu, 20 Jul 2006 01:43:02 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 20 Jul 2006 01:43:01 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060720034841.GA28298@localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24022>

Log output from SVN doesn't list all the new files that were
added if a new directory was copied from an existing place in
the repository.  This means we'll have to do some extra work and
traverse new directories ourselves.

This has been updated from the original patch to defer traversed
adds until all removals have been done.  Please disregard the
original.

Thanks to Ben Williamson for the excellent bug report and
testing.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 89ad840..6453771 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2709,6 +2709,12 @@ sub libsvn_fetch {
 			} else {
 				die "Unrecognized action: $m, ($f r$rev)\n";
 			}
+		} elsif ($t == $SVN::Node::dir && $m =~ /^[AR]$/) {
+			my @traversed = ();
+			libsvn_traverse($gui, '', $f, $rev, \@traversed);
+			foreach (@traversed) {
+				push @amr, [ $m, $_ ]
+			}
 		}
 		$pool->clear;
 	}
@@ -2778,7 +2784,7 @@ sub libsvn_parse_revision {
 }
 
 sub libsvn_traverse {
-	my ($gui, $pfx, $path, $rev) = @_;
+	my ($gui, $pfx, $path, $rev, $files) = @_;
 	my $cwd = "$pfx/$path";
 	my $pool = SVN::Pool->new;
 	$cwd =~ s#^/+##g;
@@ -2786,10 +2792,15 @@ sub libsvn_traverse {
 	foreach my $d (keys %$dirent) {
 		my $t = $dirent->{$d}->kind;
 		if ($t == $SVN::Node::dir) {
-			libsvn_traverse($gui, $cwd, $d, $rev);
+			libsvn_traverse($gui, $cwd, $d, $rev, $files);
 		} elsif ($t == $SVN::Node::file) {
-			print "\tA\t$cwd/$d\n" unless $_q;
-			libsvn_get_file($gui, "$cwd/$d", $rev);
+			my $file = "$cwd/$d";
+			if (defined $files) {
+				push @$files, $file;
+			} else {
+				print "\tA\t$file\n" unless $_q;
+				libsvn_get_file($gui, $file, $rev);
+			}
 		}
 	}
 	$pool->clear;
@@ -2913,9 +2924,7 @@ sub libsvn_new_tree {
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
