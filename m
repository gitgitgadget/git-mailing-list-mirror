From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Make project search respect project_filter
Date: Tue, 31 Jan 2012 01:20:55 +0100
Message-ID: <1327969255-26622-3-git-send-email-jnareb@gmail.com>
References: <1327969255-26622-1-git-send-email-jnareb@gmail.com>
Cc: "Bernhard R. Link" <brl+git@mail.brlink.eu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 01:20:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rs1Sm-0005kr-7K
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 01:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431Ab2AaAUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 19:20:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45675 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016Ab2AaAUe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 19:20:34 -0500
Received: by eaal13 with SMTP id l13so1305473eaa.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 16:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=68LRZAQy6F9wovHbQcvbp4/yhiTCEJUyYQA8/bX9KxE=;
        b=h6VEzdUzKhOIxNfDDr+UMU0ZZ5MM80LTHJ5To7KoLnF2jnDWndhD3ucxcBlSyGe3rp
         L51QYLHE4xEMBtokesqWBthQ2YeRv6VAgUjR2YSK58B8HJv9zP0CYnzH54cCjOw7GWVP
         UZ3/9e6vWddh4aGU5XvmPvTsw5o5+0e5EpZeY=
Received: by 10.213.9.145 with SMTP id l17mr7722ebl.79.1327969233549;
        Mon, 30 Jan 2012 16:20:33 -0800 (PST)
Received: from localhost.localdomain (abwi152.neoplus.adsl.tpnet.pl. [83.8.232.152])
        by mx.google.com with ESMTPS id b3sm28106899een.2.2012.01.30.16.20.32
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 16:20:33 -0800 (PST)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1327969255-26622-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189438>

Make gitweb search within filtered projects (i.e. projects shown), and
change "List all projects" to "List all projects in '$project_filter/'"
if project_filter is used.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is new.

 gitweb/gitweb.perl |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c4e0d8e..80975dd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5158,11 +5158,18 @@ sub git_patchset_body {
 sub git_project_search_form {
 	my ($searchtext, $search_use_regexp);
 
+	my $limit = '';
+	if ($project_filter) {
+		$limit = " in '$project_filter/'";
+	}
+
 	print "<div class=\"projsearch\">\n";
 	print $cgi->startform(-method => 'get', -action => $my_uri) .
-	      $cgi->hidden(-name => 'a', -value => 'project_list') . "\n" .
-	      $cgi->textfield(-name => 's', -value => $searchtext,
-	                      -title => 'Search project by name and description',
+	      $cgi->hidden(-name => 'a', -value => 'project_list')  . "\n";
+	print $cgi->hidden(-name => 'pf', -value => $project_filter). "\n"
+		if (defined $project_filter);
+	print $cgi->textfield(-name => 's', -value => $searchtext,
+	                      -title => "Search project by name and description$limit",
 	                      -size => 60) . "\n" .
 	      "<span title=\"Extended regular expression\">" .
 	      $cgi->checkbox(-name => 'sr', -value => 1, -label => 're',
@@ -5170,8 +5177,9 @@ sub git_project_search_form {
 	      "</span>\n" .
 	      $cgi->submit(-name => 'btnS', -value => 'Search') .
 	      $cgi->end_form() . "\n" .
-	      $cgi->a({-href => href(project => undef, searchtext => undef)},
-	              'List all projects') . "<br />\n";
+	      $cgi->a({-href => href(project => undef, searchtext => undef,
+	                             project_filter => $project_filter)},
+	              esc_html("List all projects$limit")) . "<br />\n";
 	print "</div>\n";
 }
 
-- 
1.7.6
