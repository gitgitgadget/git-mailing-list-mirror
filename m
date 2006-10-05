From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 6/6] gitweb: use blame --porcelain
Date: Thu, 05 Oct 2006 14:07:58 -0700
Message-ID: <7vwt7ebhe9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 05 23:09:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVaRr-0008WO-CP
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 23:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWJEVIB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 17:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWJEVIB
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 17:08:01 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34258 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751361AbWJEVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 17:07:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005210759.ZXOE13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 17:07:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wl811V0081kojtg0000000
	Thu, 05 Oct 2006 17:08:01 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28369>

This makes gitweb (git_blame2) to use "blame --porcelain", which
lets the caller to figure out which line in the original version
each line comes from.  Using this information, change the
behaviour of clicking the line number to go to the line of the
blame output for the original commit.

Before, clicking the line number meant "scoll up to show this
line at the beginning of the page", which was not all that
useful.  The new behaviour lets you click on the line you are
interested in to view the line in the context it was introduced,
and keep digging deeper as you examine it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I've tested this only very lightly but it seems to be quite
   pleasant to use.

 gitweb/gitweb.perl |   65 +++++++++++++++++++++++++++++++++++----------------
 1 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d217187..29a56c3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -971,6 +971,9 @@ sub parse_date {
 	$date{'hour_local'} = $hour;
 	$date{'minute_local'} = $min;
 	$date{'tz_local'} = $tz;
+	$date{'iso-tz'} = sprintf ("%04d-%02d-%02d %02d:%02d:%02d %s",
+				   1900+$year, $mon+1, $mday,
+				   $hour, $min, $sec, $tz);
 	return %date;
 }
 
@@ -2496,7 +2499,8 @@ sub git_blame2 {
 	if ($ftype !~ "blob") {
 		die_error("400 Bad Request", "Object is not a blob");
 	}
-	open ($fd, "-|", git_cmd(), "blame", '-l', '--', $file_name, $hash_base)
+	open ($fd, "-|", git_cmd(), "blame", '--porcelain', '--',
+	      $file_name, $hash_base)
 		or die_error(undef, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
@@ -2520,33 +2524,52 @@ sub git_blame2 {
 <table class="blame">
 <tr><th>Commit</th><th>Line</th><th>Data</th></tr>
 HTML
-	while (<$fd>) {
-		my ($full_rev, $author, $date, $lineno, $data) =
-			/^([0-9a-f]{40}).*?\s\((.*?)\s+([-\d]+ [:\d]+ [-+\d]+)\s+(\d+)\)\s(.*)/;
+	my %metainfo = ();
+	while (1) {
+		$_ = <$fd>;
+		last unless defined $_;
+		my ($full_rev, $lineno, $orig_lineno, $group_size) =
+		    /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/;
+		if (!exists $metainfo{$full_rev}) {
+			$metainfo{$full_rev} = {};
+		}
+		my $meta = $metainfo{$full_rev};
+		while (<$fd>) {
+			last if (s/^\t//);
+			if (/^(\S+) (.*)$/) {
+				$meta->{$1} = $2;
+			}
+		}
+		my $data = $_;
 		my $rev = substr($full_rev, 0, 8);
-		my $print_c8 = 0;
-
-		if (!defined $last_rev) {
-			$last_rev = $full_rev;
-			$print_c8 = 1;
-		} elsif ($last_rev ne $full_rev) {
-			$last_rev = $full_rev;
+		my $author = $meta->{'author'};
+		my %date = parse_date($meta->{'author-time'},
+				      $meta->{'author-tz'});
+		my $date = $date{'iso-tz'};
+		if ($group_size) {
 			$current_color = ++$current_color % $num_colors;
-			$print_c8 = 1;
 		}
 		print "<tr class=\"$rev_color[$current_color]\">\n";
-		print "<td class=\"sha1\"";
-		if ($print_c8 == 1) {
+		if ($group_size) {
+			print "<td class=\"sha1\"";
 			print " title=\"$author, $date\"";
-		}
-		print ">";
-		if ($print_c8 == 1) {
-			print $cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
+			print " rowspan=\"$group_size\"" if ($group_size > 1);
+			print ">";
+			print $cgi->a({-href => href(action=>"commit",
+						     hash=>$full_rev,
+						     file_name=>$file_name)},
 				      esc_html($rev));
+			print "</td>\n";
 		}
-		print "</td>\n";
-		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
-		      esc_html($lineno) . "</a></td>\n";
+		my $blamed = href(action => 'blame',
+				  file_name => $meta->{'filename'},
+				  hash_base => $full_rev);
+		print "<td class=\"linenr\">";
+		print $cgi->a({ -href => "$blamed#l$lineno",
+				-id => "l$lineno",
+				-class => "linenr" },
+			      esc_html($lineno));
+		print "</td>";
 		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
 		print "</tr>\n";
 	}
-- 
1.4.2.3.g866f3
