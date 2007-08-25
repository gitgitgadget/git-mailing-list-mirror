From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 3/3] gitweb: Remove git_blame (superseded by git_blame2)
Date: Sun, 26 Aug 2007 00:24:15 +0200
Message-ID: <20070825222415.16967.28292.stgit@rover>
References: <20070825222404.16967.9402.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 00:24:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP43T-00023Z-7l
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 00:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbXHYWYR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 18:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757532AbXHYWYR
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 18:24:17 -0400
Received: from rover.dkm.cz ([62.24.64.27]:45744 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757085AbXHYWYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 18:24:16 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 70A658B594;
	Sun, 26 Aug 2007 00:24:15 +0200 (CEST)
In-Reply-To: <20070825222404.16967.9402.stgit@rover>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56659>

This patch definitely removes git_blame() from the source and renames
git_blame2() to git_blame(); it was already the default handler for the
blame action for a long time and it has been actually broken for some time
now (I'm not sure how long), so noone probably cares about it much (I have
an alternative trivial patch to fix it too). All the information listing is
already included in git_blame2() output now.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |  101 +---------------------------------------------------
 1 files changed, 2 insertions(+), 99 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8536c50..23eaff3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -537,7 +537,7 @@ $git_dir = "$projectroot/$project" if $project;
 
 # dispatch
 my %actions = (
-	"blame" => \&git_blame2,
+	"blame" => \&git_blame,
 	"blame_incremental" => \&git_blame_incremental,
 	"blame_data" => \&git_blame_data,
 	"blobdiff" => \&git_blobdiff,
@@ -4180,105 +4180,8 @@ sub git_blame_incremental {
 	git_blame_common('incremental');
 }
 
-sub git_blame2 {
-	git_blame_common('oneshot');
-}
-
 sub git_blame {
-	my $fd;
-
-	my ($have_blame) = gitweb_check_feature('blame');
-	if (!$have_blame) {
-		die_error('403 Permission denied', "Permission denied");
-	}
-	die_error('404 Not Found', "File name not defined") if (!$file_name);
-	$hash_base ||= git_get_head_hash($project);
-	die_error(undef, "Couldn't find base commit") unless ($hash_base);
-	my %co = parse_commit($hash_base)
-		or die_error(undef, "Reading commit failed");
-	if (!defined $hash) {
-		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
-			or die_error(undef, "Error lookup file");
-	}
-	open ($fd, "-|", git_cmd(), "annotate", '-l', '-t', '-r', $file_name, $hash_base)
-		or die_error(undef, "Open git-annotate failed");
-	git_header_html();
-	my $formats_nav =
-		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
-		        "blob") .
-		" | " .
-		$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
-			"history") .
-		" | " .
-		$cgi->a({-href => href(action=>"blame", file_name=>$file_name), -class => "blamelink"},
-		        "HEAD");
-	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
-	git_print_page_path($file_name, 'blob', $hash_base);
-	print "<div class=\"page_body\">\n";
-	print <<HTML;
-<table class="blame">
-  <tr>
-    <th>Commit</th>
-    <th>Age</th>
-    <th>Author</th>
-    <th>Line</th>
-    <th>Data</th>
-  </tr>
-HTML
-	my @line_class = (qw(light dark));
-	my $line_class_len = scalar (@line_class);
-	my $line_class_num = $#line_class;
-	while (my $line = <$fd>) {
-		my $long_rev;
-		my $short_rev;
-		my $author;
-		my $time;
-		my $lineno;
-		my $data;
-		my $age;
-		my $age_str;
-		my $age_class;
-
-		chomp $line;
-		$line_class_num = ($line_class_num + 1) % $line_class_len;
-
-		if ($line =~ m/^([0-9a-fA-F]{40})\t\(\s*([^\t]+)\t(\d+) [+-]\d\d\d\d\t(\d+)\)(.*)$/) {
-			$long_rev = $1;
-			$author   = $2;
-			$time     = $3;
-			$lineno   = $4;
-			$data     = $5;
-		} else {
-			print qq(  <tr><td colspan="5" class="error">Unable to parse: $line</td></tr>\n);
-			next;
-		}
-		$short_rev  = substr ($long_rev, 0, 8);
-		$age        = time () - $time;
-		$age_str    = age_string ($age);
-		$age_str    =~ s/ /&nbsp;/g;
-		$age_class  = age_class($age);
-		$author     = esc_html ($author);
-		$author     =~ s/ /&nbsp;/g;
-
-		$data = untabify($data);
-		$data = esc_html ($data);
-
-		print <<HTML;
-  <tr class="$line_class[$line_class_num]">
-    <td class="sha1"><a href="${\href (action=>"commit", hash=>$long_rev)}" class="text">$short_rev..</a></td>
-    <td class="$age_class">$age_str</td>
-    <td>$author</td>
-    <td class="linenr"><a id="$lineno" href="#$lineno" class="linenr">$lineno</a></td>
-    <td class="pre">$data</td>
-  </tr>
-HTML
-	} # while (my $line = <$fd>)
-	print "</table>\n\n";
-	close $fd
-		or print "Reading blob failed.\n";
-	print "</div>";
-	git_footer_html();
+	git_blame_common('oneshot');
 }
 
 sub git_tags {
