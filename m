From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Allow for href() to be used for projectless links
Date: Fri, 15 Sep 2006 04:57:16 +0200
Message-ID: <200609150457.16924.jnareb@gmail.com>
References: <200609150453.42231.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 15 04:59:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO3vk-0007mF-0o
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 04:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWIOC7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 22:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWIOC7R
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 22:59:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:60796 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751468AbWIOC7P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 22:59:15 -0400
Received: by ug-out-1314.google.com with SMTP id o38so121424ugd
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 19:59:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XolfHo21DOZBrnOFiAGcuGzPpv9MHZihCPxS3BJSC3sJll3BpGaozOvoTh52rG6xDf5u1wMclIMu6SrtoXx7L0fyMNBso4kPGUk5ImdXIsj8TL2fQ72XeYZw98FP7EctFaJ1JOkV1CO8Ezcs6yPnqsKl40G6eXXLKyUjZ+UvH+Y=
Received: by 10.67.101.8 with SMTP id d8mr1606795ugm;
        Thu, 14 Sep 2006 19:59:14 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id b23sm1017606ugd.2006.09.14.19.59.13;
        Thu, 14 Sep 2006 19:59:13 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609150453.42231.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27059>

Change adding project to params if $params{"project"} is false
to adding project to params if it not exist. It allows for href()
to be used for projectless links by using "project=>undef" as
argument, while still adding project to params by default
in the most common case.

Convert remaining links (except $home_link and anchor links)
to use href(); this required adding 'order => "o"' to @mapping
in href(). This finishes consolidation of URL generation.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7dbcb88..e900713 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -326,11 +326,12 @@ sub href(%) {
 		hash_base => "hb",
 		hash_parent_base => "hpb",
 		page => "pg",
+		order => "o",
 		searchtext => "s",
 	);
 	my %mapping = @mapping;
 
-	$params{"project"} ||= $project;
+	$params{'project'} = $project unless exists $params{'project'};
 
 	my @result = ();
 	for (my $i = 0; $i < @mapping; $i += 2) {
@@ -1304,9 +1305,11 @@ sub git_footer_html {
 		if (defined $descr) {
 			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
 		}
-		print $cgi->a({-href => href(action=>"rss"), -class => "rss_logo"}, "RSS") . "\n";
+		print $cgi->a({-href => href(action=>"rss"),
+		              -class => "rss_logo"}, "RSS") . "\n";
 	} else {
-		print $cgi->a({-href => href(action=>"opml"), -class => "rss_logo"}, "OPML") . "\n";
+		print $cgi->a({-href => href(project=>undef, action=>"opml"),
+		              -class => "rss_logo"}, "OPML") . "\n";
 	}
 	print "</div>\n" .
 	      "</body>\n" .
@@ -2153,7 +2156,7 @@ sub git_project_list {
 		print "<th>Project</th>\n";
 	} else {
 		print "<th>" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("o=project"),
+		      $cgi->a({-href => href(project=>undef, order=>'project'),
 		               -class => "header"}, "Project") .
 		      "</th>\n";
 	}
@@ -2162,7 +2165,7 @@ sub git_project_list {
 		print "<th>Description</th>\n";
 	} else {
 		print "<th>" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("o=descr"),
+		      $cgi->a({-href => href(project=>undef, order=>'descr'),
 		               -class => "header"}, "Description") .
 		      "</th>\n";
 	}
@@ -2171,7 +2174,7 @@ sub git_project_list {
 		print "<th>Owner</th>\n";
 	} else {
 		print "<th>" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("o=owner"),
+		      $cgi->a({-href => href(project=>undef, order=>'owner'),
 		               -class => "header"}, "Owner") .
 		      "</th>\n";
 	}
@@ -2180,7 +2183,7 @@ sub git_project_list {
 		print "<th>Last Change</th>\n";
 	} else {
 		print "<th>" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("o=age"),
+		      $cgi->a({-href => href(project=>undef, order=>'age'),
 		               -class => "header"}, "Last Change") .
 		      "</th>\n";
 	}
-- 
1.4.2
