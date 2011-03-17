From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 3/3] gitweb: show alternate author/committer times
Date: Thu, 17 Mar 2011 12:38:31 -0700
Message-ID: <64c70e95e767572e5be732dc7e17815b@localhost>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:47:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0JAW-0004Bj-R9
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044Ab1CQTrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:47:23 -0400
Received: from [69.28.251.93] ([69.28.251.93]:42702 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754935Ab1CQTrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:47:21 -0400
Received: (qmail 13594 invoked from network); 17 Mar 2011 19:47:19 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 17 Mar 2011 19:47:19 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 17 Mar 2011 12:47:19 -0700
In-Reply-To: <c8621826e0576e3e31240b0205e7e3d0@localhost>
User-Agent: vim 7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169266>

On the commit/commitdiff views, show the author/committer times as
follows:

If $feature{'localtime'} is disabled, display the RFC 2822 date/time in
GMT, then print (HH:MM -TZ) in the author's/committer's local timezone.
(i.e. no change to the current behavior)

If $feature{'localtime'} is enabled, display the RFC 2822 date/time in
the author's/committer's local timezone, then print (HH:MM +0000) in GMT.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 gitweb/gitweb.perl |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 578edc0..6b8f9a7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3953,22 +3953,27 @@ sub git_print_section {
 	print $cgi->end_div;
 }
 
-sub print_local_time {
-	print format_local_time(@_);
-}
-
-sub format_local_time {
+# If localtime is disabled, show the server's local time in parentheses.
+# If localtime is enabled, show GMT in parentheses.
+sub print_alt_time {
 	my $localtime = '';
 	my %date = @_;
+	my ($h, $m, $tz) = ($date{'hour_local'}, $date{'minute_local'},
+		$date{'tz_local'});
+
+	if (gitweb_check_feature('localtime')) {
+		($h, $m, $tz) = ($date{'hour'}, $date{'minute'}, "+0000");
+	}
+
 	if ($date{'hour_local'} < 6) {
 		$localtime .= sprintf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
-			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
+			$h, $m, $tz);
 	} else {
 		$localtime .= sprintf(" (%02d:%02d %s)",
-			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
+			$h, $m, $tz);
 	}
 
-	return $localtime;
+	print $localtime;
 }
 
 # Outputs the author name and date in long form
@@ -3982,7 +3987,6 @@ sub git_print_authorship {
 	print "<$tag class=\"author_date\">" .
 	      format_search_author($author, "author", esc_html($author)) .
 	      " [$ad{'rfc2822'}";
-	print_local_time(%ad) if ($opts{-localtime});
 	print "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
 		  . "</$tag>\n";
 }
@@ -4009,7 +4013,7 @@ sub git_print_authorship_rows {
 		      "</td></tr>\n" .
 		      "<tr>" .
 		      "<td></td><td> $wd{'rfc2822'}";
-		print_local_time(%wd) if !gitweb_check_feature('localtime');
+		print_alt_time(%wd);
 		print "</td>" .
 		      "</tr>\n";
 	}
-- 
1.7.4.1
