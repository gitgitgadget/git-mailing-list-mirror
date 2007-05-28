From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] gitweb: handle non UTF-8 text
Date: Mon, 28 May 2007 22:47:34 +0200
Message-ID: <1180385254576-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 22:47:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsm83-0006Pb-VO
	for gcvg-git@gmane.org; Mon, 28 May 2007 22:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbXE1Urk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 16:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbXE1Urk
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 16:47:40 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:38852 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbXE1Urj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 16:47:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 609F17C16A9A;
	Mon, 28 May 2007 22:47:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SZFCdxlURVAv; Mon, 28 May 2007 22:47:34 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id BFC667C16A91; Mon, 28 May 2007 22:47:34 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48642>

gitweb assumes, that everything is in UTF-8. If a text contains invalid
UTF-8 character sequences, the text must be in a different encoding.

This patch interprets such a text as latin1.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
For correct UTF-8, the patch does not change anything.

If commit/blob/... is not in UTF-8, it displays the text
with a very high probability correct. 

As git itself is not aware of any encoding, I know no better
possibility to handle non UTF-8 text in gitweb.

 gitweb/gitweb.perl |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c3921cb..dfd564d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -621,12 +621,19 @@ sub esc_url {
 	return $str;
 }
 
+sub my_decode_utf8 {
+	my $str = shift;
+	my $res;
+	eval { $res = decode_utf8 ($str, 1); };
+	return $res || decode('latin1', $str);
+}
+
 # replace invalid utf8 character with SUBSTITUTION sequence
 sub esc_html ($;%) {
 	my $str = shift;
 	my %opts = @_;
 
-	$str = decode_utf8($str);
+	$str = my_decode_utf8($str);
 	$str = $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
 		$str =~ s/ /&nbsp;/g;
@@ -640,7 +647,7 @@ sub esc_path {
 	my $str = shift;
 	my %opts = @_;
 
-	$str = decode_utf8($str);
+	$str = my_decode_utf8($str);
 	$str = $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
 		$str =~ s/ /&nbsp;/g;
@@ -925,7 +932,7 @@ sub format_subject_html {
 
 	if (length($short) < length($long)) {
 		return $cgi->a({-href => $href, -class => "list subject",
-		                -title => decode_utf8($long)},
+		                -title => my_decode_utf8($long)},
 		       esc_html($short) . $extra);
 	} else {
 		return $cgi->a({-href => $href, -class => "list subject"},
@@ -1239,7 +1246,7 @@ sub git_get_projects_list {
 			if (check_export_ok("$projectroot/$path")) {
 				my $pr = {
 					path => $path,
-					owner => decode_utf8($owner),
+					owner => my_decode_utf8($owner),
 				};
 				push @list, $pr;
 				(my $forks_path = $path) =~ s/\.git$//;
@@ -1269,7 +1276,7 @@ sub git_get_project_owner {
 			$pr = unescape($pr);
 			$ow = unescape($ow);
 			if ($pr eq $project) {
-				$owner = decode_utf8($ow);
+				$owner = my_decode_utf8($ow);
 				last;
 			}
 		}
@@ -1759,7 +1766,7 @@ sub get_file_owner {
 	}
 	my $owner = $gcos;
 	$owner =~ s/[,;].*$//;
-	return decode_utf8($owner);
+	return my_decode_utf8($owner);
 }
 
 ## ......................................................................
@@ -1842,7 +1849,7 @@ sub git_header_html {
 
 	my $title = "$site_name";
 	if (defined $project) {
-		$title .= " - " . decode_utf8($project);
+		$title .= " - " . my_decode_utf8($project);
 		if (defined $action) {
 			$title .= "/$action";
 			if (defined $file_name) {
@@ -2116,7 +2123,7 @@ sub git_print_page_path {
 
 	print "<div class=\"page_path\">";
 	print $cgi->a({-href => href(action=>"tree", hash_base=>$hb),
-	              -title => 'tree root'}, decode_utf8("[$project]"));
+	              -title => 'tree root'}, my_decode_utf8("[$project]"));
 	print " / ";
 	if (defined $name) {
 		my @dirname = split '/', $name;
@@ -2936,7 +2943,7 @@ sub git_project_list_body {
 		($pr->{'age'}, $pr->{'age_string'}) = @aa;
 		if (!defined $pr->{'descr'}) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
-			$pr->{'descr_long'} = decode_utf8($descr);
+			$pr->{'descr_long'} = my_decode_utf8($descr);
 			$pr->{'descr'} = chop_str($descr, 25, 5);
 		}
 		if (!defined $pr->{'owner'}) {
@@ -3981,7 +3988,7 @@ sub git_snapshot {
 	my $git = git_cmd_str();
 	my $name = $project;
 	$name =~ s/\047/\047\\\047\047/g;
-	my $filename = decode_utf8(basename($project));
+	my $filename = my_decode_utf8(basename($project));
 	my $cmd;
 	if ($suffix eq 'zip') {
 		$filename .= "-$hash.$suffix";
-- 
1.5.2.846.g9a144
