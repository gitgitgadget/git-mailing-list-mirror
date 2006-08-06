From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/6] gitweb: Refactor printing shortened title in git_shortlog_body and git_tags_body
Date: Sun, 6 Aug 2006 02:14:33 +0200
Message-ID: <200608060214.33866.jnareb@gmail.com>
References: <200608060206.49086.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 06 02:16:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9WJs-0003ZT-Fg
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 02:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWHFAQi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 20:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWHFAQi
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 20:16:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:63281 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751451AbWHFAQf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 20:16:35 -0400
Received: by nf-out-0910.google.com with SMTP id p46so40344nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 17:16:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JsQNo+sWp/LTZnTAs1f1yg3NOCbeU0e4xgc8GkmYw4VJUGlaEksWavJSsymrGlOSw1SYpTQKM/KtsokFF8+aNewV9AIm7VHzhxUFyfaKoglRn6Y2/09MGGkB1MJjtva+c4tR9fBxFtd9lFAKwNLT5HeRPz9GPHP/Wof56m+jQEI=
Received: by 10.49.29.2 with SMTP id g2mr636690nfj;
        Sat, 05 Aug 2006 17:16:34 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id r33sm4188262nfc.2006.08.05.17.16.33;
        Sat, 05 Aug 2006 17:16:34 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608060206.49086.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24947>

Uses ugly workaround with $bold argument because style is not set via
CSS, but via presentation element <b>...</b>.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Probably needs better name, too

 gitweb/gitweb.perl |   39 +++++++++++++++++++++++----------------
 1 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f402c8f..7ea52b1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1062,6 +1062,27 @@ sub git_print_page_path {
 }
 
 ## ......................................................................
+## functions printing or outputting HTML: inline elements
+
+# print, perhaps shortened and with markers, title line
+sub print_title_html {
+	# $bold argument is workaround until style will be set via CSS
+	my ($long, $short, $query, $bold, $extra) = @_;
+	$extra = '' unless defined($extra);
+
+	if (length($short) < length($long)) {
+		print $cgi->a({-href => "$my_uri?" . esc_param($query),
+		               -class => "list", -title => $long},
+		      ($bold ? "<b>" : "") . esc_html($short) . $extra . ($bold ? "</b>" : ""));
+	} else {
+		print $cgi->a({-href => "$my_uri?" . esc_param($query),
+		               -class => "list"},
+		      ($bold ? "<b>" : "") . esc_html($long)  . $extra . ($bold ? "</b>" : ""));
+	}
+}
+
+
+## ......................................................................
 ## functions printing large fragments of HTML
 
 sub git_shortlog_body {
@@ -1087,15 +1108,7 @@ sub git_shortlog_body {
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
+		print_title_html($co{'title'}, $co{'title_short'}, "p=$project;a=commit;h=$commit", 1, $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") . " | " .
@@ -1141,13 +1154,7 @@ sub git_tags_body {
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
+			print_title_html($comment, $comment_short, "p=$project;a=tag;h=$tag{'id'}");
 		}
 		print "</td>\n" .
 		      "<td class=\"selflink\">";
-- 
1.4.1.1
