From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] gitweb: show rev only on the first line of each group in blame
Date: Tue, 29 Aug 2006 02:06:37 -0700
Message-ID: <7vbqq3oqqq.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0608281016380.27779@g5.osdl.org>
	<11567998513000-git-send-email-jnareb@gmail.com>
	<7vveocpfa3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 11:06:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHzXh-0001hp-PF
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 11:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWH2JFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 05:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWH2JFy
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 05:05:54 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:18130 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751335AbWH2JFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 05:05:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060829090553.UNVM12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Tue, 29 Aug 2006 05:05:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo02.cox.net with bizsmtp
	id Fl5t1V00Q4Noztg0000000
	Tue, 29 Aug 2006 05:05:54 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vveocpfa3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 28 Aug 2006 17:16:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26195>

Thanks to the last round, this is now easy to do.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 gitweb/gitweb.perl |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 28e1cfd..5c82d3f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2174,8 +2174,11 @@ sub flush_blame_lines {
 	my ($color, $file_name, @line) = @_;
 	my $full_rev = shift @line;
 	my $rev = substr($full_rev, 0, 8);
+	my $cnt = scalar @line;
+	my $this = 0;
 
 	for (@line) {
+		$this++;
 		unless (/^[0-9a-fA-F]{40}.*?(\d+)\)\s(.*)/) {
 			print "<tr><td>(malformed blame output)</td></tr>";
 			next;
@@ -2183,11 +2186,19 @@ sub flush_blame_lines {
 		my $lineno = $1;
 		my $data = $2;
 		print "<tr class=\"$color\">\n";
-		print "<td class=\"sha1\">" .
-		$cgi->a({-href => href(action=>"commit",
-				       hash=>$full_rev,
-				       file_name=>$file_name)},
-			esc_html($rev)) . "</td>\n";
+
+		if ($this == 1) {
+			if (1 < $cnt) {
+				print "<td class=\"sha1\" rowspan=\"$cnt\">";
+			}
+			else {
+				print "<td class=\"sha1\">";
+			}
+			print $cgi->a({-href => href(action=>"commit",
+						     hash=>$full_rev,
+						     file_name=>$file_name)},
+				      esc_html($rev)) . "</td>\n";
+		}
 		print +("<td class=\"linenr\">".
 			"<a id=\"l$lineno\" href=\"#l$lineno\" ".
 			"class=\"linenr\">" .
-- 
1.4.2.g39ee
