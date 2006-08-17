From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitweb: Support for snapshots in gitweb
Date: Thu, 17 Aug 2006 11:59:05 +0530
Message-ID: <44E40CB1.7040805@gmail.com>
References: <44E263DD.6030305@cam.ac.uk> <ebupuk$dgl$1@sea.gmane.org>	<44E2F911.6060002@gmail.com> <7v4pwc4l0y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000102020301030406050305"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 08:29:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDbNW-0007sX-9G
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 08:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWHQG3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 02:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWHQG3P
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 02:29:15 -0400
Received: from main.gmane.org ([80.91.229.2]:41960 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751131AbWHQG3O (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 02:29:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDbNQ-0007rE-2o
	for git@vger.kernel.org; Thu, 17 Aug 2006 08:29:12 +0200
Received: from 59.92.204.226 ([59.92.204.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 08:29:12 +0200
Received: from aneesh.kumar by 59.92.204.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 08:29:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.204.226
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <7v4pwc4l0y.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25551>

This is a multi-part message in MIME format.
--------------000102020301030406050305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------000102020301030406050305
Content-Type: text/plain;
 name="0001-gitweb-Support-for-snapshots-in-gitweb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-gitweb-Support-for-snapshots-in-gitweb.txt"


This add snapshot support to gitweb. This need to be enabled
per project using config gitweb.snapshot = true

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 gitweb/gitweb.perl |   34 ++++++++++++++++++++++++++++++----
 1 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 37a6284..4c78e80 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -175,6 +175,7 @@ my %actions = (
 	"tag" => \&git_tag,
 	"tags" => \&git_tags,
 	"tree" => \&git_tree,
+	"snapshot" => \&git_snapshot,
 );
 
 $action = 'summary' if (!defined($action));
@@ -1309,6 +1310,7 @@ sub git_difftree_body {
 sub git_shortlog_body {
 	# uses global variable $project
 	my ($revlist, $from, $to, $refs, $extra) = @_;
+	my $have_snapshot = git_get_project_config_bool ('snapshot');
 	$from = 0 unless defined $from;
 	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
 
@@ -1333,8 +1335,11 @@ sub git_shortlog_body {
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
@@ -2097,6 +2102,23 @@ sub git_tree {
 	git_footer_html();
 }
 
+sub git_snapshot {
+	if (!defined $hash) {
+		$hash = git_get_head_hash($project);
+	}
+	print $cgi->header(-type=>'application/x-tar', -Content-Encoding=>'x-gzip',
+		'-content-disposition' => "inline; filename=\"$project.tar.gz\"",
+		-status=> '200 OK');
+
+	open my $fd, "-|", "$GIT tar-tree $hash \'$project\' | gzip -c6" or die_error(undef, "Execute git-tar-tree failed.");
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
@@ -2191,6 +2213,7 @@ sub git_commit {
 	}
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
+	my $have_snapshot = git_get_project_config_bool ('snapshot');
 	my $formats_nav = '';
 	if (defined $file_name && defined $co{'parent'}) {
 		my $parent = $co{'parent'};
@@ -2226,8 +2249,11 @@ sub git_commit {
 	      "<td class=\"sha1\">" .
 	      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash), class => "list"}, $co{'tree'}) .
 	      "</td>" .
-	      "<td class=\"link\">" . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash)}, "tree") .
-	      "</td>" .
+	      "<td class=\"link\">" . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash)}, "tree");
+	if ($have_snapshot) {
+	      print " | " .  $cgi->a({-href => href(action=>"snapshot", hash=>$hash)}, "snapshot");
+	}
+	print "</td>" .
 	      "</tr>\n";
 	my $parents = $co{'parents'};
 	foreach my $par (@$parents) {
-- 
1.4.2.rc1.g83e1-dirty


--------------000102020301030406050305--
