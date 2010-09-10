From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/2] gitweb: Optimize paging when sorted by path
Date: Fri, 10 Sep 2010 18:17:22 +0200
Message-ID: <1284135442-10971-3-git-send-email-lkundrak@v3.sk>
References: <1284135442-10971-1-git-send-email-lkundrak@v3.sk>
 <1284135442-10971-2-git-send-email-lkundrak@v3.sk>
Cc: Lubomir Rintel <lkundrak@v3.sk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 18:17:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou6IK-000460-FH
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486Ab0IJQRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 12:17:39 -0400
Received: from norkia.v3.sk ([91.210.183.14]:49173 "EHLO norkia.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755467Ab0IJQRi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 12:17:38 -0400
Received: from localhost.localdomain.com (unknown [195.39.106.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lkundrak@v3.sk)
	by norkia.v3.sk (Postfix) with ESMTP id EF1F0A0005;
	Fri, 10 Sep 2010 18:17:36 +0200 (CEST)
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1284135442-10971-2-git-send-email-lkundrak@v3.sk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155940>

There's no need to get authors, description and last modification time
of a project that's not being shown on a current page. We can only tell
that in advance if the list is sorted by pathname.
---
 gitweb/gitweb.perl |   47 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8dc7f29..a2e9a95 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4608,12 +4608,30 @@ sub format_sort_th {
 	return $sort_th;
 }
 
+sub git_try_to_order {
+	my ($projects, $order) = @_;
+
+	my %order_info = (
+		project => { key => 'path', type => 'str' },
+		descr => { key => 'descr_long', type => 'str' },
+		owner => { key => 'owner', type => 'str' },
+		age => { key => 'age', type => 'num' }
+	);
+	my $oi = $order_info{$order};
+	return undef unless exists $projects->[0]->{$oi->{'key'}};
+	if ($oi->{'type'} eq 'str') {
+		@$projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @$projects;
+	} else {
+		@$projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @$projects;
+	}
+	return 1;
+}
+
 sub git_project_list_body {
 	# actually uses global variable $project
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
 
 	my $check_forks = gitweb_check_feature('forks');
-	my @projects = fill_project_list_info($projlist, $check_forks);
 
 	$order ||= $default_projects_order;
 	$page ||= 0;
@@ -4622,26 +4640,29 @@ sub git_project_list_body {
 		$to = $from + $projects_per_page - 1 unless defined $to;
 	}
 	$from = 0 unless defined $from;
-	$to = $#projects if (!defined $to || $#projects < $to);
+	$to = $#$projlist if (!defined $to || $#$projlist < $to);
 
 	my $prev_link = $cgi->a({-href => href(-replay=>1, page=>$page-1),
 		 -accesskey => "p", -title => "Alt-p"}, "prev") if ($page > 0);
 	my $next_link = $cgi->a({-href => href(-replay=>1, page=>$page+1),
 		 -accesskey => "n", -title => "Alt-n"}, "next") if ($#$projlist > $to);
 
-	my %order_info = (
-		project => { key => 'path', type => 'str' },
-		descr => { key => 'descr_long', type => 'str' },
-		owner => { key => 'owner', type => 'str' },
-		age => { key => 'age', type => 'num' }
-	);
-	my $oi = $order_info{$order};
-	if ($oi->{'type'} eq 'str') {
-		@projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @projects;
-	} else {
-		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @projects;
+	# If we're paginating and can order the list now (by pathname), we
+	# don't need to do an unnecessary and expensive query of the details
+	# of the projects we're not going to display. Attempt the sort and
+	# remove the other projects from the list if the sort is successful.
+	# Can't be used with ctags, since it needs a complete project list.
+	my $ordered = git_try_to_order($projlist, $order)
+		unless gitweb_check_feature('ctags');
+	if ($ordered) {
+		@$projlist = @$projlist[$from..$to];
+		$to -= $from;
+		$from = 0;
 	}
 
+	my @projects = fill_project_list_info($projlist, $check_forks);
+	git_try_to_order(\@projects, $order) unless $ordered;
+
 	my $show_ctags = gitweb_check_feature('ctags');
 	if ($show_ctags) {
 		my %ctags;
-- 
1.7.2.1
