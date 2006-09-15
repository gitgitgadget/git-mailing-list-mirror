From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3 (take 2)] gitweb: Allow for href() to be used for links without project param
Date: Fri, 15 Sep 2006 19:30:34 +0200
Message-ID: <200609151930.35744.jnareb@gmail.com>
References: <200609150453.42231.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Sep 15 19:30:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOHW8-0001Kk-IY
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 19:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWIORaL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 13:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWIORaL
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 13:30:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:28630 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932070AbWIORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 13:30:09 -0400
Received: by ug-out-1314.google.com with SMTP id o38so175751ugd
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 10:30:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:user-agent:references:in-reply-to:mime-version:content-disposition:cc:date:content-type:content-transfer-encoding:message-id;
        b=BgNWzLIN9FKUbW/I66syt5rqaQoytHy12StZgzI5scmAy2nNYOieV7ycQ0hLtj2khhc8xX89xiLZr6jb38gyfg6qLpPjx04Conhj1w07QzZ49gRL5LDPO97UJcBBl74rH6LbWSVBsZUUsPB71uBMUQFbwt7AM6O1/Ficq7/0RWY=
Received: by 10.66.242.20 with SMTP id p20mr5513904ugh;
        Fri, 15 Sep 2006 10:30:07 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id s7sm1333413uge.2006.09.15.10.30.06;
        Fri, 15 Sep 2006 10:30:07 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609150453.42231.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27093>

Make it possible use href() subroutine to generate link with
query string which does not include project ('p') parameter.
href() used to add project=$project to its parameters, if it
was not set (to be more exact if $params{'project'} was false).
Now you can pass "project => undef" if you don't want for href()
to add project parameter to query string in the generated link.

Links to "project_list", "project_index" and "opml" (all related
to list of all projects/all git repositories) doesn't need project
parameter. Moreover "project_list" is default view (action) if
project ('p') parameter is not set, just like "summary" is default
view (action) if project is set; project list served as a kind
of "home" page for gitweb instalation, and links to "project_list"
view were done without specyfying it as an action.

Convert remaining links (except $home_link and anchor links)
to use href(); this required adding 'order => "o"' to @mapping
in href(). This finishes consolidation of URL generation.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Only commit message has changed.

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
