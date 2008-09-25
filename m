Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 460 invoked by uid 111); 25 Sep 2008 16:56:03 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 25 Sep 2008 12:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbYIYQz5 (ORCPT <rfc822;peff@peff.net>);
	Thu, 25 Sep 2008 12:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbYIYQz4
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 12:55:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58689 "EHLO pixie.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753174AbYIYQzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 12:55:54 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 60C822AC877; Thu, 25 Sep 2008 18:48:37 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	Mike Ralphson <mike.ralphson@gmail.com>
Subject: [PATCH] gitweb: Clean-up sorting of project list
Date:	Thu, 25 Sep 2008 18:48:37 +0200
Message-Id: <1222361317-17275-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
In-Reply-To: <e2b179460807231010m44ff446auc054ead9178c711b@mail.gmail.com>
References: <e2b179460807231010m44ff446auc054ead9178c711b@mail.gmail.com>
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This decouples the sorting of project list and printing the column
headers, so that the project list can be easily sorted even when
the headers are not shown.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 gitweb/gitweb.perl |   45 ++++++++++++++++++++-------------------------
 1 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index da474d0..bd81e14 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3605,19 +3605,13 @@ sub fill_project_list_info {
 	return @projects;
 }
 
-# print 'sort by' <th> element, either sorting by $key if $name eq $order
-# (changing $list), or generating 'sort by $name' replay link otherwise
+# print 'sort by' <th> element, generating 'sort by $name' replay link
+# if that order is not selected
 sub print_sort_th {
-	my ($str_sort, $name, $order, $key, $header, $list) = @_;
-	$key    ||= $name;
+	my ($name, $order, $header) = @_;
 	$header ||= ucfirst($name);
 
 	if ($order eq $name) {
-		if ($str_sort) {
-			@$list = sort {$a->{$key} cmp $b->{$key}} @$list;
-		} else {
-			@$list = sort {$a->{$key} <=> $b->{$key}} @$list;
-		}
 		print "<th>$header</th>\n";
 	} else {
 		print "<th>" .
@@ -3627,14 +3621,6 @@ sub print_sort_th {
 	}
 }
 
-sub print_sort_th_str {
-	print_sort_th(1, @_);
-}
-
-sub print_sort_th_num {
-	print_sort_th(0, @_);
-}
-
 sub git_project_list_body {
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
 
@@ -3645,20 +3631,29 @@ sub git_project_list_body {
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
 
+	my %order_info = (
+		project => { key => 'path', type => 'str' },
+		descr => { key => 'descr_long', type => 'str' },
+		owner => { key => 'owner', type => 'str' },
+		age => { key => 'age', type => 'num' }
+	);
+	my $oi = $order_info{$order};
+	if ($oi->{'type'} eq 'str') {
+		@projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @projects;
+	} else {
+		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @projects;
+	}
+
 	print "<table class=\"project_list\">\n";
 	unless ($no_header) {
 		print "<tr>\n";
 		if ($check_forks) {
 			print "<th></th>\n";
 		}
-		print_sort_th_str('project', $order, 'path',
-		                  'Project', \@projects);
-		print_sort_th_str('descr', $order, 'descr_long',
-		                  'Description', \@projects);
-		print_sort_th_str('owner', $order, 'owner',
-		                  'Owner', \@projects);
-		print_sort_th_num('age', $order, 'age',
-		                  'Last Change', \@projects);
+		print_sort_th('project', $order, 'Project');
+		print_sort_th('descr', $order, 'Description');
+		print_sort_th('owner', $order, 'Owner');
+		print_sort_th('age', $order, 'Last Change');
 		print "<th></th>\n" . # for links
 		      "</tr>\n";
 	}
-- 
tg: (c427559..) t/forks/sort-refactor (depends on: vanilla/master)
