From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add title attribute with full first line of tag comment if it is needed
Date: Thu, 22 Jun 2006 00:42:22 +0200
Message-ID: <11509297422173-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 22 00:42:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtBP7-0001an-Vo
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 00:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWFUWm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 18:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWFUWm2
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 18:42:28 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:34460 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1751215AbWFUWm1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 18:42:27 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5LMg1em024696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 22 Jun 2006 00:42:01 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5LMgMRc028069;
	Thu, 22 Jun 2006 00:42:22 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5LMgMFW028068;
	Thu, 22 Jun 2006 00:42:22 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22288>

For commits in oneline view (summary, shortlog, history) commit title
(first line of commit message) is link to commit itself. If commit title
(commit description) is shortened in output, hyperlink has title attribute
with full title.

This commit does the same also for tags. It is much more rare to have long
tag description, though.

Misfeature: sometimes tag link has title attribute even if tag description
doesn't seem to be shortened.

Needs refactoring (twice done almost exactly the same, four times similar
code is used).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>

---

 gitweb/gitweb.cgi |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

e41a09e140c1ecd933ae90e7b55660d67f33dc1b
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index e044c61..8f8ae4a 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -326,7 +326,7 @@ EOF
 		} elsif (defined $hash) {
 			$search_hash = $hash;
 		} else {
-			$search_hash  = "HEAD";
+			$search_hash = "HEAD";
 		}
 		$cgi->param("a", "search");
 		$cgi->param("h", $search_hash);
@@ -1107,7 +1107,8 @@ sub git_summary {
 		foreach my $entry (@$taglist) {
 			my %tag = %$entry;
 			my $comment_lines = $tag{'comment'};
-			my $comment = shift @$comment_lines;
+			my $comment_long = shift @$comment_lines;
+			my $comment = $comment_long;
 			if (defined($comment)) {
 				$comment = chop_str($comment, 30, 5);
 			}
@@ -1119,13 +1120,17 @@ sub git_summary {
 			$alternate ^= 1;
 			if ($i-- > 0) {
 				print "<td><i>$tag{'age'}</i></td>\n" .
-				      "<td>" .
+				      "<td>";
 				      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}"), -class => "list"},
 				      "<b>" . esc_html($tag{'name'}) . "</b>") .
 				      "</td>\n" .
 				      "<td>";
 				if (defined($comment)) {
-				      print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, $comment);
+					if (length($comment) < length($comment_long)) {
+						print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}"), -title => "$comment_long"}, $comment);
+					} else {
+						print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, $comment);
+					}
 				}
 				print "</td>\n" .
 				      "<td class=\"link\">";
@@ -1346,7 +1351,8 @@ sub git_tags {
 		foreach my $entry (@$taglist) {
 			my %tag = %$entry;
 			my $comment_lines = $tag{'comment'};
-			my $comment = shift @$comment_lines;
+			my $comment_long = shift @$comment_lines;
+			my $comment = $comment_long;
 			if (defined($comment)) {
 				$comment = chop_str($comment, 30, 5);
 			}
@@ -1363,7 +1369,11 @@ sub git_tags {
 			      "</td>\n" .
 			      "<td>";
 			if (defined($comment)) {
-			      print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, $comment);
+				if (length($comment) < length($comment_long)) {
+					print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}"), -title => "$comment_long"}, $comment);
+				} else {
+					print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, $comment);
+				}
 			}
 			print "</td>\n" .
 			      "<td class=\"link\">";
-- 
1.3.0
