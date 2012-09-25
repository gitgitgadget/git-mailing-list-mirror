From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] gitweb: infrastructure for tags feed
Date: Tue, 25 Sep 2012 22:10:44 +0200
Message-ID: <1348603845-9084-2-git-send-email-giuseppe.bilotta@gmail.com>
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
	id 1TGbTG-0002IV-KY
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 22:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146Ab2IYUKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 16:10:49 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:46180 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab2IYUKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 16:10:48 -0400
Received: by wibhm2 with SMTP id hm2so1889519wib.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=u9IAaqwt6AfW28MVV3rrCpaYudnGm06P9SIFQH5m6to=;
        b=Hc7p9eIfKaYcKf3QJlJcqpDjMPPpWkSs2LkgCbf6COAOjBjT1jQfVfbU8bFxmDuqYe
         73bKxZAYc5BoFCtgrYIYOT0uMZ1o9Bll84FikZPlh+FPAlkyyzRbfR/Ah6MTlULuQGSJ
         mG/CCRhYm4oAU+J7eXl+XZmAcFBJL+rYse650DYL87sXNRn9KVuT4DpWKLCrZDdA0dNH
         s9B7aj3pbvsk0S35OKE0i7eVV/FrJn9VXkkMRkm9m/9buDqOT+da1FEGeCIImRlGgiEx
         9URZeNRm0HQ2R0rSSq95Drosc3cwlrqIhTzfWuwhvuAbL65CYrhOBzBXXmbM4v/g8xBf
         4IGQ==
Received: by 10.216.143.71 with SMTP id k49mr9284389wej.43.1348603845390;
        Tue, 25 Sep 2012 13:10:45 -0700 (PDT)
Received: from localhost ([151.74.130.142])
        by mx.google.com with ESMTPS id ga2sm2456060wib.2.2012.09.25.13.10.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Sep 2012 13:10:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.577.gff9625d
In-Reply-To: <1348603845-9084-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206374>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl | 79 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 21 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7f8c187..6cb51f7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3711,6 +3711,7 @@ sub git_get_tags_list {
 
 		if ($type eq "tag" || $type eq "commit") {
 			$ref_item{'epoch'} = $epoch;
+			$ref_item{'tz'} = $tz;
 			if ($epoch) {
 				$ref_item{'age'} = age_string(time - $ref_item{'epoch'});
 			} else {
@@ -8004,6 +8005,10 @@ sub git_shortlog {
 
 sub git_feed {
 	my $format = shift || 'atom';
+
+	# feed context: log, tags
+	my $ctx = shift || 'log';
+
 	my $have_blame = gitweb_check_feature('blame');
 
 	# Atom: http://www.atomenabled.org/developers/syndication/
@@ -8012,9 +8017,19 @@ sub git_feed {
 		die_error(400, "Unknown web feed format");
 	}
 
+	if ($ctx ne 'log' && $ctx ne 'tags') {
+		die_error(400, "Unknown web feed context");
+	}
+	my $tags = $ctx eq 'tags' ? 1 : 0;
+
 	# log/feed of current (HEAD) branch, log of given branch, history of file/directory
 	my $head = $hash || 'HEAD';
-	my @commitlist = parse_commits($head, 150, 0, $file_name);
+	my @commitlist;
+	if ($tags) {
+		@commitlist = git_get_tags_list(15);
+	} else {
+		@commitlist = parse_commits($head, 150, 0, $file_name);
+	}
 
 	my %latest_commit;
 	my %latest_date;
@@ -8026,9 +8041,12 @@ sub git_feed {
 	}
 	if (defined($commitlist[0])) {
 		%latest_commit = %{$commitlist[0]};
-		my $latest_epoch = $latest_commit{'committer_epoch'};
+		my $latest_epoch = $tags ? $latest_commit{'epoch'} :
+					   $latest_commit{'committer_epoch'};
 		exit_if_unmodified_since($latest_epoch);
-		%latest_date = parse_date($latest_epoch, $latest_commit{'comitter_tz'});
+		%latest_date = parse_date($latest_epoch,
+			$tags ? $latest_commit{'tz'} :
+				$latest_commit{'committer_tz'});
 	}
 	print $cgi->header(
 		-type => $content_type,
@@ -8043,7 +8061,9 @@ sub git_feed {
 	# header variables
 	my $title = "$site_name - $project/$action";
 	my $feed_type = 'log';
-	if (defined $hash) {
+	if ($tags) {
+		$feed_type = 'tags';
+	} elsif (defined $hash) {
 		$title .= " - '$hash'";
 		$feed_type = 'branch log';
 		if (defined $file_name) {
@@ -8060,6 +8080,7 @@ sub git_feed {
 		$descr = esc_html($descr);
 	} else {
 		$descr = "$project " .
+			 ($tags ? 'tags ' : '') .
 		         ($format eq 'rss' ? 'RSS' : 'Atom') .
 		         " feed";
 	}
@@ -8068,7 +8089,9 @@ sub git_feed {
 
 	#header
 	my $alt_url;
-	if (defined $file_name) {
+	if ($tags) {
+		$alt_url = href(-full=>1, action=>"tags");
+	} elsif (defined $file_name) {
 		$alt_url = href(-full=>1, action=>"history", hash=>$hash, file_name=>$file_name);
 	} elsif (defined $hash) {
 		$alt_url = href(-full=>1, action=>"log", hash=>$hash);
@@ -8132,9 +8155,15 @@ XML
 	}
 
 	# contents
+	my $co_action = $tags ? 'tag' : 'commitdiff';
 	for (my $i = 0; $i <= $#commitlist; $i++) {
+		my %clco; # commit info from commitlist, only used for tags
 		my %co = %{$commitlist[$i]};
 		my $commit = $co{'id'};
+		if ($tags) {
+			%clco = %co;
+			%co = parse_tag($commit);
+		}
 		# we read 150, we always show 30 and the ones more recent than 48 hours
 		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
 			last;
@@ -8142,44 +8171,52 @@ XML
 		my %cd = parse_date($co{'author_epoch'}, $co{'author_tz'});
 
 		# get list of changed files
-		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			$co{'parent'} || "--root",
-			$co{'id'}, "--", (defined $file_name ? $file_name : ())
-			or next;
-		my @difftree = map { chomp; $_ } <$fd>;
-		close $fd
-			or next;
+		my @difftree;
+		unless ($tags) {
+			open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+				$co{'parent'} || "--root",
+				$co{'id'}, "--", (defined $file_name ? $file_name : ())
+				or next;
+			@difftree = map { chomp; $_ } <$fd>;
+			close $fd
+				or next;
+		}
+
+		my $co_hash = $tags ? $clco{'name'} : $commit;
+		my $co_url = href(-full=>1, action=>$co_action, hash=>$co_hash);
+		my $co_title = esc_html($tags ? $clco{'subject'} : $co{'title'});
 
 		# print element (entry, item)
-		my $co_url = href(-full=>1, action=>"commitdiff", hash=>$commit);
 		if ($format eq 'rss') {
 			print "<item>\n" .
-			      "<title>" . esc_html($co{'title'}) . "</title>\n" .
+			      "<title>" . $co_title . "</title>\n" .
 			      "<author>" . esc_html($co{'author'}) . "</author>\n" .
 			      "<pubDate>$cd{'rfc2822'}</pubDate>\n" .
 			      "<guid isPermaLink=\"true\">$co_url</guid>\n" .
 			      "<link>$co_url</link>\n" .
-			      "<description>" . esc_html($co{'title'}) . "</description>\n" .
+			      "<description>" . $co_title . "</description>\n" .
 			      "<content:encoded>" .
 			      "<![CDATA[\n";
 		} elsif ($format eq 'atom') {
 			print "<entry>\n" .
-			      "<title type=\"html\">" . esc_html($co{'title'}) . "</title>\n" .
+			      "<title type=\"html\">" . $co_title . "</title>\n" .
 			      "<updated>$cd{'iso-8601'}</updated>\n" .
 			      "<author>\n" .
 			      "  <name>" . esc_html($co{'author_name'}) . "</name>\n";
 			if ($co{'author_email'}) {
 				print "  <email>" . esc_html($co{'author_email'}) . "</email>\n";
 			}
-			print "</author>\n" .
+			print "</author>\n";
+			unless ($tags) {
 			      # use committer for contributor
-			      "<contributor>\n" .
+			      print "<contributor>\n" .
 			      "  <name>" . esc_html($co{'committer_name'}) . "</name>\n";
-			if ($co{'committer_email'}) {
+			}
+			if (!$tags && $co{'committer_email'}) {
 				print "  <email>" . esc_html($co{'committer_email'}) . "</email>\n";
 			}
-			print "</contributor>\n" .
-			      "<published>$cd{'iso-8601'}</published>\n" .
+			print "</contributor>\n" unless $tags;
+			print "<published>$cd{'iso-8601'}</published>\n" .
 			      "<link rel=\"alternate\" type=\"text/html\" href=\"$co_url\" />\n" .
 			      "<id>$co_url</id>\n" .
 			      "<content type=\"xhtml\" xml:base=\"" . esc_url($my_url) . "\">\n" .
-- 
1.7.12.1.577.gff9625d
