From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] gitweb: Support for snapshot
Date: Fri, 18 Aug 2006 10:36:14 +0530
Message-ID: <44E54AC6.9010600@gmail.com>
References: <20060817152946.GA5917@satan.home.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040004070406090407030009"
X-From: git-owner@vger.kernel.org Fri Aug 18 07:06:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDwZA-0002mY-OW
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 07:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWHRFGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 01:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWHRFGc
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 01:06:32 -0400
Received: from main.gmane.org ([80.91.229.2]:16012 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932366AbWHRFGc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 01:06:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDwYu-0002jN-G4
	for git@vger.kernel.org; Fri, 18 Aug 2006 07:06:28 +0200
Received: from palrel1.hp.com ([15.81.168.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 07:06:28 +0200
Received: from aneesh.kumar by palrel1.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 07:06:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: palrel1.hp.com
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <20060817152946.GA5917@satan.home.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25627>

This is a multi-part message in MIME format.
--------------040004070406090407030009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Now I read RFC 2616  the content-encoding need to be specified as x-gzip. 
Also i am not sure whether the fact that it is registered with IANA exempt us from
adding it to html header.

The corrected patch below. 


--------------040004070406090407030009
Content-Type: text/plain;
 name="0001-gitweb-Support-for-snapshot.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-gitweb-Support-for-snapshot.txt"


This adds snapshort support in gitweb. To enable one need to
set gitweb.snapshot = true in the config file.
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 gitweb/gitweb.perl |   41 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 04282fa..d6f96a3 100755
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
+			-content-encoding => 'x-gzip',
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


--------------040004070406090407030009--
