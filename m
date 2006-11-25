X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: exit with status 1 for test failures
Date: Fri, 24 Nov 2006 22:38:18 -0800
Message-ID: <11644367004098-git-send-email-normalperson@yhbt.net>
References: <11644366982320-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Sat, 25 Nov 2006 06:39:01 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g22a08
In-Reply-To: <11644366982320-git-send-email-normalperson@yhbt.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32256>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnrBI-0007K5-0c for gcvg-git@gmane.org; Sat, 25 Nov
 2006 07:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757849AbWKYGiX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 01:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757850AbWKYGiX
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 01:38:23 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58842 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1757849AbWKYGiW (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 01:38:22 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 86D982DC036; Fri, 24 Nov 2006 22:38:20 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 24 Nov 2006
 22:38:20 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Some versions of the SVN libraries cause die() to exit with 255,
and 40cf043389ef4cdf3e56e7c4268d6f302e387fa0 tightened up
test_expect_failure to reject return values >128.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 5d67771..0a47b1f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -21,6 +21,7 @@ $ENV{TZ} = 'UTC';
 $ENV{LC_ALL} = 'C';
 $| = 1; # unbuffer STDOUT
 
+sub fatal (@) { print STDERR $@; exit 1 }
 # If SVN:: library support is added, please make the dependencies
 # optional and preserve the capability to use the command-line client.
 # use eval { require SVN::... } to make it lazy load
@@ -569,7 +570,7 @@ sub commit_lib {
 				$no = 1;
 			}
 		}
-		close $fh or croak $?;
+		close $fh or exit 1;
 		if (! defined $r_new && ! defined $cmt_new) {
 			unless ($no) {
 				die "Failed to parse revision information\n";
@@ -868,13 +869,16 @@ sub commit_diff {
 						print "Committed $_[0]\n";
 					}, @lock)
 				);
-	my $mods = libsvn_checkout_tree($ta, $tb, $ed);
-	if (@$mods == 0) {
-		print "No changes\n$ta == $tb\n";
-		$ed->abort_edit;
-	} else {
-		$ed->close_edit;
-	}
+	eval {
+		my $mods = libsvn_checkout_tree($ta, $tb, $ed);
+		if (@$mods == 0) {
+			print "No changes\n$ta == $tb\n";
+			$ed->abort_edit;
+		} else {
+			$ed->close_edit;
+		}
+	};
+	fatal "$@\n" if $@;
 	$_message = $_file = undef;
 	return $rev_committed;
 }
-- 
1.4.4.1.g22a08
