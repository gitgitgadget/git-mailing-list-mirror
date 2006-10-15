From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb.cgi feature request: project list "last change" column	to display last change of all heads.
Date: Sun, 15 Oct 2006 03:28:07 -0700
Message-ID: <7vfydpzxe0.fsf@assigned-by-dhcp.cox.net>
References: <4531FC77.6010004@adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 12:28:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ3EG-0002qY-MQ
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 12:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWJOK2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 06:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWJOK2K
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 06:28:10 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59558 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750713AbWJOK2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 06:28:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061015102808.LQJB28934.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Oct 2006 06:28:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id aaTw1V00C1kojtg0000000
	Sun, 15 Oct 2006 06:27:56 -0400
To: Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
In-Reply-To: <4531FC77.6010004@adelaide.edu.au> (Pierre Marc Dumuid's message
	of "Sun, 15 Oct 2006 18:46:39 +0930")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28911>

Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au> writes:

> The annoying thing is that in our mirrored personal repositories, we
> switch from head to head and push new features in different head, and
> then wait for the other developers to review.  At the moment, the
> getweb.cgi script only shows the "Last Change" for the current branch,
> and not all branches, (i.e. it's currently showing "13 days ago" for
> cinelerra-pmdumuid, whilst if you click the summary, you'll see I
> actually extended one of the branches only "24 hours ago".

It is fairly expensive to do without recent core-side support,
but if the site runs version of git from the "next" branch,
you should be able to do something like this.

I'll queue this to "next".

-- >8 --
gitweb: use for-each-ref to show the latest activity across branches

The project list page shows last change from the HEAD branch but
often people would want to view activity on any branch.

Unfortunately that is fairly expensive without the core-side
support.  for-each-ref was invented exactly for that.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e4ebce6..a78c8db 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1009,6 +1009,24 @@ sub parse_tag {
 	return %tag
 }
 
+sub git_get_last_activity {
+	my ($path) = @_;
+	my $fd;
+
+	$git_dir = "$projectroot/$path";
+	open($fd, "-|", git_cmd(), 'for-each-ref', 
+	     '--format=%(refname) %(committer)',
+	     '--sort=-committerdate',
+	     'refs/heads') or return;
+	my $most_recent = <$fd>;
+	close $fd or return;
+	if ($most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
+		my $timestamp = $1;
+		my $age = time - $timestamp;
+		return ($age, age_string($age));
+	}
+}
+
 sub parse_commit {
 	my $commit_id = shift;
 	my $commit_text = shift;
@@ -2258,16 +2276,11 @@ sub git_project_list {
 		die_error(undef, "No projects found");
 	}
 	foreach my $pr (@list) {
-		my $head = git_get_head_hash($pr->{'path'});
-		if (!defined $head) {
-			next;
-		}
-		$git_dir = "$projectroot/$pr->{'path'}";
-		my %co = parse_commit($head);
-		if (!%co) {
+		my (@aa) = git_get_last_activity($pr->{'path'});
+		unless (@aa) {
 			next;
 		}
-		$pr->{'commit'} = \%co;
+		($pr->{'age'}, $pr->{'age_string'}) = @aa;
 		if (!defined $pr->{'descr'}) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
 			$pr->{'descr'} = chop_str($descr, 25, 5);
@@ -2317,7 +2330,7 @@ sub git_project_list {
 		      "</th>\n";
 	}
 	if ($order eq "age") {
-		@projects = sort {$a->{'commit'}{'age'} <=> $b->{'commit'}{'age'}} @projects;
+		@projects = sort {$a->{'age'} <=> $b->{'age'}} @projects;
 		print "<th>Last Change</th>\n";
 	} else {
 		print "<th>" .
@@ -2339,8 +2352,8 @@ sub git_project_list {
 		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
 		      "<td>" . esc_html($pr->{'descr'}) . "</td>\n" .
 		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
-		print "<td class=\"". age_class($pr->{'commit'}{'age'}) . "\">" .
-		      $pr->{'commit'}{'age_string'} . "</td>\n" .
+		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
+		      $pr->{'age_string'} . "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
