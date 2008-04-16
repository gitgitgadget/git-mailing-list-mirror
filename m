From: apenwarr@gmail.com
Subject: [PATCH 2/3] git-svn: Add --add-author-from option.
Date: Tue, 15 Apr 2008 21:04:17 -0400
Message-ID: <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
References: <1208307858-31039-1-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@versabanq.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 07:26:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlwJx-0000IV-Pj
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 03:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbYDPBTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 21:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbYDPBTg
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 21:19:36 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:38871
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752919AbYDPBTe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2008 21:19:34 -0400
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Apr 2008 21:19:33 EDT
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Apr 2008 21:04:22 -0400
Received: (qmail 30604 invoked from network); 16 Apr 2008 01:04:21 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 16 Apr 2008 01:04:21 -0000
Received: (qmail 30597 invoked from network); 16 Apr 2008 01:04:21 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 16 Apr 2008 01:04:21 -0000
Received: (qmail 30580 invoked from network); 16 Apr 2008 01:04:20 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 16 Apr 2008 01:04:20 -0000
Received: (qmail 30550 invoked from network); 16 Apr 2008 01:04:18 -0000
Received: from unknown (HELO averyp-server.pwcorp.com) (10.65.1.129)
  by weaver.open.versabanq.com with SMTP; 16 Apr 2008 01:04:18 -0000
Received: by averyp-server.pwcorp.com (Postfix, from userid 1000)
	id 4BD7B8C066; Tue, 15 Apr 2008 21:04:18 -0400 (EDT)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1208307858-31039-1-git-send-email-apenwarr@gmail.com>
X-OriginalArrivalTime: 16 Apr 2008 01:04:22.0082 (UTC) FILETIME=[CE3B3220:01C89F5D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79662>

From: Avery Pennarun <apenwarr@versabanq.com>

This adds a From: line (based on the commit's author information) when
sending to svn.  It doesn't add if a From: or Signed-off-by: header already
exists for that commit.

This, combined with --use-log-author, can retain the author field of commits
through a round trip from git to svn and back.
Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 git-svn.perl |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b864b54..b7ad898 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -82,6 +82,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'repack-flags|repack-args|repack-opts=s' =>
 		   \$Git::SVN::_repack_flags,
 		'use-log-author' => \$Git::SVN::_use_log_author,
+		'add-author-from' => \$Git::SVN::_add_author_from,
 		%remote_opts );
 
 my ($_trunk, $_tags, $_branches, $_stdlayout);
@@ -1009,17 +1010,28 @@ sub get_commit_entry {
 		my ($msg_fh, $ctx) = command_output_pipe('cat-file',
 		                                         $type, $treeish);
 		my $in_msg = 0;
+		my $author;
+		my $saw_from = 0;
 		while (<$msg_fh>) {
 			if (!$in_msg) {
 				$in_msg = 1 if (/^\s*$/);
+				$author = $1 if (/^author (.*>)/);
 			} elsif (/^git-svn-id: /) {
 				# skip this for now, we regenerate the
 				# correct one on re-fetch anyways
 				# TODO: set *:merge properties or like...
 			} else {
+				if (/^From:/ || /^Signed-off-by:/) {
+					$saw_from = 1;
+				}
 				print $log_fh $_ or croak $!;
 			}
 		}
+		if ($Git::SVN::_add_author_from && defined($author)
+		    && !$saw_from) {
+			print $log_fh "\nFrom: $author\n"
+			      or croak $!;
+		}
 		command_close_pipe($msg_fh, $ctx);
 	}
 	close $log_fh or croak $!;
@@ -1246,7 +1258,7 @@ use constant rev_map_fmt => 'NH40';
 use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
             $_repack $_repack_flags $_use_svm_props $_head
             $_use_svnsync_props $no_reuse_existing $_minimize_url
-	    $_use_log_author/;
+	    $_use_log_author $_add_author_from/;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
-- 
1.5.4.3
