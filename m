From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] gitweb: allow working in repositories with textual symref HEAD
Date: Mon, 09 Jan 2006 00:42:41 -0800
Message-ID: <7v7j99ssfy.fsf@assigned-by-dhcp.cox.net>
References: <7vslrytcw7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 09:42:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evsc3-0006fw-Gn
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 09:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWAIImn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 03:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWAIImn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 03:42:43 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:39844 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750986AbWAIImn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 03:42:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060109084141.ZEES20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 03:41:41 -0500
To: Kay Sievers <kay.sievers@suse.de>
In-Reply-To: <7vslrytcw7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 08 Jan 2006 17:20:56 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14363>

There is a change to git-core, proposed by Pavel and cooking for
the last 6 weeks, to use textual symref to represent HEAD even
on filesystems that support symbolic links.  It would break
gitweb without this even on UNIX.

The current code is already broken on filesystems that do not
handle symbolic links. With this change, gitweb keeps working
with repositories whose HEADs are symbolic links.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Junio C Hamano <junkio@cox.net> writes:
 
 > Waiting in the proposed updates branch are two backward
 > incompatible changes.
 > ...
 >  - Use textual symbolic refs to represent .git/HEAD everywhere,
 >    not just on filesystems without symbolic link supports.  This
 >    was proposed by Pavel mid November 2005, but is known to
 >    break Porcelains that read(2) from .git/HEAD and expect to
 >    read an object name for the current branch head (use "git
 >    rev-parse --verify HEAD" instead), and write(2) into
 >    .git/HEAD and expect to update the current branch head (use
 >    "git update-ref HEAD $commit [$old]" instead).  Last time I
 >    checked, gitweb would break with this change.

 Here is a proposed fix.  It was not clear to me what your
 $ENV{'GIT_DIR'} policy was, so git_read_head tries to play
 safer, but please feel free to drop that part if the rest of
 the code is safe without them.

 gitweb.cgi |   49 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 33 insertions(+), 16 deletions(-)

c903862d1c5d77fe5a1633eb7a40171d98a8dd73
diff --git a/gitweb.cgi b/gitweb.cgi
index 1814f7f..26c7395 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -396,6 +396,23 @@ sub git_get_type {
 	return $type;
 }
 
+sub git_read_head {
+	my $project = shift;
+	my $oENV = $ENV{'GIT_DIR'};
+	my $retval = undef;
+	$ENV{'GIT_DIR'} = "$projectroot/$project";
+	if (open my $fd, "-|", "$gitbin/git-rev-parse", "--verify", "HEAD") {
+		my $head = <$fd>;
+		close $fd;
+		chomp $head;
+		if ($head =~ m/^[0-9a-fA-F]{40}$/) {
+			$retval = $head;
+		}
+	}
+	$ENV{'GIT_DIR'} = $oENV;
+	return $retval;
+}
+
 sub git_read_hash {
 	my $path = shift;
 
@@ -823,7 +840,7 @@ sub git_project_list {
 		die_error(undef, "No project found.");
 	}
 	foreach my $pr (@list) {
-		my $head = git_read_hash("$pr->{'path'}/HEAD");
+		my $head = git_read_head($pr->{'path'});
 		if (!defined $head) {
 			next;
 		}
@@ -994,7 +1011,7 @@ sub git_read_refs {
 
 sub git_summary {
 	my $descr = git_read_description($project) || "none";
-	my $head = git_read_hash("$project/HEAD");
+	my $head = git_read_head($project);
 	my %co = git_read_commit($head);
 	my %cd = date_str($co{'committer_epoch'}, $co{'committer_tz'});
 
@@ -1034,7 +1051,7 @@ sub git_summary {
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
 	      "</table>\n";
-	open my $fd, "-|", "$gitbin/git-rev-list --max-count=17 " . git_read_hash("$project/HEAD") or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$gitbin/git-rev-list --max-count=17 " . git_read_head($project) or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd;
 	print "<div>\n" .
@@ -1172,7 +1189,7 @@ sub git_summary {
 }
 
 sub git_tag {
-	my $head = git_read_hash("$project/HEAD");
+	my $head = git_read_head($project);
 	git_header_html();
 	print "<div class=\"page_nav\">\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
@@ -1211,7 +1228,7 @@ sub git_tag {
 }
 
 sub git_tags {
-	my $head = git_read_hash("$project/HEAD");
+	my $head = git_read_head($project);
 	git_header_html();
 	print "<div class=\"page_nav\">\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
@@ -1270,7 +1287,7 @@ sub git_tags {
 }
 
 sub git_heads {
-	my $head = git_read_hash("$project/HEAD");
+	my $head = git_read_head($project);
 	git_header_html();
 	print "<div class=\"page_nav\">\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
@@ -1343,7 +1360,7 @@ sub git_get_hash_by_path {
 
 sub git_blob {
 	if (!defined $hash && defined $file_name) {
-		my $base = $hash_base || git_read_hash("$project/HEAD");
+		my $base = $hash_base || git_read_head($project);
 		$hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
 	}
 	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or die_error(undef, "Open failed.");
@@ -1407,13 +1424,13 @@ sub git_blob_plain {
 
 sub git_tree {
 	if (!defined $hash) {
-		$hash = git_read_hash("$project/HEAD");
+		$hash = git_read_head($project);
 		if (defined $file_name) {
-			my $base = $hash_base || git_read_hash("$project/HEAD");
+			my $base = $hash_base || $hash;
 			$hash = git_get_hash_by_path($base, $file_name, "tree");
 		}
 		if (!defined $hash_base) {
-			$hash_base = git_read_hash("$project/HEAD");
+			$hash_base = $hash;
 		}
 	}
 	$/ = "\0";
@@ -1497,7 +1514,7 @@ sub git_tree {
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", "$gitbin/git-rev-list --max-count=150 " . git_read_hash("$project/HEAD") or die_error(undef, "Open failed.");
+	open my $fd, "-|", "$gitbin/git-rev-list --max-count=150 " . git_read_head($project) or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading rev-list failed.");
 	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
@@ -1566,7 +1583,7 @@ sub git_opml {
 
 	foreach my $pr (@list) {
 		my %proj = %$pr;
-		my $head = git_read_hash("$proj{'path'}/HEAD");
+		my $head = git_read_head($proj{'path'});
 		if (!defined $head) {
 			next;
 		}
@@ -1587,7 +1604,7 @@ sub git_opml {
 }
 
 sub git_log {
-	my $head = git_read_hash("$project/HEAD");
+	my $head = git_read_head($project);
 	if (!defined $hash) {
 		$hash = $head;
 	}
@@ -2083,7 +2100,7 @@ sub git_commitdiff_plain {
 
 sub git_history {
 	if (!defined $hash) {
-		$hash = git_read_hash("$project/HEAD");
+		$hash = git_read_head($project);
 	}
 	my %co = git_read_commit($hash);
 	if (!%co) {
@@ -2159,7 +2176,7 @@ sub git_search {
 		die_error("", "Text field empty.");
 	}
 	if (!defined $hash) {
-		$hash = git_read_hash("$project/HEAD");
+		$hash = git_read_head($project);
 	}
 	my %co = git_read_commit($hash);
 	if (!%co) {
@@ -2300,7 +2317,7 @@ sub git_search {
 }
 
 sub git_shortlog {
-	my $head = git_read_hash("$project/HEAD");
+	my $head = git_read_head($project);
 	if (!defined $hash) {
 		$hash = $head;
 	}
-- 
1.1.0
