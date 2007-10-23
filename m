From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH 1/2] gitweb: Refactor abbreviation-with-title-attribute code.
Date: Tue, 23 Oct 2007 11:31:22 +1000
Message-ID: <1193103083390-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org, David Symonds <dsymonds@gmail.com>
To: pasky@suse.cz, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Oct 23 03:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik8d9-0006Qs-7X
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 03:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbXJWBcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 21:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbXJWBcM
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 21:32:12 -0400
Received: from ipmail03.adl2.internode.on.net ([203.16.214.135]:49477 "EHLO
	ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751402AbXJWBcK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 21:32:10 -0400
X-IronPort-AV: E=Sophos;i="4.21,314,1188743400"; 
   d="scan'208";a="172497340"
Received: from ppp121-44-32-71.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.32.71])
  by ipmail03.adl2.internode.on.net with ESMTP; 23 Oct 2007 11:01:28 +0930
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62070>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 gitweb/gitweb.perl |   45 +++++++++++++++++++++------------------------
 1 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ea84c75..a835bd1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -842,6 +842,23 @@ sub chop_str {
 	return "$body$tail";
 }
 
+# takes the same arguments as chop_str, but also wraps a <span> around the
+# result with a title attribute if it does get chopped. Additionally, the
+# string is HTML-escaped.
+sub chop_and_escape_str {
+	my $str = shift;
+	my $len = shift;
+	my $add_len = shift || 10;
+
+	my $chopped = chop_str($str, $len, $add_len);
+	if ($chopped eq $str) {
+		return esc_html($chopped);
+	} else {
+		return qq{<span title="} . esc_html($str) . qq{">} .
+			esc_html($chopped) . qq{</span>};
+	}
+}
+
 ## ----------------------------------------------------------------------
 ## functions returning short strings
 
@@ -3427,12 +3444,7 @@ sub git_shortlog_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		my $author = chop_str($co{'author_name'}, 10);
-		if ($author ne $co{'author_name'}) {
-			$author = "<span title=\"" . esc_html($co{'author_name'}) . "\">" . esc_html($author) . "</span>";
-		} else {
-			$author = esc_html($author);
-		}
+		my $author = chop_and_escape_str($co{'author_name'}, 10);
 		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 		      "<td><i>" . $author . "</i></td>\n" .
@@ -3484,12 +3496,7 @@ sub git_history_body {
 		}
 		$alternate ^= 1;
 	# shortlog uses      chop_str($co{'author_name'}, 10)
-		my $author = chop_str($co{'author_name'}, 15, 3);
-		if ($author ne $co{'author_name'}) {
-			"<span title=\"" . esc_html($co{'author_name'}) . "\">" . esc_html($author) . "</span>";
-		} else {
-			$author = esc_html($author);
-		}
+		my $author = chop_and_escape_str($co{'author_name'}, 15, 3);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 		      "<td><i>" . $author . "</i></td>\n" .
 		      "<td>";
@@ -3645,12 +3652,7 @@ sub git_search_grep_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		my $author = chop_str($co{'author_name'}, 15, 5);
-		if ($author ne $co{'author_name'}) {
-			$author = "<span title=\"" . esc_html($co{'author_name'}) . "\">" . esc_html($author) . "</span>";
-		} else {
-			$author = esc_html($author);
-		}
+		my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 		      "<td><i>" . $author . "</i></td>\n" .
 		      "<td>" .
@@ -5165,12 +5167,7 @@ sub git_search {
 						print "<tr class=\"light\">\n";
 					}
 					$alternate ^= 1;
-					my $author = chop_str($co{'author_name'}, 15, 5);
-					if ($author ne $co{'author_name'}) {
-						$author = "<span title=\"" . esc_html($co{'author_name'}) . "\">" . esc_html($author) . "</span>";
-					} else {
-						$author = esc_html($author);
-					}
+					my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
 					print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 					      "<td><i>" . $author . "</i></td>\n" .
 					      "<td>" .
-- 
1.5.3.1
