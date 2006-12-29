From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH] gitweb: New feature last_modified_ref.
Date: Fri, 29 Dec 2006 18:58:05 +0000
Message-ID: <20061229185805.GF6558@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 29 19:58:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0Mvk-0003mV-VM
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 19:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWL2S6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 13:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWL2S6J
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 13:58:09 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:36678 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965102AbWL2S6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 13:58:08 -0500
Received: from 213-202-135-153.bas502.dsl.esat.net ([213.202.135.153] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1H0MvE-0002b3-7j; Fri, 29 Dec 2006 18:57:40 +0000
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35602>

Added a new feature which allows the gitweb administrator to set a
symbolic ref name that will be used to work out the Last Change value
for the project_list action.  This was suggested by Jakub Narebski in
<200612291140.46909.jnareb@gmail.com>.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |   52 +++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d845e91..9fb5208 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -185,6 +185,21 @@ our %feature = (
 	'forks' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# Set a symbolic ref name that will be used to working out the Last
+	# Change value for the project_list action.  If the ref name does not
+	# exist for a project or the ref name is undefined, the code will fall
+	# back on doing a 'for-each-ref refs/heads'.
+	#
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'last_activity_ref'}{'default'} = ['HEAD'];
+	# or
+	# $feature{'last_activity_ref'}{'default'} = ['refs/heads/master'];
+	# etc.
+	# Project specific override is not supported.
+	'last_activity_ref' => {
+		'override' => 0,
+		'default' => [undef]},
 );
 
 sub gitweb_check_feature {
@@ -1147,17 +1162,35 @@ sub git_get_project_owner {
 }
 
 sub git_get_last_activity {
-	my ($path) = @_;
+	my ($path, $ref) = @_;
 	my $fd;
+	my $most_recent = undef;
 
 	$git_dir = "$projectroot/$path";
-	open($fd, "-|", git_cmd(), 'for-each-ref',
-	     '--format=%(committer)',
-	     '--sort=-committerdate',
-	     '--count=1',
-	     'refs/heads') or return;
-	my $most_recent = <$fd>;
-	close $fd or return;
+
+	if (defined $ref) {
+		open($fd, "-|", git_cmd(), "cat-file",
+		     "commit",
+		     $ref) or return;
+		while (my $line = <$fd>) {
+			last if $line eq "\n";
+			if ($line =~ m/^committer /) {
+				$most_recent = $line;
+				last;
+			}
+		}
+		close $fd;
+	}
+	if (!defined $most_recent) {
+		open($fd, "-|", git_cmd(), 'for-each-ref',
+		     '--format=%(committer)',
+		     '--sort=-committerdate',
+		     '--count=1',
+		     'refs/heads') or return;
+		$most_recent = <$fd>;
+		close $fd or return;
+	}
+
 	if ($most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
 		my $timestamp = $1;
 		my $age = time - $timestamp;
@@ -2561,10 +2594,11 @@ sub git_project_list_body {
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
 
 	my ($check_forks) = gitweb_check_feature('forks');
+	my ($last_activity_ref) = gitweb_check_feature('last_activity_ref');
 
 	my @projects;
 	foreach my $pr (@$projlist) {
-		my (@aa) = git_get_last_activity($pr->{'path'});
+		my (@aa) = git_get_last_activity($pr->{'path'}, $last_activity_ref);
 		unless (@aa) {
 			next;
 		}
-- 
1.5.0.rc0.g5b5f
