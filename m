From: Mark Rada <marada@uwaterloo.ca>
Subject: [RFC/PATCH 1/2] gitweb: extend &git_get_head_hash to be &git_get_hash
Date: Thu, 10 Sep 2009 17:20:27 -0400
Message-ID: <4AA96D9B.6090003@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 23:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlr4I-0001tN-9j
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 23:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbZIJVUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 17:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754457AbZIJVUb
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 17:20:31 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:58772 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753855AbZIJVUa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 17:20:30 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8ALKR9u026908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Sep 2009 17:20:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: fcad5366-bc70-4088-af46-fe0380759568
X-Miltered: at mailchk-m05 with ID 4AA96D9C.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Thu, 10 Sep 2009 17:20:30 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128149>

This adds an optional second argument to the routine which lets the
caller specify a treeish that can be translated to a hash id by
rev-parse.

To maintain some backwards compatability, the second argument is
optional and it will default to `HEAD' if not specified.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 gitweb/gitweb.perl |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..d650188 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1981,13 +1981,14 @@ sub quote_command {
 		map { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ );
 }
 
-# get HEAD ref of given project as hash
-sub git_get_head_hash {
+# get object id of given project as full hash, defaults to HEAD
+sub git_get_hash {
 	my $project = shift;
+	my $hash = shift || 'HEAD';
 	my $o_git_dir = $git_dir;
 	my $retval = undef;
 	$git_dir = "$projectroot/$project";
-	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
+	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--verify', "$hash") {
 		my $head = <$fd>;
 		close $fd;
 		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
@@ -4737,7 +4738,7 @@ sub git_summary {
 }
 
 sub git_tag {
-	my $head = git_get_head_hash($project);
+	my $head = &git_get_hash($project);
 	git_header_html();
 	git_print_page_nav('','', $head,undef,$head);
 	my %tag = parse_tag($hash);
@@ -4778,7 +4779,7 @@ sub git_blame {
 
 	# error checking
 	die_error(400, "No file name given") unless $file_name;
-	$hash_base ||= git_get_head_hash($project);
+	$hash_base ||= &git_get_hash($project);
 	die_error(404, "Couldn't find base commit") unless $hash_base;
 	my %co = parse_commit($hash_base)
 		or die_error(404, "Commit not found");
@@ -4911,7 +4912,7 @@ HTML
 }
 
 sub git_tags {
-	my $head = git_get_head_hash($project);
+	my $head = &git_get_hash($project);
 	git_header_html();
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
@@ -4924,7 +4925,7 @@ sub git_tags {
 }
 
 sub git_heads {
-	my $head = git_get_head_hash($project);
+	my $head = &git_get_hash($project);
 	git_header_html();
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
@@ -4942,7 +4943,7 @@ sub git_blob_plain {
 
 	if (!defined $hash) {
 		if (defined $file_name) {
-			my $base = $hash_base || git_get_head_hash($project);
+			my $base = $hash_base || &git_get_hash($project);
 			$hash = git_get_hash_by_path($base, $file_name, "blob")
 				or die_error(404, "Cannot find file");
 		} else {
@@ -4994,7 +4995,7 @@ sub git_blob {
 
 	if (!defined $hash) {
 		if (defined $file_name) {
-			my $base = $hash_base || git_get_head_hash($project);
+			my $base = $hash_base || &git_get_hash($project);
 			$hash = git_get_hash_by_path($base, $file_name, "blob")
 				or die_error(404, "Cannot find file");
 		} else {
@@ -5197,7 +5198,7 @@ sub git_snapshot {
 	}
 
 	if (!defined $hash) {
-		$hash = git_get_head_hash($project);
+		$hash = &git_get_hash($project);
 	}
 
 	my $name = $project;
@@ -5229,7 +5230,7 @@ sub git_snapshot {
 }
 
 sub git_log {
-	my $head = git_get_head_hash($project);
+	my $head = &git_get_hash($project);
 	if (!defined $hash) {
 		$hash = $head;
 	}
@@ -5833,7 +5834,7 @@ sub git_patches {
 
 sub git_history {
 	if (!defined $hash_base) {
-		$hash_base = git_get_head_hash($project);
+		$hash_base = &git_get_hash($project);
 	}
 	if (!defined $page) {
 		$page = 0;
@@ -5904,7 +5905,7 @@ sub git_search {
 		die_error(400, "Text field is empty");
 	}
 	if (!defined $hash) {
-		$hash = git_get_head_hash($project);
+		$hash = &git_get_hash($project);
 	}
 	my %co = parse_commit($hash);
 	if (!%co) {
@@ -6159,7 +6160,7 @@ EOT
 }
 
 sub git_shortlog {
-	my $head = git_get_head_hash($project);
+	my $head = &git_get_hash($project);
 	if (!defined $hash) {
 		$hash = $head;
 	}
@@ -6486,7 +6487,7 @@ XML
 
 	foreach my $pr (@list) {
 		my %proj = %$pr;
-		my $head = git_get_head_hash($proj{'path'});
+		my $head = &git_get_hash($proj{'path'});
 		if (!defined $head) {
 			next;
 		}
-- 
1.6.4.2
