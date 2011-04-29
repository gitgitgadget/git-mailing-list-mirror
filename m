From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/6] gitweb: Split git_project_list_body in two functions
Date: Fri, 29 Apr 2011 19:51:59 +0200
Message-ID: <1304099521-27617-5-git-send-email-jnareb@gmail.com>
References: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Sebastien Cevey <seb@cine7.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:52:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFrs4-0001Q3-Dq
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 19:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760766Ab1D2Rwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 13:52:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38549 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894Ab1D2Rwb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 13:52:31 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2635577fxm.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Lr4YFfrHpQxWVXD1msQyGXREKHPODSJEomEjpG7QN5s=;
        b=NtEKb1FHWTFkno1G4etXOh7K0JwbwfgFuUhV//dCIbxzRYyrQ1CnVmpXeQO2Np4yPD
         QBUwlALXf++RYdDDKf+xT4vUBXrLoIHyYmaS/19ASK447zilu7EKbipk9h7yIcG0/Q6m
         ZknTWvCvmULLqtIUYpTetxlZbAXnMMzXThzT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=haF7Z+N7nP5yTcbNaamgLh8afCis+daEcfffJrmvTmNu5kTMICjfgGugElnRKCQY6z
         t5IIaf8xVRZAp1HEFGWEurHyZxkMp/S1biY+bygXcVVPMaKjePp/DfCB0cQm0Jv6W8dN
         0VMD5ArBclW6/CoHD9obLENVJ5zvoCczynRzM=
Received: by 10.223.75.15 with SMTP id w15mr5355875faj.134.1304099550241;
        Fri, 29 Apr 2011 10:52:30 -0700 (PDT)
Received: from localhost.localdomain (abvr62.neoplus.adsl.tpnet.pl [83.8.215.62])
        by mx.google.com with ESMTPS id n26sm962346fam.37.2011.04.29.10.52.28
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Apr 2011 10:52:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172481>

From: Sebastien Cevey <seb@cine7.net>

Extract the printing of project rows (body/contents of projects list
table) on the 'project_list' page into a separate git_project_list_rows
function. This makes it easier to reuse the code to print different
subsets of the whole project list.

[jn: Updated to post restructuring projects list generation]

Signed-off-by: Sebastien Cevey <seb@cine7.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch and subsequent patches were sent to git mailing list
(before rebasing on top of 'ctags' improvements) as

  [RFC/PATCH 0/3] gitweb: Categories support
  http://thread.gmane.org/gmane.comp.version-control.git/168616


This subseries is long in wait port of Sebastien Cevey series from
December 2008

  http://thread.gmane.org/gmane.comp.version-control.git/102844

to modern gitweb.  It was waiting for restructuring of projects list
generation that is part of this series.

Uwe, it might be an alternative to use of ctags (content tags, aka
project labels).

 gitweb/gitweb.perl |   89 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 50 insertions(+), 39 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e81c27d..f8d5722 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4946,6 +4946,55 @@ sub format_sort_th {
 	return $sort_th;
 }
 
+sub git_project_list_rows {
+	my ($projlist, $from, $to, $check_forks) = @_;
+
+	$from = 0 unless defined $from;
+	$to = $#$projlist if (!defined $to || $#$projlist < $to);
+
+	my $alternate = 1;
+	for (my $i = $from; $i <= $to; $i++) {
+		my $pr = $projlist->[$i];
+
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+
+		if ($check_forks) {
+			print "<td>";
+			if ($pr->{'forks'}) {
+				my $nforks = scalar @{$pr->{'forks'}};
+				if ($nforks > 0) {
+					print $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks"),
+					               -title => "$nforks forks"}, "+");
+				} else {
+					print $cgi->span({-title => "$nforks forks"}, "+");
+				}
+			}
+			print "</td>\n";
+		}
+		print "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
+		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
+		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
+		                        -class => "list", -title => $pr->{'descr_long'}},
+		                        esc_html($pr->{'descr'})) . "</td>\n" .
+		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
+		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
+		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
+		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
+		      "</td>\n" .
+		      "</tr>\n";
+	}
+}
+
 sub git_project_list_body {
 	# actually uses global variable $project
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
@@ -5001,47 +5050,9 @@ sub git_project_list_body {
 		print "<th></th>\n" . # for links
 		      "</tr>\n";
 	}
-	my $alternate = 1;
-	for (my $i = $from; $i <= $to; $i++) {
-		my $pr = $projects[$i];
 
-		if ($alternate) {
-			print "<tr class=\"dark\">\n";
-		} else {
-			print "<tr class=\"light\">\n";
-		}
-		$alternate ^= 1;
+	git_project_list_rows(\@projects, $from, $to, $check_forks);
 
-		if ($check_forks) {
-			print "<td>";
-			if ($pr->{'forks'}) {
-				my $nforks = scalar @{$pr->{'forks'}};
-				if ($nforks > 0) {
-					print $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks"),
-					               -title => "$nforks forks"}, "+");
-				} else {
-					print $cgi->span({-title => "$nforks forks"}, "+");
-				}
-			}
-			print "</td>\n";
-		}
-		print "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
-		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
-		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
-		                        -class => "list", -title => $pr->{'descr_long'}},
-		                        esc_html($pr->{'descr'})) . "</td>\n" .
-		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
-		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
-		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
-		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
-		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
-		      "</td>\n" .
-		      "</tr>\n";
-	}
 	if (defined $extra) {
 		print "<tr>\n";
 		if ($check_forks) {
-- 
1.7.3
