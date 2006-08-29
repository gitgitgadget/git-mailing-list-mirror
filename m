From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] gitweb: split output routine of blame2
Date: Tue, 29 Aug 2006 02:06:08 -0700
Message-ID: <7vhczvoqrj.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0608281016380.27779@g5.osdl.org>
	<11567998513000-git-send-email-jnareb@gmail.com>
	<7vveocpfa3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 11:05:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHzXE-0001b2-MN
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 11:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWH2JFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 05:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWH2JFZ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 05:05:25 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:4517 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751332AbWH2JFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 05:05:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060829090524.PPAC12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Tue, 29 Aug 2006 05:05:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo02.cox.net with bizsmtp
	id Fl5Q1V00L4Noztg0000000
	Tue, 29 Aug 2006 05:05:25 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vveocpfa3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 28 Aug 2006 17:16:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26194>

Make the loop over blame output to collect lines belonging to the
same revision, and send it over to the output routine "flush_blame_lines".
This will let me do interesting things later.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 gitweb/gitweb.perl |   73 +++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 555441d..28e1cfd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2170,6 +2170,33 @@ sub git_tag {
 	git_footer_html();
 }
 
+sub flush_blame_lines {
+	my ($color, $file_name, @line) = @_;
+	my $full_rev = shift @line;
+	my $rev = substr($full_rev, 0, 8);
+
+	for (@line) {
+		unless (/^[0-9a-fA-F]{40}.*?(\d+)\)\s(.*)/) {
+			print "<tr><td>(malformed blame output)</td></tr>";
+			next;
+		}
+		my $lineno = $1;
+		my $data = $2;
+		print "<tr class=\"$color\">\n";
+		print "<td class=\"sha1\">" .
+		$cgi->a({-href => href(action=>"commit",
+				       hash=>$full_rev,
+				       file_name=>$file_name)},
+			esc_html($rev)) . "</td>\n";
+		print +("<td class=\"linenr\">".
+			"<a id=\"l$lineno\" href=\"#l$lineno\" ".
+			"class=\"linenr\">" .
+			esc_html($lineno) . "</a></td>\n");
+		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
+		print "</tr>\n";
+	}
+}
+
 sub git_blame2 {
 	my $fd;
 	my $ftype;
@@ -2205,33 +2232,37 @@ sub git_blame2 {
 	my @rev_color = (qw(light2 dark2));
 	my $num_colors = scalar(@rev_color);
 	my $current_color = 0;
-	my $last_rev;
+	my @current_group = ();
 	print <<HTML;
 <div class="page_body">
 <table class="blame">
 <tr><th>Commit</th><th>Line</th><th>Data</th></tr>
 HTML
 	while (<$fd>) {
-		/^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
-		my $full_rev = $1;
-		my $rev = substr($full_rev, 0, 8);
-		my $lineno = $2;
-		my $data = $3;
-
-		if (!defined $last_rev) {
-			$last_rev = $full_rev;
-		} elsif ($last_rev ne $full_rev) {
-			$last_rev = $full_rev;
-			$current_color = ++$current_color % $num_colors;
-		}
-		print "<tr class=\"$rev_color[$current_color]\">\n";
-		print "<td class=\"sha1\">" .
-			$cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
-			        esc_html($rev)) . "</td>\n";
-		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
-		      esc_html($lineno) . "</a></td>\n";
-		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
-		print "</tr>\n";
+		my $full_rev;
+		unless (($full_rev) = /^([0-9a-fA-F]{40})/) {
+			print "<tr><td>(malformed blame output)</td></tr>\n";
+			next;
+		}
+		if (@current_group) {
+			if (($current_group[0] ne $full_rev)) {
+				$current_color = ++$current_color % $num_colors;
+				flush_blame_lines($rev_color[$current_color],
+						  $file_name,
+						  @current_group);
+			}
+			else {
+				push @current_group, $_;
+				next;
+			}
+		}
+		@current_group = ($full_rev, $_);
+	}
+	if (@current_group) {
+		$current_color = ++$current_color % $num_colors;
+		flush_blame_lines($rev_color[$current_color],
+				  $file_name,
+				  @current_group);
 	}
 	print "</table>\n";
 	print "</div>";
-- 
1.4.2.g39ee
