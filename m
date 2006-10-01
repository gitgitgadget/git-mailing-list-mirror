From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Sun, 01 Oct 2006 02:19:44 -0700
Message-ID: <7vwt7k4clr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 01 11:19:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTxUE-00044F-Ji
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 11:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWJAJTr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 05:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWJAJTr
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 05:19:47 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:29174 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750744AbWJAJTq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 05:19:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061001091945.MOHY6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Sun, 1 Oct 2006 05:19:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UxKn1V00N1kojtg0000000
	Sun, 01 Oct 2006 05:19:48 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28173>

Instead of labelling each and every line with clickable commit
object name, this makes the blame output to show them only on
the first line of each group of lines from the same revision.

Also it makes mouse-over to show the minimum authorship and
authordate information for extra cuteness ;-).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I've been staying away from the party to paint the bikeshed,
   but I had a bit of time to kill tonight.  Let's see if people
   might like this...

 gitweb/gitweb.perl |   67 +++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 44991b1..7e4ec8d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2429,6 +2429,41 @@ sub git_tag {
 	git_footer_html();
 }
 
+sub git_blame_flush_chunk {
+	my ($name, $revdata, $color, $rev, @line) = @_;
+	my $label = substr($rev, 0, 8);
+	my $line = scalar(@line);
+	my $cnt = 0;
+	my $pop = '';
+
+	if ($revdata->{$rev} ne '') {
+		$pop = ' title="' . esc_html($revdata->{$rev}) . '"';
+	}
+
+	for (@line) {
+		my ($lineno, $data) = @$_;
+		$cnt++;
+		print "<tr class=\"$color\">\n";
+		if ($cnt == 1) {
+			print "<td class=\"sha1\"$pop";
+			if ($line > 1) {
+				print " rowspan=\"$line\"";
+			}
+			print ">";
+			print $cgi->a({-href => href(action=>"commit",
+						     hash=>$rev,
+						     file_name=>$name)},
+				      $label);
+			print "</td>\n";
+		}
+		print "<td class=\"linenr\">".
+		    "<a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
+		    esc_html($lineno) . "</a></td>\n";
+		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
+		print "</tr>\n";
+	}
+}
+
 sub git_blame2 {
 	my $fd;
 	my $ftype;
@@ -2474,27 +2509,33 @@ sub git_blame2 {
 <table class="blame">
 <tr><th>Commit</th><th>Line</th><th>Data</th></tr>
 HTML
+	my @chunk = ();
+	my %revdata = ();
 	while (<$fd>) {
 		/^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
-		my $full_rev = $1;
-		my $rev = substr($full_rev, 0, 8);
-		my $lineno = $2;
-		my $data = $3;
-
+		my ($full_rev, $author, $date, $lineno, $data) =
+		    /^([0-9a-f]{40}).*?\s\((.*?)\s+([-\d]+ [:\d]+ [-+\d]+)\s+(\d+)\)\s(.*)/;
+		if (!exists $revdata{$full_rev}) {
+			$revdata{$full_rev} = "$author, $date";
+		}
 		if (!defined $last_rev) {
 			$last_rev = $full_rev;
 		} elsif ($last_rev ne $full_rev) {
+			git_blame_flush_chunk($file_name,
+					      \%revdata,
+					      $rev_color[$current_color],
+					      $last_rev, @chunk);
+			@chunk = ();
 			$last_rev = $full_rev;
 			$current_color = ++$current_color % $num_colors;
 		}
-		print "<tr class=\"$rev_color[$current_color]\">\n";
-		print "<td class=\"sha1\">" .
-			$cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
-			        esc_html($rev)) . "</td>\n";
-		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
-		      esc_html($lineno) . "</a></td>\n";
-		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
-		print "</tr>\n";
+		push @chunk, [$lineno, $data];
+	}
+	if (@chunk) {
+		git_blame_flush_chunk($file_name,
+				      \%revdata,
+				      $rev_color[$current_color],
+				      $last_rev, @chunk);
 	}
 	print "</table>\n";
 	print "</div>";
-- 
1.4.2.1.gc9fffe
