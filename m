From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH/RFC 3/3] gitweb: change highlighting of "atnight" commits
Date: Sat, 19 Mar 2011 13:48:27 -0700
Message-ID: <e420df635f1146388df59a27bdc6e68b@localhost>
References: <4f21902cf5f72b30a96465cf911d13aa@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 21:55:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q13Ar-00074O-2C
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 21:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757562Ab1CSUy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 16:54:58 -0400
Received: from [69.28.251.93] ([69.28.251.93]:33196 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757476Ab1CSUy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 16:54:56 -0400
Received: (qmail 3856 invoked from network); 19 Mar 2011 20:54:55 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 19 Mar 2011 20:54:55 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 19 Mar 2011 13:54:54 -0700
In-Reply-To: <4f21902cf5f72b30a96465cf911d13aa@localhost>
User-Agent: vim 7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169462>

The current behavior is to show the timestamp for "atnight" commits
(commits for which the local time is between 00:00 and 05:59,
inclusive) in red, on the commit and commitdiff views.  On the
log view, the timestamps are shown normally.

Swap this behavior so that the commit and commitdiff views do
not color these timestamps red, but the log view does.  This allows
late-night commits to be easily identified (and possibly subjected to
extra scrutiny) when reading through the change log.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---

Personally, I am not too concerned with the "atnight" behavior because
only a minuscule percentage of our commits happen late at night.  But
since we're touching this code, we might as well tweak anything in there
that needs tweaking.

 gitweb/gitweb.perl |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index aa038bd..2d4349f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3946,17 +3946,17 @@ sub git_print_section {
 }
 
 # Returns a timestamp string, which may contain HTML.
-# If $commit_view is 0, the string looks like:
+# If -commit_view is not specified, the string looks like:
 #   Fri, 18 Mar 2011 01:28:57 +0000                [localtime disabled]
 #   Thu, 17 Mar 2011 18:28:57 -0700                [localtime enabled]
-# If $commit_view is 1, the string looks like:
+# If -commit_view is specified, the string looks like:
 #   Fri, 18 Mar 2011 01:28:57 +0000 (18:28 -0700)  [localtime disabled]
 #   Thu, 17 Mar 2011 18:28:57 -0700 (01:28 +0000)  [localtime enabled]
-# If $commit_view is 1, the entire string will use the "atnight" class
+# If -atnight is specified, the entire string will use the "atnight" class
 # (red text) if the local time is between 00:00 and 05:59 inclusive.
 # This helps to flag commits made in the wee hours of the morning.
 sub timestamp_html {
-	my ($date, $commit_view) = @_;
+	my ($date, %opts) = @_;
 	my $timestamp;
 	my $alt_time;
 
@@ -3973,13 +3973,13 @@ sub timestamp_html {
 		                    $date->{'minute_local'},
 		                    $date->{'tz_local'});
 	}
-	if ($commit_view) {
+	if ($opts{-commit_view}) {
 		$timestamp .= $alt_time;
-		if ($date->{'hour_local'} < 6) {
-			$timestamp = "<span class=\"atnight\">" .
-			             $timestamp .
-			             "</span>";
-		}
+	}
+	if ($opts{-atnight} && $date->{'hour_local'} < 6) {
+		$timestamp = "<span class=\"atnight\">" .
+			     $timestamp .
+			     "</span>";
 	}
 	return $timestamp;
 }
@@ -3994,7 +3994,7 @@ sub git_print_authorship {
 	my %ad = format_date($co->{'author_epoch'}, $co->{'author_tz'});
 	print "<$tag class=\"author_date\">" .
 	      format_search_author($author, "author", esc_html($author)) .
-	      " [" . timestamp_html(\%ad, 0) . "] ".
+	      " [" . timestamp_html(\%ad, -atnight => 1) . "] ".
 	      git_get_avatar($co->{'author_email'}, -pad_before => 1) .
 	      "</$tag>\n";
 }
@@ -4021,7 +4021,7 @@ sub git_print_authorship_rows {
 		      "</td></tr>\n" .
 		      "<tr>" .
 		      "<td></td><td> " .
-		      timestamp_html(\%wd, 1) .
+		      timestamp_html(\%wd, -commit_view => 1) .
 		      "</td>" .
 		      "</tr>\n";
 	}
@@ -5434,7 +5434,7 @@ sub git_summary {
 	      "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
 	if (keys %cd) {
 		print "<tr id=\"metadata_lchange\"><td>last change</td><td>" .
-		      timestamp_html(\%cd, 0) . "</td></tr>\n";
+		      timestamp_html(\%cd) . "</td></tr>\n";
 	}
 
 	# use per project git URL list in $projectroot/$project/cloneurl
-- 
1.7.4.1
