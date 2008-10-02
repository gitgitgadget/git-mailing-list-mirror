Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 28092 invoked by uid 111); 2 Oct 2008 15:17:22 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 02 Oct 2008 11:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbYJBPRR (ORCPT <rfc822;peff@peff.net>);
	Thu, 2 Oct 2008 11:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753704AbYJBPRR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 11:17:17 -0400
Received: from [212.249.11.140] ([212.249.11.140]:47580 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753677AbYJBPRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 11:17:17 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 997252AC954; Thu,  2 Oct 2008 17:17:01 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	Petr Baudis <petr.baudis@novartis.com>
Subject: [PATCH] gitweb: Make the by_tag filter delve in forks as well
Date:	Thu,  2 Oct 2008 17:17:01 +0200
Message-Id: <1222960621-12044-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
In-Reply-To: <1222960382-11619-1-git-send-email-pasky@suse.cz>
References: <1222960382-11619-1-git-send-email-pasky@suse.cz>
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This requires us to build a full index including forks and then weed
them out only when printing.

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---
 gitweb/gitweb.perl |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 02083d5..07fa1e6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1880,9 +1880,7 @@ sub git_get_projects_list {
 
 				my $subdir = substr($File::Find::name, $pfxlen + 1);
 				# we check related file in $projectroot
-				if ($check_forks and $subdir =~ m#/.#) {
-					$File::Find::prune = 1;
-				} elsif (check_export_ok("$projectroot/$filter/$subdir")) {
+				if (check_export_ok("$projectroot/$filter/$subdir")) {
 					push @list, { path => ($filter ? "$filter/" : '') . $subdir };
 					$File::Find::prune = 1;
 				}
@@ -3715,6 +3713,7 @@ sub print_sort_th_num {
 }
 
 sub git_project_list_body {
+	# actually uses global variable $project
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
 
 	my ($check_forks) = gitweb_check_feature('forks');
@@ -3757,7 +3756,15 @@ sub git_project_list_body {
 	my $tagfilter = $cgi->param('by_tag');
 	for (my $i = $from; $i <= $to; $i++) {
 		my $pr = $projects[$i];
+
 		next if $tagfilter and $show_ctags and not grep { lc $_ eq lc $tagfilter } keys %{$pr->{'ctags'}};
+		# Weed out forks
+		if ($check_forks) {
+			my $forkbase = $project; $forkbase ||= ''; $forkbase =~ s#\.git$#/#;
+			$forkbase="^$forkbase" if $forkbase;
+			next if not $tagfilter and $pr->{'path'} =~ m#$forkbase.*/.*#; # regexp-safe
+		}
+
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
-- 
tg: (f429121..) t/tagcloud/forks (depends on: t/tagcloud/tagcloud)
