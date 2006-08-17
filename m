From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitweb: Support for snapshot
Date: Thu, 17 Aug 2006 20:59:46 +0530
Message-ID: <20060817152946.GA5917@satan.home.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 17 17:30:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDjom-00029R-1Y
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 17:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWHQP34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 11:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWHQP34
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 11:29:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:30949 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964875AbWHQP3y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 11:29:54 -0400
Received: by nz-out-0102.google.com with SMTP id n1so361349nzf
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 08:29:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=RgOZUFT4o3VYWYYKq7i2qLYsx8B6spBQucXwXWslb6+6mJ1272+veYjZsiabM+EOzCVo7Qf/V5HlkZWlZ+x+Dkne6NGgqMqVv71SCtvchgZ5hhimZfIWlesYIh2N6uq+oNY16dACdK87rDNVafJ9454IP9D3nRRnDZBRkAW3i/g=
Received: by 10.35.51.13 with SMTP id d13mr3809114pyk;
        Thu, 17 Aug 2006 08:29:54 -0700 (PDT)
Received: from localhost ( [59.92.129.37])
        by mx.gmail.com with ESMTP id t5sm1767206pyc.2006.08.17.08.29.51;
        Thu, 17 Aug 2006 08:29:53 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25589>

This adds snapshort support in gitweb. To enable one need to
set gitweb.snapshot = true in the config file.
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@hp.com>
---
 gitweb/gitweb.perl |   41 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 04282fa..52653a0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -15,6 +15,7 @@ use CGI::Carp qw(fatalsToBrowser);
 use Encode;
 use Fcntl ':mode';
 use File::Find qw();
+use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
 
 our $cgi = new CGI;
@@ -175,6 +176,7 @@ my %actions = (
 	"tag" => \&git_tag,
 	"tags" => \&git_tags,
 	"tree" => \&git_tree,
+	"snapshot" => \&git_snapshot,
 );
 
 $action = 'summary' if (!defined($action));
@@ -1320,6 +1322,7 @@ sub git_difftree_body {
 sub git_shortlog_body {
 	# uses global variable $project
 	my ($revlist, $from, $to, $refs, $extra) = @_;
+	my $have_snapshot = git_get_project_config_bool('snapshot');
 	$from = 0 unless defined $from;
 	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
 
@@ -1344,8 +1347,11 @@ sub git_shortlog_body {
 		print "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
-		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
-		      "</td>\n" .
+		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
+		if ($have_snapshot) {
+			print " | " .  $cgi->a({-href => href(action=>"snapshot", hash=>$commit)}, "snapshot");
+		}
+		print "</td>\n" .
 		      "</tr>\n";
 	}
 	if (defined $extra) {
@@ -2112,6 +2118,29 @@ sub git_tree {
 	git_footer_html();
 }
 
+sub git_snapshot {
+
+	if (!defined $hash) {
+		$hash = git_get_head_hash($project);
+	}
+
+	my $filename = basename($project) . "-$hash.tar.gz";
+
+	print $cgi->header(-type => 'application/x-tar',
+			-content-encoding => 'gzip',
+			'-content-disposition' => "inline; filename=\"$filename\"",
+			-status => '200 OK');
+
+	open my $fd, "-|", "$GIT tar-tree $hash \'$project\' | gzip" or
+				die_error(undef, "Execute git-tar-tree failed.");
+	binmode STDOUT, ':raw';
+	print <$fd>;
+	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	close $fd;
+
+
+}
+
 sub git_log {
 	my $head = git_get_head_hash($project);
 	if (!defined $hash) {
@@ -2206,6 +2235,7 @@ sub git_commit {
 	}
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
+	my $have_snapshot = git_get_project_config_bool('snapshot');
 	my $formats_nav = '';
 	if (defined $file_name && defined $co{'parent'}) {
 		my $parent = $co{'parent'};
@@ -2241,8 +2271,11 @@ sub git_commit {
 	      "<td class=\"sha1\">" .
 	      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash), class => "list"}, $co{'tree'}) .
 	      "</td>" .
-	      "<td class=\"link\">" . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash)}, "tree") .
-	      "</td>" .
+	      "<td class=\"link\">" . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash)}, "tree");
+	if ($have_snapshot) {
+		print " | " .  $cgi->a({-href => href(action=>"snapshot", hash=>$hash)}, "snapshot");
+	}
+	print "</td>" .
 	      "</tr>\n";
 	my $parents = $co{'parents'};
 	foreach my $par (@$parents) {
-- 
1.4.2.rc1.g83e1-dirty
