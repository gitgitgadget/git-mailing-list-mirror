From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 13] gitweb: Pager refactoring - use git_get_paging_nav for pagination
Date: Sun, 30 Jul 2006 17:49:00 +0200
Message-ID: <200607301749.00999.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 17:49:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7DXJ-0001UF-1g
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 17:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWG3Ps4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 11:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWG3Ps4
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 11:48:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:53398 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932348AbWG3Psz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 11:48:55 -0400
Received: by ug-out-1314.google.com with SMTP id m3so392388ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 08:48:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KWc3UX02FYVKBX/8BEuTSiKjW9bJfRu7xvnSc7V0gHX/74O6GUEYwc5TwZEu2IuqtTQasn+p4foaNSgsSsv5cL/eyCqVo38E+/Yuxlsya2iovhmczkNh13NpcWNmaOyCmbLcIlkarOXnYBnEFJEdtme3daJcXmfHidrUS+cfQRg=
Received: by 10.66.222.9 with SMTP id u9mr1616097ugg;
        Sun, 30 Jul 2006 08:48:53 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k2sm2983575ugf.2006.07.30.08.48.52;
        Sun, 30 Jul 2006 08:48:52 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24461>

Add git_get_paging_nav subroutine which returns string with pager
(paging nav) for shortlog and log actions.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It would make no sense to split this patch into two, I think.

 gitweb/gitweb.cgi |   68 +++++++++++++++++++++++++----------------------------
 1 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index df152c3..0ed3ad2 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -420,6 +420,36 @@ sub git_page_nav {
 	      "</div>\n";
 }
 
+sub git_get_paging_nav {
+	my ($project, $action, $hash, $head, $page, $nrevs) = @_;
+	my $paging_nav;
+
+
+	if ($hash ne $head || $page) {
+		$paging_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action")}, "HEAD");
+	} else {
+		$paging_nav .= "HEAD";
+	}
+
+	if ($page > 0) {
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action;h=$hash;pg=" . ($page-1)),
+							 -accesskey => "p", -title => "Alt-p"}, "prev");
+	} else {
+		$paging_nav .= " &sdot; prev";
+	}
+
+	if ($nrevs >= (100 * ($page+1)-1)) {
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action;h=$hash;pg=" . ($page+1)),
+							 -accesskey => "n", -title => "Alt-n"}, "next");
+	} else {
+		$paging_nav .= " &sdot; next";
+	}
+
+	return $paging_nav;
+}
+
 sub git_get_type {
 	my $hash = shift;
 
@@ -1873,24 +1903,7 @@ sub git_log {
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
 
-	my $paging_nav = '';
-	if ($hash ne $head || $page) {
-		$paging_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "HEAD");
-	} else {
-		$paging_nav .= "HEAD";
-	}
-	if ($page > 0) {
-		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$hash;pg=" . ($page-1)), -accesskey => "p", -title => "Alt-p"}, "prev");
-	} else {
-		$paging_nav .= " &sdot; prev";
-	}
-	if ($#revlist >= (100 * ($page+1)-1)) {
-		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$hash;pg=" . ($page+1)), -accesskey => "n", -title => "Alt-n"}, "next");
-	} else {
-		$paging_nav .= " &sdot; next";
-	}
+	my $paging_nav = git_get_paging_nav($project, 'log', $hash, $head, $page, $#revlist);
 
 	git_header_html();
 	git_page_nav('log','', $hash,undef,undef, $paging_nav);
@@ -2553,24 +2566,7 @@ sub git_shortlog {
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
 
-	my $paging_nav = '';
-	if ($hash ne $head || $page) {
-		$paging_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "HEAD");
-	} else {
-		$paging_nav .= "HEAD";
-	}
-	if ($page > 0) {
-		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash;pg=" . ($page-1)), -accesskey => "p", -title => "Alt-p"}, "prev");
-	} else {
-		$paging_nav .= " &sdot; prev";
-	}
-	if ($#revlist >= (100 * ($page+1)-1)) {
-		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash;pg=" . ($page+1)), -accesskey => "n", -title => "Alt-n"}, "next");
-	} else {
-		$paging_nav .= " &sdot; next";
-	}
+	my $paging_nav = git_get_paging_nav($project, 'shortlog', $hash, $head, $page, $#revlist);
 
 	git_header_html();
 	git_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
-- 
1.4.0
