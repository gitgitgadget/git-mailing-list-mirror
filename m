X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robert Fitzsimons <robfitz@273k.net>
Subject: [RFC] Possible optimization for gitweb
Date: Tue, 19 Dec 2006 20:54:22 +0000
Message-ID: <20061219205422.GA17864@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 20:54:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=2.988, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_NJABL_DUL 3.00,
	RCVD_IN_SORBS_DUL 1.99)
X-blacknight-igraine-MailScanner-SpamScore: ss
X-MailScanner-From: robfitz@273k.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34851>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwlyo-0007aw-JQ for gcvg-git@gmane.org; Tue, 19 Dec
 2006 21:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932943AbWLSUyX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 15:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932942AbWLSUyW
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 15:54:22 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:53513 "EHLO
 igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932943AbWLSUyV (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 15:54:21 -0500
Received: from 213-202-161-139.bas503.dsl.esat.net ([213.202.161.139]
 helo=localhost) by igraine.blacknight.ie with esmtp (Exim 4.60)
 (envelope-from <robfitz@273k.net>) id 1GwlyP-0007ze-1g for
 git@vger.kernel.org; Tue, 19 Dec 2006 20:54:05 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

While looking at the gitweb source yesterday, I noticed a number of
similar expensive workflows used by a number of actions (summary,
shortlog, log, rss, atom, and history).

The current workflows are:
	get ~100 sha1's using rev-list
	foreach sha1
		get/parse 1 commit using rev-list
		output commit

The new workflows I'm proposing would be:
	get/parse ~100 commit's using rev-list
	foreach commit
		output commit

The following simplified commands gives an idea of the git only overhead
between these two workflows.

time \
for r in `git-rev-list --max-count=100 HEAD --` ; \
do git-rev-list --header --parents --max-count=1 $r -- ; \
done > /dev/null

real    0m0.490s
user    0m0.224s
sys     0m0.228s

time \
git-rev-list --header --parents --max-count=100 HEAD -- > /dev/null

real    0m0.058s
user    0m0.008s
sys     0m0.004s

There would seems to be a benefit from making the proposed change to
these workflows, when run on my machine against a clone of Linus's tree.

One issue with this change is that, gitweb is page orientated.  Page 0
shows the first 100 items from a given hash, page 1 uses the same given
hash but show 100 to 199 items, etc.  Using 'git-rev-list --header
--parents' and then throwing away most of the result is very wasteful.

So I'm suggesting we add a new option to git-rev-list which will only
start show results once its has iterated past a given number of items.
Using a caret or tilde doesn't seem to return the same result.

I've attached a discussion patch which adds a new option --start-count
to git-rev-list and changed the summary and showlog actions of gitweb to
use this new option.

I'm sure there are many improvements to this patch, comments?

Robert

-----


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4059894..a1e0ccc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1260,6 +1260,30 @@ sub parse_tag {
 	return %tag
 }
 
+sub parse_commits {
+	my $commit_id = shift;
+	my $start_count = shift;
+	my $max_count = shift;
+
+	my @cos;
+	my @commit_lines;
+
+	local $/ = "\0";
+	open my $fd, "-|", git_cmd(), "rev-list",
+		"--header", "--parents", "--start-count=$start_count", "--max-count=$max_count",
+		$commit_id, "--"
+		or return;
+	while (my $commit = <$fd>) {
+		@commit_lines = split '\n', $commit;
+		pop @commit_lines;
+		my %co = parse_commit(undef, \@commit_lines);
+		push @cos, \%co;
+	}
+	close $fd or return;
+
+	return @cos;
+}
+
 sub parse_commit {
 	my $commit_id = shift;
 	my $commit_text = shift;
@@ -2633,29 +2657,29 @@ sub git_project_list_body {
 
 sub git_shortlog_body {
 	# uses global variable $project
-	my ($revlist, $from, $to, $refs, $extra) = @_;
+	my ($commitlist, $from, $to, $refs, $extra) = @_;
 
 	$from = 0 unless defined $from;
-	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
+	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
 	print "<table class=\"shortlog\" cellspacing=\"0\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
-		my $commit = $revlist->[$i];
+		my $co = $commitlist->[$i];
+		my $commit = $co->{'id'};
 		#my $ref = defined $refs ? format_ref_marker($refs, $commit) : '';
 		my $ref = format_ref_marker($refs, $commit);
-		my %co = parse_commit($commit);
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
-		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
+		# git_summary() used print "<td><i>$co->{'age_string'}</i></td>\n" .
+		print "<td title=\"$co->{'age_string_age'}\"><i>$co->{'age_string_date'}</i></td>\n" .
+		      "<td><i>" . esc_html(chop_str($co->{'author_name'}, 10)) . "</i></td>\n" .
 		      "<td>";
-		print format_subject_html($co{'title'}, $co{'title_short'},
+		print format_subject_html($co->{'title'}, $co->{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
@@ -2952,13 +2976,9 @@ sub git_summary {
 		}
 	}
 
-	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
-		git_get_head_hash($project), "--"
-		or die_error(undef, "Open git-rev-list failed");
-	my @revlist = map { chomp; $_ } <$fd>;
-	close $fd;
+	my @commitlist = parse_commits($head, 0, 17);
 	git_print_header_div('shortlog');
-	git_shortlog_body(\@revlist, 0, 15, $refs,
+	git_shortlog_body(\@commitlist, 0, 15, $refs,
 	                  $cgi->a({-href => href(action=>"shortlog")}, "..."));
 
 	if (@taglist) {
@@ -4313,15 +4333,12 @@ sub git_shortlog {
 	}
 	my $refs = git_get_references();
 
-	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash, "--"
-		or die_error(undef, "Open git-rev-list failed");
-	my @revlist = map { chomp; $_ } <$fd>;
-	close $fd;
+	my $max_count = (100 * ($page+1));
+	my @commitlist = parse_commits($hash, (100 * $page), $max_count);
 
-	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#revlist);
+	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $max_count);
 	my $next_link = '';
-	if ($#revlist >= (100 * ($page+1)-1)) {
+	if ($max_count >= 100) {
 		$next_link =
 			$cgi->a({-href => href(action=>"shortlog", hash=>$hash, page=>$page+1),
 			         -title => "Alt-n"}, "next");
@@ -4332,7 +4349,7 @@ sub git_shortlog {
 	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
 	git_print_header_div('summary', $project);
 
-	git_shortlog_body(\@revlist, ($page * 100), $#revlist, $refs, $next_link);
+	git_shortlog_body(\@commitlist, 0, $#commitlist, $refs, $next_link);
 
 	git_footer_html();
 }
diff --git a/list-objects.c b/list-objects.c
index f1fa21c..d96c8bf 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -108,8 +108,12 @@ void traverse_commit_list(struct rev_info *revs,
 	struct object_array objects = { 0, 0, NULL };
 
 	while ((commit = get_revision(revs)) != NULL) {
-		process_tree(revs, commit->tree, &objects, NULL, "");
-		show_commit(commit);
+		if (revs->start_count <= 0) {
+			process_tree(revs, commit->tree, &objects, NULL, "");
+			show_commit(commit);
+		} else {
+			revs->start_count--;
+		}
 	}
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
diff --git a/revision.c b/revision.c
index 993bb66..3e3d929 100644
--- a/revision.c
+++ b/revision.c
@@ -524,6 +524,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->prefix = prefix;
 	revs->max_age = -1;
 	revs->min_age = -1;
+	revs->start_count = -1;
 	revs->max_count = -1;
 
 	revs->prune_fn = NULL;
@@ -756,6 +757,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		const char *arg = argv[i];
 		if (*arg == '-') {
 			int opts;
+			if (!strncmp(arg, "--start-count=", 14)) {
+				revs->start_count = atoi(arg + 14);
+				continue;
+			}
 			if (!strncmp(arg, "--max-count=", 12)) {
 				revs->max_count = atoi(arg + 12);
 				continue;
diff --git a/revision.h b/revision.h
index 3adab95..c2dce8c 100644
--- a/revision.h
+++ b/revision.h
@@ -75,6 +75,7 @@ struct rev_info {
 	struct grep_opt	*grep_filter;
 
 	/* special limits */
+	int start_count;
 	int max_count;
 	unsigned long max_age;
