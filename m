X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH] Small optimizations to gitweb
Date: Mon, 18 Dec 2006 22:43:27 +0000
Message-ID: <20061218224327.GG16029@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 23:07:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1287 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 18:05:00 EST
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34757>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwRXc-0007Ev-W7 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 00:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754727AbWLRXFB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 18:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754728AbWLRXFB
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 18:05:01 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:55023 "EHLO
 igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754727AbWLRXFA (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 18:05:00 -0500
Received: from [212.2.165.238] (helo=localhost) by igraine.blacknight.ie with
 esmtp (Exim 4.60) (envelope-from <robfitz@273k.net>) id 1GwRCP-0003qh-GS for
 git@vger.kernel.org; Mon, 18 Dec 2006 22:43:09 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Limit some of the git_cmd's so they only return the number of lines
that will be processed.  Don't recompute head hash or have_snapshot
values.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5ea3fda..1990f15 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1141,6 +1141,7 @@ sub git_get_last_activity {
 	open($fd, "-|", git_cmd(), 'for-each-ref',
 	     '--format=%(refname) %(committer)',
 	     '--sort=-committerdate',
+	     '--count=1',
 	     'refs/heads') or return;
 	my $most_recent = <$fd>;
 	close $fd or return;
@@ -2559,6 +2560,8 @@ sub git_shortlog_body {
 	# uses global variable $project
 	my ($revlist, $from, $to, $refs, $extra) = @_;
 
+	my $have_snapshot = gitweb_have_snapshot();
+
 	$from = 0 unless defined $from;
 	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
 
@@ -2586,7 +2589,7 @@ sub git_shortlog_body {
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
-		if (gitweb_have_snapshot()) {
+		if ($have_snapshot) {
 			print " | " . $cgi->a({-href => href(action=>"snapshot", hash=>$commit)}, "snapshot");
 		}
 		print "</td>\n" .
@@ -2876,8 +2879,8 @@ sub git_summary {
 		}
 	}
 
-	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
-		git_get_head_hash($project), "--"
+	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=16",
+		$head, "--"
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
-- 
1.4.4.2.gee60-dirty
