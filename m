From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Split git_project_list_body in two functions
Date: Tue,  8 Mar 2011 00:13:33 +0100
Message-ID: <1299539616-19991-2-git-send-email-jnareb@gmail.com>
References: <1299539616-19991-1-git-send-email-jnareb@gmail.com>
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, "J.H." <warthog9@kernel.org>,
	Sebastien Cevey <seb@cine7.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 00:14:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwjdD-0004uH-8v
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 00:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab1CGXOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 18:14:07 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65266 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574Ab1CGXOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 18:14:04 -0500
Received: by bwz15 with SMTP id 15so4166894bwz.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 15:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=hy9/SWC1TpmXm6mkPkZdHif8lslieSnnhIv+lhFwVX8=;
        b=QMQQhK4G76ePrz5iQ/u+mjXB/YHv1GXXldnQ5J5bqYaePL0wGEW5s8t+8/1oQDgawF
         pKSfIJ5OnpKJncH+r/4e3YLF+ryUdvhV9eAuyUQP5oLuFxxMxZJFqYlw8fPAanQ4u1ER
         +xtdIusbcIVh31ZgVsbepps307yT1tXCwReDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JtHKXzetc5/e1OVHN2QwThFjLXGQXRh943ZF1Y1x7LazNZnVd6uqhuh1e//B530jNS
         1/J/cvLwP7Opm9weOKcpF08rljQzyay5R1By1qR3u2aB/i/uMd8NznSiMUBxz15wXOyg
         gdUVvBJftYbOKzHli/JuWcYDNJuqWCm/M6US8=
Received: by 10.204.0.79 with SMTP id 15mr3815755bka.172.1299539642829;
        Mon, 07 Mar 2011 15:14:02 -0800 (PST)
Received: from localhost.localdomain (abvd192.neoplus.adsl.tpnet.pl [83.8.201.192])
        by mx.google.com with ESMTPS id l1sm75621bkl.1.2011.03.07.15.14.00
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 15:14:01 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1299539616-19991-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168617>

From: Sebastien Cevey <seb@cine7.net>

Extract the printing of project rows (body/contents of projects list
table) on the 'project_list' page into a separate git_project_list_rows
function. This makes it easier to reuse the code to print different
subsets of the whole project list.

[jn: Updated to post restructuring projects list generation]

Signed-off-by: Sebastien Cevey <seb@cine7.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   89 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 50 insertions(+), 39 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 996b647..0020b13 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4868,6 +4868,55 @@ sub format_sort_th {
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
@@ -4928,47 +4977,9 @@ sub git_project_list_body {
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
