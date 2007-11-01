From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Use href(-replay=>1, page=>...) to generate pagination links
Date: Thu,  1 Nov 2007 13:06:28 +0100
Message-ID: <1193918789-16421-4-git-send-email-jnareb@gmail.com>
References: <1193918789-16421-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 13:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYml-0008UE-V4
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 13:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064AbXKAMEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 08:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbXKAMEK
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 08:04:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:34272 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064AbXKAMEC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 08:04:02 -0400
Received: by ug-out-1314.google.com with SMTP id z38so453895ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=00GzFhzg8sRdDYPBGJk8ck2W7v4k8q4YZt2MwN22dDU=;
        b=AoWPscXmAFfHaeCVH/UYHYHbB5ruNX48EQM7GFyQtbVTAabLb18BVys64tDu9sMz5fzpA/rTuZz5jAhR7OwiX5nN2xlE0S8QDe6drTDem+0xxP7xemNo43RUwbKP3wqWB37BA+XY72IC2/ceReTWqSa71tUGe7fn6I8JYgQ95Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BcRIf3B7kxNtxL0sZPoJkg/zEuZ3npLk0o8v6zpY9pFgDlflyedF9wTR7i3/PRudybgAFfEgVX8OBz+GyGFiOOxak/8zORmuF2KwCNLPtNGbd6yB1ncFg58u56HG6yAj9Y8JetG019EotucbrHjhr7AUybbsuVESFpDz8deQ/KY=
Received: by 10.67.92.20 with SMTP id u20mr160093ugl.1193918640605;
        Thu, 01 Nov 2007 05:04:00 -0700 (PDT)
Received: from roke.D-201 ( [83.8.199.125])
        by mx.google.com with ESMTPS id 30sm5782634ugf.2007.11.01.05.03.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 05:03:59 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA1C6Wsi016538;
	Thu, 1 Nov 2007 13:06:32 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA1C6WTE016537;
	Thu, 1 Nov 2007 13:06:32 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1193918789-16421-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62944>

Use href(-replay=>1, page=>$page-1) and href(-replay=>1, page=>$page+1)
to generate previous page and next page links.

Generate next page link only once.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   44 +++++++++++++++-----------------------------
 1 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index eaab895..20d4009 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2518,7 +2518,7 @@ sub format_paging_nav {
 
 	if ($page > 0) {
 		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => href(action=>$action, hash=>$hash, page=>$page-1),
+			$cgi->a({-href => href(-replay=>1, page=>$page-1),
 			         -accesskey => "p", -title => "Alt-p"}, "prev");
 	} else {
 		$paging_nav .= " &sdot; prev";
@@ -2526,7 +2526,7 @@ sub format_paging_nav {
 
 	if ($nrevs >= (100 * ($page+1)-1)) {
 		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => href(action=>$action, hash=>$hash, page=>$page+1),
+			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	} else {
 		$paging_nav .= " &sdot; next";
@@ -4448,7 +4448,7 @@ sub git_log {
 	}
 	if ($#commitlist >= 100) {
 		print "<div class=\"page_nav\">\n";
-		print $cgi->a({-href => href(action=>"log", hash=>$hash, page=>$page+1),
+		print $cgi->a({-href => href(-replay=>1, page=>$page+1),
 			       -accesskey => "n", -title => "Alt-n"}, "next");
 		print "</div>\n";
 	}
@@ -5015,27 +5015,20 @@ sub git_history {
 			                       file_name=>$file_name)},
 			        "first");
 		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
-			                       file_name=>$file_name, page=>$page-1),
+			$cgi->a({-href => href(-replay=>1, page=>$page-1),
 			         -accesskey => "p", -title => "Alt-p"}, "prev");
 	} else {
 		$paging_nav .= "first";
 		$paging_nav .= " &sdot; prev";
 	}
-	if ($#commitlist >= 100) {
-		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
-			                       file_name=>$file_name, page=>$page+1),
-			         -accesskey => "n", -title => "Alt-n"}, "next");
-	} else {
-		$paging_nav .= " &sdot; next";
-	}
 	my $next_link = '';
 	if ($#commitlist >= 100) {
 		$next_link =
-			$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
-			                       file_name=>$file_name, page=>$page+1),
+			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
+		$paging_nav .= " &sdot; $next_link";
+	} else {
+		$paging_nav .= " &sdot; next";
 	}
 
 	git_header_html();
@@ -5105,30 +5098,23 @@ sub git_search {
 				                       searchtext=>$searchtext, searchtype=>$searchtype)},
 				        "first");
 			$paging_nav .= " &sdot; " .
-				$cgi->a({-href => href(action=>"search", hash=>$hash,
-				                       searchtext=>$searchtext, searchtype=>$searchtype,
-				                       page=>$page-1),
+				$cgi->a({-href => href(-replay=>1, page=>$page-1),
 				         -accesskey => "p", -title => "Alt-p"}, "prev");
 		} else {
 			$paging_nav .= "first";
 			$paging_nav .= " &sdot; prev";
 		}
+		my $next_link = '';
 		if ($#commitlist >= 100) {
-			$paging_nav .= " &sdot; " .
-				$cgi->a({-href => href(action=>"search", hash=>$hash,
-				                       searchtext=>$searchtext, searchtype=>$searchtype,
-				                       page=>$page+1),
+			$next_link =
+				$cgi->a({-href => href(-replay=>1, page=>$page+1),
 				         -accesskey => "n", -title => "Alt-n"}, "next");
+			$paging_nav .= " &sdot; $next_link";
 		} else {
 			$paging_nav .= " &sdot; next";
 		}
-		my $next_link = '';
+
 		if ($#commitlist >= 100) {
-			$next_link =
-				$cgi->a({-href => href(action=>"search", hash=>$hash,
-				                       searchtext=>$searchtext, searchtype=>$searchtype,
-				                       page=>$page+1),
-				         -accesskey => "n", -title => "Alt-n"}, "next");
 		}
 
 		git_print_page_nav('','', $hash,$co{'tree'},$hash, $paging_nav);
@@ -5327,7 +5313,7 @@ sub git_shortlog {
 	my $next_link = '';
 	if ($#commitlist >= 100) {
 		$next_link =
-			$cgi->a({-href => href(action=>"shortlog", hash=>$hash, page=>$page+1),
+			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
 
-- 
1.5.3.4
