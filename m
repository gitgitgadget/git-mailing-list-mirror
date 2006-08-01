From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 22]
Date: Tue, 1 Aug 2006 02:59:12 +0200
Message-ID: <200608010259.13721.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 01 02:59:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7ibI-0007Oi-8i
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 02:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWHAA7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 20:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWHAA7A
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 20:59:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:25448 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030374AbWHAA67 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 20:58:59 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1065039ugc
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 17:58:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pfr+YgCWDFE4wf0KIuVInlJ9Mf1NznTV79sCWuaCbgToaLzPvjEgytd+4EUwbpJCoY4M/tcx4VRFlt8kWoJWlmOVeoox7GCrHu9XMoAnu40GzA3q4nXr3lbxsO9T2Ad+DZFbS4wJYIdGRCENgUt7+L+0Gd+ooUFWfXRYhzhQWc8=
Received: by 10.67.89.5 with SMTP id r5mr244058ugl;
        Mon, 31 Jul 2006 17:58:58 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id q40sm5717396ugc.2006.07.31.17.58.57;
        Mon, 31 Jul 2006 17:58:57 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24559>

>From d69d3357f134bb5548f18fafff7664499adc1fcd Mon Sep 17 00:00:00 2001
From: Jakub Narebski <jnareb@gmail.com>
Date: Tue, 1 Aug 2006 02:56:51 +0200
Subject: [PATCH] gitweb: Refactoring git_project_list

Slightly reworking git_project_list, including moving setting $order,
as it is used only in this action. Mostly reindent.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
After Matthias Lederhofer <matled@gmx.net> patch,
"[PATCH] gitweb: use a hash to lookup the sub for an action"

 gitweb/gitweb.cgi |   57 +++++++++++++++++++++++++++++++++--------------------
 1 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 75390c8..27c36ef 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -80,14 +80,6 @@ if (defined $action) {
 	}
 }
 
-our $order = $cgi->param('o');
-if (defined $order) {
-	if ($order =~ m/[^0-9a-zA-Z_]/) {
-		undef $order;
-		die_error(undef, "Invalid order parameter.");
-	}
-}
-
 our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
 if (defined $project) {
 	$project =~ s|^/||; $project =~ s|/$||;
@@ -1303,10 +1295,15 @@ sub git_logo {
 }
 
 sub git_project_list {
+	my $order = $cgi->param('o');
+	if (defined $order && $order !~ m/project|descr|owner|age/) {
+		die_error(undef, "Invalid order parameter '$order'.");
+	}
+
 	my @list = git_read_projects();
 	my @projects;
 	if (!@list) {
-		die_error(undef, "No project found.");
+		die_error(undef, "No projects found.");
 	}
 	foreach my $pr (@list) {
 		my $head = git_read_head($pr->{'path'});
@@ -1328,6 +1325,7 @@ sub git_project_list {
 		}
 		push @projects, $pr;
 	}
+
 	git_header_html();
 	if (-f $home_text) {
 		print "<div class=\"index_include\">\n";
@@ -1338,29 +1336,42 @@ sub git_project_list {
 	}
 	print "<table class=\"project_list\">\n" .
 	      "<tr>\n";
-	if (!defined($order) || (defined($order) && ($order eq "project"))) {
+	$order ||= "project";
+	if ($order eq "project") {
 		@projects = sort {$a->{'path'} cmp $b->{'path'}} @projects;
 		print "<th>Project</th>\n";
 	} else {
-		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=project")}, "Project") . "</th>\n";
+		print "<th>" .
+		      $cgi->a({-href => "$my_uri?" . esc_param("o=project"),
+		               -class => "header"}, "Project") .
+		      "</th>\n";
 	}
-	if (defined($order) && ($order eq "descr")) {
+	if ($order eq "descr") {
 		@projects = sort {$a->{'descr'} cmp $b->{'descr'}} @projects;
 		print "<th>Description</th>\n";
 	} else {
-		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=descr")}, "Description") . "</th>\n";
+		print "<th>" .
+		      $cgi->a({-href => "$my_uri?" . esc_param("o=descr"),
+		               -class => "header"}, "Description") .
+		      "</th>\n";
 	}
-	if (defined($order) && ($order eq "owner")) {
+	if ($order eq "owner") {
 		@projects = sort {$a->{'owner'} cmp $b->{'owner'}} @projects;
 		print "<th>Owner</th>\n";
 	} else {
-		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=owner")}, "Owner") . "</th>\n";
+		print "<th>" .
+		      $cgi->a({-href => "$my_uri?" . esc_param("o=owner"),
+		               -class => "header"}, "Owner") .
+		      "</th>\n";
 	}
-	if (defined($order) && ($order eq "age")) {
+	if ($order eq "age") {
 		@projects = sort {$a->{'commit'}{'age'} <=> $b->{'commit'}{'age'}} @projects;
 		print "<th>Last Change</th>\n";
 	} else {
-		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=age")}, "Last Change") . "</th>\n";
+		print "<th>" .
+		      $cgi->a({-href => "$my_uri?" . esc_param("o=age"),
+		               -class => "header"}, "Last Change") .
+		      "</th>\n";
 	}
 	print "<th></th>\n" .
 	      "</tr>\n";
@@ -1372,14 +1383,16 @@ sub git_project_list {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		print "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary"), -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
+		print "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary"),
+		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
 		      "<td>" . esc_html($pr->{'descr'}) . "</td>\n" .
 		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
-		print "<td class=\"". age_class($pr->{'commit'}{'age'}) . "\">" . $pr->{'commit'}{'age_string'} . "</td>\n" .
+		print "<td class=\"". age_class($pr->{'commit'}{'age'}) . "\">" .
+		      $pr->{'commit'}{'age_string'} . "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary")}, "summary") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=shortlog")}, "shortlog") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=log")}, "log") .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary")}, "summary")   . " | " .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=shortlog")}, "shortlog") . " | " .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=log")}, "log") .
 		      "</td>\n" .
 		      "</tr>\n";
 	}
-- 
1.4.1.1
