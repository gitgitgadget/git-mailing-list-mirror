From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH v2 4/3] gitweb: Always call format_date with timezone parameter
Date: Sat, 19 Mar 2011 19:11:16 -0700
Message-ID: <b599dae39131b90d0970a1ef63e6599b@localhost>
References: <4f21902cf5f72b30a96465cf911d13aa@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 03:18:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q18Dc-00009f-L6
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 03:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab1CTCR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 22:17:59 -0400
Received: from [69.28.251.93] ([69.28.251.93]:40959 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab1CTCR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 22:17:58 -0400
Received: (qmail 17897 invoked from network); 20 Mar 2011 02:17:56 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 20 Mar 2011 02:17:56 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 19 Mar 2011 19:17:56 -0700
In-Reply-To: <4f21902cf5f72b30a96465cf911d13aa@localhost>
User-Agent: vim 7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169483>

From: Jakub Narebski <jnareb@gmail.com>

Make the timezone parameter mandatory.  This ensures that the *_local
fields are always populated with accurate information.

Also, delete an unnecessary call to format_date().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---

v2: Fix typos.  Remove unnecessary call.  Remove default "-0000" tz value.
Rebase on top of my patch 3/3 (as applying -1/3 then 1/3 would create a
merge conflict).

 gitweb/gitweb.perl |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2d4349f..485ebd0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2907,8 +2907,7 @@ sub git_get_rev_name_tags {
 ## parse to hash functions
 
 sub format_date {
-	my $epoch = shift;
-	my $tz = shift || "-0000";
+	my ($epoch, $tz) = @_;
 
 	my %date;
 	my @months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
@@ -4943,7 +4942,6 @@ sub git_log_body {
 		next if !%co;
 		my $commit = $co{'id'};
 		my $ref = format_ref_marker($refs, $commit);
-		my %ad = format_date($co{'author_epoch'});
 		git_print_header_div('commit',
 		               "<span class=\"age\">$co{'age_string'}</span>" .
 		               esc_html($co{'title'}) . $ref,
@@ -7102,7 +7100,8 @@ sub git_feed {
 	if (defined($commitlist[0])) {
 		%latest_commit = %{$commitlist[0]};
 		my $latest_epoch = $latest_commit{'committer_epoch'};
-		%latest_date   = format_date($latest_epoch);
+		%latest_date   = format_date($latest_epoch,
+		                             $latest_commit{'committer_tz'});
 		my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
 		if (defined $if_modified) {
 			my $since;
@@ -7233,7 +7232,7 @@ XML
 		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
 			last;
 		}
-		my %cd = format_date($co{'author_epoch'});
+		my %cd = format_date($co{'author_epoch'}, $co{'author_tz'});
 
 		# get list of changed files
 		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-- 
1.7.4.1
