From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/6] gitweb: More per-view navigation bar links
Date: Fri, 22 Sep 2006 03:19:41 +0200
Message-ID: <20060922011941.15909.32671.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 22 03:19:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQZhj-0003QH-BO
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 03:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWIVBTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 21:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWIVBTn
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 21:19:43 -0400
Received: from rover.dkm.cz ([62.24.64.27]:60576 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932168AbWIVBTn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 21:19:43 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id C642B8B875;
	Fri, 22 Sep 2006 03:19:41 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27511>

Navigation bars in various views were empty or missed important items that
should have been there, e.g. getting a snapshot in tree view or log of
ancestry in commit view...

This feeble patch attempts to consolidate that.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |   42 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0d2ff82..87df7bb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2444,6 +2444,9 @@ sub git_blame2 {
 		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
 		        "blob") .
 		" | " .
+		$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
+			"history") .
+		" | " .
 		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
 		        "head");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
@@ -2510,6 +2513,9 @@ sub git_blame {
 		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
 		        "blob") .
 		" | " .
+		$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
+			"history") .
+		" | " .
 		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
 		        "head");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
@@ -2685,6 +2691,10 @@ sub git_blob {
 					" | ";
 			}
 			$formats_nav .=
+				$cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+				                       hash=>$hash, file_name=>$file_name)},
+				        "history") .
+				" | " .
 				$cgi->a({-href => href(action=>"blob_plain",
 				                       hash=>$hash, file_name=>$file_name)},
 				        "plain") .
@@ -2720,6 +2730,9 @@ sub git_blob {
 }
 
 sub git_tree {
+	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
+	my $have_snapshot = (defined $ctype && defined $suffix);
+
 	if (!defined $hash) {
 		$hash = git_get_head_hash($project);
 		if (defined $file_name) {
@@ -2743,7 +2756,23 @@ sub git_tree {
 	my $base = "";
 	my ($have_blame) = gitweb_check_feature('blame');
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
-		git_print_page_nav('tree','', $hash_base);
+		my @views_nav = ();
+		if (defined $file_name) {
+			push @views_nav,
+				$cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+				                       hash=>$hash, file_name=>$file_name)},
+				        "history"),
+				$cgi->a({-href => href(action=>"tree",
+				                       hash_base=>"HEAD", file_name=>$file_name)},
+				        "head");
+		}
+		if ($have_snapshot) {
+			# FIXME: Should be available when we have no hash base as well.
+			push @views_nav,
+				$cgi->a({-href => href(action=>"snapshot")},
+					"snapshot");
+		}
+		git_print_page_nav('tree','', $hash_base, undef, undef, join(' | ', @views_nav));
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
 	} else {
 		undef $hash_base;
@@ -2888,17 +2917,22 @@ sub git_commit {
 	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
 	my $have_snapshot = (defined $ctype && defined $suffix);
 
-	my $formats_nav = '';
+	my @views_nav = ();
 	if (defined $file_name && defined $co{'parent'}) {
 		my $parent = $co{'parent'};
-		$formats_nav .=
+		push @views_nav,
 			$cgi->a({-href => href(action=>"blame", hash_parent=>$parent, file_name=>$file_name)},
 			        "blame");
 	}
+	if (defined $co{'parent'}) {
+		push @views_nav,
+			$cgi->a({-href => href(action=>"shortlog", hash=>$hash)}, "shortlog"),
+			$cgi->a({-href => href(action=>"log", hash=>$hash)}, "log");
+	}
 	git_header_html(undef, $expires);
 	git_print_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff',
 	                   $hash, $co{'tree'}, $hash,
-	                   $formats_nav);
+	                   join (' | ', @views_nav));
 
 	if (defined $co{'parent'}) {
 		git_print_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
