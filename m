Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 6625 invoked by uid 111); 3 Oct 2008 13:45:33 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 03 Oct 2008 09:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbYJCNpY (ORCPT <rfc822;peff@peff.net>);
	Fri, 3 Oct 2008 09:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbYJCNpY
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 09:45:24 -0400
Received: from [212.249.11.140] ([212.249.11.140]:53026 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751459AbYJCNpY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 09:45:24 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 8E38E2AC95E; Fri,  3 Oct 2008 15:45:02 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	Petr Baudis <petr.baudis@novartis.com>
Subject: [PATCH] gitweb: Unify shortlog/log links
Date:	Fri,  3 Oct 2008 15:45:02 +0200
Message-Id: <1223041502-5204-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
In-Reply-To: <1222958212-5896-1-git-send-email-pasky@suse.cz>
References: <1222958212-5896-1-git-send-email-pasky@suse.cz>
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Instead of 'shortlog | log', we use only 'log' now, pointing to the shortlog
action, since that is what most people are usually interested in first. In the
action-specific navbar, you can then choose between short and full log view.

The aim of this patch is to reduce the overwhelming number of links by
including only orthogonal links to most popular views.

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---
 gitweb/gitweb.perl |   46 +++++++++++++++++++++++++++++++++-------------
 1 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9fbc9f8..58fc137 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2761,7 +2761,7 @@ sub git_print_page_nav {
 	my ($current, $suppress, $head, $treehead, $treebase, $extra) = @_;
 	$extra = '' if !defined $extra; # pager or formats
 
-	my @navs = qw(summary shortlog log commit commitdiff tree);
+	my @navs = qw(summary log commit commitdiff tree);
 	if ($suppress) {
 		@navs = grep { $_ ne $suppress } @navs;
 	}
@@ -2772,12 +2772,11 @@ sub git_print_page_nav {
 			$arg{$_}{'hash'} = $head;
 		}
 		if ($current =~ m/^(tree | log | shortlog | commit | commitdiff | search)$/x) {
-			for (qw(shortlog log)) {
-				$arg{$_}{'hash'} = $head;
-			}
+			$arg{'log'}{'hash'} = $head;
 		}
 	}
 
+	$arg{'log'}{'action'} = 'shortlog';
 	$arg{'tree'}{'hash'} = $treehead if defined $treehead;
 	$arg{'tree'}{'hash_base'} = $treebase if defined $treebase;
 
@@ -2832,6 +2831,26 @@ sub format_paging_nav {
 	return $paging_nav;
 }
 
+sub format_log_nav {
+	my ($action, $hash, $head, $page, $has_next_link) = @_;
+	my $paging_nav;
+
+	if ($action eq 'shortlog') {
+		$paging_nav .= 'shortlog';
+	} else {
+		$paging_nav .= $cgi->a({-href => href(action=>'shortlog', -replay=>1)}, 'shortlog');
+	}
+	$paging_nav .= ' | ';
+	if ($action eq 'log') {
+		$paging_nav .= 'fulllog';
+	} else {
+		$paging_nav .= $cgi->a({-href => href(action=>'log', -replay=>1)}, 'fulllog');
+	}
+
+	$paging_nav .= " | " . format_paging_nav($action, $hash, $head, $page, $has_next_link);
+	return $paging_nav;
+}
+
 ## ......................................................................
 ## functions printing or outputting HTML: div
 
@@ -3722,8 +3741,7 @@ sub git_project_list_body {
 		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "log") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
 		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
 		      "</td>\n" .
@@ -3894,8 +3912,7 @@ sub git_tags_body {
 		      "<td class=\"link\">" . " | " .
 		      $cgi->a({-href => href(action=>$tag{'reftype'}, hash=>$tag{'refid'})}, $tag{'reftype'});
 		if ($tag{'reftype'} eq "commit") {
-			print " | " . $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'fullname'})}, "shortlog") .
-			      " | " . $cgi->a({-href => href(action=>"log", hash=>$tag{'fullname'})}, "log");
+			print " | " . $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'fullname'})}, "log");
 		} elsif ($tag{'reftype'} eq "blob") {
 			print " | " . $cgi->a({-href => href(action=>"blob_plain", hash=>$tag{'refid'})}, "raw");
 		}
@@ -3934,8 +3951,7 @@ sub git_heads_body {
 		               -class => "list name"},esc_html($ref{'name'})) .
 		      "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'})}, "shortlog") . " | " .
-		      $cgi->a({-href => href(action=>"log", hash=>$ref{'fullname'})}, "log") . " | " .
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'})}, "log") . " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'name'})}, "tree") .
 		      "</td>\n" .
 		      "</tr>";
@@ -4628,9 +4644,12 @@ sub git_log {
 
 	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
-	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
+	my $paging_nav = format_log_nav('log', $hash, $head, $page, $#commitlist >= 100);
 
-	git_header_html();
+	{
+		local $action = 'fulllog';
+		git_header_html();
+	}
 	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
 
 	if (!@commitlist) {
@@ -5533,7 +5552,8 @@ sub git_shortlog {
 
 	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
-	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#commitlist >= 100);
+	my $paging_nav = format_log_nav('shortlog', $hash, $head, $page, $#commitlist >= 100);
+
 	my $next_link = '';
 	if ($#commitlist >= 100) {
 		$next_link =
-- 
tg: (7fac06d..) t/extra-actions/log-consolidate (depends on: t/extra-actions/extra-actions)
