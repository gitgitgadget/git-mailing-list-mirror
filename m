From: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
Subject: [PATCH] gitweb: remove git_blame and rename git_blame2 to git_blame
Date: Fri,  6 Jun 2008 09:53:32 +0200
Message-ID: <1212738812-31277-1-git-send-email-rgarciasuarez@gmail.com>
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 09:54:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Wlu-0006Ng-JE
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 09:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439AbYFFHxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 03:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755393AbYFFHxI
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 03:53:08 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:38590 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754626AbYFFHxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 03:53:07 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 3C6E25FE54;
	Fri,  6 Jun 2008 09:53:04 +0200 (CEST)
Received: from localhost.localdomain (inv75-3-82-241-119-67.fbx.proxad.net [82.241.119.67])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 1F5765FE4B;
	Fri,  6 Jun 2008 09:53:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc1.5.gadf6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84036>

git_blame is dead code. It's possible to plug it in place of
git_blame2, but I don't know whether anyone does still that,
because git_blame2 can now be considered stable enough, I think.

Signed-off-by: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
---
 gitweb/gitweb.perl |  101 +--------------------------------------------------
 1 files changed, 2 insertions(+), 99 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 198772c..8d1f3e0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -539,7 +539,7 @@ $git_dir = "$projectroot/$project" if $project;
 
 # dispatch
 my %actions = (
-	"blame" => \&git_blame2,
+	"blame" => \&git_blame,
 	"blobdiff" => \&git_blobdiff,
 	"blobdiff_plain" => \&git_blobdiff_plain,
 	"blob" => \&git_blob,
@@ -4152,7 +4152,7 @@ sub git_tag {
 	git_footer_html();
 }
 
-sub git_blame2 {
+sub git_blame {
 	my $fd;
 	my $ftype;
 
@@ -4260,103 +4260,6 @@ HTML
 	git_footer_html();
 }
 
-sub git_blame {
-	my $fd;
-
-	my ($have_blame) = gitweb_check_feature('blame');
-	if (!$have_blame) {
-		die_error('403 Permission denied', "Permission denied");
-	}
-	die_error('404 Not Found', "File name not defined") if (!$file_name);
-	$hash_base ||= git_get_head_hash($project);
-	die_error(undef, "Couldn't find base commit") unless ($hash_base);
-	my %co = parse_commit($hash_base)
-		or die_error(undef, "Reading commit failed");
-	if (!defined $hash) {
-		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
-			or die_error(undef, "Error lookup file");
-	}
-	open ($fd, "-|", git_cmd(), "annotate", '-l', '-t', '-r', $file_name, $hash_base)
-		or die_error(undef, "Open git-annotate failed");
-	git_header_html();
-	my $formats_nav =
-		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
-		        "blob") .
-		" | " .
-		$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
-			"history") .
-		" | " .
-		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
-		        "HEAD");
-	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
-	git_print_page_path($file_name, 'blob', $hash_base);
-	print "<div class=\"page_body\">\n";
-	print <<HTML;
-<table class="blame">
-  <tr>
-    <th>Commit</th>
-    <th>Age</th>
-    <th>Author</th>
-    <th>Line</th>
-    <th>Data</th>
-  </tr>
-HTML
-	my @line_class = (qw(light dark));
-	my $line_class_len = scalar (@line_class);
-	my $line_class_num = $#line_class;
-	while (my $line = <$fd>) {
-		my $long_rev;
-		my $short_rev;
-		my $author;
-		my $time;
-		my $lineno;
-		my $data;
-		my $age;
-		my $age_str;
-		my $age_class;
-
-		chomp $line;
-		$line_class_num = ($line_class_num + 1) % $line_class_len;
-
-		if ($line =~ m/^([0-9a-fA-F]{40})\t\(\s*([^\t]+)\t(\d+) [+-]\d\d\d\d\t(\d+)\)(.*)$/) {
-			$long_rev = $1;
-			$author   = $2;
-			$time     = $3;
-			$lineno   = $4;
-			$data     = $5;
-		} else {
-			print qq(  <tr><td colspan="5" class="error">Unable to parse: $line</td></tr>\n);
-			next;
-		}
-		$short_rev  = substr ($long_rev, 0, 8);
-		$age        = time () - $time;
-		$age_str    = age_string ($age);
-		$age_str    =~ s/ /&nbsp;/g;
-		$age_class  = age_class($age);
-		$author     = esc_html ($author);
-		$author     =~ s/ /&nbsp;/g;
-
-		$data = untabify($data);
-		$data = esc_html ($data);
-
-		print <<HTML;
-  <tr class="$line_class[$line_class_num]">
-    <td class="sha1"><a href="${\href (action=>"commit", hash=>$long_rev)}" class="text">$short_rev..</a></td>
-    <td class="$age_class">$age_str</td>
-    <td>$author</td>
-    <td class="linenr"><a id="$lineno" href="#$lineno" class="linenr">$lineno</a></td>
-    <td class="pre">$data</td>
-  </tr>
-HTML
-	} # while (my $line = <$fd>)
-	print "</table>\n\n";
-	close $fd
-		or print "Reading blob failed.\n";
-	print "</div>";
-	git_footer_html();
-}
-
 sub git_tags {
 	my $head = git_get_head_hash($project);
 	git_header_html();
-- 
1.5.6.rc1.5.gadf6
