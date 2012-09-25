From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/2] gitweb: expose tags feed in appropriate places
Date: Tue, 25 Sep 2012 22:10:45 +0200
Message-ID: <1348603845-9084-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1348603845-9084-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 22:11:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGbTH-0002IV-AB
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 22:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab2IYUKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 16:10:51 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:45453 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851Ab2IYUKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 16:10:49 -0400
Received: by wibhm2 with SMTP id hm2so1889587wib.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4NDaL3tvjKi1UDiA7IXr5IRz4eGRoQHRWPf2hxglX1o=;
        b=O1+7C4SJMjPeYHk54D0ZAEG1vkwm5ferXcCfQgWurOZAHA/L1gOpFNu4hAdqxZgg6x
         lcgzxKIwxE5NTQnPBnL8E3aLUiviPs7LOh4fZv2jtFfDRNGyzm8czV7mew5j5ehWCyCU
         Ufc56FwIHMybtOjp6ixjqPqE7xwqidEo+bPUpynHeNIAS0Qqi1TV33NFw4xzrdYwY0jJ
         4LQE/B6D/lzB90kGKHJpwaf6ZW7nr2mvij3fhpIacEHOArZHQGnEy0AnEt0p64AS1BRH
         yIKzTqTkKcsG6MzlcZelarsOW+EjMPu9Xl27/pwf6tMqeqdUdnpDnG9SEVGN9+lzwZ7m
         Opkg==
Received: by 10.180.106.130 with SMTP id gu2mr24042995wib.20.1348603848610;
        Tue, 25 Sep 2012 13:10:48 -0700 (PDT)
Received: from localhost ([151.74.130.142])
        by mx.google.com with ESMTPS id w7sm21728328wiz.0.2012.09.25.13.10.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Sep 2012 13:10:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.577.gff9625d
In-Reply-To: <1348603845-9084-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206375>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6cb51f7..9ac28aa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -804,6 +804,8 @@ our %actions = (
 	"summary" => \&git_summary,
 	"tag" => \&git_tag,
 	"tags" => \&git_tags,
+	"tags_rss" => \&git_tags_rss,
+	"tags_atom" => \&git_tags_atom,
 	"tree" => \&git_tree,
 	"snapshot" => \&git_snapshot,
 	"object" => \&git_object,
@@ -2518,7 +2520,7 @@ sub get_feed_info {
 	return unless (defined $project);
 	# some views should link to OPML, or to generic project feed,
 	# or don't have specific feed yet (so they should use generic)
-	return if (!$action || $action =~ /^(?:tags|heads|forks|tag|search)$/x);
+	return if (!$action || $action =~ /^(?:heads|forks|search)$/x);
 
 	my $branch;
 	# branches refs uses 'refs/heads/' prefix (fullname) to differentiate
@@ -2528,8 +2530,10 @@ sub get_feed_info {
 		$branch = $1;
 	}
 	# find log type for feed description (title)
-	my $type = 'log';
-	if (defined $file_name) {
+	my $type = "log";
+	if ($action eq 'tag' || $action eq 'tags') {
+		$type = "tags";
+	} elsif (defined $file_name) {
 		$type  = "history of $file_name";
 		$type .= "/" if ($action eq 'tree');
 		$type .= " on '$branch'" if (defined $branch);
@@ -3907,6 +3911,7 @@ sub print_feed_meta {
 			$href_params{'-title'} = 'log';
 		}
 
+		my $tag_view = $href_params{-title} eq 'tags';
 		foreach my $format (qw(RSS Atom)) {
 			my $type = lc($format);
 			my %link_attr = (
@@ -3916,7 +3921,7 @@ sub print_feed_meta {
 			);
 
 			$href_params{'extra_options'} = undef;
-			$href_params{'action'} = $type;
+			$href_params{'action'} = ($tag_view ? 'tags_' : '') . $type;
 			$link_attr{'-href'} = href(%href_params);
 			print "<link ".
 			      "rel=\"$link_attr{'-rel'}\" ".
@@ -3925,15 +3930,17 @@ sub print_feed_meta {
 			      "type=\"$link_attr{'-type'}\" ".
 			      "/>\n";
 
-			$href_params{'extra_options'} = '--no-merges';
-			$link_attr{'-href'} = href(%href_params);
-			$link_attr{'-title'} .= ' (no merges)';
-			print "<link ".
-			      "rel=\"$link_attr{'-rel'}\" ".
-			      "title=\"$link_attr{'-title'}\" ".
-			      "href=\"$link_attr{'-href'}\" ".
-			      "type=\"$link_attr{'-type'}\" ".
-			      "/>\n";
+			unless ($tag_view) {
+				$href_params{'extra_options'} = '--no-merges';
+				$link_attr{'-href'} = href(%href_params);
+				$link_attr{'-title'} .= ' (no merges)';
+				print "<link ".
+				      "rel=\"$link_attr{'-rel'}\" ".
+				      "title=\"$link_attr{'-title'}\" ".
+				      "href=\"$link_attr{'-href'}\" ".
+				      "type=\"$link_attr{'-type'}\" ".
+				      "/>\n";
+			}
 		}
 
 	} else {
@@ -4115,8 +4122,9 @@ sub git_footer_html {
 		}
 		$href_params{'-title'} ||= 'log';
 
+		my $tag_view = $href_params{-title} eq 'tags';
 		foreach my $format (qw(RSS Atom)) {
-			$href_params{'action'} = lc($format);
+			$href_params{'action'} = ($tag_view ? 'tags_' : '') . lc($format);
 			print $cgi->a({-href => href(%href_params),
 			              -title => "$href_params{'-title'} $format feed",
 			              -class => $feed_class}, $format)."\n";
@@ -8280,10 +8288,18 @@ sub git_rss {
 	git_feed('rss');
 }
 
+sub git_tags_rss {
+	git_feed('rss', 'tags')
+}
+
 sub git_atom {
 	git_feed('atom');
 }
 
+sub git_tags_atom {
+	git_feed('atom', 'tags')
+}
+
 sub git_opml {
 	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
@@ -8328,6 +8344,9 @@ XML
 		my $rss  = href('project' => $proj{'path'}, 'action' => 'rss', -full => 1);
 		my $html = href('project' => $proj{'path'}, 'action' => 'summary', -full => 1);
 		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
+		# and now the tags rss feed
+		$rss  = href('project' => $proj{'path'}, 'action' => 'tags_rss', -full => 1);
+		print "<outline type=\"rss\" text=\"$path tags\" title=\"$path tags\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
 	}
 	print <<XML;
 </outline>
-- 
1.7.12.1.577.gff9625d
