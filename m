From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/9] gitweb: Refactor printing shortened title in git_shortlog_body and git_tags_body
Date: Mon, 14 Aug 2006 02:08:27 +0200
Message-ID: <200608140208.27246.jnareb@gmail.com>
References: <200608140202.46160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:16:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZV9-0001tP-2C
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbWHNKQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbWHNKQk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:16:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:24460 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751975AbWHNKQi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 06:16:38 -0400
Received: by nf-out-0910.google.com with SMTP id a4so20978nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 03:16:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=r74KInb7bmFBGpcb0nQ4HVE/VoK3KaRptkdIBKDhJ5jWxf9RoY0H1y1/RKZD21Wlxl/7DSTxbez+XRqIlzUl1KCHHESyHpC2f6NNwq5tv18mYvi4FiSo/YiHtKOC2lkrPwSFMD5MjSTIibNay04KQBQUe46g6nwefb3oDRuIRSo=
Received: by 10.48.48.18 with SMTP id v18mr6800650nfv;
        Mon, 14 Aug 2006 03:16:38 -0700 (PDT)
Received: from host-81-190-23-158.torun.mm.pl ( [81.190.23.158])
        by mx.gmail.com with ESMTP id m16sm9637471nfc.2006.08.14.03.16.37;
        Mon, 14 Aug 2006 03:16:37 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608140202.46160.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25337>

Separate printing of perhaps shortened title (subject) in
git_shortlog_body and git_tags_body into format_subject_html.

While at it, remove presentation element <b>...</b> used to format
title (subject) and move formatting to CSS.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
CSS is used in such a way as to not change output

 gitweb/gitweb.css  |    5 +++++
 gitweb/gitweb.perl |   34 ++++++++++++++++++----------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 47c1ade..f58a418 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -117,9 +117,14 @@ div.list_head {
 
 a.list {
 	text-decoration: none;
+	font-weight: bold;
 	color: #000000;
 }
 
+table.tags a.list {
+	font-weight: normal;
+}
+
 a.list:hover {
 	text-decoration: underline;
 	color: #880000;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0c4ec92..c4d6eab 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -372,6 +372,22 @@ sub format_ref_marker {
 	}
 }
 
+# format, perhaps shortened and with markers, title line
+sub format_subject_html {
+	my ($long, $short, $query, $extra) = @_;
+	$extra = '' unless defined($extra);
+
+	if (length($short) < length($long)) {
+		return $cgi->a({-href => "$my_uri?" . esc_param($query),
+		               -class => "list", -title => $long},
+		       esc_html($short) . $extra);
+	} else {
+		return $cgi->a({-href => "$my_uri?" . esc_param($query),
+		               -class => "list"},
+		       esc_html($long)  . $extra);
+	}
+}
+
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
@@ -1085,15 +1101,7 @@ sub git_shortlog_body {
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
 		      "<td>";
-		if (length($co{'title_short'}) < length($co{'title'})) {
-			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"),
-			               -class => "list", -title => "$co{'title'}"},
-			      "<b>" . esc_html($co{'title_short'}) . "$ref</b>");
-		} else {
-			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"),
-			               -class => "list"},
-			      "<b>" . esc_html($co{'title'}) . "$ref</b>");
-		}
+		print format_subject_html($co{'title'}, $co{'title_short'}, "p=$project;a=commit;h=$commit", $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") . " | " .
@@ -1139,13 +1147,7 @@ sub git_tags_body {
 		      "</td>\n" .
 		      "<td>";
 		if (defined $comment) {
-			if (length($comment_short) < length($comment)) {
-				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}"),
-				               -class => "list", -title => $comment}, $comment_short);
-			} else {
-				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}"),
-				               -class => "list"}, $comment);
-			}
+			print format_subject_html($comment, $comment_short, "p=$project;a=tag;h=$tag{'id'}");
 		}
 		print "</td>\n" .
 		      "<td class=\"selflink\">";
-- 
1.4.1.1
