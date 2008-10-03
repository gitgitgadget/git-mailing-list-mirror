Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 4861 invoked by uid 111); 3 Oct 2008 07:30:28 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 03 Oct 2008 03:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbYJCHaG (ORCPT <rfc822;peff@peff.net>);
	Fri, 3 Oct 2008 03:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbYJCHaG
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 03:30:06 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:61243 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754666AbYJCHaE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 03:30:04 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 6B6C62AC8FD; Fri,  3 Oct 2008 09:29:46 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	Petr Baudis <petr.baudis@novartis.com>
Subject: [PATCH] gitweb: Support for simple project search form
Date:	Fri,  3 Oct 2008 09:29:45 +0200
Message-Id: <1223018985-19169-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
In-Reply-To: <1222960621-12044-1-git-send-email-pasky@suse.cz>
References: <1222960621-12044-1-git-send-email-pasky@suse.cz>
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is a trivial patch adding support for searching projects by name
and description, making use of the "infrastructure" provided by the
tag cloud generation.

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---
 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |   12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 07f5b53..a01eac8 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -435,6 +435,10 @@ div.search {
 	right: 12px
 }
 
+p.projsearch {
+	text-align: center;
+}
+
 td.linenr {
 	text-align: right;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 07fa1e6..4bc8a12 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3758,11 +3758,14 @@ sub git_project_list_body {
 		my $pr = $projects[$i];
 
 		next if $tagfilter and $show_ctags and not grep { lc $_ eq lc $tagfilter } keys %{$pr->{'ctags'}};
-		# Weed out forks
+		next if $searchtext and not $pr->{'path'} =~ /$searchtext/
+			and not $pr->{'descr_long'} =~ /$searchtext/;
+		# Weed out forks or non-matching entries of search
 		if ($check_forks) {
 			my $forkbase = $project; $forkbase ||= ''; $forkbase =~ s#\.git$#/#;
 			$forkbase="^$forkbase" if $forkbase;
-			next if not $tagfilter and $pr->{'path'} =~ m#$forkbase.*/.*#; # regexp-safe
+			next if not $searchtext and not $tagfilter and $show_ctags
+				and $pr->{'path'} =~ m#$forkbase.*/.*#; # regexp-safe
 		}
 
 		if ($alternate) {
@@ -4099,6 +4102,11 @@ sub git_project_list {
 		close $fd;
 		print "</div>\n";
 	}
+	print $cgi->startform(-method => "get") .
+	      "<p class=\"projsearch\">Search:\n" .
+	      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
+	      "</p>" .
+	      $cgi->end_form() . "\n";
 	git_project_list_body(\@list, $order);
 	git_footer_html();
 }
-- 
tg: (0d352a0..) t/misc/projsearch (depends on: t/tagcloud/forks)
