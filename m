From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] GitWeb + TopGit
Date: Wed,  3 Jun 2009 13:09:12 +0200
Message-ID: <1244027352-24055-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jun 03 13:15:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBoRI-0002vV-Ts
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 13:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbZFCLPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 07:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbZFCLPO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 07:15:14 -0400
Received: from mail-ew0-f162.google.com ([209.85.219.162]:50771 "EHLO
	mail-ew0-f162.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbZFCLPM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 07:15:12 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2009 07:15:06 EDT
Received: by ewy6 with SMTP id 6so130003ewy.37
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 04:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=yNgECj5nhAlogPn2qGsk7mSysgaHbUgVzTIchBf3n4s=;
        b=GbKZs0f5OK1kxn+PD936y+44FysyFanAARZKIX7tEQnYUo0R7rhiRRyCbtVhf8AKNF
         wFEScGOREPbx0R2RsqWVCUausU0bj1eTcWT0X1UofnKZ3gNJkFERWM/kkFb1fQvm7IzL
         cdmD7SyLLM6J6wJGM4dmrv6qBR32czLC4j6uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HAvU+MCBys1kjSjN+8JT8GlWpsFefQJzCgG0MwfEOl+7IYJ/isaj0WDyo7WJDtIekQ
         X/SbgEZImiGVXPVpHbqkP6dK414J/G0dRtySq3GvacoONdg2HbfuyPuLtP3rpJqnBnud
         merKgxyISgb/9UdszdKEnbqKJ3FtttAi/Scl0=
Received: by 10.216.36.79 with SMTP id v57mr282258wea.19.1244027354924;
        Wed, 03 Jun 2009 04:09:14 -0700 (PDT)
Received: from localhost ([141.76.90.80])
        by mx.google.com with ESMTPS id g11sm17867263gve.1.2009.06.03.04.09.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 04:09:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.143.g17592
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120602>

Hello Petr,

I have changed gitweb to show topgit topics. log and shortlog shows
only the history for refs/top-bases/$topic..$topic.

You can see it in action here:

http://kgb2.thruhere.net/git/?p=bertw/topgit.git;a=summary

This patch is based on the debian package gitweb-1.6.3.1-1.  If you'r
interested I can rebase the patch on git.git.

Regards,
Bert

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
diff --git a/gitweb.cgi b/gitweb.cgi
index 820f073..fd9e64b 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -536,6 +536,7 @@ our %actions = (
 	"summary" => \&git_summary,
 	"tag" => \&git_tag,
 	"tags" => \&git_tags,
+	"topics" => \&git_topics,
 	"tree" => \&git_tree,
 	"snapshot" => \&git_snapshot,
 	"object" => \&git_object,
@@ -2684,12 +2685,13 @@ sub parse_from_to_diffinfo {
 ## ......................................................................
 ## parse to array of hashes functions
 
-sub git_get_heads_list {
+sub _git_get_heads_list {
+	my $topics = shift;
 	my $limit = shift;
+	my $n = 0;
 	my @headslist;
 
-	open my $fd, '-|', git_cmd(), 'for-each-ref',
-		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
+	open my $fd, '-|', git_cmd(), 'for-each-ref', '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
 		'refs/heads'
 		or return;
@@ -2704,6 +2706,22 @@ sub git_get_heads_list {
 		$ref_item{'fullname'}  = $name;
 		$name =~ s!^refs/heads/!!;
 
+		# filter TopGit topics out
+		open (my $dd, "-|", git_cmd(), 'rev-parse',  '--quiet',
+			'--verify', "refs/top-bases/$name")
+			or die_error(500, "Open rev-parse failed");
+		my $base_ref = <$dd>;
+		close $dd;
+		next if ($topics ? !defined $base_ref : defined $base_ref);
+
+		# limit list
+		last if ($limit and $n++ > ($limit + 1));
+
+		if ($topics) {
+			$ref_item{'base_name'}  = "refs/top-bases/$name";
+			$ref_item{'base_id'}    = $base_ref;
+		}
+
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
 		$ref_item{'title'} = $title || '(no commit message)';
@@ -2721,6 +2739,14 @@ sub git_get_heads_list {
 	return wantarray ? @headslist : \@headslist;
 }
 
+sub git_get_heads_list {
+	return _git_get_heads_list(0, @_);
+}
+
+sub git_get_topics_list {
+	return _git_get_heads_list(1, @_);
+}
+
 sub git_get_tags_list {
 	my $limit = shift;
 	my @tagslist;
@@ -4335,6 +4361,53 @@ sub git_heads_body {
 	print "</table>\n";
 }
 
+sub git_topics_body {
+	# uses global variable $project
+	my ($topiclist, $head, $from, $to, $extra) = @_;
+	$from = 0 unless defined $from;
+	$to = $#{$topiclist} if (!defined $to || $#{$topiclist} < $to);
+
+	print "<table class=\"heads\">\n";
+	my $alternate = 1;
+	for (my $i = $from; $i <= $to; $i++) {
+		my $entry = $topiclist->[$i];
+		my %ref = %$entry;
+		my $curr = $ref{'id'} eq $head;
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+		print "<td><i>$ref{'age'}</i></td>\n" .
+		      ($curr ? "<td class=\"current_head\">" : "<td>") .
+		      $cgi->a({-href => href(action=>"shortlog",
+		                             hash_parent=>$ref{'base_name'},
+		                             hash=>$ref{'fullname'},
+		                             extra_options=>'--no-merges'),
+		               -class => "list name"},esc_html($ref{'name'})) .
+		      "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => href(action=>"shortlog",
+		                             hash_parent=>$ref{'base_name'},
+		                             hash=>$ref{'fullname'},
+		                             extra_options=>'--no-merges')}, "shortlog") . " | " .
+		      $cgi->a({-href => href(action=>"log",
+		                             hash_parent=>$ref{'base_name'},
+		                             hash=>$ref{'fullname'},
+		                             extra_options=>'--no-merges')}, "log") . " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'name'})}, "tree") .
+		      "</td>\n" .
+		      "</tr>";
+	}
+	if (defined $extra) {
+		print "<tr>\n" .
+		      "<td colspan=\"3\">$extra</td>\n" .
+		      "</tr>\n";
+	}
+	print "</table>\n";
+}
+
 sub git_search_grep_body {
 	my ($commitlist, $from, $to, $extra) = @_;
 	$from = 0 unless defined $from;
@@ -4481,6 +4554,7 @@ sub git_summary {
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
 	my @headlist = git_get_heads_list(16);
+	my @topiclist = git_get_topics_list(16);
 	my @forklist;
 	my $check_forks = gitweb_check_feature('forks');
 
@@ -4558,6 +4632,13 @@ sub git_summary {
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
+	if (@topiclist) {
+		git_print_header_div('topics');
+		git_topics_body(\@topiclist, $head, 0, 15,
+		               $#topiclist <= 15 ? undef :
+		               $cgi->a({-href => href(action=>"topics")}, "..."));
+	}
+
 	if (@forklist) {
 		git_print_header_div('forks');
 		git_project_list_body(\@forklist, 'age', 0, 15,
@@ -4757,6 +4838,19 @@ sub git_heads {
 	git_footer_html();
 }
 
+sub git_topics {
+	my $head = git_get_head_hash($project);
+	git_header_html();
+	git_print_page_nav('','', $head,undef,$head);
+	git_print_header_div('summary', $project);
+
+	my @topicslist = git_get_topics_list();
+	if (@topicslist) {
+		git_topics_body(\@topicslist, $head);
+	}
+	git_footer_html();
+}
+
 sub git_blob_plain {
 	my $type = shift;
 	my $expires;
@@ -5054,7 +5148,11 @@ sub git_log {
 	}
 	my $refs = git_get_references();
 
-	my @commitlist = parse_commits($hash, 101, (100 * $page));
+	my $commit_hash = $hash;
+	if (defined $hash_parent) {
+		$commit_hash = "$hash_parent..$hash";
+	}
+	my @commitlist = parse_commits($commit_hash, 101, (100 * $page));
 
 	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
 
