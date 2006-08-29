From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] gitweb: show age and author in blame output
Date: Tue, 29 Aug 2006 02:07:03 -0700
Message-ID: <7v64gboqq0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 11:06:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHzY6-0001lH-S3
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 11:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWH2JGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 05:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWH2JGT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 05:06:19 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:11429 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751317AbWH2JGT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 05:06:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060829090618.PPKO12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Tue, 29 Aug 2006 05:06:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo02.cox.net with bizsmtp
	id Fl6K1V0034Noztg0000000
	Tue, 29 Aug 2006 05:06:19 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26196>

The commit object name link on each link uses "title", which
shows the author and age of the particular line when hovered
over.

The background of these links are painted on darker color as
they become older and the links on younger lines are shown on
lighter background.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 gitweb/gitweb.css  |    6 ++++++
 gitweb/gitweb.perl |   27 +++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index eb9fc38..f3211c2 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -215,6 +215,12 @@ td.sha1 {
 	font-family: monospace;
 }
 
+table.blame td.age-week   { color: #0000ff; background-color: #ffffff; }
+table.blame td.age-month  { color: #0000ff; background-color: #ddddee; }
+table.blame td.age-season { color: #0000ff; background-color: #bbbbdd; }
+table.blame td.age-year   { color: #0000ff; background-color: #9999cc; }
+table.blame td.age-old    { color: #0000ff; background-color: #7777bb; }
+
 td.error {
 	color: red;
 	background-color: yellow;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5c82d3f..0265a82 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2171,12 +2171,26 @@ sub git_tag {
 }
 
 sub flush_blame_lines {
-	my ($color, $file_name, @line) = @_;
+	my ($color, $file_name, $now, @line) = @_;
 	my $full_rev = shift @line;
+
+	my ($author, $timestamp, $zone) =
+	    ($line[0] =~
+	     /^[0-9a-f]{40}\s\((.*?)\s+(\d+)\s([-+\d]{5})\s+\d+\)/);
+	my $age = $now - $timestamp;
+	my $ago = age_string($age);
+	my $pop = 'title="' . esc_html("$author, $ago") . '"';
+	my $agegroup =
+	    (($age < 60*60*24*7) ? "age-week" :
+	     ($age < 60*60*24*30) ? "age-month" :
+	     ($age < 60*60*24*120) ? "age-season" :
+	     ($age < 60*60*24*360) ? "age-year" : "age-old");
+
 	my $rev = substr($full_rev, 0, 8);
 	my $cnt = scalar @line;
 	my $this = 0;
 
+
 	for (@line) {
 		$this++;
 		unless (/^[0-9a-fA-F]{40}.*?(\d+)\)\s(.*)/) {
@@ -2188,11 +2202,12 @@ sub flush_blame_lines {
 		print "<tr class=\"$color\">\n";
 
 		if ($this == 1) {
+			my $cls = "class=\"sha1 $agegroup\"";
 			if (1 < $cnt) {
-				print "<td class=\"sha1\" rowspan=\"$cnt\">";
+				print "<td $cls $pop rowspan=\"$cnt\">";
 			}
 			else {
-				print "<td class=\"sha1\">";
+				print "<td $cls $pop>";
 			}
 			print $cgi->a({-href => href(action=>"commit",
 						     hash=>$full_rev,
@@ -2228,7 +2243,8 @@ sub git_blame2 {
 	if ($ftype !~ "blob") {
 		die_error("400 Bad Request", "Object is not a blob");
 	}
-	open ($fd, "-|", git_cmd(), "blame", '-l', $file_name, $hash_base)
+	open ($fd, "-|", git_cmd(), "blame", '-l', '-t',
+	      $file_name, $hash_base)
 		or die_error(undef, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
@@ -2242,6 +2258,7 @@ sub git_blame2 {
 	git_print_page_path($file_name, $ftype, $hash_base);
 	my @rev_color = (qw(light2 dark2));
 	my $num_colors = scalar(@rev_color);
+	my $now = time();
 	my $current_color = 0;
 	my @current_group = ();
 	print <<HTML;
@@ -2260,6 +2277,7 @@ HTML
 				$current_color = ++$current_color % $num_colors;
 				flush_blame_lines($rev_color[$current_color],
 						  $file_name,
+						  $now,
 						  @current_group);
 			}
 			else {
@@ -2273,6 +2291,7 @@ HTML
 		$current_color = ++$current_color % $num_colors;
 		flush_blame_lines($rev_color[$current_color],
 				  $file_name,
+				  $now,
 				  @current_group);
 	}
 	print "</table>\n";
-- 
1.4.2.g39ee
