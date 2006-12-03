X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: avoid fetching files twice in the same revision
Date: Sat, 2 Dec 2006 16:19:31 -0800
Message-ID: <20061203001930.GA468@soma>
References: <87psb2ou6f.fsf@mid.deneb.enyo.de> <20061202223419.GA7057@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 00:19:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061202223419.GA7057@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33068>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqf51-00037r-OZ for gcvg-git@gmane.org; Sun, 03 Dec
 2006 01:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424807AbWLCATd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 19:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424886AbWLCATd
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 19:19:33 -0500
Received: from hand.yhbt.net ([66.150.188.102]:50329 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1424807AbWLCATd (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 19:19:33 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 696E62DC034; Sat,  2 Dec 2006 16:19:31 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat,  2 Dec 2006
 16:19:31 -0800
To: Florian Weimer <fw@deneb.enyo.de>
Sender: git-owner@vger.kernel.org

SVN is not entirely consistent in returning log information and
sometimes returns file information when adding subdirectories,
and sometimes it does not (only returning information about the
directory that was added).  This caused git-svn to occasionally
add a file to the list of files to be fetched twice.  Now we
change the data structure to be hash to avoid repeated fetches.

As of now (in master), this only affects repositories fetched
without deltas enabled (file://, and when manually overriden
with GIT_SVN_DELTA_FETCH=0); so this bug mainly affects users of
1.4.4.1 and maint.

Thanks to Florian Weimer for reporting this bug.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3891122..d0bd0bd 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2982,7 +2982,7 @@ sub libsvn_fetch_delta {
 sub libsvn_fetch_full {
 	my ($last_commit, $paths, $rev, $author, $date, $msg) = @_;
 	open my $gui, '| git-update-index -z --index-info' or croak $!;
-	my @amr;
+	my %amr;
 	my $p = $SVN->{svn_path};
 	foreach my $f (keys %$paths) {
 		my $m = $paths->{$f}->action();
@@ -3001,7 +3001,7 @@ sub libsvn_fetch_full {
 		my $t = $SVN->check_path($f, $rev, $pool);
 		if ($t == $SVN::Node::file) {
 			if ($m =~ /^[AMR]$/) {
-				push @amr, [ $m, $f ];
+				$amr{$f} = $m;
 			} else {
 				die "Unrecognized action: $m, ($f r$rev)\n";
 			}
@@ -3009,13 +3009,13 @@ sub libsvn_fetch_full {
 			my @traversed = ();
 			libsvn_traverse($gui, '', $f, $rev, \@traversed);
 			foreach (@traversed) {
-				push @amr, [ $m, $_ ]
+				$amr{$_} = $m;
 			}
 		}
 		$pool->clear;
 	}
-	foreach (@amr) {
-		libsvn_get_file($gui, $_->[1], $rev, $_->[0]);
+	foreach (keys %amr) {
+		libsvn_get_file($gui, $_, $rev, $amr{$_});
 	}
 	close $gui or croak $?;
 	return libsvn_log_entry($rev, $author, $date, $msg, [$last_commit]);
-- 
1.4.4.1.gdf6b
