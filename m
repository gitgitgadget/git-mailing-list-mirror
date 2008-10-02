Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 27602 invoked by uid 111); 2 Oct 2008 14:37:25 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 02 Oct 2008 10:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbYJBOhJ (ORCPT <rfc822;peff@peff.net>);
	Thu, 2 Oct 2008 10:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753984AbYJBOhJ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:37:09 -0400
Received: from [212.249.11.140] ([212.249.11.140]:32659 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753723AbYJBOhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:37:08 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 847892AC954; Thu,  2 Oct 2008 16:36:52 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Subject: [PATCH] gitweb: Add support for extending the action bar with custom links
Date:	Thu,  2 Oct 2008 16:36:52 +0200
Message-Id: <1222958212-5896-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This makes it possible to easily extend gitweb with custom functionality,
e.g. git-browser or web-based repository administration system like
the repo.or.cz/Girocco duct tape.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 gitweb/gitweb.perl |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index da474d0..9fbc9f8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -275,6 +275,26 @@ our %feature = (
 	'forks' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# Insert custom links to the action bar of all project pages.
+	# This enables you mainly to link to third-party scripts integrating
+	# into gitweb; e.g. git-browser for graphical history representation
+	# or custom web-based repository administration interface.
+
+	# The 'default' value consists of a list of triplets in the form
+	# (label, link, position) where position is the label after which
+	# to inster the link and link is a format string where %n expands
+	# to the project name, %f to the project path within the filesystem,
+	# %h to the current hash (h gitweb parameter) and %b to the current
+	# hash base (hb gitweb parameter).
+
+	# To enable system wide have in $GITWEB_CONFIG e.g.
+	# $feature{'actions'}{'default'} = [('graphiclog',
+	# 	'/git-browser/by-commit.html?r=%n', 'summary')];
+	# Project specific override is not supported.
+	'actions' => {
+		'override' => 0,
+		'default' => []},
 );
 
 sub gitweb_check_feature {
@@ -2757,13 +2777,26 @@ sub git_print_page_nav {
 			}
 		}
 	}
+
 	$arg{'tree'}{'hash'} = $treehead if defined $treehead;
 	$arg{'tree'}{'hash_base'} = $treebase if defined $treebase;
 
+	my @actions = gitweb_check_feature('actions');
+	while (@actions) {
+		my ($label, $link, $pos) = (shift(@actions), shift(@actions), shift(@actions));
+		@navs = map { $_ eq $pos ? ($_, $label) : $_ } @navs;
+		# munch munch
+		$link =~ s#%n#$project#g;
+		$link =~ s#%f#$git_dir#g;
+		$treehead ? $link =~ s#%h#$treehead#g : $link =~ s#%h##g;
+		$treebase ? $link =~ s#%b#$treebase#g : $link =~ s#%b##g;
+		$arg{$label}{'_href'} = $link;
+	}
+
 	print "<div class=\"page_nav\">\n" .
 		(join " | ",
 		 map { $_ eq $current ?
-		       $_ : $cgi->a({-href => href(%{$arg{$_}})}, "$_")
+		       $_ : $cgi->a({-href => ($arg{$_}{_href} ? $arg{$_}{_href} : href(%{$arg{$_}}))}, "$_")
 		 } @navs);
 	print "<br/>\n$extra<br/>\n" .
 	      "</div>\n";
-- 
tg: (c427559..) t/extra-actions/extra-actions (depends on: vanilla/master)
